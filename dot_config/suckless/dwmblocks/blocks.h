//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/ /*Command*/	 	                            /*Update Interval*/	/*Update Signal*/
      //  {" 🐧 ", "~/.scripts/distrotube/kernel",	 360,		          2},

     // {" 🔺 ", "~/.scripts/distrotube/upt",		 60,		          2},

	{"  ", "~/.scripts/xbpsupdate",  360,		          31},
	
     //{" 💻 ", "~/.scripts/distrotube/memory",	 6,		              1},

	{"  ", "~/.scripts/volume",     0,		              19},

	{" ", "~/.scripts/sb-internet",	     5,	              21},
	
	{" ", "~/.scripts/sb-battery",	     5,	              20},
	
     //{"    ", "~/.scripts/LS/sb-doppler",	     0,	             13},
	
	{" ", "~/.scripts/sb-forecast",	     18000,	              18},

	{" ", "~/.scripts/sb-clock",	     60,	              22},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim =  ' ';
