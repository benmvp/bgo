function QuickNavi(calctype, langtype, progtype) 
{ 
	if (calctype == "TI-82") {
			if (langtype == "BASIC") {
					if (progtype == "Games") {
							window.location="archives/ti-82/games.html";
					}
					if (progtype == "Math") {
							window.location="archives/ti-82/math.html";
					}
					if (progtype == "Miscellaneous") {
							window.location="archives/ti-82/misc.html";
					}
					if (progtype == "Science") {
							window.location="archives/ti-82/basic.html";
					}
			}
			if (langtype == "Assembly") {
					window.location="archives/ti-82/assembly.html";	
			}
	}
	if (calctype == "TI-83") {
			if (langtype == "BASIC") {
					if (progtype == "Games") {
							window.location="archives/ti-83/games.html";
					}
					if (progtype == "Math") {
							window.location="archives/ti-83/math.html";
					}
					if (progtype == "Miscellaneous") {
							window.location="archives/ti-83/misc.html";
					}
					if (progtype == "Science") {
							window.location="archives/ti-83/basic.html";
					}
			}
			if (langtype == "Assembly") {
					if (progtype == "Games") {
							window.location="archives/ti-83/agames.html";
					}
					if (progtype == "Miscellaneous") {
							window.location="archives/ti-83/amisc.html";
					}
					if (progtype == "Math" || progtype == "Science") {
							window.location="archives/ti-83/assembly.html";
					}
			}
	}
	if (calctype == "TI-83 Plus") {
			if (langtype == "BASIC") {
					if (progtype == "Games") {
							window.location="archives/ti-83plus/games.html";
					}
					if (progtype == "Math") {
							window.location="archives/ti-83plus/math.html";
					}
					if (progtype == "Miscellaneous") {
							window.location="archives/ti-83plus/misc.html";
					}
					if (progtype == "Science") {
							window.location="archives/ti-83plus/science.html";
					}
			}
			if (langtype == "Assembly") {
					if (progtype == "Miscellaneous") {
							window.location="archives/ti-83plus/amisc.html";
					}
					else 
							window.location="archives/ti-83plus/assembly.html";
			}
	}
}