//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/ /*Command*/	 	                            /*Update Interval*/	/*Update Signal*/
      //  {" 🐧 ", "~/.scripts/distrotube/kernel",	 360,		          2},

     // {" 🔺 ", "~/.scripts/distrotube/upt",		 60,		          2},

	{"  ", "~/.scripts/xbpsupdate",  360,		          9},
	
     //{" 💻 ", "~/.scripts/distrotube/memory",	 6,		              1},

	{"  ", "~/.scripts/sb-volume",     0,		              10},

	{" ", "~/.scripts/sb-internet",	     5,	              4},
	
	{" ", "~/.scripts/sb-battery",	     5,	              3},
	
     //{"    ", "~/.scripts/LS/sb-doppler",	     0,	             13},
	
	{" ", "~/.scripts/sb-forecast",	     18000,	              5},
	
	{" ", "~/.scripts/distrotube/clock",	     60,	              0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim =  ' ';
