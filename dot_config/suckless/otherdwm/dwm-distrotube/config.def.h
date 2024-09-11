/*  ____ _____  */
/* |  _ \_   _|  Derek Taylor (DistroTube) */
/* | | | || |  	http://www.youtube.com/c/DistroTube */
/* | |_| || |  	http://www.gitlab.com/dwt1/dwm-distrotube */
/* |____/ |_|  	*/

/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int gappx     = 6;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int horizpadbar        = 6;        /* horizontal padding for statusbar */
static const int vertpadbar         = 7;        /* vertical padding for statusbar */
/* Default font will be Ubuntu if installed (ttf-ubuntu).
 * Otherwise, your default font will be Hack (ttf-hack)
 * JoyPixels (ttf-joypixels) is a dependency for colored fonts and emojis.
 */
static const char *fonts[]     = {"Ubuntu:weight=bold:size=14:antialias=true:hinting=true",
                                  "Hack:size=14:antialias=true:autohint=true",
                                  "JoyPixels:size=14:antialias=true:autohint=true"
						     	};
static const char col_1[]  = "#2f4f4f"; /* background color of bar */
static const char col_2[]  = "#8b0000"; /* border color unfocused windows */
static const char col_3[]  = "#82b48c"; /* icon colors */
static const char col_4[]  = "#924441"; /* border color focused windows and tags */
/* bar opacity
 * 0xff is no transparency.
 * 0xee adds wee bit of transparency.
 * 0xdd adds adds a bit more transparency.
 * Play with the value to get desired transparency.
 */
static const unsigned int baralpha    = 0xdd;
static const unsigned int borderalpha = OPAQUE;
static const char *colors[][3]        = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_3, col_1, col_2 },
	[SchemeSel]  = { col_3, col_4, col_4 },
};
static const unsigned int alphas[][3] = {
	/*               fg      bg        border     */
	[SchemeNorm] = { OPAQUE, baralpha, borderalpha },
	[SchemeSel]  = { OPAQUE, baralpha, borderalpha },
};

/* tagging */
/* static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }; */
static const char *tags[] = { "", "", "", "", "", "", "", "", "" }; 
//static const char *tags[] = { "dev", "www", "sys", "doc", "vbox", "chat", "mus", "vid", "gfx" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
};

/* layout(s) */
static const float mfact        = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster        = 1;    /* number of clients in master area */
static const int resizehints    = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

#include "grid.c"
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "HHH",      grid },
    { NULL,       NULL },
};

/* key definitions */
#define MODKEY Mod4Mask

#define TAGKEYS(KEY,TAG)												\
	{1, {{MODKEY, KEY}},								view,           {.ui = 1 << TAG} },	\
	{1, {{MODKEY|ControlMask, KEY}},					toggleview,     {.ui = 1 << TAG} }, \
	{1, {{MODKEY|ShiftMask, KEY}},						tag,            {.ui = 1 << TAG} }, \
	{1, {{MODKEY|ControlMask|ShiftMask, KEY}},			toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]    = { "dmenu_run","-c", NULL };
static const char *termcmd[]  = { "alacritty", NULL };
static const char *tabtermcmd[]  = { "tabbed", "-r", "2", "alacritty", "-w", "''", NULL };

