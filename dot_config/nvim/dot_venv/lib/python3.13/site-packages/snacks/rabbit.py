import ast
import json
import logging
import numbers
import threading
import time
import typing
import uuid
from inspect import signature
from typing import Optional, Any, Callable, Mapping, Union, Iterable, Type

from pika import (BlockingConnection, BasicProperties, ConnectionParameters,
                  PlainCredentials)
from pika.adapters.blocking_connection import BlockingChannel
from pika.exceptions import (AMQPChannelError, ChannelClosed,
                             AMQPConnectionError)
from pika import exceptions as e
from pika.exchange_type import ExchangeType
from pika.frame import Method
from pika.spec import Basic

__all__ = ('RabbitClient', 'BasicProperties', 'exceptions')
log = logging.getLogger('snacks')
exceptions = e


# TODO django_rest_framework serializer support?
class RabbitClient:
    """A class to interface with RabbitMQ."""

    def __init__(
            self,
            host: Optional[str] = None,
            port: Optional[Union[str, int]] = None,
            virtual_host: Optional[str] = None,
            username: Optional[str] = None,
            password: Optional[str] = None,
            default_exchange: Optional[str] = None,
            default_content_type: Optional[str] = None,
            retry_timeout: float = 10.0
    ) -> None:
        self.host = host or '127.0.0.1'
        self.port = port or 5762
        self.default_exchange = default_exchange or ''
        self.default_content_type = default_content_type or ''
        self.virtual_host = virtual_host or '/'
        log.info('RabbitClient configured.')
        log.debug('host=%s', self.host)
        log.debug('port=%s', self.port)
        log.debug('default_exchange=%s', self.default_exchange)
        log.debug('default_content_type=%s', self.default_content_type)
        log.debug('virtual_host=%s', self.virtual_host)
        if username and password:
            self.credentials = PlainCredentials(username, password)
        else:
            self.credentials = PlainCredentials('guest', 'guest')
        self.params = ConnectionParameters(
            host=host,
            port=int(port),
            virtual_host=self.virtual_host,
            credentials=self.credentials
        )
        self.connection: BlockingConnection = BlockingConnection(self.params)
        self.channel: BlockingChannel = self.connection.channel()
        self.retry_timeout: float = retry_timeout

    @staticmethod
    def from_dict(dictionary: dict[str, Any]) -> 'RabbitClient':
        return RabbitClient(
            dictionary.get('host'),
            dictionary.get('port'),
            dictionary.get('exchange'),
            dictionary.get('virtual_host'),
            dictionary.get('username') or dictionary.get('user') or 'guest',
            dictionary.get('password') or dictionary.get('pass') or 'guest',
            dictionary.get('retry_timeout') or 10.0
        )

    def exchange_declare(
            self,
            exchange: Optional[str] = None,
            exchange_type: str = ExchangeType.direct,
            passive: bool = False,
            durable: bool = False,
            auto_delete: bool = False,
            internal: bool = False,
            arguments: Optional[Mapping[str, Any]] = None
    ) -> Method:
        """Wrapper for pika.BlockingChannel exchange_declare method.

        This method creates an exchange if it does not already exist,
        and if the exchange exists, verifies that it is of the correct
        and expected class.

        If passive set, the server will reply with Declare-Ok if the
        exchange already exists with the same name, and raise an error
        if not and if the exchange does not already exist, the server
        MUST raise a channel exception with reply code 404 (not found).

        :param exchange: The exchange name consists of a non-empty
            sequence of these characters: letters, digits, hyphen,
            underscore, period, or colon.
        :param exchange_type: The exchange type to use.
        :param passive: Perform a declare or just check to see if it
            exists.
        :param durable: Survive a reboot of RabbitMQ.
        :param auto_delete: Remove when no more queues are bound to it.
        :param internal: Can only be published to by other exchanges.
        :param arguments: Custom key/value pair arguments for the
            exchange.
        :return: Method frame from the Exchange.Declare-ok response.
        """
        self._reset_if_lost()
        return self.channel.exchange_declare(
            exchange or self.default_exchange,
            exchange_type,
            passive,
            durable,
            auto_delete,
            internal,
            arguments
        )

    def queue_declare(
            self,
            queue: Optional[str] = None,
            passive: bool = False,
            durable: bool = False,
            exclusive: bool = False,
            auto_delete: bool = False,
            arguments: Optional[Mapping[str, Any]] = None,
    ) -> Method:
        """Wrapper for pika.BlockingChannel queue_declare method.

        Declare queue, create if needed. This method creates or
        checks a queue. When creating a new queue the client can specify
        various properties that control the durability of the queue and
        its contents, and the level of sharing for the queue. Use an
        empty string as the queue name for the broker to auto-generate
        one. Retrieve this auto-generated queue name from the returned
        spec.Queue.DeclareOk method frame.

        :param queue: The queue name; if empty string, the broker will
            create a unique queue name.
        :param passive: Only check to see if the queue exists and raise
            `ChannelClosed` if it doesn't.
        :param durable: Survive reboots of the broker.
        :param exclusive: Only allow access by the current connection.
        :param auto_delete: Delete after consumer cancels or
            disconnects.
        :param arguments: Custom key/value arguments for the queue.
        :return: Method frame from the Queue.Declare-ok response
        """
        self._reset_if_lost()
        return self.channel.queue_declare(
            queue or '',
            passive,
            durable,
            exclusive,
            auto_delete,
            arguments
        )

    def queue_bind(
            self,
            queue: str,
            routing_key: Optional[str] = None,
            exchange: Optional[str] = None,
            arguments: Optional[Mapping[str, Any]] = None
    ) -> Method:
        """Wrapper for pika.BlockingChannel queue_bind method.

        Bind the queue to the specified exchange.

        :param queue: The queue to bind to the exchange.
        :param routing_key: The routing key to bind on.
        :param exchange: The source exchange to bind to.
        :param arguments: Custom key/value pair arguments for the
            binding.
        :return: Method frame from the Queue.Bind-ok response.
        """
        self._reset_if_lost()
        return self.channel.queue_bind(
            queue,
            exchange or self.default_exchange,
            routing_key,
            arguments
        )

    def queue_delete(
            self,
            queue: str,
            if_unused: bool = False,
            if_empty: bool = False
    ) -> Method:
        """Wrapper for pika.BlockingChannel queue_delete method.

        Delete a queue from the broker.

        :param queue: The queue to delete.
        :param if_unused: Only delete if it's unused.
        :param if_empty: Only delete if the queue is empty.
        :return: Method frame from the Queue.Delete-ok response.
        """
        self._reset_if_lost()
        return self.channel.queue_delete(queue, if_unused, if_empty)

    def publish(
            self,
            body: Any,
            routing_key: str,
            exchange: Optional[str] = None,
            **kwargs
    ) -> None:
        """Publish message to a rabbit queue with the given routing key.

        :param body: The message to publish.
        :param routing_key: The routing key.
        :param exchange: Exchange to publish to.
        :param kwargs: Keyword args to pass to pika publish.
        """
        self._reset_if_lost()
        log.debug('Publishing key=%s msg=%s', routing_key, body)
        try:
            properties = kwargs.pop('properties')
        except KeyError:
            properties = BasicProperties(
                content_type=self.default_content_type
            )
        self.channel.basic_publish(
            exchange=exchange or self.default_exchange,
            routing_key=routing_key,
            body=self._serialize(body),
            properties=properties,
            **kwargs
        )

    def publish_and_receive(
            self,
            body: Any,
            routing_key: str,
            exchange: Optional[str] = None,
            time_limit: int = 60,
            **kwargs,
    ) -> Any:
        """Publish message to a rabbit queue with the given routing key.

        :param body: The message to publish.
        :param routing_key: The routing key.
        :param exchange: Exchange to publish to.
        :param time_limit: Number of seconds to wait for a response.
        :param kwargs: Keyword args to pass to pika publish.
        """
        self._reset_if_lost()
        log.debug('Publishing key=%s msg=%s', routing_key, body)
        response: Optional[bytes] = None
        corr_id = str(uuid.uuid4())

        def _on_response(
                _channel: BlockingChannel,
                _method: Basic.Deliver,
                props: BasicProperties,
                resp_body: bytes
        ) -> None:
            nonlocal response
            if props.correlation_id == corr_id:
                log.debug('Response from [%s] is [%s]', routing_key, resp_body)
                response = resp_body

        result = self.channel.queue_declare(queue='', exclusive=True)
        callback_queue = result.method.queue
        self.channel.basic_consume(
            queue=callback_queue,
            on_message_callback=_on_response,
            auto_ack=True
        )
        try:
            properties = kwargs.pop('properties')
        except KeyError:
            properties = BasicProperties(
                reply_to=callback_queue,
                correlation_id=corr_id,
                content_type=self.default_content_type
            )
        self.channel.basic_publish(
            exchange=exchange or self.default_exchange,
            routing_key=routing_key,
            properties=properties,
            body=self._serialize(body),
            **kwargs
        )
        self.connection.process_data_events(time_limit=time_limit)
        return response

    def listener(
            self,
            routing_keys: Union[list[str], str],
            exchange: Optional[str] = None,
            declare_arguments: Optional[Mapping[str, Any]] = None,
            bind_arguments: Optional[Mapping[str, Any]] = None
    ) -> Callable:
        """Decorate a callable to generate queues and consume from them.

        A new non-durable, auto-deleting, exclusive queue will be
        generated for each provided routing key.
        The decorated function can have as parameters, any or all of,
        message body, method, and properties.

        A new connection, channel, and thread is created for each
        consumer.

        :param routing_keys: Key or keys to generate queues for.
        :param exchange: The queues to consume from.
        :param declare_arguments: Arguments for queue_declare.
        :param bind_arguments: Arguments for queue_bind.
        :return: Function decorated to be a rabbit consumer.
        """
        self._reset_if_lost()
        rks = [routing_keys] if isinstance(routing_keys, str) else routing_keys
        exchange = exchange or self.default_exchange

        # If a connection is lost, the auto-deleting queues will all be
        # gone so reconnecting won't work. We pass the consume logic
        # this queue_factory to generate the queues initially and
        # whenever a connection fails.
        def queue_factory(channel: BlockingChannel) -> list[str]:
            queues = []
            for key in rks:
                log.debug('Declaring new queue top bind to [%s].', key)
                q = channel.queue_declare(
                    queue='',
                    exclusive=True,
                    auto_delete=True,
                    arguments=declare_arguments
                ).method.queue
                channel.queue_bind(q, exchange, key, arguments=bind_arguments)
                queues.append(q)
                log.debug('[%s] bound to [%s] with [%s]', q, exchange, key)
            return queues

        def wrapper(fun: Callable) -> Any:
            if fun.__name__ == '<lambda>':
                fun_name = f'{"_".join(rks)}_lambda_listener'.replace('.', '_')
                log.debug('Renaming lambda to [%s]', fun_name)
                fun.__name__ = fun_name
            thread = threading.Thread(
                target=self._consume,
                args=(fun, [], queue_factory)
            )
            thread.daemon = True
            thread.start()
            for rk in rks:
                log.info(
                    'Thread spawned for [%s] to consume a queue on [%s: %s]',
                    fun.__name__,
                    exchange,
                    rk
                )

        return wrapper

    def consumer(self, queues: Union[list[str], str]) -> Callable:
        """Decorate a callable to consume from one or more queues.

        The decorated function can have as parameters, any or all of,
        message body, method, and properties.

        A new connection, channel, and thread is created for each
        consumer.

        :param queues: The queue or queues to consume from.
        :return: Function decorated to be a rabbit consumer.
        """

        def wrapper(fun: Callable) -> Any:
            thread = threading.Thread(target=self._consume, args=(fun, queues))
            thread.daemon = True
            thread.start()

        return wrapper

    def _consume(
            self,
            fun: Callable,
            queues: Union[Iterable[str], str],
            q_factory: Optional[Callable[[BlockingChannel], list[str]]] = None
    ) -> None:
        running = True
        channel = None
        connection = None
        while running:
            try:
                # New channel and connection since threads can't share.
                if not connection or connection.is_closed:
                    connection = BlockingConnection(self.params)
                if not channel or channel.is_closed:
                    channel = connection.channel()

                def consume(q: str) -> None:
                    self._listen(channel, q, fun)
                    level = log.debug if q.startswith('amq.gen') else log.info
                    level('[%s] consuming queue [%s]', fun.__name__, q)

                if q_factory:
                    queues = q_factory(channel)
                queues = [queues] if isinstance(queues, str) else queues
                [consume(queue) for queue in queues]
                channel.start_consuming()
            except (ChannelClosed, AMQPChannelError, AMQPConnectionError) as e:
                log.error(
                    '[%s] on consumer [%s]',
                    type(e).__name__,
                    fun.__name__
                )
                log.info(
                    'Retrying connection in [%s] seconds...',
                    self.retry_timeout
                )
            except KeyboardInterrupt:
                running = False
                if channel and channel.is_open:
                    channel.stop_consuming()
                    channel.close()
            time.sleep(self.retry_timeout)

    def _reset_if_lost(self) -> None:
        if self.connection.is_closed:
            self.connection = BlockingConnection(self.params)
        if self.channel.is_closed:
            self.channel = self.connection.channel()

    def _serialize(self, body: Any) -> bytes:
        if self.default_content_type == 'application/json':
            if 'to_json' in dir(body):
                return body.to_json().encode()
            try:
                return json.dumps(body).encode()
            except TypeError:
                return body
        elif isinstance(body, (numbers.Number, Iterable)):
            return str(body).encode()
        else:
            return body

    def _listen(
            self,
            channel: BlockingChannel,
            queue: str,
            fun: Callable
    ) -> None:
        sig = signature(fun)

        def callback(
                ch: BlockingChannel,
                method: Basic.Deliver,
                properties: BasicProperties,
                body: bytes
        ) -> None:
            log.debug('Queue [%s] received [%s]', queue, body)
            log.debug('Properties [%s]', properties)
            kwargs: dict[str, Any] = {}
            for name, param in sig.parameters.items():
                annotation = param.annotation
                if name == 'self':
                    kwargs[name] = None
                elif annotation == BlockingChannel:
                    kwargs[name] = ch
                elif annotation == method:
                    kwargs[name] = method
                elif annotation == BasicProperties:
                    kwargs[name] = properties
                elif 'application/json' in [properties.content_type,
                                            properties.content_encoding]:
                    kwargs[name] = _deserialize_json(body, annotation)
                else:
                    kwargs[name] = _deserialize(annotation, body)
            # noinspection PyBroadException
            try:
                resp = fun(**kwargs)
                if properties.reply_to:
                    if resp is None:
                        resp = b''
                    ch.basic_publish(
                        exchange='',
                        routing_key=properties.reply_to,
                        properties=BasicProperties(
                            correlation_id=properties.correlation_id
                        ),
                        body=self._serialize(resp)
                    )
                    ch.basic_ack(delivery_tag=method.delivery_tag)
            except Exception as e:
                log.exception(msg=f'{type(e).__name__}:{e}', exc_info=e)

        channel.basic_qos(prefetch_count=1)
        channel.basic_consume(
            queue=queue,
            auto_ack=not sig.return_annotation,
            on_message_callback=callback
        )


