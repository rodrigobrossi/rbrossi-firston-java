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