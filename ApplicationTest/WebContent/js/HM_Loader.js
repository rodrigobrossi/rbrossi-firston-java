/*HM_Loader.js
* by Peter Belesis. v4.0.11 010529
* Copyright (c) 2001 Peter Belesis. All Rights Reserved.
*/

HM_DOM = (document.getElementById) ? true : false;
HM_NS4 = (document.layers) ? true : false;
HM_IE = (document.all) ? true : false;
HM_IE4 = HM_IE && !HM_DOM;
HM_Mac = (navigator.appVersion.indexOf("Mac") != -1);
HM_IE4M = HM_IE4 && HM_Mac;
HM_IsMenu = (HM_DOM || HM_NS4 || (HM_IE4 && !HM_IE4M));

HM_BrowserString = HM_NS4 ? "NS4" : HM_DOM ? "DOM" : "IE4";

if(window.event + "" == "undefined") event = null;
function HM_f_PopUp(){return false};
function HM_f_PopDown(){return false};
popUp = HM_f_PopUp;
popDown = HM_f_PopDown;


HM_GL_MenuWidth          = 100;
HM_GL_FontFamily         = "Arial,sans-serif";
HM_GL_FontSize           = 8;
HM_GL_FontBold           = false;
HM_GL_FontItalic         = false;
HM_GL_FontColor          = "#333333";
HM_GL_FontColorOver      = "#000000";
HM_GL_BGColor            = "#C4DF9B";
HM_GL_BGColorOver        = "#A4BF7B";
HM_GL_ItemPadding        = 2;

HM_GL_BorderWidth        = 2;
HM_GL_BorderColor        = "#C4DF9B";
HM_GL_BorderStyle        = "solid";
HM_GL_SeparatorSize      = 0;
HM_GL_SeparatorColor     = "#C4DF9B";
HM_GL_ImageSrc           = "#";
HM_GL_ImageSrcRight      = "#";
HM_GL_ImageSize          = 0;
HM_GL_ImageHorizSpace    = 0;
HM_GL_ImageVertSpace     = 0;

HM_GL_KeepHilite         = false;
HM_GL_ClickStart         = false;
HM_GL_ClickKill          = 0;
HM_GL_ChildOverlap       = 40;
HM_GL_ChildOffset        = 10;
HM_GL_ChildPerCentOver   = null;
HM_GL_TopSecondsVisible  = 0;
HM_GL_StatusDisplayBuild = 0;
HM_GL_StatusDisplayLink  = 1;
HM_GL_UponDisplay        = null;
HM_GL_UponHide           = null;

//HM_GL_RightToLeft      = true;
HM_GL_CreateTopOnly      = HM_NS4 ? true : false;
HM_GL_ShowLinkCursor     = true;

// the following function is included to illustrate the improved JS expression handling of
// the left_position and top_position parameters
// you may delete if you have no use for it

function HM_f_CenterMenu(topmenuid) {
	var TheMenu = HM_DOM ? document.getElementById(topmenuid) : HM_IE4 ? document.all(topmenuid) : eval("window." + topmenuid);
	var TheMenuWidth = HM_DOM ? parseInt(TheMenu.style.width) : HM_IE4 ? TheMenu.style.pixelWidth : TheMenu.clip.width;
	var TheWindowWidth = HM_IE ? document.body.clientWidth : window.innerWidth;
	return ((TheWindowWidth-TheMenuWidth) / 2);
}

if(HM_IsMenu) {
	document.write("<SCR" + "IPT LANGUAGE='JavaScript1.2' SRC='js/"+array1()+"' TYPE='text/javascript'><\/SCR" + "IPT>");
	document.write("<SCR" + "IPT LANGUAGE='JavaScript1.2' SRC='js/HM_Script"+ HM_BrowserString +".js' TYPE='text/javascript'><\/SCR" + "IPT>");
}


//end