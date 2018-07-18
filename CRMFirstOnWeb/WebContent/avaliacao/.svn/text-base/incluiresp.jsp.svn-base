<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="java.sql.*"%>
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");

	try {
		request.getSession();
		FOLocalizationBean trd = (FOLocalizationBean) session
				.getAttribute("Traducao");
		FODBConnectionBean conexao = (FODBConnectionBean) session
				.getAttribute("Conexao");

		String cod_per = "", n_grupo = "", nome_box = "", cod = "", gp_cod = "", query = "", reload = "", tipo = "";
		ResultSet rs;
		int cont_grupo = 0;

		if (request.getParameter("per_cod") != null)
			cod_per = request.getParameter("per_cod");
		if (request.getParameter("cod") != null)
			cod = request.getParameter("cod");
		if (request.getParameter("sel_gp") != null)
			gp_cod = request.getParameter("sel_gp");
		if (request.getParameter("reloaded") != null)
			reload = request.getParameter("reloaded");

		query = "SELECT PER_NOME, PER_TIPO FROM PERGUNTA WHERE PER_CODIGO = "
				+ cod_per;
		rs = conexao.executaConsulta(query, session.getId() + "RS_1");

		if (rs.next()) {
			tipo = rs.getString(2).trim();
		}
%>


<html>
<head>
<title>FirstOn</title>
<script language="JavaScript" src="/js/scripts.js"></script>
<script language="JavaScript">
function insere(){
    if (frm.txt_peso.value == "") {
        alert(<%=("\"" + trd.Traduz("Favor digitar o peso!") + "\"")%>);
        return false;
    }
    if (<%=tipo.equals("N")%>) {//numerica
        if ((frm.valor_min.value == "") || (frm.valor_max.value == "")) {
            alert(<%=("\""
										+ trd
												.Traduz("Favor digitar valor minimo e maximo!") + "\"")%>);
            return false;
        }
    }
    //if (<%=tipo.equals("D")%>) {//dissertativa
    //    if (frm.txt_resp.value == "") {
    //        alert(<%=("\""
										+ trd
												.Traduz("Favor digitar uma resposta!") + "\"")%>);
    //        return false;
    //    }
    //}
    document.value = "";
    window.close();
}

function numero2(campo){
  aux = campo.value;
  tam = aux.length;
  i = 0;
  nova = "";
  while(i != tam){
    aux2 = aux.substring(i,i+1);
    if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" && aux2 != "4" &&
       aux2 != "5" && aux2 != "6" && aux2 != "7" && aux2 != "8" && aux2 != "9"){
      nova = nova;
    }
    else{
      nova = nova + aux2;
    }
    i++;
  }
  campo.value = nova;
}
function numero(campo){
  aux = campo.value;
  tam = aux.length
  aux2 = aux.substring(tam-1,tam);
  if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" && aux2 != "4" &&
     aux2 != "5" && aux2 != "6" && aux2 != "7" && aux2 != "8" && aux2 != "9"){
    aux = campo.value;
    aux = aux.length;
    aux = aux - 1;
    pal = campo.value;
    campo.value = pal.substring(0, aux);
  }
}
function aspa(campo){
  aux = campo.value;
  tam = aux.length
  aux2 = aux.substring(tam-1,tam);
  if(aux2 == "\"" || aux2 == "\'"){
    aux = campo.value;
    aux = aux.length;
    aux = aux - 1;
    pal = campo.value;
    campo.value = pal.substring(0, aux);
  }
}
function aspa2(campo){
  aux = campo.value;
  tam = aux.length;
  i = 0;
  nova = "";
  while(i != tam){
    aux2 = aux.substring(i,i+1);
    if(aux2 == "\"" || aux2 == "\'")
      nova = nova;
    else
      nova = nova + aux2;
    i++;
    
  }
  campo.value = nova;
}
</script>

<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<body onunload='return fecha();' marginwidth="0" marginheight="0"
	leftmargin="no" rightmargin="no" scroll="yes">
<FORM name="frm" action="questionariograva2.jsp" method="POST"
	target="_parent">
