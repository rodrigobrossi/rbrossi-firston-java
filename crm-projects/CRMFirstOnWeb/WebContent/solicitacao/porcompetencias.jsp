<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.util.*"%>

<%
//try {

request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 
Vector per = (Vector)session.getAttribute("vetorPermissoes");

ResultSet rs = null, rsf = null, rst = null, rsG = null, rscmp = null;

Vector funcvet = new Vector();
session.setAttribute("funcs", funcvet);
String queryG = "";
String query = "", queryf = "", func = "", queryi = "", query_perfil = ""; 

boolean primeiro=true;

if (!(request.getParameter("fun_codigo") == null))
	func = request.getParameter("fun_codigo");
else
	func="0";

//Pega a origem se for por planosucessorio
String origem = "";
if (!(request.getParameter("origemp") == null))
	origem = request.getParameter("origemp");
else
	origem = "porcompetencias";

queryf = "SELECT FUN_CODIGO, FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = " + func + " ";

if ((request.getParameter("selectcar") == null)) {
query = "SELECT C.CMP_DESCRICAO, CC.INDICEREQUERIDO, CC.CAR_CODIGO, C.CMP_CODIGO "+
		"FROM FUNCIONARIO F, COMP_CARGO CC, COMPETENCIA C "+
		"WHERE F.FUN_CODIGO = "+func+" "+
		"AND F.CAR_CODIGO = CC.CAR_CODIGO "+
		"AND C.CMP_CODIGO = CC.CMP_CODIGO "+
		"ORDER BY CC.CCA_IMPORTANCIA DESC";
} else {
	query = "SELECT COMPETENCIA.CMP_DESCRICAO, COMP_FUNC.INDICEATUAL, COMP_CARGO.INDICEREQUERIDO, COMPETENCIA.CMP_CODIGO FROM COMPETENCIA, COMP_FUNC, COMP_CARGO WHERE COMPETENCIA.CMP_CODIGO = COMP_FUNC.CMP_CODIGO AND COMP_CARGO.CMP_CODIGO = COMP_FUNC.CMP_CODIGO AND COMP_FUNC.FUN_CODIGO = " + func + "  AND COMP_CARGO.CAR_CODIGO = " + request.getParameter("selectcar") + " ORDER BY COMP_CARGO.CCA_IMPORTANCIA DESC";
}
%>

<script language="JavaScript">
  function descricao() {
    //alert("" + document.frm_porcomp.valor.value);
    if (showModalDialog) {
      var sRtn;
      sRtn = showModalDialog("comp_descricao.jsp?rdo_desc="+document.frm_porcomp.valor.value,"","center=yes;status=no;scroll=no;dialogWidth=600px;dialogHeight=400px");
      if (sRtn!="")
        return false;
    } else {
      alert("Internet Explorer 4.0 ou superior E necessArio.");
      return false;
    }
  }

  function valoriza(cod) {
    //alert(""+cod);
    document.frm_porcomp.valor.value = cod;
  }
  function semcomp()
  {
      alert(<%=("\""+trd.Traduz("NAO EXISTE CURSO CADASTRADO PARA A COMPETENCIA SELECIONADA")+"\"")%>);
      return false;
  }

  function semtit()
  {
      alert(<%=("\""+trd.Traduz("NAO EXISTE CURSO CADASTRADO PARA O TITULO SELECIONADO")+"\"")%>);
      return false;
  }
