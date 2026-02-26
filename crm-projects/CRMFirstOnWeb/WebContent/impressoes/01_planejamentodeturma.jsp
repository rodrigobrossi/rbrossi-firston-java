<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1"))
    response.setHeader("Cache-Control", "no-cache");
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
<title>FirstOn - <%=trd.Traduz("ImpressOes")%> - <%=trd.Traduz("Planejamento de Turma")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<script language="JavaScript">
function filtra() {
	if (frm.sel_filial.value == "") {
	    alert(<%=("\""+trd.Traduz("Favor selecionar a filial!")+"\"")%>);
	    frm.sel_filial.focus;
	    return false;
	}

    if (frm.chk_part_ok.checked == false && frm.chk_part_maior.checked == false &&
             frm.chk_part_menor.checked == false && frm.chk_part_reg.checked == false) {
        alert(<%=("\""+trd.Traduz("Favor selecionar o status da turma!")+"\"")%>);
        return false;
    }
    else if (frm.chk_turma_ant.checked == false && frm.chk_turma_longa.checked == false) {
        alert(<%=("\""+trd.Traduz("Favor selecionar o tipo da turma!")+"\"")%>);
        return false;
    }
  
  frm.action ="02_planejamentodeturma.jsp";
  frm.submit();
  return false;	
}

function FormataData(campo, evento, direcao){
	if (campo.value.length < 10000){
		if (evento != 9 ){//tab
			if(evento != 8 && evento != 46 && evento != 16 && !(evento > 36 && evento < 41)){ //delete, backspace, shift nAo causam evento
				var tam = campo.value.length
				if ((evento >= 48 && evento <= 57) || (evento >= 96 && evento <= 105)) {
					if (tam == 2 || tam == 5){
						campo.value = campo.value + "/";
						}
					} 
				else{
					if (direcao == "up"){
						if (campo.value.length == 0){
							campo.value = ""
							}
						else{
							campo.value = campo.value.substring(0,campo.value.length-1)
							}
						}
					}
				campo.focus()
				}
			} 
		else{
			if (direcao == "down"){
				ChecaData(campo)
				}
			}
		}
	}

function ChecaData(THISDATE){
	var erro = 0
	var data = THISDATE.value
	if (data.length != 10) 
		erro=1
	var dia = data.substring(0, 2)// dia
	var barra1 = data.substring(2, 3)// '/'
	var mes = data.substring(3, 5)// mes
	var barra2 = data.substring(5, 6)// '/'
	var ano = data.substring(6, 10)// ano
		
	if (mes < 1 || mes > 12) 
		erro = 1
	if (dia < 1 || dia > 31) 
		erro = 1
	if (ano < 1990) 
		erro = 1
	if (mes == 4 || mes == 6 || mes == 9 || mes == 11){
		if (dia == 31) 
			erro = 1
			}
	if (mes == 2){
		var bis = parseInt(ano/4)
		if (isNaN(bis)){
			erro = 1
			}
		if (dia > 29) 
			erro = 1
		if (dia == 29 && ((ano/4) != parseInt(ano/4))) 
			erro = 1
		}
	if ((erro == 1) && (THISDATE.value != "")) {
		alert(THISDATE.value + ' <%=trd.Traduz("E uma data invAlida!")%>');
		THISDATE.value = "";
		}
	}
function DoCal(elTarget){
	if (showModalDialog){
		var sRtn;
		sRtn = showModalDialog("calendar.htm","","center=yes;status=no;dialogWidth=306px;dialogHeight=220px");
		if (sRtn!="")
			elTarget.value = sRtn;
		} 
	else
		alert(<%=("\""+trd.Traduz("INTERNET EXPLORER 4.0 OU SUPERIOR E NECESSARIO")+"\"")%>)
}
</script>

<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../art/onenglish.gif','../art/onespanol.gif')">
 <FORM name = "frm">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="59" class="hcfundo"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
<%             String ponto = (String)session.getAttribute("barra");
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
                  oia = "../menu/menu1.jsp?opt="+"PDT";
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
	          oia = "/menu/menu1.jsp?opt="+"PDT";
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
                <td class="trontrk" width="297" align="center"><%=trd.Traduz("PLANEJAMENTO DE TURMA")%></td>
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
                        <option value=""><%=trd.Traduz("Todos")%></option>
<%			if(usu_tipo.equals("F"))
                            query = cmb.montaCombo("Filial", "null", "null", aplicacao);	
			if(usu_tipo.equals("P") || usu_tipo.equals("G"))
                            query = cmb.montaCombo("Filial", filial, "null", aplicacao);	
			if(usu_tipo.equals("S"))
                            query = cmb.montaCombo("Filial", filial, codigo, aplicacao);	

			rs = conexao.executaConsulta(query,session.getId());
			if(rs.next()) {
                            do {%>
                                <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
<%                          } while(rs.next());
			}
                         if(rs!=null){rs.close();conexao.finalizaConexao(session.getId());}   