<table width="100%" border="0" cellspacing="1" cellpadding="0">
	<tr>
		<td class="celtittab" colspan="100%"><%=trd.Traduz("PERGUNTA")%>:
		<%=rs.getString(1)%></td>
	</tr>
	<tr>
		<td class="celnortab" colspan="100%"><b><%=trd.Traduz("PESO")%>:</b><br>
		<input type="text" name="txt_peso" onBlur="numero2(this)"
			onKeyUp="numero(this)"></td>
	</tr>
	<%
		if (tipo.equals("D")) { //dissertativa
	%>
	<tr>
		<td class="celnortab" valign="top"><b><%=trd.Traduz("RESPOSTA")%>:</b><br>
		<textarea cols="50" rows="6" name="txt_resp" onBlur="aspa2(this)"
			onKeyUp="aspa(this)"></textarea></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<input type="hidden" name="sel_resp" value="">
	<%
		} else if (tipo.equals("ME")) { //multipla escolha
	%>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="celnortab" valign="top"><b><%=trd.Traduz("GRUPO DE RESPOSTAS")%>:</b>
			</td>
		</tr>
	</table>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<%
				query = "SELECT RG.QGR_GRUPO, R.RES_NOME, RG.QGR_VALOR FROM RESPGRUPO RG, RESPOSTA R "
								+ "WHERE RG.RES_CODIGO = R.RES_CODIGO "
								+ "ORDER BY QGR_GRUPO";

						if (rs != null) {
							rs.close();
							conexao.finalizaConexao(session.getId() + "RS_1");
						}

						rs = conexao.executaConsulta(query, session.getId()
								+ "RS_2");
						if (rs.next()) {
							n_grupo = rs.getString(1);
							do {
								if (n_grupo.equals(rs.getString(1))) {
									//out.println("Comp: " + n_grupo + ":" + rs2.getInt(1) + "Nome:" + nome);
									nome_box = nome_box + rs.getString(1) + "("
											+ rs.getString(2) + "); ";
								} else {
			%>
			<tr>
				<td class="celnortab" valign="top">
				<%
					if (cont_grupo == 0) {
				%> <input type="radio"
					name="sel_resp" value="<%=n_grupo%>" checked><%=nome_box%>
				<%
					} else {
				%> <input type="radio" name="sel_resp"
					value="<%=n_grupo%>"><%=nome_box%> <%
 	}
 %>
				</td>
			</tr>
			<%
				n_grupo = rs.getString(1);
									nome_box = rs.getString(1) + "("
											+ rs.getString(2) + ");";
									cont_grupo++;
								}
							} while (rs.next());
			%>
			<tr>
				<td class="celnortab" valign="top">
				<%
					if (cont_grupo == 0) {
				%> <input type="radio"
					name="sel_resp" value="<%=n_grupo%>" checked><%=nome_box%>
				<%
					} else {
				%> <input type="radio" name="sel_resp"
					value="<%=n_grupo%>"><%=nome_box%> <%
 	}
 %>
				</td>
			</tr>
			<%
				}
			%>
			<tr>
				<td>&nbsp;<input type="hidden" name="txt_resp" value=""></td>
			</tr>
		</table>
		</td>
	</tr>
	<%
		} else if (tipo.equals("N")) {
	%>
	<tr>
		<td class="celnortab" valign="top"><b><%=trd.Traduz("VALOR MINIMO")%>:</b><br>
		<input type="text" name="valor_min" size="5" maxlength="5"
			onBlur="numero2(this)" onKeyUp="numero(this)">&nbsp;&nbsp;</td>
		<td class="celnortab" valign="top"><b><%=trd.Traduz("VALOR MAXIMO")%>:</b><br>
		<input type="text" name="valor_max" size="5" maxlength="5"
			onBlur="numero2(this)" onKeyUp="numero(this)"></td>
	</tr>
	<tr>
		<td><input type="hidden" name="txt_resp" value="">&nbsp;
		<input type="hidden" name="sel_resp" value=""></td>
	</tr>
	<%
		}
	%>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" colspan="100%" bgcolor='#FFFFFF'><input
				type="submit" value="        OK        " class="botcin"
				onClick="return insere();">&nbsp; <input type="button"
				value="CANCELAR" class="botcin" onClick="JavaScript:window.close();">
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
	</table>
	<input type="hidden" name="tipo" value="I">
	<input type="hidden" name="tipo_resp" value="<%=tipo%>">
	<input type="hidden" name="cod_per" value="<%=cod_per%>">
	<input type="hidden" name="cod" value="<%=cod%>">
	<input type="hidden" name="gp_cod" value="<%=gp_cod%>">
</table>
</form>
</body>
</html>
<%
	if (rs != null) {
			rs.close();
			conexao.finalizaConexao(session.getId() + "RS_2");
		}

	} catch (Exception e) {
		out.println("Erro: " + e);
	}
%>
