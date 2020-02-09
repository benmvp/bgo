var time=new Date();
var endyear=time.getYear();
if (endyear < 2000)
	endyear = endyear + 1900;
document.write("<center><small>Copyright © 2000-" + endyear + " BASIC Guru Online.  All Rights Reserved.<\/small><\/center>");