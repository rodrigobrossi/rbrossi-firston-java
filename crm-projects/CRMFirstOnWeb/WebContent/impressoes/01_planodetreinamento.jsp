<%
    response.setHeader("Pragma", "no-cache");
    if (request.getProtocol().equals("HTTP/1.1"))
    {
      response.setHeader("Cache-Control", "no-cache");
    }
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*"%>

<jsp:useBean id="cmb" scope="page" class="firston.eval.components.FODynamicComboBean" />

<%
request.getSession();
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");

String usu_tipo  = (String) session.getAttribute("usu_tipo"); 
String usu_nome  = (String) session.getAttribute("usu_nome"); 
String usu_login = (String) session.getAttribute("usu_login"); 
String aplicacao = (String) session.getAttribute("aplicacao");
Integer usu_fil  = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi  = (Integer)session.getAttribute("usu_idi");  
Integer usu_cod  = (Integer)session.getAttribute("usu_cod");

String usuario = ""+usu_cod;

ResultSet rs = null;
String query = "";

String filial = ""+usu_fil;
String codigo = ""+usu_cod;
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("ImpressOes")%> - <%=trd.Traduz("Plano de Treinamento")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<script language="JavaScript">
function filtra() {

/*Rosangela - Qdo for resumido nAo pedir a filial*/


	if (frm.sel_filial.value == "0" && frm.radio1.checked) {
		alert(<%=("\""+trd.Traduz("Favor selecionar a filial!")+"\"")%>);
		frm.sel_filial.focus;
		return false;
	}
	else if(frm.check_a.checked == false && frm.check_t.checked == false && frm.check_d.checked == false){
		alert(<%=("\""+trd.Traduz("Favor selecionar pelo menos um tipo de funcionario")+"\"")%>);
		return false;
	}
	else{
		frm.action ="02_planodetreinamento.jsp";
		frm.submit();
		return false;
	}
}
</script>

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
	      	                    
              if(ponto.equals("..")){%>
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
		if (request.getParameter("op") == null)	{
                  oi = "../menu/menu.jsp?op="+"I";
		} else {
                  oi = "../menu/menu.jsp?op="+request.getParameter("op");
		}
		if (request.getParameter("opt") == null) {
                  oia = "../menu/menu1.jsp?opt="+"P";
		} else {
                  oia = "../menu/menu1.jsp?opt="+request.getParameter("opt");
		}
	}else{
		if (request.getParameter("op") == null)	{
	                  oi = "/menu/menu.jsp?op="+"I";
			} else {
	                  oi = "/menu/menu.jsp?op="+request.getParameter("op");
			}
			if (request.getParameter("opt") == null) {
	                  oia = "/menu/menu1.jsp?opt="+"P";
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
                <td class="trontrk" width="297" align="center"><%=trd.Traduz("PLANO DE TREINAMENTO")%></td>
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
		  <FORM name = "frm">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1">&nbsp;<br><center>
                <table width="80%" border="0" cellspacing="2" cellpadding="2">
                  <tr> 
                    <td colspan="4" class="celtittab"><%=trd.Traduz("FILTROS")%></td>
                  </tr>
                  <tr> 
                    
                    <!--///////////////////////FILIAL///////////////////////-->
                    <td width="10%" class="ftverdanacinza" align="right"><%=trd.Traduz("FILIAL")%>:</td>
                    <td width="21%"> 
                      <select name="sel_filial">
                        <option value="0"><%=trd.Traduz("Todos")%></option>
                        <%
							if(usu_tipo.equals("F"))
								query = cmb.montaCombo("Filial", "null", "null", aplicacao);	

							if(usu_tipo.equals("P") || usu_tipo.equals("G"))
								query = cmb.montaCombo("Filial", filial, "null", aplicacao);	
	
							if(usu_tipo.equals("S"))
								query = cmb.montaCombo("Filial", filial, codigo, aplicacao);	

					 		    rs = conexao.executaConsulta(query,session.getId()+"RS1");
							    if(rs.next()) {
							      do {%>
                        <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                        <%	  }while(rs.next());
						    }
                                   if(rs != null){
                                      rs.close();
                                      conexao.finalizaConexao(session.getId()+"RS1");
                                   }%>
                      </select>
                    </td>
                    
                    <!--///////////////////////DEPARTAMENTO///////////////////////-->
                    <td width="9%" class="ftverdanacinza" align="right"><%=trd.Traduz("DEPARTAMENTO")%>:</td>
                    <td width="21%"> 
                      <select name="sel_depto">
                        <option value="0"><%=trd.Traduz("Todos")%></option>
                        <%
							if(usu_tipo.equals("F"))
								query = cmb.montaCombo("Departamento", "null", "null", aplicacao);	

							if(usu_tipo.equals("P") || usu_tipo.equals("G"))
								query = cmb.montaCombo("Departamento", filial, "null", aplicacao);	
	
							if(usu_tipo.equals("S"))
								query = cmb.montaCombo("Departamento", filial, codigo, aplicacao);	

							  rs = conexao.executaConsulta(query,session.getId()+"RS2");
							  if(rs.next())	{
							    do {%>
                        <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                        <% }while(rs.next());
						  }
                                   if(rs != null){
                                      rs.close();
                                      conexao.finalizaConexao(session.getId()+"RS2");
                                   }%>%>
                      </select>
                    </td>
                  </tr>
                  
                  <tr> 
                    <!--///////////////////////TABELA2///////////////////////-->
<%			if(prm.buscaparam("USE_TB2").equals("S"))
			{
				%>
                    <td width="9%" class="ftverdanacinza" align="right"><%=trd.Traduz("TABELA2")%>:</td>
                    <td width="21%"> 
                      <select name="sel_tabela2">
                        <option value="0"><%=trd.Traduz("Todos")%></option>
                        <%
						if(usu_tipo.equals("F"))
							query = cmb.montaCombo("Tabela2", "null", "null", aplicacao);	

						if(usu_tipo.equals("P") || usu_tipo.equals("G"))
							query = cmb.montaCombo("Tabela2", filial, "null", aplicacao);	
	
						if(usu_tipo.equals("S"))
							query = cmb.montaCombo("Tabela2", filial, codigo, aplicacao);		

			    		rs = conexao.executaConsulta(query,session.getId()+"RS3");
			    		if(rs.next())
			    		{
			      			do
				  			{
		      					%>
                        <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                        <%
                       		}while(rs.next());
		    			}
                                        if(rs != null){
                                            rs.close();
                                            conexao.finalizaConexao(session.getId()+"RS3");
                                        }
			    		%>
                      </select>
                      <%
			    	}
			    	else
					{
					%>
                    <td width="10%">&nbsp;</td>
                    <td width="21%">&nbsp; 
                      <%
					}
		    		%>
                    </td>
                     <!--///////////////////////TABELA3///////////////////////-->
                    <%
			if(prm.buscaparam("USE_TB3").equals("S"))
			{
				%>
                    <td width="9%" class="ftverdanacinza" align="right"><%=trd.Traduz("TABELA3")%>:</td>
                    <td width="21%"> 
                      <select name="sel_tabela3">
                        <option value="0"><%=trd.Traduz("Todos")%></option>
                        <%
					if(usu_tipo.equals("F"))
						query = cmb.montaCombo("Tabela3", "null", "null", aplicacao);	

					if(usu_tipo.equals("P") || usu_tipo.equals("G"))
						query = cmb.montaCombo("Tabela3", filial, "null", aplicacao);	
	
					if(usu_tipo.equals("S"))
						query = cmb.montaCombo("Tabela3", filial, codigo, aplicacao);					
	            
               		rs = conexao.executaConsulta(query,session.getId()+"RS4");
               		if(rs.next())
               		{
						do
						{
							%>
                        <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                        <%
 			            }while(rs.next());
		      		}
                                if(rs != null){
                                            rs.close();
                                            conexao.finalizaConexao(session.getId()+"RS4");
                                        }
		    		%>
                      </select>
                      <%
				  	}
		      		else
			      	{
					%>
                    <td width="0%">&nbsp;</td>
                    <td width="9%">&nbsp; 
                      <%
			      	}		      		
		      	%>
                    </td>
                  </tr>

                  <tr>
                     <!--///////////////////////CARGO///////////////////////-->
                    <td width="10%" class="ftverdanacinza" align="right"><%=trd.Traduz("CARGO")%>:</td>
                    <td width="21%"> 
                      <select name="sel_cargo">
                        <option value="0"><%=trd.Traduz("Todos")%></option>
                        <%
							if(usu_tipo.equals("F"))
								query = cmb.montaCombo("Cargo", "null", "null", aplicacao);	

							if(usu_tipo.equals("P") || usu_tipo.equals("G"))
								query = cmb.montaCombo("Cargo", filial, "null", aplicacao);	
	
							if(usu_tipo.equals("S"))
								query = cmb.montaCombo("Cargo", filial, codigo, aplicacao);	

						  rs = conexao.executaConsulta(query,session.getId()+"RS5");
						  if(rs.next()) {
						    do {%>
                        <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                        <% }while(rs.next());
					  }
                                          if(rs != null){
                                            rs.close();
                                            conexao.finalizaConexao(session.getId()+"RS5");
                                          }%>
                      </select>
                    </td>
                    <!--///////////////////////TIPO///////////////////////-->
                    <td width="10%" class="ftverdanacinza" align="right"><%=trd.Traduz("TIPO DE CURSO")%>:</td>
                    <td width="21%"> 
                      <select name="sel_tipo">
                        <option value="0"><%=trd.Traduz("Todos")%></option>
                        <%  		  query = "SELECT TCU_CODIGO, TCU_NOME "+
                                                  "FROM TIPOCURSO "+
                                                  "ORDER BY TCU_NOME";
		  rs = conexao.executaConsulta(query,session.getId()+"RS6");
		  if(rs.next()) {
		    do {%>
                        <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                        <%                  }while(rs.next());
		  }
                                        if(rs != null){
                                            rs.close();
                                            conexao.finalizaConexao(session.getId()+"RS6");
                                        }%>
                      </select>
                    </td>
                  </tr>
                  <!--///////////////////////ENTIDADE///////////////////////-->
                  <tr> 
                    <td width="9%" class="ftverdanacinza" align="right"><%=trd.Traduz("ENTIDADE")%>:</td>
                    <td width="21%"> 
                      <select name="sel_empresa">
                        <option value="0"><%=trd.Traduz("Todos")%></option>
                        <%                        query = "SELECT EMP_CODIGO, EMP_NOME "+
                                  "FROM EMPRESA "+
				  "ORDER BY EMP_NOME";
			  rs = conexao.executaConsulta(query,session.getId()+"RS7");
			  if(rs.next()) {
			    do {%>
                        <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                        <%			    }while(rs.next());
			  }
                                        if(rs != null){
                                            rs.close();
                                            conexao.finalizaConexao(session.getId()+"RS7");
                                        }
                          %>
                      </select>
                    </td>
                  <!--///////////////////////CURSO///////////////////////-->
                    <td width="9%" class="ftverdanacinza" align="right"><%=trd.Traduz("CURSO")%>:</td>
                    <td width="21%"> 
                      <select name="sel_curso">
                        <option value="0"><%=trd.Traduz("Todos")%></option>
                        <%		        query = "SELECT CUR_CODIGO, CUR_NOME "+
			        "FROM CURSO WHERE CUR_SIMPLES = 'N' "+
			        "ORDER BY CUR_NOME";
		        rs = conexao.executaConsulta(query,session.getId()+"RS8");
                        if(rs.next()) {
			  do {%>
                        <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                        <%			  }while(rs.next());
			}
                                        if(rs != null){
                                            rs.close();
                                            conexao.finalizaConexao(session.getId()+"RS8");
                                        }%>
                      </select>
                    </td>
                  </tr>
                  <!--///////////////////////TITULO///////////////////////-->
                  <tr> 
                    <td width="9%" class="ftverdanacinza" align="right"><%=trd.Traduz("TITULO")%>:</td>
                    <td width="21%"> 
                      <select name="sel_titulo">
                        <option value="0"><%=trd.Traduz("Todos")%></option>
                        <%                    query = "SELECT TIT_CODIGO, TIT_NOME "+
			      "FROM TITULO "+
			      "ORDER BY TIT_NOME";
		      rs = conexao.executaConsulta(query,session.getId()+"RS9");
	              if(rs.next()) {
			do {%>
                        <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                        <%                      }while(rs.next());
		      }
                                        if(rs != null){
                                            rs.close();
                                            conexao.finalizaConexao(session.getId()+"RS9");
                                        }%>
                      </select>
                    </td>
                    <!--///////////////////////TABELA1///////////////////////-->
                    <%
			if(prm.buscaparam("USE_TB1").equals("S"))
			{
				%>
                    <td width="10%" class="ftverdanacinza" align="right"><%=trd.Traduz("TABELA1")%>:</td>
                    <td width="21%"> 
                      <select name="sel_tabela1">
                        <option value="0"><%=trd.Traduz("Todos")%></option>
                        <%
					if(usu_tipo.equals("F"))
						query = cmb.montaCombo("Tabela1", "null", "null", aplicacao);	

					if(usu_tipo.equals("P") || usu_tipo.equals("G"))
						query = cmb.montaCombo("Tabela1", filial, "null", aplicacao);	
	
					if(usu_tipo.equals("S"))
						query = cmb.montaCombo("Tabela1", filial, codigo, aplicacao);								

					rs = conexao.executaConsulta(query,session.getId()+"RS10");
					if(rs.next())
					{
						do
						{
							%>
                        <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                        <%
						}while(rs.next());
					}
                                        if(rs != null){
                                            rs.close();
                                            conexao.finalizaConexao(session.getId()+"RS11");
                                        }
					%>
                      </select>
                      <%
				}
				else
				{
					%>
                    <td width="9%">&nbsp;</td>
                    <td width="21%">&nbsp; 
                      <%
				}
				%>
                    </td>
                  </tr>

                  <tr>
                    <!--///////////////////////FUNCIONARIO///////////////////////-->
                    <td width="9%" class="ftverdanacinza" align="right"><%=trd.Traduz("FUNCIONARIO")%>:</td>
                    <td width="21%"> 
                      <select name="sel_funcion">
                        <option value="0"><%=trd.Traduz("Todos")%></option>
                        <%
							if(usu_tipo.equals("F"))
								query = cmb.montaCombo("Funcionario", "null", "null", aplicacao);	

							if(usu_tipo.equals("P") || usu_tipo.equals("G"))
								query = cmb.montaCombo("Funcionario", filial, "null", aplicacao);	
	
							if(usu_tipo.equals("S"))
								query = cmb.montaCombo("Funcionario", filial, codigo, aplicacao);	

							rs = conexao.executaConsulta(query,session.getId()+"RS12");
 			  			    
							if(rs.next()) 
							{
							    do {%>
                        <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                        <%	   }while(rs.next());
			  			    }
                                                    if(rs != null){
                                                         rs.close();
                                                         conexao.finalizaConexao(session.getId()+"RS12");
                                                    }%>
                      </select>
                    </td>
                    <!--/////////////////////////SOLICITANTE////////////////////////-->
                    <td width="10%" class="ftverdanacinza" align="right"><%=trd.Traduz("SOLICITANTE")%>:</td>
                    <td width="21%"> 
                      <select name="sel_solic">
                        <option value="0"><%=trd.Traduz("Todos")%></option>
                        <%
							if(usu_tipo.equals("F"))
								query = cmb.montaCombo("Solicitante", "null", "null", aplicacao);	

							if(usu_tipo.equals("P") || usu_tipo.equals("G"))
								query = cmb.montaCombo("Solicitante", filial, "null", aplicacao);	
	
							if(usu_tipo.equals("S"))
								query = cmb.montaCombo("Solicitante", filial, codigo, aplicacao);	
				
							rs = conexao.executaConsulta(query,session.getId()+"RS13");
                                                        String querysolic = query + " codigo = " + codigo;
							if(rs.next()) {
							  do {%>
                        <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                        <% }while(rs.next());}
                                            if(rs != null){
                                                rs.close();
                                                conexao.finalizaConexao(session.getId()+"RS13");
                                            }
%>
                      </select>
                    </td>
                  </tr>
                  <!--///////////////////////TABELA4///////////////////////-->
                  <tr> 
                    <%
			if(prm.buscaparam("USE_TB4").equals("S"))
			{
				%>
                    <td width="9%" class="ftverdanacinza" align="right"><%=trd.Traduz("TABELA4")%>:</td>
                    <td width="21%"> 
                      <select name="sel_tabela4">
                        <option value="0"><%=trd.Traduz("Todos")%></option>
                        <%
						if(usu_tipo.equals("F"))
							query = cmb.montaCombo("Tabela4", "null", "null", aplicacao);	

						if(usu_tipo.equals("P") || usu_tipo.equals("G"))
							query = cmb.montaCombo("Tabela4", filial, "null", aplicacao);	
	
						if(usu_tipo.equals("S"))
							query = cmb.montaCombo("Tabela4", filial, codigo, aplicacao);	  

					  	rs = conexao.executaConsulta(query,session.getId()+"RS14");
						if(rs.next())
						{
			    				do
					    		{
					    			%>
                        <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                        <%
                        		}while(rs.next());
					  	}
                                                if(rs != null){
                                                    rs.close();
                                                    conexao.finalizaConexao(session.getId()+"RS14");
                                                }
						%>
                      </select>
                      <%
					}
					else
					{
						%>
                    <td width="10%">&nbsp;</td>
                    <td width="21%">&nbsp; 
                      <%
					}
				%>
                    </td>
                    <td width="9%">&nbsp;</td>
                    <td width="21%">&nbsp;</td>
                  </tr>
		</table>
   	        <br>
			  <%
			  if(request.getParameter("check_a") == null && request.getParameter("check_t") == null && request.getParameter("check_d") == null){
			  	%>
                <input checked type="checkbox" name="check_a">
                <tt class="ftverdanacinza"> <%=trd.Traduz("VISUALIZAR ATIVO")%> &nbsp;&nbsp;&nbsp; </tt>
                <input type="checkbox" name="check_t"> 
				<tt class="ftverdanacinza"> <%=trd.Traduz("VISUALIZAR TERCEIRO")%> &nbsp;&nbsp;&nbsp; </tt>
                <input type="checkbox" name="check_d">
                <tt class="ftverdanacinza"> <%=trd.Traduz("VISUALIZAR DEMITIDO")%> </tt>
 				<%               
			  }
			  else{
			  
			  if(request.getParameter("check_a") == null){
			  	%>
                <input type="checkbox" name="check_a">
                <tt class="ftverdanacinza"> <%=trd.Traduz("VISUALIZAR ATIVO")%> &nbsp;&nbsp;&nbsp; </tt>
                <%
              }
              else {
              	%>
                <input checked type="checkbox" name="check_a">
                <tt class="ftverdanacinza"> <%=trd.Traduz("VISUALIZAR ATIVO")%> &nbsp;&nbsp;&nbsp; </tt>
                <%
              }
		       if (request.getParameter("check_t") != null) {%>
                        <input type="checkbox" name="check_t" checked> 
						<tt class="ftverdanacinza"> <%=trd.Traduz("VISUALIZAR TERCEIRO")%> &nbsp;&nbsp;&nbsp; </tt>
<%                  } else {%>
                        <input type="checkbox" name="check_t"> 
						<tt class="ftverdanacinza"> <%=trd.Traduz("VISUALIZAR TERCEIRO")%> &nbsp;&nbsp;&nbsp; </tt>
<%                  }
			  if(request.getParameter("check_d") == null){%>
                    <input type="checkbox" name="check_d">
                    <tt class="ftverdanacinza"> <%=trd.Traduz("VISUALIZAR DEMITIDO")%> </tt>
                    <%                  } else {%>
                    <input checked type="checkbox" name="check_d">
                    <tt class="ftverdanacinza"> <%=trd.Traduz("VISUALIZAR DEMITIDO")%> </tt>
                    <%}
              }
					%>
			  <br><br>
			  <table width="90%" border="0" cellspacing="2" cellpadding="2">                  
                  <tr> 
                    <td width="30%" class="celtittab"><%=trd.Traduz("IMPRIMIR")%></td>
                    <td width="30%" class="celtittab"><%=trd.Traduz("ORDENACAO")%></td>
                    <td width="30%" class="celtittab"><%=trd.Traduz("TIPO")%></td>
                  </tr>
                  <tr valign="top"> 
                    <td width="30%" class="ftverdanacinza"> 
                      <input type="radio" name="rb_imp" value="T" checked>
                      <%=trd.Traduz("TODOS")%><br>
                      <input type="radio" name="rb_imp" value="P">
                      <%=trd.Traduz("PLANEJADOS")%><br>
                      <input type="radio" name="rb_imp" value="J">
                      <%=trd.Traduz("JUSTIFICADOS")%><br>
                      <input type="radio" name="rb_imp" value="R">
                      <%=trd.Traduz("REALIZADOS")%><br>
                      <input type="radio" name="rb_imp" value="A">
                      <%=trd.Traduz("AGENDADOS")%></td>
                    <td width="30%" class="ftverdanacinza"> 
					  <input type="radio" name="rb_ord" value="U">
                      <%=trd.Traduz("UNIDADE")%><br>
                      <input type="radio" name="rb_ord" value="D">
                      <%=trd.Traduz("UNIDADE / DEPARTAMENTO / CELULA / TIME")%><br>
                      <input type="radio" name="rb_ord" value="C">
                      <%=trd.Traduz("CURSO")%><br>
					  <input type="radio" name="rb_ord" value="S" checked>
                      <%=trd.Traduz("SOLICITANTE")%><br>                                          
                      <input type="radio" name="rb_ord" value="F">
                      <%=trd.Traduz("FUNCIONARIO")%><br>
                    </td>
                    <td width="30%" class="ftverdanacinza"> 
                      <input type="radio" id="radio1" name="rb_tipo" value="D" checked>
                      <%=trd.Traduz("DETALHADO")%><br>
                      <input type="radio" id="radio2" name="rb_tipo" value="R">
                      <%=trd.Traduz("RESUMIDO")%><br>
                  </tr>
                  <tr> 
                    <td colspan="4" align="center">&nbsp;<br>
                      <input type="button" onClick="return filtra();"  value=<%=("\""+trd.Traduz("GERAR RELATORIO")+"\"")%> class="botcin" name="button1">
                    </td>
                  </tr>
                </table>
                <p>&nbsp;
              </center>
          </td>
		  </FORM>
          <td width="20" valign="top">&nbsp;</td>
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

%>