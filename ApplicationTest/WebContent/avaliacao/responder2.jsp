<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.lang.Math.*,java.util.*,java.text.*"%>
<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	String avaliacao = "", fun_codigo = "", query = "", pro_codigo = "", cod = "", questionario = "", proposta = "", tipo = "", cod_que = "";

	ResultSet rs = null, rs1 = null;

	if (request.getParameter("cod") != null) {
		cod = request.getParameter("cod");
	}
	if (request.getParameter("fun_cod") != null) {
		fun_codigo = request.getParameter("fun_cod");
	}
	if (request.getParameter("pro_codigo") != null) {
		pro_codigo = request.getParameter("pro_codigo");
	}

	query = "SELECT Q.QUE_CODIGO, Q.QUE_NOME, Q.QUE_COMENTARIO, Q.AVA_CODIGO, A.AVA_DESCRICAO "
			+ "FROM QUESTIONARIO Q, PROCESSO P, AVALIACAO A "
			+ "WHERE P.PRO_CODIGO = "
			+ pro_codigo
			+ " "
			+ "AND P.QUE_CODIGO = Q.QUE_CODIGO";

	rs = conexao.executaConsulta(query, session.getId());
	if (rs.next()) {
		cod_que = rs.getString(1);
		avaliacao = rs.getString(5);
		questionario = rs.getString(2);
		proposta = rs.getString(3);
	}
	if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId());
	}
%>



<html>
<head>
<title>FirstOn - <%=trd.Traduz("AVALIACAO")%> - <%=trd.Traduz("RESPONDER")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>

<script language="JavaScript">
function envia(){
  naopode = false;
  for (i = 1; i <= document.frm.aux.value; i++){
    t = eval("document.frm.resp"+i);
    for (j = 0; j <= t.length-1; j++){
      if (eval("t["+j+"].checked"))
        naopode = true;
    }      
    if(!naopode){
      alert(" "+i+"ª "+ <%=(""
									+ trd
											.Traduz("PERGUNTA DE MULTIPLA ESCOLHA NAO RESPONDIDA") + "\"")%>);
      //window.open("#perg"+i,"_self");
      naopode = true;
      break;
    }
    else{
      naopode = false;
    }
  }
  if(naopode == false){
    p = document.frm.qtde_numericas.value;
    nao = 0;
    if(p != 0){
      for (i = 1; i <= p; i++){
        //recupera o valor digitado na resposta da questão numérica//
        x = eval("document.frm.num_"+i+".value")
        if(x == ""){
          alert(<%=("\""
									+ trd
											.Traduz("E OBRIGATORIO RESPONDER TODAS AS QUESTOES NUMERICAS") + "\"")%>);
          eval("frm.num_"+i+".focus()");
          return false;
        }
        else{
          //recupera o valor máximo e mínimo da questão numérica//
          m1 = eval("document.frm.num_max"+i+".value")
          m2 = eval("document.frm.num_min"+i+".value")
          //verifica se o valor digitado está dentro do escopo da questão          
          if((x >= m2) && (x <= m1)){
            nao = nao + 1;
            alert(" "+i+"ª "+<%=("\""
									+ trd
											.Traduz("QUESTAO NUMERICA ESTA COM A RESPOSTA FORA DO ESCOPO DEFINIDO") + "\"")%>);
            eval("frm.num_"+i+".value = ''")
            eval("frm.num_"+i+".focus()");
            return false;
          }
        }
      }
    }
    if(nao == 0){
      frm.action="respondergrava.jsp";
      frm.submit();
    }
  }
}

