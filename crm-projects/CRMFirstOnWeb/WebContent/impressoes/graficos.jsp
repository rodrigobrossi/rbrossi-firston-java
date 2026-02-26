<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")) {
  response.setHeader("Cache-Control", "no-cache");
}
%>

<%@page import=" java.sql.*, java.text.*"%>

<jsp:useBean id="cmb" scope="page" class="firston.eval.components.FODynamicComboBean" />
<%@page import="java.net.*,java.util.*"%>

<%
/*VALIDACAO DOS PARAMETROS PARA RODAPE*/
String parametro= "?";
//try{
   for (Enumeration e = request.getParameterNames() ; e.hasMoreElements() ;) {
   String nome = ""+e.nextElement();
   parametro =parametro+ nome+"="+(String)request.getParameter(nome)+"&";
    }
//} catch(Exception e ){out.println("Erro do RodapE "+e);};
URLEncoder codec=null;
parametro = codec.encode(parametro);
request.getSession(true);
session.setAttribute("par",parametro);

//Recupera dados da sessao
request.getSession();
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");

String usu_tipo = (String)session.getAttribute("usu_tipo");
String usu_nome = (String)session.getAttribute("usu_nome");
String usu_login = (String)session.getAttribute("usu_login");
String aplicacao = (String)session.getAttribute("aplicacao");
Integer usu_fil = (Integer)session.getAttribute("usu_fil");
Integer usu_idi = (Integer)session.getAttribute("usu_idi");
Integer usu_plano = (Integer)session.getAttribute("usu_plano");
Integer usu_cod  = (Integer)session.getAttribute("usu_cod");

//variaveis
String query="";
ResultSet rs = null;

String filial = ""+usu_fil;
String codigo = ""+usu_cod;
String grupo = "";

if (request.getParameter("rdo_grupo") != null)
  grupo = request.getParameter("rdo_grupo");

//try{
%>

<script language="JavaScript">
function gera(){
    var sRtn;
    var parametros;
    parametros = "?rdo_valor="+frm_graf.valor_cbo_valor.value+
                 "&cbo_grupo="+frm_graf.cbo_grupo.value+
                 "&cbo_solic="+frm_graf.cbo_solic.value+
                 "&cbo_tipo="+frm_graf.cbo_tipo.value+
                 "&cbo_departamento="+frm_graf.cbo_departamento.value+
                 "&cbo_cargo="+frm_graf.cbo_cargo.value+
                 "&cbo_tb1="+frm_graf.cbo_tb1.value+
                 "&cbo_tb2="+frm_graf.cbo_tb2.value+
                 "&cbo_tb3="+frm_graf.cbo_tb3.value+
                 "&cbo_tb4="+frm_graf.cbo_tb4.value+
                 "&cbo_curso="+frm_graf.cbo_curso.value+
                 "&cbo_filial="+frm_graf.cbo_filial.value+
                 "&cbo_titulo="+frm_graf.cbo_titulo.value+
                 "&cbo_entidade="+frm_graf.cbo_entidade.value+
                 "&cbo_func="+frm_graf.cbo_func.value;
    if (frm_graf.rdo_grupo[0].checked) {
        parametros = parametros + "&rdo_grupo=R";
    } else {
        parametros = parametros + "&rdo_grupo=P";
    }
    
    window.open("graficosResult.jsp"+parametros,"_parent");
}

function  valor_valor(valor) {
  //alert(""+valor);
  frm_graf.valor_cbo_valor.value = valor;
  return false;
}

