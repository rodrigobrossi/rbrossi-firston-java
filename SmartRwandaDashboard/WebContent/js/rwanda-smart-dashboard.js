/**
 * Rwanda Smart Dashboard IBM Copyright 2015
 * 
 * @author: Rodrigo Luis Nolli Brossi
 * @file rwanda_smart_dashboard.js
 * @param strURL
 * @param name
 * @param element
 */

// register worker

/**
 * This function updates the page
 * 
 * @param str
 *            JSON data
 * @param element
 *            HTML element to be updated, if null the JSON one of the attriutes
 *            will be used to name the HTML component.
 */

/**
 * This function update the entire application KPIS
 * 
 * @author rbrossi
 */
function update() {
	var worker = new Worker('js/rwanda-smart-dashboard-worker.js');

	console.log("Update start:"+ new Date());
	
	worker.onmessage = function(e) {
		console.log("Start update:"+ new Date())
		document.getElementById("result").innerHTML = e.data.updatepage;
		console.log("Start ends:"+ new Date()+""+e.data.updatepage);
	};

	worker.onerror = function(e) {
		alert('Error: Line ' + e.lineno + ' in ' + e.filename + ': '
				+ e.message);
	};
	
	var browser = 0 ;

	/* Mozilla/Safari*/
	if (window.XMLHttpRequest) {
		browser =1; 
	}
	/* IE*/ 

	worker.postMessage({
		'cmd' : 'xmlhttpPost',
		'value' : 'kpi.jsp'
	});
	
	console.log("worker post message:"+ new Date());
}
