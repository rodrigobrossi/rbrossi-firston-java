<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.util.*"%>
<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOParametersBean"%>

<jsp:useBean id="cmb" scope="page" class="firston.eval.components.FODynamicComboBean" />
<jsp:useBean id="pos" scope="page" class="firston.eval.components.FOUserPositionBean" />

<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session.getAttribute("Conexao");
	FOParametersBean prm = (FOParametersBean) session.getAttribute("Param");

	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");

	request.getSession();
	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	String aplicacao = (String) session.getAttribute("aplicacao");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	Integer usu_cod = (Integer) session.getAttribute("usu_cod");

	boolean existe = false, mostraCheck = false;

	//try {

	String filial = "" + usu_fil;
	String codigo = "" + usu_cod;
	String query = "", query1 = "", query2 = "", tipoOperacao = "";
	ResultSet rs, rs1, rs2;
	Vector vetAvaliacao = new Vector();
	Vector vetFuncionario = new Vector();
	Vector queries = new Vector();
	int cont = 0, cont_func = 0, cont_aval = 0;

	//limpa vetores
	if (request.getParameter("apagavetor") == null) {
		session.setAttribute("vetor_avaliacao", vetAvaliacao);
		session.setAttribute("vetor_funcionario", vetFuncionario);
		//out.println("apagou!!");
	} else {
		vetAvaliacao = (Vector) session.getAttribute("vetor_avaliacao");
		vetFuncionario = (Vector) session
				.getAttribute("vetor_funcionario");
		//out.println("recuperou!!");
	}

	//Insere nos vetores
	if (request.getParameter("tipo_op") != null) {
		tipoOperacao = request.getParameter("tipo_op");
		if (tipoOperacao.equals("IT")) {
			//inclusao de titulo no vetor
			vetFuncionario.add(request.getParameter("cbo_funcionario"));
		}
		if (tipoOperacao.equals("ET")) {
			//exclusao de titulo no vetor
			int qtde = Integer.parseInt(request.getParameter("c_tit"));
			for (int ii = 0; ii <= qtde; ii++) {
				if (request.getParameter("chk_funcionario" + ii) != null) {
					vetFuncionario.removeElement((String) request
							.getParameter("chk_funcionario" + ii));
					//out.println("apagou" + ii + "-" + qtde);
				}
			}
		}
		if (tipoOperacao.equals("IC")) {
			//inclusao de cargo no vetor
			vetAvaliacao.add(request.getParameter("cbo_cargo"));
		}
		if (tipoOperacao.equals("EC")) {//exclusao de titulo no vetor
			int qtde = Integer.parseInt(request.getParameter("c_car"));
			for (int ii = 0; ii <= qtde; ii++) {
				if (request.getParameter("chk_avaliacao" + ii) != null) {
					vetAvaliacao.removeElement((String) request
							.getParameter("chk_avaliacao" + ii));
					//out.println("apagou" + ii + "-" + qtde);
				}
			}
		}
	}

	//conexao.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"));
%>




<html>
<head>
<title>FirstOn - <%=trd.Traduz("CADASTRO")%> - <%=trd
									.Traduz("INCLUSAO DE FUNCIONARIO PARA AVALIACAO")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<script language="JavaScript">
function incluir_tit(){
  if (frm_prereq.cbo_funcionario.value == "") {
    alert(<%=("\""+trd.Traduz("FAVOR SELECIONAR UM FUNCIONARIO")+"\"")%>);
    return false;
    }
    frm_prereq.tipo_op.value = "IT";
    frm_prereq.action = "incluifuncaval.jsp";
    frm_prereq.submit();
    return true;
}

function excluir_tit(){
  var teste = 0;
  for(i=1;i<=frm_prereq.c_tit.value;i++){
    if(eval("frm_prereq.chk_funcionario"+i+".checked")==true){
      teste = teste+1;
    }
  }
  if(teste == 0){
        alert(<%=("\""+trd.Traduz("NENHUM ITEM SELECIONADO")+"\"")%>);
        return false;
    }
    else{
      if(confirm("DESEJA EXCLUIR O ITEM SELECIONADO?")){
        frm_prereq.tipo_op.value = "ET";
        frm_prereq.action = "incluifuncaval.jsp";
        frm_prereq.submit();
        return true;
      }
      else
        return false;
    }
}