%>
                      </select>
                    </td>
                    
                    <!--///////////////////////DEPARTAMENTO///////////////////////-->
                    <td width="9%" class="ftverdanacinza" align="right"><%=trd.Traduz("DEPARTAMENTO")%>:</td>
                    <td width="21%"> 
                      <select name="sel_depto">
                        <option value=""><%=trd.Traduz("Todos")%></option>
<%			if(usu_tipo.equals("F"))
                            query = cmb.montaCombo("Departamento", "null", "null", aplicacao);	
			if(usu_tipo.equals("P") || usu_tipo.equals("G"))
                            query = cmb.montaCombo("Departamento", filial, "null", aplicacao);	
			if(usu_tipo.equals("S"))
                            query = cmb.montaCombo("Departamento", filial, codigo, aplicacao);	

			rs = conexao.executaConsulta(query,session.getId());
			if(rs.next())	{
                            do {%>
                                <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
<%                          }while(rs.next());
			}
                        if(rs!=null){rs.close();conexao.finalizaConexao(session.getId());}   
                        %>
                      </select>
                    </td>
                  </tr>
                  
                  <tr> 
                  <!--///////////////////////TABELA2///////////////////////-->
<%		  if(prm.buscaparam("USE_TB2").equals("S")) {%>
                    <td width="9%" class="ftverdanacinza" align="right"><%=trd.Traduz("TABELA2")%>:</td>
                    <td width="21%"> 
                      <select name="sel_tabela2">
                        <option value=""><%=trd.Traduz("Todos")%></option>
<%			if(usu_tipo.equals("F"))
                            query = cmb.montaCombo("Tabela2", "null", "null", aplicacao);
                        if(usu_tipo.equals("P") || usu_tipo.equals("G"))
                            query = cmb.montaCombo("Tabela2", filial, "null", aplicacao);
			if(usu_tipo.equals("S"))
                            query = cmb.montaCombo("Tabela2", filial, codigo, aplicacao);

                        rs = conexao.executaConsulta(query,session.getId());
			if(rs.next()) {
                            do	{%>
                                <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
<%                          } while(rs.next());
		    	}
                        if(rs!=null){rs.close();conexao.finalizaConexao(session.getId());}   
                        %>
                      </select>
<%		    } else {%>
                    <td width="10%">&nbsp;</td>
                    <td width="21%">&nbsp; 
<%                  }%>
                    </td>
                    <!--///////////////////////TABELA3///////////////////////-->
<%		    if(prm.buscaparam("USE_TB3").equals("S"))	{%>
                    <td width="9%" class="ftverdanacinza" align="right"><%=trd.Traduz("TABELA3")%>:</td>
                    <td width="21%"> 
                      <select name="sel_tabela3">
                        <option value=""><%=trd.Traduz("Todos")%></option>
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
<%		            } while(rs.next());
		      	}
                        if(rs!=null){rs.close();conexao.finalizaConexao(session.getId());}   
                    %>
                      </select>
<%                  } else {%>
                    <td width="0%">&nbsp;</td>
                    <td width="9%">&nbsp; 
<%                  }%>
                    </td>
                  </tr>

                  <tr>
                     <!--///////////////////////CARGO///////////////////////-->
                    <td width="10%" class="ftverdanacinza" align="right"><%=trd.Traduz("CARGO")%>:</td>
                    <td width="21%"> 
                      <select name="sel_cargo">
                        <option value=""><%=trd.Traduz("Todos")%></option>
<%			if(usu_tipo.equals("F"))
                            query = cmb.montaCombo("Cargo", "null", "null", aplicacao);	
                        if(usu_tipo.equals("P") || usu_tipo.equals("G"))
                            query = cmb.montaCombo("Cargo", filial, "null", aplicacao);	
			if(usu_tipo.equals("S"))
                            query = cmb.montaCombo("Cargo", filial, codigo, aplicacao);	

			rs = conexao.executaConsulta(query,session.getId());
			if(rs.next()) {
                            do {%>
                                <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
<%                          } while(rs.next());
			}
                        if(rs!=null){rs.close();conexao.finalizaConexao(session.getId());}       
                        %>
                      </select>
                    </td>
                    <!--///////////////////////TIPO///////////////////////-->
                    <td width="10%" class="ftverdanacinza" align="right"><%=trd.Traduz("TIPO DE CURSO")%>:</td>
                    <td width="21%"> 
                      <select name="sel_tipo">
                        <option value=""><%=trd.Traduz("Todos")%></option>