def _deserialize(annotation: Type, body: bytes) -> Any:
    # noinspection PyBroadException
    try:
        origin = typing.get_origin(annotation)
        if annotation == str:
            return body.decode('utf-8')
        elif annotation == bytes:
            return body
        elif annotation in {int, float, numbers.Number}:
            return annotation(body)
        elif origin in {list, tuple, set, dict}:
            return ast.literal_eval(body.decode('utf-8'))
        elif origin == Union:
            args = typing.get_args(annotation)
            for arg in args:
                b = _deserialize(arg, body)
                if not isinstance(b, bytes):
                    return b
            return body
        # TODO Arbitrary class serializing?
        else:
            return body
    except Exception:
        return body


def _deserialize_json(body: bytes, annotation: Type) -> Union[list[Any], Any]:
    js_dict = json.loads(body)

    def _deserialize_dict_list() -> list[Any]:
        ret_val = []
        processed = []
        for arg in typing.get_args(annotation):
            # noinspection PyBroadException
            try:
                for i, obj in enumerate(js_dict):
                    ret_val.append(arg.from_dict(obj))
                    processed.append(i)
            except Exception:
                [js_dict.pop(i) for i in processed]
                processed = []
        return ret_val if ret_val else js_dict

    if isinstance(js_dict, dict) and 'from_json' in dir(annotation):
        # noinspection PyUnresolvedReferences
        return annotation.from_json(body)
    elif isinstance(js_dict, list):
        # FIXME Union[json_serializable_one, json_serializable_two]
        if all('from_dict' in dir(a) for a in typing.get_args(annotation)):
            return _deserialize_dict_list()
    else:
        return json.loads(body)
