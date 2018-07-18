
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conn = (FODBConnectionBean) session
			.getAttribute("Conexao");

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	String obrigatorio = (String) request.getParameter("obrigatorio");
	String cargo = "", titulo = "";

	String query = "SELECT CAR_CODIGO, TIT_CODIGO FROM PLANOCARREIRA WHERE PLC_CODIGO = "
			+ request.getParameter("codigo");
	ResultSet rs = null, rs1 = null;

	rs = conn.executaConsulta(query, session.getId() + "RS_1");
	if (rs.next()) {
		cargo = rs.getString(1);
		titulo = rs.getString(2);
	}
	if (rs != null) {
		rs.close();
		conn.finalizaConexao(session.getId() + "RS_1");
	}

	//try{
%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Cadastro")%> - <%=trd.Traduz("ALTERACAO DE PRE-REQUISITOS")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<script language="JavaScript">
function checa()
{
  if(frm.sel_titulo.value=="false")
  {
    alert("Selecione uma opCAo valida!");
    frm.sel_titulo.focus();
    return false;
  }
  else if(frm.sel_cargo.value=="false")
  {
    alert("Selecione uma opCAo valida!");
    frm.sel_cargo.focus();
    return false;
  }
  else 
    return true;
}
</script>
<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','art/onenglish.gif','art/onespanol.gif')">
<FORM action="valida_prerequisitos.jsp" name="frm" method="POST">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	height="100%">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="59" class="hcfundo">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<%
							String ponto = (String) session.getAttribute("barra");
							if (ponto.equals("..")) {
						%>
						<jsp:include page="../menu/banner.jsp" flush="true">
							<jsp:param value="opt" name="CA" />
						</jsp:include>
						<%
							} else {
						%>
						<jsp:include page="/menu/banner.jsp" flush="true">
							<jsp:param value="opt" name="CA" />
						</jsp:include>
						<%
							}
						%>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="mnfundo"><img src="../art/bit.gif" width="12"
					height="5"></td>
			</tr>
			<tr>
				<td height="25" class="mnfundo">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<%
							String oi = "", oia = "";
							if (ponto.equals("..")) {
								if (request.getParameter("op") == null) {
									oi = "../menu/menu.jsp?op=" + "C";
								} else {
									oi = "../menu/menu.jsp?op=" + request.getParameter("op");
								}
								if (request.getParameter("opt") == null) {
									oia = "../menu/menu1.jsp?opt=" + "PR";
								} else {
									oia = "../menu/menu1.jsp?opt="
											+ request.getParameter("opt");
								}
							} else {
								if (request.getParameter("op") == null) {
									oi = "/menu/menu.jsp?op=" + "C";
								} else {
									oi = "/menu/menu.jsp?op=" + request.getParameter("op");
								}
								if (request.getParameter("opt") == null) {
									oia = "/menu/menu1.jsp?opt=" + "PR";
								} else {
									oia = "/menu/menu1.jsp?opt=" + request.getParameter("opt");
								}

							}
						%>
						<jsp:include page="<%=oi%>" flush="true"></jsp:include>
					</tr>
				</table>
				</td>
			</tr>
			<jsp:include page="<%=oia%>" flush="true"></jsp:include>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="20">&nbsp;</td>
				<td width="100%" align="center">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="13"><img src="../art/bit.gif" width="13"
							height="15"></td>
						<td class="trontrk" width="297" align="center"><%=trd.Traduz("ALTERACAO DE PRE-REQUISITOS")%></td>
						<td width="29"><img src="../art/bit.gif" width="13"
							height="15"></td>
					</tr>
				</table>
				</td>
				<td width="20">&nbsp;</td>
			</tr>
			<tr>
				<td width="20" height="1"><img src="../art/bit.gif" width="1"
					height="1"></td>
				<td valign="top" class="ctvdiv"><img src="../art/bit.gif"
					width="1" height="1"></td>
				<td width="20"><img src="../art/bit.gif" width="1" height="1"></td>
			</tr>
			<tr>
				<td width="20" valign="top"></td>

				<td valign="top"><img src="../art/bit.gif" width="159"
					height="1">&nbsp;<br>
				<center>
				<table border="0" cellspacing="2" cellpadding="3" width="90%">
					<tr class="celnortab">
						<td colspan="3" height="150">
						<p><%=trd.Traduz("TITULO")%> <br>
						<br>
						<input type="hidden" name="plc_codigo"
							value=<%=("\"" + request.getParameter("codigo") + "\"")%>> <select
							name="sel_titulo">
							<%
								String query1 = "SELECT tit_codigo, tit_nome FROM titulo ORDER BY TIT_NOME";
								rs1 = conn.executaConsulta(query1, session.getId());
								while (rs1.next()) {
									if (rs1.getInt(1) == Integer.parseInt(titulo)) {
							%>
							<option value="<%=rs1.getInt(1)%>" selected><%=rs1.getString(2)%>
							<%
								} else {
							%>
							
							<option value="<%=rs1.getInt(1)%>"><%=rs1.getString(2)%>
							<%
								}
								}
								if (rs1 != null) {
									conn.finalizaConexao(session.getId());
								}
							%>
							
						</select></p>

						<p><%=trd.Traduz("CARGO")%> <br>
						<br>
						<select name="sel_cargo">
							<%
								query = "SELECT car_codigo, car_nome FROM cargo ORDER BY CAR_NOME";
								rs = conn.executaConsulta(query, session.getId() + "RS_2");
								while (rs.next()) {
									if (rs.getInt(1) == Integer.parseInt(cargo)) {
							%>
							<option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%>
							<%
								} else {
							%>
							
							<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%> <%
 	}
 	}
 	if (rs != null) {
 		conn.finalizaConexao(session.getId() + "RS_2");
 	}
 %>
							
						</select></p>
						<p>
						<%
							if (obrigatorio.equals("S")) {
						%> <input type="radio" name="rdo_req_des" value="S" checked>
						<%=trd.Traduz("REQUERIDO")%> &nbsp; &nbsp; &nbsp;<input
							type="radio" name="rdo_req_des" value="N"> <%=trd.Traduz("DESEJADO")%><br>
						<%
							} else if (obrigatorio.equals("N")) {
						%> <input type="radio" name="rdo_req_des" value="S"> <%=trd.Traduz("REQUERIDO")%>
						&nbsp; &nbsp; &nbsp;<input type="radio" name="rdo_req_des"
							value="N" checked> <%=trd.Traduz("DESEJADO")%><br>
						<%
							}
						%> <input type="hidden" name="update" value="S">
						</td>
					</tr>
					<tr>
						<td align="center" colspan="3">&nbsp;<br>
						<input type="submit" class="botcin"
							value="       <%=trd.Traduz("OK")%>       "
							onClick="return checa();">&nbsp; <input type="button"
							class="botcin" value=<%=("\"" + trd.Traduz("CANCELAR") + "\"")%>
							onClick="JavaScript:window.open('prerequisitos.jsp','_self')">
						</td>
					</tr>
				</table>
				<p>&nbsp;
				</center>
				</td>

				<td width="20" valign="top"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td align="right" height="30" class="difundo">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<%
					if (ponto.equals("..")) {
				%> <jsp:include page="../rodape/rodape.jsp"
					flush="true"></jsp:include> <%
 	} else {
 %> <jsp:include
					page="/rodape/rodape.jsp" flush="true"></jsp:include> <%
 	}
 %>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</FORM>
</body>
</html>
<%
	/*if(rs != null)
	 rs.close();
	 conn.finalizaConexao();

	 conn1.finalizaConexao();
	 conn1.finalizaBD();
	 //} catch(Exception e) {
	 //  out.println(e);
	 //}*/
%>