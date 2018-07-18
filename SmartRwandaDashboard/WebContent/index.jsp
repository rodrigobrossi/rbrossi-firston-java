<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<title>Rwanda Smart DashBoard - PoC 1.0</title>
<link rel="stylesheet" href="css/styles.css">

<script src="js/jquery-1.6.2.min.js" type="text/javascript"></script>
<script src="js/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>

<script src="js/AquaGauge.js" type="text/javascript"></script>
<script src="js/helper.js" type="text/javascript"></script>

<!--  script src="js/rwanda-smart-dashboard-meters.js" type="text/javascript"></script -->

<script type="text/javascript">

var worker = new Worker('js/rwanda-smart-dashboard-worker.js');

function update() {

		console.log("Update start:" + new Date());

		worker.onmessage = function(e) {
			document.getElementById("result").innerHTML = e.data.updatepage;
		};

		worker.onerror = function(e) {
			alert('Error: Line ' + e.lineno + ' in ' + e.filename + ': '
					+ e.message);
		};

		var browser = 0;

		/* Mozilla/Safari*/
		if (window.XMLHttpRequest) {
			browser = 1;
		}
		/* IE*/

		worker.postMessage({
			"cmd" : "xmlhttpPost",
			"value" : "http://<%=request.getServerName()%>:<%=request.getServerPort()%>/SmartRwandaDashboard/kpi.jsp"
				});
	}
</script>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body class=".body" onload="update()">

	<table>
		<tbody>
			<tr>
				<td width="100%" height="100%" colspan="3" align="justify"
					bgcolor="#1D3649">

					<div class="header">
						<table width="100%">
							<tbody>
								<tr >
									<td ><img alt="MYICT Logo"
										src="images/MYICT_toplogo.png" width="35px" height="35px" />&nbsp;&nbsp;&nbsp;Smart
										Rwanda Dashboard - PoC &nbsp;</td>
									<td  align="right"><img alt="MYICT Logo"
										src="images/user-profile_24.png" /> <img alt="MYICT Logo"
										src="images/settings-manage_24.png" /> <img alt="MYICT Logo"
										src="images/search_24.png" />
										</td>
								</tr>
							</tbody>
						</table>
					</div>

					<div id="menu" align="right">
						<ul>
							<li>Dashboard</li>
							<li>Projects</li>
							<li>Events</li>
							<li>Citizen Connection</li>
							<li>Reports</li>
						</ul>
					</div>
				</td>

			</tr>
			<tr>
				<td width="75%" align="center" valign="middle">
					<div> <font face="Helvetica" size="2" color="#777777"><blink>PoC
							- Proof of Concept: Not Functional</blink></font>

					<div id="result" style="vertical-align: left;">
						<jsp:include page="kpi.jsp"></jsp:include>
					</div>
				</td>
				<td width="25%"
					style="padding: 5px; vertical-align: top; width: 200; text-align: center;"
					rowspan="3">
					<div >
						<iframe id="rwanda"
							src="https://www.google.com/maps/embed?pb=!1m10!1m8!1m3!1d1020804.7681908224!2d30.095342850000005!3d-1.9454362999999935!3m2!1i1024!2i768!4f13.1!5e0!3m2!1spt-BR!2sbr!4v1439300056797"
							width="350" height="400" style="border: 0"></iframe>
						<br> <br>
						<!--  -canvas id="gauge" width="250" height="250">Sorry, your
						browser is very old. Please upgrade.</canvas -->
					</div> &nbsp;
				</td>
			</tr>
			<tr height="%" bgcolor="#F0F0F0">
				<td colspan="2"><font face="Helvetica" size="4" color="#777777">
						Infrastructure KPIs</font>
					<div id="infra">
						<font face="Helvetica" size="2" color="#777777">PoC - Not
							Functional: </font>
					</div></td>
			</tr>
			<tr height="20%" bgcolor="#F0F0F0">
				<td colspan="2"><font face="Helvetica" size="4" color="#777777">
						Cyber Secutiry KPIs</font>
					<div id="cyber">
						<font face="Helvetica" size="2" color="#777777"><blink>PoC
								- Not Functional:</blink></font>
					</div></td>
			</tr>
		</tbody>
	</table>
	<form name="kpi">
		<p>
			<input name="word" type="hidden"
				onblur='JavaScript:xmlhttpPost("kpi.jsp","kpi","result" )'
				onkeyup='JavaScript:xmlhttpPost("kpi.jsp","kpi","result" )'>
		</p>
	</form>
</body>
</html>