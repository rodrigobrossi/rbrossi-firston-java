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

ResultSet rs = null;
String query = "", tipo_rel = "";
int ava_codigo = 0;

String filial = ""+usu_fil;
String codigo = ""+usu_cod;

//try {

	if(request.getParameter("hid_avaliacao") != null)
		ava_codigo = Integer.parseInt(request.getParameter("hid_avaliacao"));

	if(request.getParameter("hid_tiporel") != null)
		tipo_rel = request.getParameter("rdo_tipo");
	else
		tipo_rel = "R";
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("ImpressOes")%> - <%=trd.Traduz("Impressoes das Avaliacoes")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<script language="JavaScript">
function filtra() 
{
  if ((frm.sel_avaliacao.value == "S") || (frm.sel_avaliacao.value == "T"))
  {
    alert(<%=("\""+trd.Traduz("Favor selecionar a avaliacao!")+"\"")%>);
    frm.sel_avaliacao.focus;
    return false;
  }

  if (frm.sel_questionario.value == "S") 
  {
    alert(<%=("\""+trd.Traduz("Favor selecionar o questionario!")+"\"")%>);
    frm.sel_questionario.focus;
    return false;
  }

  frm.action ="01_impressaoavaliacao_lista.jsp";
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

function questionario()
{
	frm.hid_avaliacao.value = frm.sel_avaliacao.value;
	frm.action="01_impressaoavaliacao.jsp";
	frm.submit();
	return true;
}

function tipo_relatorio()
{
	//frm.hid_tiporel.value = frm.rdo_tipo.value;	
	//frm.action="01_impressaoavaliacao.jsp";
	//frm.submit();
	//return true;
}
</script>

<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../art/onenglish.gif','../art/onespanol.gif')">
<form name = "frm">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="59" class="hcfundo"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
<%	       String ponto = (String)session.getAttribute("barra");
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
				if (request.getParameter("op") == null)
				{
                  oi = "../menu/menu.jsp?op="+"I";
				}
				else
				{
                  oi = "../menu/menu.jsp?op="+request.getParameter("op");
				}
				if (request.getParameter("opt") == null)
				{
                  oia = "../menu/menu1.jsp?opt="+"IDA";
				} 
				else
				{  
                  oia = "../menu/menu1.jsp?opt="+request.getParameter("opt");
				}
		}else{
		
		if (request.getParameter("op") == null)
						{
		                  oi = "/menu/menu.jsp?op="+"I";
						}
						else
						{
		                  oi = "/menu/menu.jsp?op="+request.getParameter("op");
						}
						if (request.getParameter("opt") == null)
						{
		                  oia = "/menu/menu1.jsp?opt="+"IDA";
						} 
						else
						{  
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
                <td class="trontrk" align="center"><%=trd.Traduz("Impressoes das Avaliacoes")%></td>
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
                  <TR>
                    <!--***************************DEPARTAMENTO*******************************-->

					<%
					if(prm.buscaparam("USE_DEPARTAMENTO").equals("S"))
					{
						%>
							<td width="13%" class="ftverdanacinza" align="right"><%=trd.Traduz("Departamento")%>:</td>
		                    <td width="36%"> 
								<select name="cbo_departamento">
								<option value=""><%=trd.Traduz("todos")%></option>
								<%
									if(usu_tipo.equals("F"))
									  query = cmb.montaCombo("Departamento", "null", "null", aplicacao);	
									if(usu_tipo.equals("P") || usu_tipo.equals("G"))
									  query = cmb.montaCombo("Departamento", filial, "null", aplicacao);	
									if(usu_tipo.equals("S"))
									  query = cmb.montaCombo("Departamento", filial, codigo, aplicacao);	
									rs = conexao.executaConsulta(query,session.getId());
									if(rs.next()) 
									{
			                          do 
									  {
										  %>
											<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
										  <%
										} while(rs.next());
									}
                                                                        if(rs!=null){
                                                                            rs.close();
                                                                            conexao.finalizaConexao(session.getId());
                                                                            }
								%>
								</select>
				            </td>
						<%
					}
								
					else
					{
						%>
							<td width="13%" class="ftverdanacinza" align="right"> &nbsp; </td>
			                   <td width="36%"> &nbsp; </td>
						<%
					}
					%>

                    
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
                        if(rs!=null){
                           rs.close();
                           conexao.finalizaConexao(session.getId());
                        }
                      }%>
                      </select>
                    </td>
                  </tr>

                  <TR>
                    <!--***************************FUNCIONARIO*******************************-->
                    <td width="18%" class="ftverdanacinza" align="right"><%=trd.Traduz("FuncionArio")%>:</td>
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
                  </TR>

                  <tr> 
                    <!--///////////////////////AVALIACAO///////////////////////////-->
                    <td width="18%" class="ftverdanacinza" align="center"><%=trd.Traduz("AVALIACAO")%>:</TD>
                    <td width="33%">
					<select name="sel_avaliacao" onChange="return questionario();">
						<%
							if(tipo_rel.equals("R"))
							{
								%> <option value="S"><%=trd.Traduz("Selecione")%></option> <%					
							}	
							
							else
							{
								%> <option value="T"><%=trd.Traduz("Todos")%></option> <%					
							}	
						
						    query = "SELECT AVA_CODIGO, AVA_DESCRICAO FROM AVALIACAO ORDER BY AVA_DESCRICAO";
                            rs = conexao.executaConsulta(query,session.getId());
                            if(rs.next()) 
							{
								do
								{
									if(rs.getInt(1) == ava_codigo)
									{
										%>
											<option selected 	value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
										<%
									}

									else
									{
										%>
											<option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
										<%
									}
								}while(rs.next());
                            }
                            if(rs!=null){
                            rs.close(); 
                            conexao.finalizaConexao(session.getId());
                            }
						%>
					</select>												
                    </td>                  

			 <!--///////////////////////QUESTIONARIO///////////////////////////-->
			 <%
				 if(ava_codigo > 0)
				 {
				 %>					 
					 <td width="18%" class="ftverdanacinza" align="center"><%=trd.Traduz("QUESTIONARIO")%>:</td>
		             <td width="33%">
					 <select name="sel_questionario">
						 <option value="S"><%=trd.Traduz("Selecione")%></option>
						 <%
							query = "SELECT QUE_CODIGO, QUE_NOME "+
									"FROM QUESTIONARIO "+
									"WHERE AVA_CODIGO = "+ava_codigo+" "+
									"ORDER BY QUE_NOME";

				            rs = conexao.executaConsulta(query,session.getId());
						    if(rs.next()) 
							{
								do 
								{
									%>
										<option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
									<%
								}while(rs.next());
						    }
                                                   if(rs!=null) {
                                                   rs.close();
                                                   conexao.finalizaConexao(session.getId());
                                                    }
						 %>
					 </select>												
		             </td>					
				 <%
				 }
				%>
				</tr>
				<tr>
                  <!--//////////////////////// DATA INICIAL //////////////////////////////-->
		    <td width="25%" class="ftverdanacinza" align="right"><%=trd.Traduz("DATA INICIAL")%>:</td>
                    <td width="25%">							
                      <input type="text" name="text_datainicio" size="10" maxlength="10" onChange="ChecaData(this)" onKeyDown="FormataData(this, window.event.keyCode,'down')" onKeyUp="FormataData(this, window.event.keyCode,'up')"> 
                      &nbsp;<img onclick="DoCal(text_datainicio)" style="cursor:hand" src="../art/icon_cal.gif" title="CalendArio" WIDTH="17" HEIGHT="16"> 
                    </td>                 
                  <!--//////////////////////// DATA FINAL //////////////////////////////-->
					<td width="25%" class="ftverdanacinza" align="right"><%=trd.Traduz("DATA FINAL")%>:</td>
					<td width="25%"> 				
		      <input type="text" name="text_datafinal" size="10" maxlength="10" onChange="ChecaData(this)" onKeyDown="FormataData(this, window.event.keyCode,'down')" onKeyUp="FormataData(this, window.event.keyCode,'up')">
		      &nbsp;
	              <img onclick="DoCal(text_datafinal)" style="cursor:hand" src="../art/icon_cal.gif" title="CalendArio" WIDTH="17" HEIGHT="16"> 
                    </td>
                  </tr>	
                </table>
                <br>
                <table width="100%" border="0" cellspacing="2" cellpadding="2">
                  <tr> 
                    <td width="80%" class="celtittab"><%=trd.Traduz("TIPOS DE RELATORIO")%></td>
                  </tr>
                  <tr> 
                    <td class="ftverdanacinza"> 
					  <input type="radio" name="rdo_tipo" value="R" checked onClick="return tipo_relatorio();"><%=trd.Traduz("FOLHA DE RESPOSTA")%><br>
                      <input type="radio" name="rdo_tipo" value="A" onClick="return tipo_relatorio();"><%=trd.Traduz("AVALIACAO")%>
					</td>
                  </tr>
		  <tr><td colspan="100%">&nbsp;</td></tr>
                  <tr><td colspan="100%" align="center"><input type="button" value=<%=("\""+trd.Traduz("IMPRIMIR")+"\"")%> onclick='return filtra();' class="botcin"></td></tr>
                </table>
              </center>
          </td>
		  <input type="hidden" name="hid_avaliacao">
		  <input type="hidden" name="hid_tiporel">
	
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
               <%if(ponto.equals("..")) {%>
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
  </form>
</body>
</html>
<%

//} catch (Exception e) {
//}
%>