function incluir_car(){
  if (frm_prereq.cbo_cargo.value == ""){
    alert(<%=("\""+trd.Traduz("FAVOR SELECIONAR UMA AVALIACAO")+"\"")%>);
    return false;
  }
  frm_prereq.tipo_op.value = "IC";
  frm_prereq.action = "incluifuncaval.jsp";
  frm_prereq.submit();
  return true;
}

function excluir_car(){
  var teste = 0;
  //alert(""+frm_prereq.c_car.value);
  for(i=1;i<=frm_prereq.c_car.value;i++){
    if(eval("frm_prereq.chk_avaliacao"+i+".checked")==true){
      teste = teste+1;
    }
  }
  if(teste == 0){
    alert(<%=("\""+trd.Traduz("NENHUM ITEM SELECIONADO")+"\"")%>);
    return false;
  }
  else{
    if(confirm("DESEJA EXCLUIR O ITEM SELECIONADO?")){
      frm_prereq.tipo_op.value = "EC";
      frm_prereq.action = "incluifuncaval.jsp";
      frm_prereq.submit();
      return true;
    }
    else
      return false;
  }
}

function cancela(){
  window.open("funcionarioavaliacao.jsp", "_parent");
  return true;
}

function grava(){
  alert("UNDER CONSTRUCTION");
  //frm_prereq.action = "valida_prerequisitos.jsp";
  //frm_prereq.submit();
  return true;
}

function tabela5(){
  window.open("inclusaodeprerequisito.jsp?cbo_tabela5="+frm_prereq.cbo_tabela5.value+"&apagavetor=N","_parent");
  return true;
}    
function tabela6(){
  window.open("inclusaodeprerequisito.jsp?cbo_tabela5="+frm_prereq.cbo_tabela5.value+"&cbo_tabela6="+frm_prereq.cbo_tabela6.value+"&apagavetor=N","_parent");
  return true;
}    
function tabela7(){
  window.open("inclusaodeprerequisito.jsp?cbo_tabela5="+frm_prereq.cbo_tabela5.value+"&cbo_tabela6="+frm_prereq.cbo_tabela6.value+"&cbo_tabela7="+frm_prereq.cbo_tabela7.value+"&apagavetor=N","_parent");
  return true;
}    
function tabela8(){
  window.open("inclusaodeprerequisito.jsp?cbo_tabela5="+frm_prereq.cbo_tabela5.value+"&cbo_tabela6="+frm_prereq.cbo_tabela6.value+"&cbo_tabela7="+frm_prereq.cbo_tabela7.value+"&cbo_tabela8="+frm_prereq.cbo_tabela8.value+"&apagavetor=N","_parent");
  return true;
}    
</script>