function muda_cbo(tipo) {
  frm_graf.action = "graficos.jsp";
  frm_graf.submit();
}
</script>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("ImpressOes")%> - <%=trd.Traduz("GrAficos")%></title>
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
<%     	       String ponto = (String)session.getAttribute("barra");
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
<%            String oi = "", oia = "";
              if(ponto.equals("..")){
		if (request.getParameter("op") == null)	{
                  oi = "../menu/menu.jsp?op="+"I";
		} else {
                  oi = "../menu/menu.jsp?op="+request.getParameter("op");
		}
		if (request.getParameter("opt") == null) {
                  oia = "../menu/menu1.jsp?opt="+"GF";
		} else {  
                  oia = "../menu/menu1.jsp?opt="+request.getParameter("opt");
		}
              } else {
                if (request.getParameter("op") == null)	{
	          oi = "/menu/menu.jsp?op="+"I";
		} else {
	          oi = "/menu/menu.jsp?op="+request.getParameter("op");
		}
		if (request.getParameter("opt") == null) {
	          oia = "/menu/menu1.jsp?opt="+"GF";
		} else {  
	          oia = "/menu/menu1.jsp?opt="+request.getParameter("opt");
		}
              }%>
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
                <td class="trontrk" width="297" align="center"><%=trd.Traduz("GrAficos")%></td>
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
	  <FORM name="frm_graf">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1">&nbsp;<br><center>
                <table width="100%" border="0" cellspacing="2" cellpadding="2">
                  <tr> 
                    <td colspan="4" class="celtittab" align="center"><%=trd.Traduz("GRAFICOS")%></td>
                  </tr>
                  <tr> 
                    <td colspan="4" class="ftverdanacinza"> 
                      <input type="radio" name="rdo_valor" value="H" checked onchange="valor_valor('H');">
                      <%=trd.Traduz("Hora")%> &nbsp; &nbsp; &nbsp; &nbsp; 
                      <input type="radio" name="rdo_valor" value="V" onchange="valor_valor('V');">
                      <%=trd.Traduz("Valor")%> &nbsp; &nbsp; &nbsp; &nbsp; 
                      <input type="radio" name="rdo_valor" value="T" onchange="valor_valor('T');">
                      <%=trd.Traduz("Nº de Treinamentos")%> </td>
                  </tr>
                  <tr> 
                    <td colspan="1" class="ftverdanacinza" width="30%"> 
<%                    if (grupo.equals("") || grupo.equals("R")) {%>
                      <input type="radio" name="rdo_grupo" value="R" checked onclick="return muda_cbo('R');"><%=trd.Traduz("Realizados")%>&nbsp;
                        <input type="radio" name="rdo_grupo" value="P" onclick="return muda_cbo('P');"><%=trd.Traduz("Planejados")%>&nbsp;
<%                    } else {%>
                        <input type="radio" name="rdo_grupo" value="R" onclick="return muda_cbo('R');"><%=trd.Traduz("Realizados")%>&nbsp;
                        <input type="radio" name="rdo_grupo" value="P" checked onclick="return muda_cbo('P');"><%=trd.Traduz("Planejados")%>&nbsp;
<%                    }%>
                    </td>
                    <td colspan="3" class="ftverdanacinza" width="70%"> 

                      <select name="cbo_grupo">
<%                      if (grupo.equals("R") || grupo.equals("")) {%>
                        <option value="AS"><%=trd.Traduz("Assunto")%></option>
                        <option value="CA"><%=trd.Traduz("Cargo")%></option>
                        <option value="CU"><%=trd.Traduz("Curso")%></option>
                        <option value="DE"><%=trd.Traduz("Departamento")%></option>
                        <option value="FI"><%=trd.Traduz("Filial")%></option>
                        <option value="SO"><%=trd.Traduz("Solicitante")%></option>                        
                        <option value="T1"><%=trd.Traduz("Tabela1")%></option>
                        <option value="T2"><%=trd.Traduz("Tabela2")%></option>
                        <option value="T3"><%=trd.Traduz("Tabela3")%></option>
                        <option value="TP"><%=trd.Traduz("Tipo de Treinamento")%></option>
                        <option value="TI"><%=trd.Traduz("TItulo")%></option>
<%                      } else if (grupo.equals("P")) {%>
                        <option value="RJ"><%=trd.Traduz("Realizados X Justificados")%></option>
<%                      }%>
                      </select>
                    </td>
                  </tr>
                 </table>
		 <br>
                 <table width="80%" border="0" cellspacing="2" cellpadding="2">
                   <tr align="center"> 
                     <td colspan="4" class="celtittab"><%=trd.Traduz("FILTRO")%></td>
                   </tr>
                   <tr> 
                     <!--***************************FILIAL*******************************-->
                     <td width="13%" class="ftverdanacinza" align="right"><%=trd.Traduz("Filial")%>:</td>
                     <td width="36%"> 
                       <select name="cbo_filial">
                         <option value=""><%=trd.Traduz("todos")%></option>
