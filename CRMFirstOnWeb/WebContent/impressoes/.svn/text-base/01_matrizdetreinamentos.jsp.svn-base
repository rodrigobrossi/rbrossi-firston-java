<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
  response.setHeader("Cache-Control", "no-cache");
}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import ="java.sql.*,java.util.*,java.sql.*,java.text.*"%>

<jsp:useBean id="cmb" scope="page" class="firston.eval.components.FODynamicComboBean" />

<%
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");

String usu_tipo  = (String) session.getAttribute("usu_tipo"); 
String usu_nome  = (String) session.getAttribute("usu_nome"); 
String usu_login = (String) session.getAttribute("usu_login"); 
String aplicacao = (String) session.getAttribute("aplicacao");
Integer usu_fil  = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi  = (Integer)session.getAttribute("usu_idi"); 
Integer usu_cod  = (Integer)session.getAttribute("usu_cod");
String pag_cargo = (request.getParameter("sel_cargo")==null)?"":request.getParameter("sel_cargo");

String query="";
ResultSet rs = null;

String filial = ""+usu_fil;
String codigo = ""+usu_cod;

//try{
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("ImpressOes")%> - <%=trd.Traduz("Matriz de Treinamentos")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','art/onenglish.gif','art/onespanol.gif')">
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
	                    
              if(ponto.equals("..")){
              %>
               <jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="IM"/></jsp:include> 
               <%}else{%>
               <jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="IM"/></jsp:include> 
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
<%              String oi = "", oia = "";
        if(ponto.equals("..")){

		if (request.getParameter("op") == null){
                  oi = "../menu/menu.jsp?op="+"I";
                } else {
                  oi = "../menu/menu.jsp?op="+request.getParameter("op");
		}
		if (request.getParameter("opt") == null){
                  oia = "../menu/menu1.jsp?opt="+"M";
		} else {  
                  oia = "../menu/menu1.jsp?opt="+request.getParameter("opt");
		}
	}else{
		if (request.getParameter("op") == null){
	                  oi = "/menu/menu.jsp?op="+"I";
	                } else {
	                  oi = "/menu/menu.jsp?op="+request.getParameter("op");
			}
			if (request.getParameter("opt") == null){
	                  oia = "/menu/menu1.jsp?opt="+"M";
			} else {  
	                  oia = "/menu/menu1.jsp?opt="+request.getParameter("opt");
		}
	
	
	}	%>
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
                <td class="trontrk" width="297" align="center"><%=trd.Traduz("Matriz de Treinamentos")%></td>
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
          <FORM name="frm_matriz_tre" method="post" action="02_matrizdetreinamentos.jsp">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1">&nbsp;<br><center>
                <table width="90%" border="0" cellspacing="2" cellpadding="2">
                  <tr> 
                    <td colspan="4" class="celtittab"><%=trd.Traduz("FILTROS")%></td>
                  </tr>
                  <tr> 
                    <td width="12%" align="right" class="ftverdanacinza"><%=trd.Traduz("Filial")%>:</td>
                    <td width="36%"> 
                      <select name="cbo_filial">
                        <option value="T"><%=trd.Traduz("Todos")%></option>
                        <%
							if(usu_tipo.equals("F"))
								query = cmb.montaCombo("Filial", "null", "null", aplicacao);	

							if(usu_tipo.equals("P") || usu_tipo.equals("G"))
								query = cmb.montaCombo("Filial", filial, "null", aplicacao);	
	
							if(usu_tipo.equals("S"))
								query = cmb.montaCombo("Filial", filial, codigo, aplicacao);	

	                        rs = conexao.executaConsulta(query,session.getId());
		                    if (rs.next()){
			                  do {%>
                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                        <% } while (rs.next());
	                        } 
                                if(rs!=null){
                                    rs.close();
                                    conexao.finalizaConexao(session.getId());
                                }
                                    
                            %>
                      </select>
                    </td>
                    <td width="17%" align="right" class="ftverdanacinza"><%=trd.Traduz("Departamento")%>:</td>
                    <td width="35%"> 
                      <select name="cbo_departamento">
                        <option value="T"><%=trd.Traduz("Todos")%></option>
                        <%
							if(usu_tipo.equals("F"))
								query = cmb.montaCombo("Departamento", "null", "null", aplicacao);	

							if(usu_tipo.equals("P") || usu_tipo.equals("G"))
								query = cmb.montaCombo("Departamento", filial, "null", aplicacao);	
	
							if(usu_tipo.equals("S"))
								query = cmb.montaCombo("Departamento", filial, codigo, aplicacao);	

	                        rs = conexao.executaConsulta(query,session.getId());
                        
		                    if (rs.next()){
			                  do {%>
                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                        <%   } while (rs.next());
                        } 
                            if(rs!=null){
                                    rs.close();
                                    conexao.finalizaConexao(session.getId());
                                }
                            
    %>
                      </select>
                    </td>
                  </tr>
                  <tr> 
		<%
                    if(prm.buscaparam("USE_TB2").equals("S")) {%>
                    <td width="17%" align="right" class="ftverdanacinza" height="24"><%=trd.Traduz("TABELA2")%>:</td>
                    <td width="35%" height="24"> 
                      <select name="select2">
                        <option value="T"><%=trd.Traduz("Todos")%></option>
                        <%
							if(usu_tipo.equals("F"))
								query = cmb.montaCombo("Tabela2", "null", "null", aplicacao);	

							if(usu_tipo.equals("P") || usu_tipo.equals("G"))
								query = cmb.montaCombo("Tabela2", filial, "null", aplicacao);	
	
							if(usu_tipo.equals("S"))
								query = cmb.montaCombo("Tabela2", filial, codigo, aplicacao);	

						    rs = conexao.executaConsulta(query,session.getId());
							if (rs.next()){
	                          do {%>
                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                        <%   } while (rs.next());
                        } 
                        if(rs!=null){
                                    rs.close();
                                    conexao.finalizaConexao(session.getId());
                                }

%>
                      </select>
                    </td>
                    <%                  } else {%>
                    <td width="17%" height="24"> 
                      <input type="hidden" name="cbo_tabela_2" value="T">
                    </td>
                    <!--parAmetro TODOS-->
                    <td width="35%" height="24">&nbsp;</td>
                    <%                  
                    }
                    
                    if(prm.buscaparam("USE_TB3").equals("S")) {%>
                    <td width="12%" align="right" class="ftverdanacinza"><%=trd.Traduz("Tabela3")%>:</td>
                    <td width="36%"> 
                      <select name="cbo_tabela_3">
                        <option value="T"><%=trd.Traduz("Todos")%></option>
                        <%
							if(usu_tipo.equals("F"))
								query = cmb.montaCombo("Tabela3", "null", "null", aplicacao);	

							if(usu_tipo.equals("P") || usu_tipo.equals("G"))
								query = cmb.montaCombo("Tabela3", filial, "null", aplicacao);	
	
							if(usu_tipo.equals("S"))
								query = cmb.montaCombo("Tabela3", filial, codigo, aplicacao);				

	                        rs = conexao.executaConsulta(query,session.getId());
		                    if (rs.next()){
			                  do {%>
                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                        <%   } while (rs.next());
                        } 
                            if(rs!=null){
                                    rs.close();
                                    conexao.finalizaConexao(session.getId());
                                }

%>
                      </select>
                    </td>
                    <%                  } else {%>
                    <td width="12%">
                      <input type="hidden" name="cbo_tabela_3" value="T">
                    </td>
                    <!--parAmetro TODOS-->
                    <td width="36%">&nbsp;</td>
                    <%}%>
                    </tr>
					
					<tr>


									

							<%    

				  	if(usu_tipo.equals("S"))
					{
						%>
                    <td width="12%" align="right" class="ftverdanacinza">&nbsp; </td>
                    <td width="36%">&nbsp; </td>
                    <%
					}

					else
					{
						%>
                    <td width="12%" align="right" class="ftverdanacinza"><%=trd.Traduz("Solicitante")%>:</td>
                    <td width="36%"> 
                      <select name="cbo_solicitante">
                        <option value="T"><%=trd.Traduz("Todos")%></option>
                        <%
									if(usu_tipo.equals("F"))
										query = cmb.montaCombo("Solicitante", "null", "null", aplicacao);	

									if(usu_tipo.equals("P") || usu_tipo.equals("G"))
										query = cmb.montaCombo("Solicitante", filial, "null", aplicacao);	
	
									if(usu_tipo.equals("S"))
										query = cmb.montaCombo("Solicitante", filial, codigo, aplicacao);	

									rs = conexao.executaConsulta(query,session.getId());
							
									if (rs.next())
		                        	{
				                		do
						        		{
											%>
                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                        <%
										}while (rs.next());
		                        	}
			                	 if(rs!=null){
                                                    rs.close();
                                                    conexao.finalizaConexao(session.getId());
                                                    }
				            }
                        %>
                      </select>
                    </td>
                  </tr>
                  <tr>
					<td width="18%" class="ftverdanacinza" align="right"><%=trd.Traduz("CARGO")%>:</td>
                <td width="33%"> 
		  <select name="cbo_cargo">
                    <option value="T"><%=trd.Traduz("Todos")%></option>						
<%                  if(usu_tipo.equals("F"))
                      query = cmb.montaCombo("Cargo", "null", "null", aplicacao);	
                    if(usu_tipo.equals("P") || usu_tipo.equals("G"))
                      query = cmb.montaCombo("Cargo", filial, "null", aplicacao);	
                    if(usu_tipo.equals("S"))
                      query = cmb.montaCombo("Cargo", filial, codigo, aplicacao);	
                    rs = conexao.executaConsulta(query,session.getId());
                    if(rs.next()) {
                      do {
                        if (pag_cargo.equals(rs.getString(1))) {%>
			  <option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
<%                      } else {%>
                          <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                      }
                      } while(rs.next());
                    }
                    if(rs!=null){
                                    rs.close();
                                    conexao.finalizaConexao(session.getId());
                                }


%>
		  </select>												
                </td>

                    <td width="17%" align="right" class="ftverdanacinza"><%=trd.Traduz("TIPOS DE REGISTRO")%>:</td>
                    <td width="35%"> 
                      <select name="cbo_tipo">
                        <option value="T"><%=trd.Traduz("Todos")%></option>
                        <%                       query = "SELECT TTR_CODIGO, TTR_NOME "+
                                 "FROM TIPOTREINAMENTO "+
                                 "ORDER BY TTR_NOME";
                        rs = conexao.executaConsulta(query,session.getId());
                        if (rs.next()){
                          do {%>
                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                        <%                        } while (rs.next());
                        } 
                            if(rs!=null){
                                    rs.close();
                                    conexao.finalizaConexao(session.getId());
                                }

%>
                      </select>
                    </td>
                  </tr>
                  <tr> 
                    <%                  if(prm.buscaparam("USE_TB1").equals("S")) {%>
                    <td width="17%" align="right" class="ftverdanacinza" height="24"><%=trd.Traduz("Assunto")%>:</td>
                    <td width="35%" height="24"> 
                      <select name="cbo_assunto">
                        <option value="T"><%=trd.Traduz("Todos")%></option>
                        <%                      query = "SELECT ASS_CODIGO, ASS_NOME "+
                                "FROM ASSUNTO "+
                                "ORDER BY ASS_NOME";
                        rs = conexao.executaConsulta(query,session.getId());
                        if (rs.next()){
                          do {%>
                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                        <%                        } while (rs.next());
                        }
                            if(rs!=null){
                                    rs.close();
                                    conexao.finalizaConexao(session.getId());
                                }



%>
                      </select>
                    </td>
                    <%                  } else {%>
                    <td width="17%" height="24"> 
                      <input type="hidden" name="cbo_tabela_1" value="T">
                    </td>
                    <!--parAmetro TODOS-->
                    <td width="35%" height="24">&nbsp;</td>
                    <%}
			%>
                  </tr>
                  <tr> 
                    <%              
                    if(prm.buscaparam("USE_TB4").equals("S")) {%>
                    <td width="12%" align="right" class="ftverdanacinza"><%=trd.Traduz("TABELA4")%>:</td>
                    <td width="36%"> 
                      <select name="cbo_tabela_4">
                        <option value="T"><%=trd.Traduz("Todos")%></option>
                        <%
							if(usu_tipo.equals("F"))
								query = cmb.montaCombo("Tabela4", "null", "null", aplicacao);	

							if(usu_tipo.equals("P") || usu_tipo.equals("G"))
								query = cmb.montaCombo("Tabela4", filial, "null", aplicacao);	
	
							if(usu_tipo.equals("S"))
								query = cmb.montaCombo("Tabela4", filial, codigo, aplicacao);	

							rs = conexao.executaConsulta(query,session.getId());
	                        if (rs.next()){
		                      do {%>
                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                        <%   } while (rs.next());
                        } 
                                if(rs!=null){
                                    rs.close();
                                    conexao.finalizaConexao(session.getId());
                                }


%>
                      </select>
                    </td>
                    <%                  } else {%>
                    <td width="12%">
                      <input type="hidden" name="cbo_tabela_4" value="T">
                    </td>
                    <!--parAmetro TODOS-->
                    <td width="36%">&nbsp;</td>
                    <%                  }%>
                  </tr>

                </table>
                <table width="90%" border="0" cellspacing="2" cellpadding="2">                  
                  <tr> 
                    <td colspan="4" class="celtittab"><%=trd.Traduz("IMPRIMIR EM")%>:</td>
                  </tr>
                  <tr valign="top"> 
                    <td colspan="4" class="ftverdanacinza">
                      <input type="radio" name="rdo_tipo" value="1" checked><%=trd.Traduz("Hora")%>
                    </td>
                  </tr>
                  <tr valign="top"> 
                    <td colspan="4" class="ftverdanacinza">
                    <input type="radio" name="rdo_tipo" value="2"><%=trd.Traduz("Valor")%>
                    </td>
                  </tr>
                  <tr> 
                    <td colspan="4" align="center">&nbsp;<br>
                      <input type="submit" value=<%=("\""+trd.Traduz("GERAR RELATORIO")+"\"")%> class="botcin" name="button1">
                    </td>
                  </tr>
                </table><p>&nbsp;
              </center>
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
          <% if(ponto.equals("..")){%>
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
</body>
</html>
<%
//} catch(Exception e) {
//  out.println(""+e);
//}%>