<%                      query = "SELECT TCU_CODIGO, TCU_NOME "+
                                "FROM TIPOCURSO "+
                                "ORDER BY TCU_NOME";
                        rs = conexao.executaConsulta(query,session.getId());
                        if(rs.next()) {
                            do {%>
                                <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
<%                          } while(rs.next());
                        }
                          if(rs!=null){rs.close();conexao.finalizaConexao(session.getId());}     
                        %>
                      </select>
                    </td>
                  </tr>
                  <!--///////////////////////ENTIDADE///////////////////////-->
                  <tr> 
                    <td width="9%" class="ftverdanacinza" align="right"><%=trd.Traduz("ENTIDADE")%>:</td>
                    <td width="21%"> 
                      <select name="sel_empresa">
                        <option value=""><%=trd.Traduz("Todos")%></option>
<%                        query = "SELECT EMP_CODIGO, EMP_NOME "+
                                  "FROM EMPRESA "+
				  "ORDER BY EMP_NOME";
			  rs = conexao.executaConsulta(query,session.getId());
			  if(rs.next()) {
                            do {%>
                                <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
<%			    }while(rs.next());
			  }
                          if(rs!=null){rs.close();conexao.finalizaConexao(session.getId());}   
                        %>
                      </select>
                    </td>
                  <!--///////////////////////CURSO///////////////////////-->
                    <td width="9%" class="ftverdanacinza" align="right"><%=trd.Traduz("CURSO")%>:</td>
                    <td width="21%"> 
                      <select name="sel_curso">
                        <option value=""><%=trd.Traduz("Todos")%></option>
<%		        query = "SELECT CUR_CODIGO, CUR_NOME "+
			        "FROM CURSO "+
			        "ORDER BY CUR_NOME";
		        rs = conexao.executaConsulta(query,session.getId());
                        if(rs.next()) {
			  do {%>
                        <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
<%			  }while(rs.next());
			}
                        if(rs!=null){rs.close();conexao.finalizaConexao(session.getId());}   
                        %>
                      </select>
                    </td>
                  </tr>
                  <!--///////////////////////TITULO///////////////////////-->
                  <tr> 
                    <td width="9%" class="ftverdanacinza" align="right"><%=trd.Traduz("TITULO")%>:</td>
                    <td width="21%"> 
                      <select name="sel_titulo">
                        <option value=""><%=trd.Traduz("Todos")%></option>
<%                    query = "SELECT TIT_CODIGO, TIT_NOME "+
			      "FROM TITULO "+
			      "ORDER BY TIT_NOME";
		      rs = conexao.executaConsulta(query,session.getId());
	              if(rs.next()) {
			do {%>
                        <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
<%                      }while(rs.next());
		      }
                      if(rs!=null){rs.close();conexao.finalizaConexao(session.getId());}   
                    %>
                      </select>
                    </td>
                    <!--///////////////////////TABELA1///////////////////////-->
<%                  if(prm.buscaparam("USE_TB1").equals("S"))	{%>
                    <td width="10%" class="ftverdanacinza" align="right"><%=trd.Traduz("TABELA1")%>:</td>
                    <td width="21%"> 
                      <select name="sel_tabela1">
                        <option value=""><%=trd.Traduz("Todos")%></option>
<%			if(usu_tipo.equals("F"))
                            query = cmb.montaCombo("Tabela1", "null", "null", aplicacao);	
			if(usu_tipo.equals("P") || usu_tipo.equals("G"))
                            query = cmb.montaCombo("Tabela1", filial, "null", aplicacao);	
                        if(usu_tipo.equals("S"))
                            query = cmb.montaCombo("Tabela1", filial, codigo, aplicacao);								

			rs = conexao.executaConsulta(query,session.getId());
			if(rs.next()) {
                            do {%>
                                <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
<%                          } while(rs.next());
			}
                        if(rs!=null){rs.close();conexao.finalizaConexao(session.getId());}   
                            %>
                      </select>
<%                  } else {%>
                    <td width="9%">&nbsp;</td>
                    <td width="21%">&nbsp; 
<%                  }%>
                    </td>
                  </tr>

                  <tr>
                    <!--///////////////////////FUNCIONARIO///////////////////////-->
                    <td width="9%" class="ftverdanacinza" align="right"><%=trd.Traduz("FUNCIONARIO")%>:</td>
                    <td width="21%"> 
                      <select name="sel_funcion">
                        <option value=""><%=trd.Traduz("Todos")%></option>
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
<%                          } while(rs.next());
			}
                        if(rs!=null){rs.close();conexao.finalizaConexao(session.getId());}   
                        %>
                      </select>
                    </td>
                    <!--/////////////////////////SOLICITANTE////////////////////////-->
                    <td width="10%" class="ftverdanacinza" align="right"><%=trd.Traduz("SOLICITANTE")%>:</td>
                    <td width="21%"> 
                      <select name="sel_solic">
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
                                <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