</script>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("SolicitaCAo")%> - <%=trd.Traduz("Por CompetEncias")%></title>
<script language="JavaScript" src="scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../art/onenglish.gif','../art/onespanol.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="59" class="hcfundo"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
              <%
	      	      String ponto = (String)session.getAttribute("barra");
	      	      %>
              <%if(ponto.equals("..")){%>
               <jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="SO"/></jsp:include> 
               <%}else{%>
               <jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="SO"/></jsp:include> 
               <%}%>
              </tr>
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
                <%String oi = "", oia = "";
                if(ponto.equals("..")){
		  if (request.getParameter("op") == null)
				{
                  oi = "../menu/menu.jsp?op="+"S";
				}
				else
				{
                  oi = "../menu/menu.jsp?op="+request.getParameter("op");
				}
				if (request.getParameter("opt") == null)
				{
                  oia = "../menu/menu1.jsp?opt="+"S&op=S";
				} 
				else
				{  
                  oia = "../menu/menu1.jsp?opt="+request.getParameter("opt")+"&op=S";
				}
				}else{
				 if (request.getParameter("op") == null)
								{
				                  oi = "/menu/menu.jsp?op="+"S";
								}
								else
								{
				                  oi = "/menu/menu.jsp?op="+request.getParameter("op");
								}
								if (request.getParameter("opt") == null)
								{
				                  oia = "/menu/menu1.jsp?opt="+"S&op=S";
								} 
								else
								{  
				                  oia = "/menu/menu1.jsp?opt="+request.getParameter("opt")+"&op=S";
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
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
				<%if (origem.equals("porcompetencias")){%>
                <td class="trontrk" width="297" align="center"><%=trd.Traduz("POR COMPETENCIAS")%></td>
				<%}else{%>
                <td class="trontrk" width="297" align="center"><%=trd.Traduz("PLANO SUCESSORIO")%></td>
				<%}%>
                <td width="29"><img src="../art/bit.gif" width="13" height="15"></td>
              </tr>
            </table>
          </td>
          <td width="20">&nbsp;</td>
        </tr>
        <tr> 
          <td width="20" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
          <td valign="top" class="ctvdiv"><img src="../art/bit.gif" width="1" height="1"></td>
          <td width="20"><img src="../art/bit.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td width="20" valign="top"></td>
	  <FORM name="frm_porcomp">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
                </tr>

                <tr> 

	<%
	rsf = conexao.executaConsulta(queryf,session.getId()+"RS1");
	if (rsf.next()){
		%>
		<td>&nbsp;<br>
		<span class="ftverdanacinza"><%=trd.Traduz("FuncionArio")%>:</span> <span class="ftverdanapreto"><a class="lnk" href="result_solics.jsp?fun_codigo=<%=func%>" ><%=rsf.getString(2)%></a></span> 
		<%
	}
        if(rsf != null){
             rsf.close();
             conexao.finalizaConexao(session.getId()+"RS1");
        }
	%>
		<p> 
		<center>
			<table border="0" cellspacing="1" cellpadding="2" width="72%">
				<%
				rs = conexao.executaConsulta(query,session.getId()+"RS2");
				if (rs.next()){
				%>
				<tr> 
					<td width="5%">&nbsp;</td>
					<td width="16%" class="celtittab"> 
						<div align="center"><%=trd.Traduz("COMPETENCIA")%></div>
					</td>
					<td width="15%" class="celtittab"> 
                    	<div align="center"><%=trd.Traduz("INDICE ATUAL")%></div>
                    </td>
                    <td width="15%" class="celtittab"> 
						<div align="center"><%=trd.Traduz("INDICE REQUERIDO")%></div>
					</td>
					<%
					if (prm.buscaparam("COMPTITULO").equals("S")){
						%>
						<td width="49%" class="celtittab"> 
							<div align="left"> <%=trd.Traduz("TITULO")%></div>
						</td>
						<%
					}
					%>
	            </tr>
                <%	
					do{
            			boolean lnkcomp = false;

            			String queryvc = "SELECT CUR_CODIGO, CUR_NOME FROM CURSO " +
										 "WHERE CUR_ATIVO = 'S' AND CUR_SIMPLES = 'N' AND CUR_CODIGO IN (SELECT DISTINCT CUR_CODIGO FROM CURSOCOMP WHERE CMP_CODIGO = " + rs.getString(4) + ")";
						rscmp = conexao.executaConsulta(queryvc,session.getId()+"RS3");
						if (rscmp.next()){
                			lnkcomp = true;
						}
						else{
                			lnkcomp = false;
						}

                                                if(rscmp != null){
                                                    rscmp.close();
                                                    conexao.finalizaConexao(session.getId()+"RS3");
                                                }

						queryG = "SELECT INDICEATUAL FROM COMP_FUNC WHERE FUN_CODIGO = "+func+" AND CMP_CODIGO = "+rs.getString(4);
						rsG = conexao.executaConsulta(queryG,session.getId()+"RS4");
						if(rsG.next()){
							if (rsG.getFloat(1)< rs.getFloat(2)){
								%>
								<tr class="celnortab"> 
								<td width="5%" align="center">
								<%
							if (primeiro){
								%>
								<input type="hidden" name="valor" value="<%=rs.getString(4)%>">
								<input type="radio" name="rdo_desc" value="<%=rs.getString(4)%>" onchange="valoriza(<%=rs.getString(4)%>);" checked>
								<%
							}
							else{
								%>
								<input type="radio" name="rdo_desc" value="<%=rs.getString(4)%>" onchange="valoriza(<%=rs.getString(4)%>);">
								<%
							}
							%>
							</td>
							<%				
							if(per.contains("SOLICITACAO - POR COMPETENCIAS - MANUTENCAO")){
								if (lnkcomp == true){
									%>
									<td width="16%"> 
										<div align="center"><a class="lnk" href="solic_extra.jsp?fun_codigo=<%=func%>&extra=N&origem=<%=origem%>&operacao=I&contador=1&compt=<%=rs.getString(4)%>"><%=rs.getString(1)%></a></div>
									</td>
									<%
								}
								else{
									%>
									<td width="16%"> 
										<div align="center"><a class="lnk" href="#" onclick="return semcomp();"><%=rs.getString(1)%></a></div>
									</td>
						    		<%
						    	}
							}
							else{
								%>
								<td width="16%"> 
									<div align="center"><%=rs.getString(1)%></div>
								</td>
								<%
							}
							%>
							<td width="15%">
							<%
							do{
								if(rsG.getString(1) != null){
									%>
									<div align="center"><%=rsG.getString(1)%></div>
									<%
								}
								else{
									%>
									<div align="center"></div>
									<%
								}
							}while(rsG.next());
							%>
							</td>
							<td width="15%">
							<%
							if(rs.getString(2) != null){
								%>
								<div align="center"><%=rs.getString(2)%></div>
								<%
							}
							else{
								%>
								<div align="center"></div>
								<%	
							}
							%>
							</td>
							<%
							if (prm.buscaparam("COMPTITULO").equals("S")){
								%>
								<td width="49%" align="center"> 
								<%
								queryi = "SELECT TITULO.TIT_NOME, COMP_TITULO.TIT_CODIGO, TITULO.ASS_CODIGO FROM COMP_TITULO, TITULO WHERE TITULO.TIT_CODIGO = COMP_TITULO.TIT_CODIGO AND COMP_TITULO.CMP_CODIGO = " + rs.getString(4) + " ORDER BY TITULO.TIT_NOME";
								rst = conexao.executaConsulta(queryi,session.getId()+"RS5");
								if (rst.next()){
									do{
										if (lnkcomp == true){
											%>
											&#149; <a class="lnk" href="solic_extra.jsp?fun_codigo=<%=func%>&extra=N&selectass=<%=rst.getString(3)%>&selecttit=<%=rst.getString(2)%>&origem=<%=origem%>&operacao=I&contador=1"><%=rst.getString(1)%></a><br>
											<%
										}
										else{
											%> 
                                			&#149; <a class="lnk" href="#" onclick="return semtit();"><%=rst.getString(1)%></a><br>
										  	<%
										}
									}while (rst.next());							
								}
                                                                if(rst != null){
                                                                     rst.close();
                                                                     conexao.finalizaConexao(session.getId()+"RS5");
                                                                }
								%>
								</td>
								<%
							}
							%>
							</tr>
							<%
						}
						else{
							%>
							<tr class="celnortab"> 
								<td width="5%" align="center"> 
							<%
							if (primeiro){
								%>
								<input type="hidden" name="valor" value="<%=rs.getString(4)%>">
								<input type="radio" name="rdo_desc" value="<%=rs.getString(4)%>" onchange="valoriza(<%=rs.getString(4)%>);" checked>
								<%
							}
							else{
								%>
								<input type="radio" name="rdo_desc" value="<%=rs.getString(4)%>" onchange="valoriza(<%=rs.getString(4)%>);">
								<%
							}
							%>
							</td>
							<td width="16%"> 
								<div align="center"><%=rs.getString(1)%></div>
							</td>
							<td width="18%">
							<%
							do{
								if(rsG.getString(1) != null){
									%>
									<div align="center"><%=rsG.getString(1)%></div>
									<%
								}
								else{
									%>
									<div align="center"></div>
									<%
								}
							}while(rsG.next());
							%>
							</td>
							<td width="17%"> 
							<%
							if(rs.getString(2) != null){
								%>
								<div align="center"><%=rs.getString(2)%></div>
								<%
							}
							else{
								%>
								<div align="center">&nbsp;</div>
								<%
							}
							%>
							</td>
							<%
							if (prm.buscaparam("COMPTITULO").equals("S")){
								%>
								<td width="49%"> 
								<%
													
							queryi = "SELECT TITULO.TIT_NOME, COMP_TITULO.TIT_CODIGO, TITULO.ASS_CODIGO FROM COMP_TITULO, TITULO WHERE TITULO.TIT_CODIGO = COMP_TITULO.TIT_CODIGO AND COMP_TITULO.CMP_CODIGO = " + rs.getString(4) + " ORDER BY TITULO.TIT_NOME";
							rst = conexao.executaConsulta(queryi,session.getId()+"RS6");
							if (rst.next()){
								do{
									%>
									&#149; <%=rst.getString(1)%><br>
									<%
								}while (rst.next());								
							}
							if(rst != null){
                                                              rst.close();
                                                              conexao.finalizaConexao(session.getId()+"RS6");
                                                        }
							%>
							</td>
							<%
						}
						%>
						</tr>
						<%
					}
				primeiro = false;
			}
			else{
				%>
				<tr class="celnortab"> 
				<td width="5%" align="center"> 
				<%
				if (primeiro){
					%>
					<input type="hidden" name="valor" value="<%=rs.getString(4)%>">
					<input type="radio" name="rdo_desc" value="<%=rs.getString(4)%>" onchange="valoriza(<%=rs.getString(4)%>);" checked>
					<%
				}
				else{
					%>
					<input type="radio" name="rdo_desc" value="<%=rs.getString(4)%>" onchange="valoriza(<%=rs.getString(4)%>);">
					<%
				}
				%>
				</td>
				<td width="16%"> 
				
				<%
				if (lnkcomp == true){
					%>
					<div align="center"><a class="lnk" href="solic_extra.jsp?fun_codigo=<%=func%>&extra=N&origem=<%=origem%>&operacao=I&contador=1&compt=<%=rs.getString(4)%>"><%=rs.getString(1)%></a></div>
					<%
				}
				else{
					%>
					<div align="center"><a class="lnk" href="#" onclick="return semcomp();"><%=rs.getString(1)%></a></div>
					<%
				}
				%>
				
				</td>
				<td width="18%">
				<div align="center">0.0</div>
				</td>
				<td width="17%"> 
				<%
				if(rs.getString(2) != null){
					%>
					<div align="center"><%=rs.getString(2)%></div>
					<%
				}
				else{
				%>
					<div align="center">&nbsp;</div>
					<%
				}
				%>
				</td>
				<%
				if (prm.buscaparam("COMPTITULO").equals("S")){
					%>
					<td width="49%"> 
					<%
					queryi = "SELECT TITULO.TIT_NOME, COMP_TITULO.TIT_CODIGO, TITULO.ASS_CODIGO FROM COMP_TITULO, TITULO WHERE TITULO.TIT_CODIGO = COMP_TITULO.TIT_CODIGO AND COMP_TITULO.CMP_CODIGO = " + rs.getString(4) + " ORDER BY TITULO.TIT_NOME";
					rst = conexao.executaConsulta(queryi,session.getId()+"RS7");
					if (rst.next()){
						do{
							%>
							&#149; <%=rst.getString(1)%><br>
							<%
						}while (rst.next());					
					}
                                        if(rst != null){
                                            rst.close();
                                            conexao.finalizaConexao(session.getId()+"RS7");
                                        }
					%>
					</td>
					<%
				}
				%>
				</tr>
				<%
			}
			primeiro = false;
		}while (rs.next());
 
	        if(rsG != null){
                    rsG.close();
                    conexao.finalizaConexao(session.getId()+"RS4");
                }
 
		%>
		<tr><td>&nbsp;</td></tr>
		<tr align="center"><td colspan="100%">
		<input type="button" onClick="return descricao();"  value=<%=("\""+trd.Traduz("VISUALIZAR DESCRICAO")+"\"")%> class="botcin" name="button">
		<% 
	}
	else{
		%>
		</td></tr>
		<tr><td>&nbsp;</td>
		<td align="center" colspan="4" class="celtittab"><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...</td></tr>
		<%
	}
        if(rs != null){
             rs.close();
             conexao.finalizaConexao(session.getId()+"RS2");
        }
	%>
    </table>
	</center>
    &nbsp;
    </td>
    </tr>
              </table>
          </td>
		  </FORM>
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
</table>
<!--<script language="JavaScript1.2" src="HM_Loader.js" type='text/JavaScript'></script>-->
</body>
</html>

<%

//} catch(Exception e) {
//  out.println("ERRO: " + e);
//}
%>