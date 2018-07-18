<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
	response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*"%>

<%
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");


String usu_tipo	= (String)session.getAttribute("usu_tipo"); 
String usu_nome	= (String)session.getAttribute("usu_nome"); 
String usu_login	= (String)session.getAttribute("usu_login"); 
Integer usu_fil		= (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi	= (Integer)session.getAttribute("usu_idi"); 
String aplicacao	= (String)session.getAttribute("aplicacao");

ResultSet rs = null, rs_cbo = null;

//Variaveis
String query="", cod_solic="", codigo="", nome_solic="";
int cont=0;
boolean primeiro=true, contem=false;

//Parametros
if (request.getParameter("chk_solic") != null)
  cod_solic = request.getParameter("chk_solic");

query = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = " +cod_solic+ " ";
rs = conexao.executaConsulta(query,session.getId());
if (rs.next())
  nome_solic = rs.getString(1);

//try{
%>

<script language="JavaScript">
  function remaneja() {
    document.remanejamento.action = "remanejamento_sql.jsp";
    document.remanejamento.submit();
  }

  function cancela() {
    history.go(-1);
  }

</script>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Solicitantes")%> - <%=trd.Traduz("Remanejamento")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../solicitacao/art/onenglish.gif','../solicitacao/art/onespanol.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%" align="center">
<tr>
	<td valign="top">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
		<tr> 
			<td height="59" class="hcfundo"> 
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<%
				      	      	      String ponto = (String)session.getAttribute("barra");
				      	      	      %>
              <%if(ponto.equals("..")){%>
				<tr><jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="CA"/></jsp:include> </tr>
				<%}else{%>
				<tr><jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="CA"/></jsp:include> </tr>
				<%}%>
			</table>
			</td>
		</tr>
		<tr> 
			<td class="mnfundo"><img src="../art/bit.gif" width="12" height="5"></td>
		</tr>
		<tr> 
			<td height="25" class="mnfundo"> 
			<table border="0" cellspacing="0" cellpadding="0">
				<tr> 
					<td>
					<%if(ponto.equals("..")){%>
					<jsp:include page="../menu/menu.jsp" flush="true"><jsp:param value="op" name="SO"/></jsp:include> 
					<%}else{%>
					<jsp:include page="/menu/menu.jsp" flush="true"><jsp:param value="op" name="SO"/></jsp:include> 
					<%}%>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table border="0" cellspacing="2" cellpadding="0" bgcolor="c0c0c0">
		<tr>
			<td>
			<%if(ponto.equals("..")){%>
			<jsp:include page="../menu/menu_solicitante.jsp" flush="true"><jsp:param value="op" name="C"/></jsp:include>
			<%}else{%>
			<jsp:include page="/menu/menu_solicitante.jsp" flush="true"><jsp:param value="op" name="C"/></jsp:include> 
			<%}%>
			</td>
		</tr>
	</table>

	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr> 
			<td width="20">&nbsp;</td>
			
			<td width="100%"> 
			<center>
			<table border="0" cellspacing="1" cellpadding="2" width="80%">
				<tr>
					<td>
					<div align="center" class="trontrk"><b><%=trd.Traduz("REMANEJAMENTO DE SUBORDINADOS")%></b></div>
					</td>
				</tr>
			</table>
			</center>
			</td>
			<td width="20">&nbsp;</td>
		</tr>
		
		<tr>
			<FORM name="remanejamento">
			<td width="20" valign="top"></td>
			<td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
               <td>&nbsp;</td>
              </tr>
              <tr>
               <td align="center" class="ftverdanacinza"><%=trd.Traduz("REMANEJAR PARA")%> &nbsp;
                 <select name="cbo_sol">
					<%
					/*
					query = "SELECT DISTINCT F.FUN_CODIGO, F.FUN_NOME "+
							"FROM FUNCIONARIO F, APLICACAO A, TIPOUSUARIO T, FUNC_USUARIO FU, CARGO C "+
							"WHERE F.FUN_TIPOUSUARIO IS NOT NULL "+
							"AND A.APL_SIGLA = '" +aplicacao+ "' "+
							"AND T.APL_CODIGO = A.APL_CODIGO "+
							"AND T.TIP_TIPO = F.FUN_TIPOUSUARIO "+
							"AND FU.FUN_CODIGO = F.FUN_CODIGO "+
							"AND F.CAR_CODIGO = C.CAR_CODIGO "+
                    		"ORDER BY F.FUN_NOME";
					*/
					
					String usu_filtro = "";
					
					if(!usu_tipo.equals("F")){
						usu_filtro = "AND F.FIL_CODIGO = "+usu_fil;
					}
					query = "SELECT DISTINCT F.FUN_CODIGO, F.FUN_NOME "+
							"FROM FUNCIONARIO F, APLICACAO A, TIPOUSUARIO T, FUNC_USUARIO FU, CARGO C "+
							"WHERE A.APL_SIGLA = '"+aplicacao+"' "+
							"AND T.APL_CODIGO = A.APL_CODIGO "+
							"AND FU.TIP_TIPO = 'S'" +
							"AND FU.FUN_CODIGO = F.FUN_CODIGO "+
							"AND F.CAR_CODIGO = C.CAR_CODIGO "+
							usu_filtro+" "+
							"ORDER BY F.FUN_NOME ";
					
                    rs_cbo = conexao.executaConsulta(query,session.getId());
                    if (rs_cbo.next()) {
                    	do {
                    		%>
                        	<option value="<%=rs_cbo.getString(1)%>"><%=rs_cbo.getString(2)%></option>
							<%
						}while(rs_cbo.next());
                    }%>
                    </td>
                   </tr>
                  </select>
                  <tr><td>&nbsp;</td></tr>
				<tr align="center">
                  <td class="ctvdiv" height="1" colspan="90%"><img src="../art/bit.gif" width="1" height="1"></td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td align="center">
							<table border="0" cellspacing="0" cellpadding="0">
								<tr> 
									<td> 
									<table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
										<tr> 
											<td onMouseOver="this.className='ctonlnk2';" onClick="return remaneja();" width="127" height="22" align=center class="botver">
											<a href="#" class="txbotver"><%=trd.Traduz("REMANEJAR")%></a></td>
										</tr>
									</table>
									</td>
									<td width="10">&nbsp;</td>
									<td> 
									<table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
										<tr> 
											<td onMouseOver="this.className='ctonlnk2';" onClick="cancela();" width="127" height="22" align=center class="botver">
											<a href="#" class="txbotver"><%=trd.Traduz("CANCELAR")%></a></td>
										</tr>
									</table>
									</td>
									
								</tr>
							</table>
							<br>
							</td>
							</tr>
				<table border="0" cellspacing="1" cellpadding="2" width="80%" align="center">

<%                      query = "SELECT COUNT(*) FROM FUNCIONARIO WHERE FUN_CODSOLIC = " +cod_solic+ " ";
                        rs = conexao.executaConsulta(query,session.getId());
                        if (rs.next()) {
                            cont = rs.getInt(1);%>
                            <tr class="celtittabcin" align="center"> 
				<td colspan="100%"><%=trd.Traduz("SUBORDINADOS DE ")%><%=nome_solic%></td>
                            </tr>
                            <tr class="celtittab"> 
                                <td width="18%"><%=trd.Traduz("Chapa")%></td>
                                <td width="52%"><%=trd.Traduz("Nome")%></td>
                                <td width="30%"><%=trd.Traduz("Cargo")%></td>
                            </tr>
<%                          for (int i=0; i<=cont; i++) {
                                if (request.getParameter("chk"+i) != null) {
                                codigo = request.getParameter("chk"+i);
                                query = "SELECT F.FUN_CODIGO, F.FUN_NOME, F.FUN_CHAPA, C.CAR_NOME " +
                                        "FROM FUNCIONARIO F, CARGO C "+
                                        "WHERE F.CAR_CODIGO = C.CAR_CODIGO "+
                                        "AND FUN_CODIGO = " +codigo+  " ";
                                 conexao.finalizaConexao(session.getId());
                                rs = conexao.executaConsulta(query,session.getId()+"RS_4");
                                if (rs.next()) {
                                    contem = true;%>
                                    <tr class="celnortab"> 
                                        <td width="18%"><%=rs.getString(3)%></td>
                                        <td width="52%">
                                            <%=rs.getString(2)%>
                                            <input type="hidden" name="sub_<%=i%>" value="<%=rs.getString(1)%>">
                                        </td>
                                        <td width="30%"><%=rs.getString(4)%></td>
                                    </tr>
<%				}
                                if(rs!=null){
                                    rs.close(); 
                                    conexao.finalizaConexao(session.getId());
                                }
                                }
                            }
                            if (contem) {%>
				<tr>
					<td align="center">&nbsp;</td>
				</tr>
<%                          }
                        }
                        if (!contem) {%>
                            <tr><td colspan="3">&nbsp;</td></tr>
                            <tr class="celtittabcin" align="center"> 
							<td colspan="100%"><%=trd.Traduz("NENHUM SUBORDINADO SELECIONADO")%>!</td>
                            </tr>
                            <tr><td align="center">&nbsp;</td></tr>
                            <tr align="center">
                                <td colspan="100%" align="center">
                                    <input type="button" name="btn_exc" class="botcin" value=<%=("\""+trd.Traduz("VOLTAR")+"\"")%> onclick="cancela();"> <br>
								</td>
                            </tr>
<%                      }%>
                            <tr><td colspan="3">&nbsp;</td></tr>
			</table>
		</tr>
	</table>
	</td>
        <input type="hidden" name="cont" value="<%=cont%>">
	</FORM>
	<tr>
		<td align="right" height="30" class="difundo"> 
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr> 
				<td> 
				<%if(ponto.equals("..")){%>
				<jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include>
				<%}else{%>
				<jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>
				<%}%>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	</td>
</tr>
</table>
</body>
</html>
<%

//} catch (Exception e) {
//}
%>