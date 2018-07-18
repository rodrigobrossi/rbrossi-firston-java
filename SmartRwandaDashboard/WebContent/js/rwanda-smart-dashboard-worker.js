/**
 * Rwanda Smart Dashboard IBM Copyright 2015
 * 
 * @author: Rodrigo Luis Nolli Brossi
 * @file rwanda_smart_dashboard.js
 * @param strURL
 */

var xmlhttp = null;

function xmlhttpPost(strURL) {

	xmlhttp = new XMLHttpRequest();

	self.xmlHttpReq = xmlhttp;
	self.xmlHttpReq.open('POST',
			"http://localhost:9080/SmartRwandaDashboard/kpi.jsp", false);
	self.xmlHttpReq.open('POST', strURL, false);

	self.xmlHttpReq.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded');
	self.xmlHttpReq.overrideMimeType("text/plain");

	var ok = false

	self.xmlHttpReq.send();

	if (self.xmlHttpReq.readyState !== 4)
		return 

			

	self.postMessage({
		'updatepage' : self.xmlHttpReq.responseText
	});
}

// wait for the start 'CalculatePi' message
// e is the event and e.data contains the JSON object
self.onmessage = function(e) {

	var value = e.data.value;

	var time = 5000;

	var mim = new Date().getTime() + (time);

	while (true) {
		if (new Date().getTime() <= mim) {
			xmlhttpPost(value)
			mim = new Date().getTime() + (time);
		}
	}

}