<%			 if(usu_tipo.equals("F"))
			   query = cmb.montaCombo("Filial", "null", "null", aplicacao);	
			 if(usu_tipo.equals("P") || usu_tipo.equals("G"))
			   query = cmb.montaCombo("Filial", filial, "null", aplicacao);	
			 if(usu_tipo.equals("S"))
			   query = cmb.montaCombo("Filial", filial, codigo, aplicacao);	
			 rs = conexao.executaConsulta(query,session.getId());
			 if(rs.next()) {
	                   do {%>
                             <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
<%                         } while(rs.next());
			}
                        if(rs!=null) {
                           rs.close();
                           conexao.finalizaConexao(session.getId());
                        }
                        %>
                      </select>
                    </td>
                  
                    <!--***************************DEPARTAMENTO*******************************-->
                    <td width="13%" class="ftverdanacinza" align="right"><%=trd.Traduz("Departamento")%>:</td>
                    <td width="36%"> 
                      <select name="cbo_departamento">
                        <option value=""><%=trd.Traduz("todos")%></option>
<%			if(usu_tipo.equals("F"))
			  query = cmb.montaCombo("Departamento", "null", "null", aplicacao);	
			if(usu_tipo.equals("P") || usu_tipo.equals("G"))
			  query = cmb.montaCombo("Departamento", filial, "null", aplicacao);	
			if(usu_tipo.equals("S"))
			  query = cmb.montaCombo("Departamento", filial, codigo, aplicacao);	
			rs = conexao.executaConsulta(query,session.getId());
			if(rs.next()) {
                          do {%>
                            <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                        } while(rs.next());
			}
                        if(rs!=null)    {
                        rs.close();
                        conexao.finalizaConexao(session.getId());
                        }
                        %>
                      </select>
                    </td>
                  </tr>

                  <tr>
                    <!--***************************TABELA 2*******************************-->
<%                  if(prm.buscaparam("USE_TB2").equals("S")) {%>
                    <td width="18%" class="ftverdanacinza" align="right"><%=trd.Traduz("Tabela2")%>:</td>
                    <td width="33%"> 
                      <select name="cbo_tb2">
                        <option value=""><%=trd.Traduz("todos")%></option>
<%			if(usu_tipo.equals("F"))
			  query = cmb.montaCombo("Tabela2", "null", "null", aplicacao);	
			if(usu_tipo.equals("P") || usu_tipo.equals("G"))
			  query = cmb.montaCombo("Tabela2", filial, "null", aplicacao);	
                        if(usu_tipo.equals("S"))
			  query = cmb.montaCombo("Tabela2", filial, codigo, aplicacao);				
			rs = conexao.executaConsulta(query,session.getId());
			if(rs.next()) {
                          do {%>
                            <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                        } while(rs.next());
			}
                        if(rs!=null){
                        rs.close(); 
                        conexao.finalizaConexao(session.getId());
                        }
                         %>
                      </select>
                    </td>
<%                  } else {%>
                    <td width="18%">
                      <input type="hidden" name="cbo_tb2" value="">
                    </td>
                    <td width="33%">&nbsp;</td>
<%                  }%>
                  
                    <!--***************************TABELA 3*******************************-->