function aspa(campo){
  aux = campo.value;
  tam = aux.length
  aux2 = aux.substring(tam-1,tam);
//verifica o tamanho da string//
  nova = "";
  if(tam >= 500){
    nova = aux.substring(0,500);
  }
  else{
    nova = campo.value;
  }
  campo.value = nova;
/////////////////////////////////
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

</script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','solicitacao/../art/onenglish.gif','solicitacao/../art/onespanol.gif')">
<FORM name="frm" method="post">
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
							<jsp:param value="opt" name="SO" />
						</jsp:include>
						<%
							} else {
						%>
						<jsp:include page="/menu/banner.jsp" flush="true">
							<jsp:param value="opt" name="SO" />
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
				<jsp:param value="op" name="RE" />
			</jsp:include>
			<%
				} else {
			%>
			<jsp:include page="/menu/menu_avaliacao.jsp" flush="true">
				<jsp:param value="opt" name="AV" />
				<jsp:param value="op" name="RE" />
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
						<td class="trontrk" align="center"><%=trd.Traduz("RESPONDER")%>
						<%=trd.Traduz("AVALIACAO")%> <%=avaliacao%></td>
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
				<td width="20" valign="top"><img src="../art/bit.gif"
					width="20" height="15"></td>

				<td valign="top"><img src="../art/bit.gif" width="159"
					height="1"><br>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="12"><img src="../art/bit.gif" width="1"
							height="1"></td>
					</tr>
					<tr align="left" class="ftverdanacinza">
						<td align="left" width="10%"><b><%=trd.Traduz("QUESTIONARIO")%></b>:&nbsp;&nbsp;&nbsp;
						</td>
						<td><%=questionario%></td>
					</tr>
					<tr>
						<td colspan="100%">&nbsp;</td>
					</tr>
					<tr align="left" class="ftverdanacinza">
						<td align="left" width="10%" valign="top"><b><%=trd.Traduz("PROPOSTA")%></b>:
						</td>
						<td><%=proposta%></td>
					<tr></tr>
					<tr>
						<td height="12" colspan="100%"><img src="../art/bit.gif"
							width="1" height="1"></td>
					</tr>
					<tr>
						<td class="ctvdiv" height="1" colspan="100%"><img
							src="../art/bit.gif" width="1" height="1"></td>
					</tr>
					<tr>
						<td align="center" colspan="100%">&nbsp;<br>
						<p>
						<table border="0" cellspacing="1" cellpadding="2" width="60%">


							<%
								//query de perguntas 
								query = "SELECT P.PER_NOME, P.PER_CODIGO,P.PER_TIPO "
										+ "FROM PERGUNTA P, QUEST_PERGUNTA Q "
										+ "WHERE Q.QUE_CODIGO = " + cod_que + " "
										+ "AND P.PER_CODIGO = Q.PER_CODIGO ";

								rs = conexao.executaConsulta(query, session.getId() + "RS_1");
								String per_nome = "", per_codigo = "", per_tipo = "", res_nome = "";
								String max = "", min = "";
								int counter = 0, aux = 0, indice = 1, cont_d = 0, qtde_numericas = 0;
								while (rs.next()) {
									if (!per_nome.equals(rs.getString(1))) {
										per_nome = rs.getString(1);
										per_codigo = rs.getString(2);
										per_tipo = rs.getString(3);
							%>
							<tr>
								<td align="left" width="30%" class="celtittab"><b><%=indice%>.
								<%=per_nome%></b></td>
							</tr>
							<%
								indice++;
										if (per_tipo.equals("ME")) {
											//query de respostas tipo Multipla Escolha
											query = "SELECT R.RES_NOME, R.RES_CODIGO "
													+ "FROM QUESTIONARIO Q, QUEST_RESP QR, RESPOSTA R "
													+ "WHERE QR.QUE_CODIGO = " + cod_que + " "
													+ "AND QR.PER_CODIGO = " + per_codigo + " "
													+ "AND Q.QUE_CODIGO = QR.QUE_CODIGO "
													+ "AND QR.RES_CODIGO = R.RES_CODIGO";
											rs1 = conexao.executaConsulta(query, session.getId()
													+ "RS_2");
											counter = 0;
											aux++;
											while (rs1.next()) {
												counter++;
												res_nome = rs1.getString(1);
							%>
							<tr>
								<td class="celnortab"><input type="radio"
									name="resp<%=aux%>" value="<%=rs1.getString(2)%>"><%=rs1.getString(1)%>
								</td>
							</tr>
							<%
								}
										} else if (per_tipo.equals("N ")) {
											query = "SELECT QPG_MINIMO, QPG_MAXIMO FROM QUEST_PERGUNTA WHERE PER_CODIGO = "
													+ per_codigo
													+ " "
													+ "AND QUE_CODIGO = "
													+ cod_que;

											rs1 = conexao.executaConsulta(query, session.getId()
													+ "RS_2");
											rs1.next();
											min = rs1.getString(1);
											max = rs1.getString(2);
											tipo = "1";
											qtde_numericas++;
							%>
							<tr>
								<td class="celnortab"><input type="text"
									name="num_<%=qtde_numericas%>" size="5" maxlength="9"
									onBlur="numero2(this)" onKeyUp="numero(this);"> <input
									type="hidden" name="num_max<%=qtde_numericas%>"
									value="<%=max%>"> <input type="hidden"
									name="num_min<%=qtde_numericas%>" value="<%=min%>"> <%=trd.Traduz("DE")%>
								<b><%=min%></b> <%=trd.Traduz("ATE")%> <b><%=max%></b></td>
							</tr>
							<%
								} else {
							%>
							<tr>
								<td><textarea name="txt_<%=per_codigo%>" cols="90%"
									rows="3" onBlur="aspa2(this);" onKeyUp="aspa(this)"></textarea></td>
							</tr>
							<%
								}
										if (rs1 != null) {
											rs1.close();
											conexao.finalizaConexao(session.getId() + "RS_2");
										}
									}
								}

								if (rs != null) {
									rs.close();
									conexao.finalizaConexao(session.getId());

								}
							%>
						</table>
						<br>
						</td>
					</tr>
					<tr>
						<td align="center" colspan="100%"><input type="button"
							value="        OK        " class="botcin"
							onClick="return envia();">&nbsp;&nbsp;&nbsp; <input
							type="button" value="CANCELAR" class="botcin"
							onClick="JavaScript:history.go(-1);">&nbsp;&nbsp;&nbsp; <input
							type="reset" value="  LIMPAR  " class="botcin"></td>
					</tr>
					<tr>
						<td colspan="100%">&nbsp;</td>
					</tr>

				</table>
				</td>
				<input type="hidden" name="tipo" value="<%=tipo%>">
				<input type="hidden" name="aux" value="<%=aux%>">
				<input type="hidden" name="per_tipo" value="<%=per_tipo%>">
				<input type="hidden" name="que_codigo" value="<%=cod_que%>">
				<input type="hidden" name="fun_cod" value="<%=fun_codigo%>">
				<input type="hidden" name="pergunta" value="<%=per_codigo%>">
				<input type="hidden" name="min" value="<%=min%>">
				<input type="hidden" name="max" value="<%=max%>">
				<input type="hidden" name="pro_codigo" value="<%=pro_codigo%>">
				<input type="hidden" name="qtde_numericas"
					value="<%=qtde_numericas%>">

				<td width="20" valign="top"><img src="../art/bit.gif"
					width="20" height="15"></td>
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
</FORM>
</body>
</html>
<%
	out.println("min = " + min);
	out.println("max = " + max);

	//}
	//catch(Exception e){
	//  out.println("Erro: "+e);
	//}
%>