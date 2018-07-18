/**
 * Rwanda Smart Dashboard IBM Copyright 2015
 * 
 * @author: Rodrigo Luis Nolli Brossi
 * @file rwanda_smart_dashboard.js
 * @param strURL
 * @param name
 * @param element
 */

//Build the Gauge
var aGauge = null;
var sGauge = null;
var wGauge = null;
$(document).ready(function() {
	aGauge = new AquaGauge('gauge');
	aGauge.props.minValue = 0;
	aGauge.props.maxValue = 100;
	aGauge.props.noOfDivisions = 5;
	aGauge.props.noOfSubDivisions = 4;
	aGauge.props.showMinorScaleValue = true;
	aGauge.refresh(0);
	initPage();
	setupSlider();
	setupRangeSliders();

});

//Build the Gauge
function updateGauge(val) {
	aGauge.refresh(val);
}

//Build the Gauge
function loadXMLDoc() {
	var xmlhttp;
	//check browser
	if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
	} else {// code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("myDiv").innerHTML = xmlhttp.responseText;
			document.getElementById("meter1").setAttribute("value", "0.9");
			document.getElementById("slider").setAttribute("value", "70");
		}

	}
	xmlhttp.open("GET", "ajax.html", true);
	xmlhttp.send();
}

function xmlhttpPost(strURL, name, element) {
	var xmlHttpReq = false;
	var self = this;
	// Mozilla/Safari
	if (window.XMLHttpRequest) {
		self.xmlHttpReq = new XMLHttpRequest();
	}
	// IE
	else if (window.ActiveXObject) {
		self.xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
	}
	self.xmlHttpReq.open('POST', strURL, true);
	self.xmlHttpReq.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded');
	self.xmlHttpReq.overrideMimeType("text/plain");

	self.xmlHttpReq.onreadystatechange = function() {
		if (self.xmlHttpReq.readyState == 4) {
			updatepage(self.xmlHttpReq.responseText, element);
		}
	}
	self.xmlHttpReq.send(getquerystring(name));
}

/**
 * Get String to Send data.
 * 
 * @param name
 *            Form name
 * @returns {String}
 */
function getquerystring(name) {
	var form = document.forms[name];
	var word = form.word.value;
	qstr = 'w=' + escape(word); // NOTE: no '?' before querystring
	return qstr;
}

/**
 * This function updates the page
 * 
 * @param str
 *            JSON data
 * @param element
 *            HTML element to be updated, if null the JSON one of the attriutes
 *            will be used to name the HTML component.
 */
function updatepage(str, element) {
		document.getElementById(element).innerHTML = str;
	// TODO Implement the KPIS update once the JSON are OK.
		update(500);
}

function updatepageJSON(str, element) {

	var objs = JSON.parse(str);
	for (i = 0; i < objs.kpi.length; i++) {

		document.getElementById(element).innerHTML = objs.kpi[i].is_vip;
	}
	// TODO Implement the KPIS update once the JSON are OK.
}

/**
 * This function intend to sleep the javascript update.
 * 
 * @author rbrossi
 * 
 * @param millis
 *            time to sleep
 */
function sleep(millis) {
	// var date = new Date();
	// var curDate = null;
	// do {
	// curDate = new Date();
	// } while (curDate - date < millis);

	console.log("HELLO");
	setTimeout(function() {
		console.log("THIS IS");
	}, millis);
	console.log("DOG");
}

/**
 * This function update the entire application KPIS
 * 
 * @author rbrossi
 */
function update(millis) {
	

	var e = new Date().getTime() + (1 * millis);
	  while (new Date().getTime() <= e) {
		  //xmlhttpPost("kpi.jsp", "kpi", "result");  
		  console.log("KPI UPDATED");
	  }

}

/* Clone object*/ 
function cloneObject(obj) {
    
	if (obj === null || typeof obj !== 'XMLHttpRequest') {
        return obj;
    }
 
   /*var temp = obj.constructor(); // give temp the original obj's constructor*/ 
    var temp = new XMLHttpRequest();
    for (var key in obj) {
        temp[key] = cloneObject(obj[key]);
    }
 
    return temp;
}