<%                          } while(rs.next());
                        } 
                        if(rs!=null){rs.close();conexao.finalizaConexao(session.getId());}   
                        %>
                      </select>
                    </td>
                  </tr>
                  <!--///////////////////////TABELA4///////////////////////-->
                  <tr> 
<%		  if(prm.buscaparam("USE_TB4").equals("S")) {	%>
                    <td width="9%" class="ftverdanacinza" align="right"><%=trd.Traduz("TABELA4")%>:</td>
                    <td width="21%"> 
                      <select name="sel_tabela4">
                        <option value=""><%=trd.Traduz("Todos")%></option>
<%			if(usu_tipo.equals("F"))
                            query = cmb.montaCombo("Tabela4", "null", "null", aplicacao);	
			if(usu_tipo.equals("P") || usu_tipo.equals("G"))
                            query = cmb.montaCombo("Tabela4", filial, "null", aplicacao);	
			if(usu_tipo.equals("S"))
                            query = cmb.montaCombo("Tabela4", filial, codigo, aplicacao);	  

			rs = conexao.executaConsulta(query,session.getId());
			if(rs.next()) {
                            do {%>
                                <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
<%                          } while(rs.next());
			}
                        if(rs!=null){rs.close();conexao.finalizaConexao(session.getId());}   
                        %>
                      </select>
<%                  } else {%>
                    <td width="10%">&nbsp;</td>
                    <td width="21%">&nbsp; 
<%                  }%>
                    </td>
                    <td width="9%">&nbsp;</td>
                    <td width="21%">&nbsp;</td>
                  </tr>
		</table>
                <table width="80%" border="0" cellspacing="2" cellpadding="2">
                  <tr>
                    <!--//////////////////////// DATA INICIAL //////////////////////////////-->
		    <td width="13%" class="ftverdanacinza" align="right"><%=trd.Traduz("DATA INICIAL")%>:</td>
                    <td width="33%">							
                      <input type="text" name="text_datainicio" size="10" maxlength="10" onChange="ChecaData(this)" onKeyDown="FormataData(this, window.event.keyCode,'down')" onKeyUp="FormataData(this, window.event.keyCode,'up')"> 
                      &nbsp;<img onclick="DoCal(text_datainicio)" style="cursor:hand" src="../art/icon_cal.gif" title="CalendArio" WIDTH="17" HEIGHT="16"> 
                    </td>                 
                    <!--//////////////////////// DATA FINAL //////////////////////////////-->
                    <td width="13%" class="ftverdanacinza" align="right"><%=trd.Traduz("DATA FINAL")%>:</td>
                    <td width="33%"> 				
                    <input type="text" name="text_datafinal" size="10" maxlength="10" onChange="ChecaData(this)" onKeyDown="FormataData(this, window.event.keyCode,'down')" onKeyUp="FormataData(this, window.event.keyCode,'up')">
                    &nbsp;<img onclick="DoCal(text_datafinal)" style="cursor:hand" src="../art/icon_cal.gif" title="CalendArio" WIDTH="17" HEIGHT="16"> 
		    </td>
                  </tr>
                </table>
                <br>
                <table width="80%" border="0" cellspacing="2" cellpadding="2">
                  <tr> 
                    <td width="30%" class="celtittab"><%=trd.Traduz("STATUS TURMA")%></td>
                    <td width="30%" class="celtittab"><%=trd.Traduz("TIPO RELATORIO")%></td>
                    <td width="30%" class="celtittab"><%=trd.Traduz("TIPO TURMA")%></td>
                  </tr>
                  <tr valign="top"> 
                    <td width="30%" class="ftverdanacinza"> 
                      <input type="checkbox" name="chk_part_ok" value="OK">
                      <%=trd.Traduz("PART. OK")%><br>
                      <input type="checkbox" name="chk_part_maior" value="MA">
                      <%=trd.Traduz("PART. EXCEDIDO")%><br>
                      <input type="checkbox" name="chk_part_menor" value="ME">
                      <%=trd.Traduz("PART. ABAIXO")%><br>
                      <input type="checkbox" name="chk_part_reg" value="RE">
                      <%=trd.Traduz("REGISTRADAS")%><br>
                    </td>
                    <td width="30%" class="ftverdanacinza"> 
                      <input type="radio" name="rdo_tipo_rel" value="R" checked>
                      <%=trd.Traduz("RESUMIDO")%><br>
                      <input type="radio" name="rdo_tipo_rel" value="D">
                      <%=trd.Traduz("DETALHADO")%><br>
                    </td>
                    <td width="30%" class="ftverdanacinza"> 
                      <input type="checkbox" name="chk_turma_ant" value="2">
                      <%=trd.Traduz("ANTECIPADA")%><br>
                      <input type="checkbox" name="chk_turma_longa" value="3">
                      <%=trd.Traduz("LONGA DURACAO")%><br>
                    </td>
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
 </FORM>
</body>
</html>
<%
%>