static Keychord keychords[] = {
	/* Keys        function        argument */
	{1, {{MODKEY, XK_m}}, spawn,          {.v = dmenucmd } },
	{1, {{MODKEY, XK_Return}},			 spawn,          {.v = termcmd } },
	{1, {{Mod1Mask, XK_Return}},         spawn,          {.v = tabtermcmd } },
	{1, {{MODKEY|ShiftMask, XK_c}},		 killclient,     {0} },

	/* Dmenu scripts launched with emacs-style keychords SUPER + p followed by "key" */
	{2, {{MODKEY, XK_p}, {0, XK_e}},      spawn,         SHCMD("dm-confedit") },
	{2, {{MODKEY, XK_p}, {0, XK_i}},      spawn,         SHCMD("dm-maim") },
	{2, {{MODKEY, XK_p}, {0, XK_k}},      spawn,         SHCMD("dm-kill") },
	{2, {{MODKEY, XK_p}, {0, XK_l}},      spawn,         SHCMD("dm-logout") },
	{2, {{MODKEY, XK_p}, {0, XK_m}},      spawn,         SHCMD("dm-man") },
	{2, {{MODKEY, XK_p}, {0, XK_r}},      spawn,         SHCMD("dm-reddit") },
	{2, {{MODKEY, XK_p}, {0, XK_s}},      spawn,         SHCMD("dm-websearch") },
	{2, {{MODKEY, XK_p}, {0, XK_p}},      spawn,         SHCMD("passmenu") },

	{2, {{MODKEY, XK_e}, {0, XK_e}},      spawn,         SHCMD("emacsclient -c -a 'emacs'") },
	{2, {{MODKEY, XK_e}, {0, XK_a}},      spawn,         SHCMD("emacsclient -c -a 'emacs' --eval '(emms)' --eval '(emms-play-directory-tree \"~/Music/\")'") },
	{2, {{MODKEY, XK_e}, {0, XK_b}},      spawn,         SHCMD("emacsclient -c -a 'emacs' --eval '(ibuffer)'") },
	{2, {{MODKEY, XK_e}, {0, XK_d}},      spawn,         SHCMD("emacsclient -c -a 'emacs' --eval '(dired nil)'") },
	{2, {{MODKEY, XK_e}, {0, XK_i}},      spawn,         SHCMD("emacsclient -c -a 'emacs' --eval '(erc)'") },
	{2, {{MODKEY, XK_e}, {0, XK_n}},      spawn,         SHCMD("emacsclient -c -a 'emacs' --eval '(elfeed)'") },
	{2, {{MODKEY, XK_e}, {0, XK_s}},      spawn,         SHCMD("emacsclient -c -a 'emacs' --eval '(eshell)'") },
	{2, {{MODKEY, XK_e}, {0, XK_v}},      spawn,         SHCMD("emacsclient -c -a 'emacs' --eval '(+vterm/here nil)'") },
	{2, {{MODKEY, XK_e}, {0, XK_w}},      spawn,         SHCMD("emacsclient -c -a 'emacs' --eval '(doom/window-maximize-buffer(eww \"distro.tube\"))'") },

    /* Web browsers */
    {1, {{MODKEY, XK_b}},                 spawn,         SHCMD("qutebrowser") },
    {1, {{MODKEY|Mod1Mask, XK_s}},        spawn,         SHCMD("tabbed -r 2 surf -pe x '.surf/html/homepage.html'") },


	{1, {{MODKEY, XK_b}},				  togglebar,      {0} },
	{1, {{MODKEY, XK_j}},				  focusstack,     {.i = +1 } },
	{1, {{MODKEY, XK_k}},				  focusstack,     {.i = -1 } },
	{1, {{MODKEY|ShiftMask, XK_j}},		  rotatestack,    {.i = +1 } },
	{1, {{MODKEY|ShiftMask, XK_k}},		  rotatestack,    {.i = -1 } },
	{1, {{MODKEY, XK_i}},				  incnmaster,     {.i = +1 } },
	{1, {{MODKEY, XK_d}},				  incnmaster,     {.i = -1 } },
	{1, {{MODKEY, XK_h}},				  setmfact,       {.f = -0.05} },
	{1, {{MODKEY, XK_l}},				  setmfact,       {.f = +0.05} },
	{1, {{MODKEY, XK_Return}},			  zoom,           {0} },
	{1, {{MODKEY, XK_Tab}},				  view,           {0} },

    /* Layout manipulation */
	{1, {{MODKEY, XK_Tab}},				  cyclelayout,    {.i = -1 } },
	{1, {{MODKEY|ShiftMask, XK_Tab}},		  cyclelayout,    {.i = +1 } },
	{1, {{MODKEY, XK_t}},				  setlayout,      {.v = &layouts[0]} },
	{1, {{MODKEY, XK_f}},				  setlayout,      {.v = &layouts[1]} },
	{1, {{MODKEY, XK_m}},				  setlayout,      {.v = &layouts[2]} },
	{1, {{MODKEY, XK_g}},				  setlayout,      {.v = &layouts[3]} },
	{1, {{MODKEY, XK_space}},			  setlayout,      {0} },

	{1, {{MODKEY|ShiftMask, XK_space}},	  togglefloating, {0} },
	{1, {{MODKEY, XK_0}},				  view,           {.ui = ~0 } },
	{1, {{MODKEY|ShiftMask, XK_0}},		  tag,            {.ui = ~0 } },

    /* Switching between monitors */
	{1, {{MODKEY, XK_comma}},			  focusmon,       {.i = -1 } },
	{1, {{MODKEY, XK_period}},			  focusmon,       {.i = +1 } },
	{1, {{MODKEY|ShiftMask, XK_comma}},	  tagmon,         {.i = -1 } },
	{1, {{MODKEY|ShiftMask, XK_period}},  tagmon,         {.i = +1 } },

	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)

    /* Restart or quit dwm */
	{1, {{MODKEY|ShiftMask, XK_r}},		  quit,           {1} },
	{1, {{MODKEY|ShiftMask, XK_q}},		  quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