<%                  if(prm.buscaparam("USE_TB3").equals("S")) {%>
                    <td width="13%" class="ftverdanacinza" align="right"><%=trd.Traduz("Tabela3")%>:</td>
                    <td width="36%"> 
                      <select name="cbo_tb3">
                        <option value=""><%=trd.Traduz("todos")%></option>
<%			if(usu_tipo.equals("F"))
			  query = cmb.montaCombo("Tabela3", "null", "null", aplicacao);	
                        if(usu_tipo.equals("P") || usu_tipo.equals("G"))
			  query = cmb.montaCombo("Tabela3", filial, "null", aplicacao);	
                        if(usu_tipo.equals("S"))
			  query = cmb.montaCombo("Tabela3", filial, codigo, aplicacao);					
			rs = conexao.executaConsulta(query,session.getId());
			if(rs.next()) {
                          do {%>
                            <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
<%                        } while(rs.next());
			}
                        if(rs!=null){
                        rs.close();
                        conexao.finalizaConexao(session.getId());
                        }
                        %>
                      </select>
                    </td>
<%                  } else {%>
                    <td width="13%">
                      <input type="hidden" name="cbo_tb3" value="">
                    </td>
                    <td width="36%">&nbsp;</td>
<%                  }%>
                  </tr>

                  <tr>
                    <!--***************************CARGO*******************************-->
                    <td width="18%" class="ftverdanacinza" align="right"><%=trd.Traduz("Cargo")%>:</td>
                    <td width="33%"> 
                      <select name="cbo_cargo">
                        <option value=""><%=trd.Traduz("todos")%></option>
<%			if(usu_tipo.equals("F"))
			  query = cmb.montaCombo("Cargo", "null", "null", aplicacao);	
			if(usu_tipo.equals("P") || usu_tipo.equals("G"))
			  query = cmb.montaCombo("Cargo", filial, "null", aplicacao);	
			if(usu_tipo.equals("S"))
			  query = cmb.montaCombo("Cargo", filial, codigo, aplicacao);	
                        out.println(query);
			rs = conexao.executaConsulta(query,session.getId());
			if(rs.next()) {
                          do {%>
                            <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                        } while(rs.next());
			}
                        if(rs!=null){
                        rs.close();
                        conexao.finalizaConexao(session.getId());
                        }
                        %>
                      </select>
                    </td>

                    <!--***************************SOLICITANTE*******************************-->
<%                  if(usu_tipo.equals("S")) {%>
                    <td width="13%" class="ftverdanacinza" align="right">&nbsp; </td>
                    <td width="36%">&nbsp; </td>
<%                  } else {%>
                    <td width="13%" class="ftverdanacinza" align="right"><%=trd.Traduz("Solicitante")%>:</td>
                    <td width="36%"> 
                      <select name="cbo_solic">
                        <option value=""><%=trd.Traduz("Todos")%></option>
<%			if(usu_tipo.equals("F"))
			  query = cmb.montaCombo("Solicitante", "null", "null", aplicacao);	
			if(usu_tipo.equals("P") || usu_tipo.equals("G"))
			  query = cmb.montaCombo("Solicitante", filial, "null", aplicacao);	
			if(usu_tipo.equals("S"))
			  query = cmb.montaCombo("Solicitante", filial, codigo, aplicacao);					
			rs = conexao.executaConsulta(query,session.getId());
			if(rs.next()) {
                          do {%>
                            <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                        } while(rs.next());
			}
                      }
                       if(rs!=null) {
                       rs.close();
                       conexao.finalizaConexao(session.getId());
                        }
                        %>
                      </select>
                    </td>
                  </tr>

                  <tr>
                    <!--***************************TIPO DE CURSO*******************************-->
                    <td width="18%" class="ftverdanacinza" align="right"><%=trd.Traduz("Tipo de curso")%>:</td>
                    <td width="33%"> 
                      <select name="cbo_tipo">
                        <option value=""><%=trd.Traduz("todos")%></option>