<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0">
<form name="frm_prereq">
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
							if (ponto.equals("..")) {
						%>
						<jsp:include page="../menu/menu.jsp" flush="true">
							<jsp:param value="op" name="AV" />
						</jsp:include>
						<%
							} else {
						%>
						<jsp:include page="/menu/menu.jsp" flush="true">
							<jsp:param value="op" name="AV" />
						</jsp:include>
						<%
							}
						%>
					</tr>
				</table>
				</td>
			</tr>
			<%
				if (ponto.equals("..")) {
			%>
			<jsp:include page="../menu/menu_avaliacao.jsp" flush="true">
				<jsp:param value="opt" name="AV" />
				<jsp:param value="op" name="FA" />
			</jsp:include>
			<%
				} else {
			%>
			<jsp:include page="/menu/menu_avaliacao.jsp" flush="true">
				<jsp:param value="opt" name="AV" />
				<jsp:param value="op" name="FA" />
			</jsp:include>
			<%
				}
			%>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="20">&nbsp;</td>
				<td width="100%" align="center">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="13"><img src="../art/bit.gif" width="13"
							height="15"></td>
						<td class="trontrk"><%=trd
									.Traduz("INCLUSAO DE FUNCIONARIO PARA AVALIACAO")%></td>
						<td width="13"><img src="../art/bit.gif" width="13"
							height="15"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td width="20" height="1"><img src="../art/bit.gif" width="1"
					height="1"></td>
				<td valign="top" class="ctvdiv"><img src="../art/bit.gif"
					width="1" height="1"></td>
				<td width="20"><img src="../art/bit.gif" width="1" height="1"></td>
			</tr>
		</table>
		<center>
		<%
			String tabela5 = "", tabela6 = "", tabela7 = "", tabela8 = "", opt_filtro = "";
			opt_filtro = "Cargo";//essa tela nao tem esse filtro, por isso cargo sera fixo
			if (request.getParameter("cbo_tabela5") != null)
				tabela5 = request.getParameter("cbo_tabela5");
			else
				tabela5 = "" + usu_fil;
			if (request.getParameter("cbo_tabela6") != null)
				tabela6 = request.getParameter("cbo_tabela6");
			if (request.getParameter("cbo_tabela7") != null)
				tabela7 = request.getParameter("cbo_tabela7");
			if (request.getParameter("cbo_tabela8") != null)
				tabela8 = request.getParameter("cbo_tabela8");

			queries = pos.montaCombo(opt_filtro, "null", "null", aplicacao,
					tabela5, tabela6, tabela7, tabela8);

			//Combos auxiliares para LOTACAO
			if (prm.buscaparam("LOTACAO").equals("S")) {
		%>
		<table border="0" cellspacing="1" cellpadding="0" width="80%">
			<tr>
				<td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
			</tr>
			<tr>
				<td class="ctfontc" align="left" width="50%"><%=trd.Traduz("TABELA5")%>:&nbsp;<br>
				<%
					rs = conexao.executaConsulta((String) queries.elementAt(1),
								"INC_FUNC_CARN");
						//out.println(queries);
						if (rs.next()) {
				%> <select name="cbo_tabela5" onChange="return tabela5();">
					<option value=""><%=trd.Traduz("Todos")%></option>
					<%
						do {
									if ((rs.getInt(1)) == (usu_fil.intValue())
											&& (request.getParameter("cbo_tabela5") == null)) {
					%>
					<option selected value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
					<%
						} else {
										if (request.getParameter("cbo_tabela5") != null
												&& (rs.getString(1).equals(request
														.getParameter("cbo_tabela5")))) {
					%>
					<option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
					<%
						} else {
					%>
					<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
					<%
						}
									}
								} while (rs.next());
					%>
				</select> <%
 	rs = null;
 		}
 %>
				</td>
				<td class="ctfontc" align="left" width="50%"><%=trd.Traduz("TABELA6")%>:&nbsp;<br>

				<%
					//out.println(queries.elementAt(2) + "");
						rs = conexao.executaConsulta((String) queries.elementAt(2),
								"INC_FUNC_CARN");
						if (rs.next()) {
				%> <select name="cbo_tabela6" onChange="return tabela6();">
					<option value="" selected><%=trd.Traduz("Todos")%></option>
					<%
						do {
									if (tabela6.equals(rs.getString(1))) {
					%>
					<option selected value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
					<%
						} else {
					%>
					<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
					<%
						}
								} while (rs.next());
					%>
				</select> <%
 	rs = null;
 		}
 %>
				</td>
			</tr>
			<tr>
				<td class="ctfontc" align="left" width="50%"><%=trd.Traduz("TABELA7")%>:&nbsp;<br>
				<%
					rs = conexao.executaConsulta((String) queries.elementAt(3),
								"INC_FUNC_CARN");
						if (rs.next()) {
				%> <select name="cbo_tabela7" onChange="return tabela7();">
					<option value="" selected><%=trd.Traduz("Todos")%></option>
					<%
						do {
									if (tabela7.equals(rs.getString(1))) {
					%>
					<option selected value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
					<%
						} else {
					%>
					<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
					<%
						}
								} while (rs.next());
					%>
				</select> <%
 	rs = null;
 		}
 %>
				</td>
				<td class="ctfontc" align="left" width="50%"><%=trd.Traduz("TABELA8")%>:&nbsp;<br>
				<%
					rs = conexao.executaConsulta((String) queries.elementAt(4),
								"INC_FUNC_CARN");
						if (rs.next()) {
				%> <select name="cbo_tabela8" onChange="return tabela8();">
					<option value="" selected><%=trd.Traduz("Todos")%></option>
					<%
						do {
									if (tabela8.equals(rs.getString(1))) {
					%>
					<option selected value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
					<%
						} else {
					%>
					<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
					<%
						}
								} while (rs.next());
					%>
				</select> <%
 	rs = null;
 		}
 %>
				</td>
			</tr>
		</table>
		<%
			}
		%>

		<table border="0" cellspacing="1" cellpadding="0" width="80%">
			<tr>
				<td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
			</tr>
			<tr>
				<td class="ctfontc" align="left"><%=trd.Traduz("AVALIACAO")%>:
				<select name="cbo_cargo">
					<option value=""><%=trd.Traduz("Selecione")%></option>
					<%
						String queryA = "SELECT AVA_CODIGO, AVA_DESCRICAO FROM AVALIACAO";
						ResultSet rsA = conexao.executaConsulta(queryA, "INC_FUNC_CARN");
						if (rsA.next()) {
							do {
								if (!vetAvaliacao.contains(rsA.getString(1))) {
					%>
					<option value="<%=rsA.getString(1)%>"><%=rsA.getString(2)%></option>
					<%
						}
							} while (rsA.next());
						}
					%>
				</select> &nbsp;&nbsp; <input type="button" class="botcin" name="btn_inc"
					value=<%=("\""+trd.Traduz("incluir")+"\"")%> onclick="return incluir_car();">
				&nbsp; <input type="button" class="botcin" name="btn_del"
					value=<%=("\""+trd.Traduz("excluir")+"\"")%> onclick="return excluir_car();">
				</td>
			</tr>
		</table>
		<table border="0" cellspacing="1" cellpadding="0" width="80%">
			<tr>
				<td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
			</tr>
			<tr>
				<td width="70%" class="celtittab" colspan="2">AVALIACOES</td>
			</tr>

			<%
				query2 = "SELECT AVA_CODIGO, AVA_DESCRICAO FROM AVALIACAO ";
				if (!vetAvaliacao.isEmpty()) {
					query2 = query2 + "WHERE ";
					for (int i = 0; i < vetAvaliacao.size(); i++) {
						if (i != 0)
							query2 = query2 + " OR ";
						query2 = query2 + "AVA_CODIGO = "
								+ vetAvaliacao.elementAt(i) + " ";
					}
					query2 = query2 + " ORDER BY AVA_DESCRICAO";
					//out.println(query2);

					rs2 = conexao.executaConsulta(query2, "INC_FUNC_CARN");
					if (rs2.next()) {
						cont_aval = 0;
						try {
							do {
								cont_aval++;
			%>
			<tr class="celnortab">
				<td width="3%" align="center"><input type="checkbox"
					name="chk_avaliacao<%=cont_aval%>" value="<%=rs2.getInt(1)%>">
				</td>
				<td width="66%"><%=rs2.getString(2)%></td>
			</tr>
			<%
				} while (rs2.next());
						} catch (Exception e) {//out.println(""+e);
						}
					}
				} else {
			%>
			<tr class="celnortab">
				<td width="3%">&nbsp;</td>
				<td width="66%"><%=trd.Traduz("NENHUM ITEM ADICIONADO")%>...</td>
			</tr>
			<%
				}
			%>

		</table>

		<table border="0" cellspacing="1" cellpadding="0" width="100%">
			<tr>
				<td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
			</tr>
			<tr>
				<td width="20" height="1"><img src="../art/bit.gif" width="1"
					height="1"></td>
				<td valign="top" class="ctvdiv"><img src="../art/bit.gif"
					width="1" height="1"></td>
				<td width="20"><img src="../art/bit.gif" width="1" height="1"></td>
			</tr>
			<tr>
				<td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
			</tr>
		</table>

		<table border="0" cellspacing="1" cellpadding="0" width="80%">
			<tr>
				<td class="ctfontc" align="left">FUNCIONARIO: <select
					name="cbo_funcionario">
					<option value=""><%=trd.Traduz("Selecione")%></option>
					<%
						query1 = "SELECT FUN_CODIGO, FUN_NOME FROM FUNCIONARIO WHERE FUN_DEMITIDO <> 'S' ORDER BY FUN_NOME ";
						rs1 = conexao.executaConsulta(query1, "INC_FUNC_CARN");
						while (rs1.next()) {
							//cont_func++;
							if (vetFuncionario.contains(rs1.getString(1))) {
					%>
					<!--nao insere no combo os intens que ja estao na grid-->
					<%
						} else {
					%>
					<option value="<%=rs1.getInt(1)%>"><%=rs1.getString(2)%></option>
					<%
						}
						}
					%>
				</select> &nbsp;&nbsp; <input type="button" class="botcin" name="btn_inc"
					value=<%=("\""+trd.Traduz("incluir")+"\"")%> onclick="return incluir_tit();">
				&nbsp; <input type="button" class="botcin" name="btn_del"
					value=<%=("\""+trd.Traduz("excluir")+"\"")%> onclick="return excluir_tit();">
				</td>
			</tr>
		</table>

		<table border="0" cellspacing="1" cellpadding="0" width="80%">
			<tr>
				<td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
			</tr>
			<tr>
				<td width="70%" class="celtittab" colspan="2">FUNCIONARIOS</td>
			</tr>

			<%
				query2 = "SELECT FUN_CODIGO, FUN_NOME FROM FUNCIONARIO ";
				if (!vetFuncionario.isEmpty()) {
					query2 = query2 + "WHERE ";
					for (int i = 0; i < vetFuncionario.size(); i++) {
						if (i != 0)
							query2 = query2 + " OR ";
						query2 = query2 + "FUN_CODIGO = "
								+ vetFuncionario.elementAt(i);
					}
					query2 = query2 + " ORDER BY FUN_NOME";
					//out.println(query2);

					rs2 = conexao.executaConsulta(query2, "INC_FUNC_CARN");
					if (rs2.next()) {
						cont_func = 0;
						try {
							do {
								cont_func++;
			%>
			<tr class="celnortab">
				<td width="3%" align="center"><input type="checkbox"
					name="chk_funcionario<%=cont_func%>" value="<%=rs2.getString(1)%>">
				</td>
				<td width="66%"><%=rs2.getString(2)%></td>
				<%
					} while (rs2.next());
							} catch (Exception e) {//out.println(""+e);
							}
						}
					} else {
				%>
			
			<tr class="celnortab">
				<td width="3%">&nbsp;</td>
				<td width="66%"><%=trd.Traduz("NENHUM ITEM ADICIONADO")%>...</td>
			</tr>
			<%
				}
			%>
		</table>

		<table border="0" cellspacing="1" cellpadding="0" width="100%">
			<tr>
				<td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
			</tr>
			<tr>
				<td width="20" height="1"><img src="../art/bit.gif" width="1"
					height="1"></td>
				<td valign="top" class="ctvdiv"><img src="../art/bit.gif"
					width="1" height="1"></td>
				<td width="20"><img src="../art/bit.gif" width="1" height="1"></td>
			</tr>
			<tr>
				<td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
			</tr>
		</table>

		<table border="0" cellspacing="1" cellpadding="0" width="100%">
			<tr>
				<td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
			</tr>
			<tr>
				<td align="center" colspan="100%"><input type="button"
					class="botcin" name="btn_inc"
					value="        <%=trd.Traduz("OK")%>        "
					onclick="return grava();"> &nbsp; <input type="button"
					class="botcin" name="btn_del" value=<%=("\""+trd.Traduz("cancelar")+"\"")%>
					onclick="return cancela();"></td>
			</tr>
			<tr>
				<td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
			</tr>
		</table>
		</center>
		<input type="hidden" name="apagavetor" value="N"> <!--verifica se apaga o vetor da secao-->
		<input type="hidden" name="tipo_op"> <!--tipo da operacao (inclusao de funcionario ou avaliacao-->
		<input type="hidden" name="c_tit" value="<%=cont_func%>"> <!--contador funcionario-->
		<input type="hidden" name="c_car" value="<%=cont_aval%>"> <!--contador avaliacao-->

		</td>
	</tr>

	<tr>
		<td align="right" height="30" class="difundo">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<%
					if (ponto.equals("..")) {
				%> <jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include>
				<%
					} else {
				%> <jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>
				<%
					}
				%>
				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>
</form>
</body>

</html>
<%
	//} catch (Exception e) {
	//  out.println("Erro:"+e);
	//}
%>