#ifndef CONFIG_H
#define CONFIG_H

// String used to delimit block outputs in the status.
#define DELIMITER " " 

// Maximum number of Unicode characters that a block can output.
#define MAX_BLOCK_OUTPUT_LENGTH 45

// Control whether blocks are clickable.
#define CLICKABLE_BLOCKS 0

// Control whether a leading delimiter should be prepended to the status.
#define LEADING_DELIMITER 0

// Control whether a trailing delimiter should be appended to the status.
#define TRAILING_DELIMITER 0

// Define blocks for the status feed as X(icon, cmd, interval, signal).
#define BLOCKS(X)   \
    X("", "xbpsupdate", 18000, 17)  \
    X("", "sb-forcast", 18000, 18) \
    X("", "volume", 0, 19)  \
    X("", "sb-battery", 5, 20)  \
    X("", "sb-internet", 5, 21) \
    X("", "sb-clock", 60, 22) 

#endif  // CONFIG_H