<%			query = "SELECT TCU_CODIGO, TCU_NOME "+
				"FROM TIPOCURSO "+
				"ORDER BY TCU_NOME";
			rs = conexao.executaConsulta(query,session.getId());
			if(rs.next()) {
                          do {%>
                        <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<% 			  } while(rs.next());
			}
                        if(rs!=null){
                        rs.close();
                        conexao.finalizaConexao(session.getId());
                        }
                        %>
                      </select>
                    </td>

                    <!--***************************FUNCIONARIO*******************************-->
                    <td width="18%" class="ftverdanacinza" align="right"><%=trd.Traduz("FUNCIONARIO")%>:</td>
                    <td width="82%"> 
                      <select name="cbo_func">
                        <option value=""><%=trd.Traduz("todos")%></option>
<%			if(usu_tipo.equals("F"))
			  query = cmb.montaCombo("Funcionario", "null", "null", aplicacao);	
			if(usu_tipo.equals("P") || usu_tipo.equals("G"))
			  query = cmb.montaCombo("Funcionario", filial, "null", aplicacao);	
			if(usu_tipo.equals("S"))
			  query = cmb.montaCombo("Funcionario", filial, codigo, aplicacao);	
			rs = conexao.executaConsulta(query,session.getId());
			if(rs.next()) {
			  do {%>
                            <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
<%                        } while(rs.next());
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
                    <!--***************************REGIAO*******************************-->
					<% if(prm.buscaparam("USE_REGIAO").equals("S")) {%>
	                    <td width="13%" class="ftverdanacinza" align="right"><%=trd.Traduz("RegiAo")%>:</td>
		                <td width="36%"> 
			              <select name="cbo_regiao">
				            <option value=""><%=trd.Traduz("todos")%></option>
								<%
									query = "SELECT REG_CODIGO, REG_NOME "+
											"FROM REGIAO "+
											"ORDER BY REG_NOME";
									rs = conexao.executaConsulta(query,session.getId());
									if(rs.next()) {
									  do {%>
										<option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
									  <% } while(rs.next());
									}
                                                                         if(rs!=null){
                                                                            rs.close();
                                                                            conexao.finalizaConexao(session.getId());
                                                                            }
                                                                            %>
						  </select>
                        </td>
					<% }
					
					else { %>
						<td width="13%" class="ftverdanacinza" align="right"> &nbsp; </td>
		                <td width="36%"> &nbsp; </td>
					<% } %>

                    <!--***************************ENTIDADE*******************************-->
                    <td width="18%" class="ftverdanacinza" align="right"><%=trd.Traduz("Entidade")%>:</td>
                    <td width="33%"> 
                      <select name="cbo_entidade">
                        <option value=""><%=trd.Traduz("todos")%></option>
<%			query = "SELECT EMP_CODIGO, EMP_NOME "+
				"FROM EMPRESA "+
				"ORDER BY EMP_NOME";
			rs = conexao.executaConsulta(query,session.getId());
			if(rs.next()) {
			  do {%>
                            <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
<%			  }while(rs.next());
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
                    <!--***************************TITULO*******************************-->  
                    <td width="18%" class="ftverdanacinza" align="right"><%=trd.Traduz("TItulo")%>:</td>
                    <td width="33%"> 
                      <select name="cbo_titulo">
                        <option value=""><%=trd.Traduz("todos")%></option>
<%			query = "SELECT TIT_CODIGO, TIT_NOME "+
				"FROM TITULO "+
				"ORDER BY TIT_NOME";
			rs = conexao.executaConsulta(query,session.getId());
			if(rs.next()) {
			  do {%>
                            <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
<%			  } while(rs.next());
			}
                         if(rs!=null){
                            rs.close();
                            conexao.finalizaConexao(session.getId());
                        }
%>
                      </select>
                    </td>

                    <!--***************************CURSO*******************************-->
                    <td width="18%" class="ftverdanacinza" align="right"><%=trd.Traduz("Curso")%>:</td>
                    <td width="33%"> 
                      <select name="cbo_curso">
                        <option value=""><%=trd.Traduz("todos")%></option>
<%			query = "SELECT CUR_CODIGO, CUR_NOME "+
				"FROM CURSO "+
				"ORDER BY CUR_NOME";
			rs = conexao.executaConsulta(query,session.getId());
			if(rs.next()) {
			  do {%>
                        <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
<%			  } while(rs.next());
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
                    <!--***************************TABELA 1*******************************-->
<%                  if(prm.buscaparam("USE_TB1").equals("S")) {%>
                    <td width="13%" class="ftverdanacinza" align="right"><%=trd.Traduz("Tabela1")%>:</td>
                    <td width="36%"> 
                      <select name="cbo_tb1">
                        <option value=""><%=trd.Traduz("todos")%></option>
<%			if(usu_tipo.equals("F"))
 			  query = cmb.montaCombo("Tabela1", "null", "null", aplicacao);	
			if(usu_tipo.equals("P") || usu_tipo.equals("G"))
			  query = cmb.montaCombo("Tabela1", filial, "null", aplicacao);	
			if(usu_tipo.equals("S"))
			  query = cmb.montaCombo("Tabela1", filial, codigo, aplicacao);	
			rs = conexao.executaConsulta(query,session.getId());
			if(rs.next()) {
		          do {%>
                            <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                        } while(rs.next());
			}
                        if(rs!=null){
                            rs.close();
                            conexao.finalizaConexao(session.getId());
                        }
                        %>
                      </select>
                    </td>
<%                  } else {%>
                    <td width="13%">
                      <input type="hidden" name="cbo_tb1" value="">
                    </td>
                    <td width="36%">&nbsp;</td>
<%                  }%>
                  
                    <!--***************************TABELA 4*******************************-->
<%                  if(prm.buscaparam("USE_TB4").equals("S")) {%>
                    <td width="18%" class="ftverdanacinza" align="right"><%=trd.Traduz("Tabela4")%>:</td>
                    <td width="33%"> 
                      <select name="cbo_tb4">
                        <option value=""><%=trd.Traduz("todos")%></option>
<%			if(usu_tipo.equals("F"))
			  query = cmb.montaCombo("Tabela4", "null", "null", aplicacao);	
			if(usu_tipo.equals("P") || usu_tipo.equals("G"))
			  query = cmb.montaCombo("Tabela4", filial, "null", aplicacao);	
			if(usu_tipo.equals("S"))
			  query = cmb.montaCombo("Tabela4", filial, codigo, aplicacao);	
			rs = conexao.executaConsulta(query,session.getId());
			if(rs.next()) {
			  do {%>
                            <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                        } while(rs.next());
			}
                         if(rs!=null){
                            rs.close();
                            conexao.finalizaConexao(session.getId());
                        } 
                    %>
                      </select>
                    </td>
<%                  } else {%>
                    <td width="18%">
                      <input type="hidden" name="cbo_tb4" value="">
                    </td>
                    <td width="33%">&nbsp;</td>
<%                  }%>
                  </tr>

                  <tr> 
                    <td colspan="4" align="center">&nbsp;<br>
                      <input type="button" onClick="return gera();"  value=<%=("\""+trd.Traduz("GERAR GRAFICO")+"\"")%> class="botcin" name="button1">
                    </td>
                  </tr>
                </table>
                <p>&nbsp;
              </center>
          </td>
          <input type="hidden"name="valor_cbo_valor" value="H">
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
</body>
</html>
<%
if(rs != null) {
rs.close();
conexao.finalizaConexao(session.getId());
}

//} catch (Exception e) {
//}
%>