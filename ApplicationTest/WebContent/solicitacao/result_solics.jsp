<%
    response.setHeader("Pragma", "no-cache");
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
    if (request.getProtocol().equals("HTTP/1.1"))
    {
      response.setHeader("Cache-Control", "cache");
    }
	
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*, java.util.*"%>

<%
//try{
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 
String usu_plano = "";
usu_plano = usu_plano.valueOf(session.getAttribute("usu_plano")); 
Vector per = (Vector)session.getAttribute("vetorPermissoes");

String moeda = prm.buscaparam("MOEDA");

ResultSet rs = null, rsf = null, rsps = null;

Vector funcvet = new Vector();
session.setAttribute("funcs", funcvet);

String query = "", queryf = "", func = "", query_perfil; 
int contador = 0;

boolean botao1 = false, botao2 = false, botao3 = false, botao4 = false, bloquear = false;

if (!(request.getParameter("fun_codigo") == null)){
 func = request.getParameter("fun_codigo");
}
else
{
 func="0";
}

//Verifica Bloqueio de Funcionalidades
query = "SELECT PLA_NOVASOLICITACAO FROM PLANO WHERE PLA_CODIGO = "+usu_plano;
rs = conexao.executaConsulta(query, session.getId()+"RS1");

if (rs.next()) {
	if(rs.getString(1) != null) {
		if(rs.getString(1).equals("N"))
			bloquear = true;
	}
}

if(rs != null){
    rs.close();
    conexao.finalizaConexao(session.getId()+"RS1");
}

queryf = "SELECT FUN_CODIGO, FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = " + func + " ";

query = "SELECT TREINAMENTO.FUN_CODIGO, FUNCIONARIO.FUN_NOME, " + 
" CURSO.CUR_NOME, QUEBRA.QBR_NOME, " + 
" TREINAMENTO.TEF_DURACAO, TREINAMENTO.TEF_CUSTO, " + 
" TREINAMENTO.TEF_INICIO, TREINAMENTO.TEF_FIM, " + 
" NULL, TREINAMENTO.JUS_CODIGO, CURSO.CUR_CODIGO, " + 
" TREINAMENTO.TEF_CODIGO, TITULO.TIT_CODIGO, TITULO.ASS_CODIGO " + 
" FROM TREINAMENTO, FUNCIONARIO, QUEBRA, CURSO, TITULO " + 
" WHERE FUNCIONARIO.FUN_CODIGO = TREINAMENTO.FUN_CODIGO AND " + 
" CURSO.CUR_CODIGO = TREINAMENTO.CUR_CODIGO AND " + 
" TITULO.TIT_CODIGO = CURSO.TIT_CODIGO AND " + 
" QUEBRA.QBR_CODIGO = TREINAMENTO.QBR_CODIGO AND " + 
" TREINAMENTO.FUN_CODIGO = " + func + " " + 
" AND TREINAMENTO.PLA_CODIGO = " + usu_plano + " " + 
" AND TREINAMENTO.TEF_PLANEJADO = 'S' AND TREINAMENTO.TUR_CODIGO_REAL IS NULL " + 
" UNION SELECT TREINAMENTO.FUN_CODIGO, FUNCIONARIO.FUN_NOME, " + 
" CURSO.CUR_NOME, QUEBRA.QBR_NOME, " + 
" TURMA.TUR_DURACAO, TURMA.TUR_CUSTO, " + 
" TURMA.TUR_DATAINICIO, TURMA.TUR_DATAFINAL, " + 
" TREINAMENTO.TUR_CODIGO_REAL, TREINAMENTO.JUS_CODIGO, CURSO.CUR_CODIGO, " + 
" TREINAMENTO.TEF_CODIGO, TITULO.TIT_CODIGO, TITULO.ASS_CODIGO " + 
" FROM TREINAMENTO, FUNCIONARIO, QUEBRA, CURSO, TITULO, TURMA " + 
" WHERE FUNCIONARIO.FUN_CODIGO = TREINAMENTO.FUN_CODIGO AND " + 
" TURMA.TUR_CODIGO = TREINAMENTO.TUR_CODIGO_REAL AND " + 
" CURSO.CUR_CODIGO = TREINAMENTO.CUR_CODIGO AND " + 
" TITULO.TIT_CODIGO = CURSO.TIT_CODIGO AND " + 
" QUEBRA.QBR_CODIGO = TREINAMENTO.QBR_CODIGO AND " + 
" TREINAMENTO.FUN_CODIGO = " + func + " " + 
" AND TREINAMENTO.PLA_CODIGO = " + usu_plano + " " + 
" AND TREINAMENTO.TEF_PLANEJADO = 'S' AND TREINAMENTO.TUR_CODIGO_REAL IS NOT NULL " + 
" ORDER BY CUR_NOME";
%>

<script language="JavaScript"> 
function deleta()
{
	var checado=0;
	var cod = 0;
	for(i=1;i<=frm.contador.value;i++)
	{
		if(eval("frm.checkbox"+i+".checked")==true)
		{
			checado = checado+1;
		}
	}
	if(checado == 0)
	{
		alert(<%=("\""+trd.Traduz("NENHUM ITEM SELECIONADO")+"\"")%>);
		return false;
	}
	else
	{
		if (confirm(<%=("\""+trd.Traduz("Deseja Excluir o item selecionado?")+"\"")%>))
		{
			frm.action = "solic_deleta.jsp";
			frm.submit();
			return true;
		}
		else
		{
			return false;
		}
	}
}

function semplano()
{
	alert(<%=("\""+trd.Traduz("NAO EXISTE PLANO SUCESSORIO PARA O FUNCIONARIO")+"\"")%>);
	return false;
}

function altera(func)
{
	var teste = 0;
	var cod = 0;
	for(i=1;i<=frm.contador.value;i++)
	{
		if(eval("frm.checkbox"+i+".checked")==true)
		{
			teste = teste+1;
			cod = eval("frm.hd"+i+".value");
			//cod = eval("frm.curso"+i+".value");
		}
	}
	if(teste == 0)
	{
		alert(<%=("\""+trd.Traduz("NENHUM ITEM SELECIONADO")+"\"")%>);
		return false;
	}
	else
	{
		if(teste>1)
		{
			alert(<%=("\""+trd.Traduz("Selecione apenas um item!")+"\"")%>);
		}
		else
		{		
  			window.open("solic_extra.jsp?"+cod,"_parent");			
		}
	}
	return false;
}
</script>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("SolicitaCAo")%> - <%=trd.Traduz("SOLICITAR")%></title>
<script language="JavaScript" src="scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<%!
public String ReaistoStr(float valor, String moeda){
	DecimalFormat dcf = new DecimalFormat("0.00");
	dcf.setMaximumFractionDigits(2);
	String strReais = dcf.format(valor);
	return moeda + strReais;
}
%>

<%! public String convHora(float minutos)
{	
	Float aux = new Float(minutos);
	int hora_aux = aux.intValue();
	String total = "";
	int hora = hora_aux / 60;
	int min  = hora_aux % 60;
	if(min < 10)
		total = hora + ":0" + min;
	else
		total = hora + ":" + min;
	return total;
}
%>


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
	      	      	      	      if(ponto.equals("..")){
              %>
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
                <td class="trontrk" width="297" align="center"><%=trd.Traduz("SOLICITAR")%></td>
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
          <td width="20" valign="top">&nbsp;</td>
		  <FORM name="frm">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
                </tr>
                <tr> 
                  <td height="20" class="ctfontc" align="center"> 
                    <table border="0" cellspacing="3" cellpadding="0">
                      <tr class="ctfontb"> 
                        <td width="10"><img src="../art/green.gif" width="17" height="17"></td>
                        <td width="100">= <%=trd.Traduz("Realizado")%></td>
                        <td width="10"><img src="../art/black.gif" width="17" height="17"></td>
                        <td width="100">= <%=trd.Traduz("Planejado")%></td>
                        <td width="10"><img src="../art/blue.gif" width="17" height="17"></td>
                        <td width="100">= <%=trd.Traduz("Justificado")%></td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
                </tr>
                <tr> 
                  <td class="ctvdiv" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
                </tr>
                <tr> 
                  <td height="258">
					<% if(bloquear == false) { %>
					<center>
                      <p>&nbsp;</p><table border="0" cellspacing="0" cellpadding="0">				      
                        <tr> 
                          <td> 
                            <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
							<%
								if(per.contains("SOLICITACAO - PRE REQUISITOS - CONSULTA")||per.contains("SOLICITACAO - PRE REQUISITOS - MANUTENCAO"))
									{
										botao1 = true;
										%>
				                          <tr>
					                        <td onMouseOver="this.className='ctonlnk2';" OnClick = "location='prerequisitos.jsp?fun_codigo=<%=func%>'" width="200" height="22" align=center class="botver"><a href="prerequisitos.jsp?fun_codigo=<%=func%>"  class="txbotver"><%=trd.Traduz("PRE-REQUISITOS")%></a></td>
						                  </tr>
										<%
									}
								%>
		                        </table>
			                 </td>
							 <td width="10">&nbsp;</td>
                          <td> 
                            <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
							<%
									if(per.contains("SOLICITACAO - POR COMPETENCIAS - MANUTENCAO")||per.contains("SOLICITACAO - POR COMPETENCIAS - CONSULTA"))
								{
									botao2 = true;
									%>							
		                              <tr> 
				                        <td onMouseOver="this.className='ctonlnk2';" OnClick = "location='porcompetencias.jsp?fun_codigo=<%=func%>'" width="200" height="22" align=center class="botver"><a href="porcompetencias.jsp?fun_codigo=<%=func%>" class="txbotver">
										<%=trd.Traduz("POR COMPETENCIAS")%></a></td>
								      </tr>
									<%
								}
							%>
                            </table>
                          </td>
						   <td width="10">&nbsp;</td>
                          <td> 
                            <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
							<%							
								

								if(per.contains("SOLICITACAO - PLANO SUCESSORIO"))
								{
									botao3 = true;

                                   	String querys = "SELECT CAR_CODIGO, CAR_NOME FROM CARGO WHERE CAR_CODIGO IN (SELECT CAR_CODIGO FROM PLANO_SUCESSORIO WHERE FUN_CODIGO = " + func + ") ORDER BY CAR_NOME";	
									rsps = conexao.executaConsulta(querys, session.getId()+"RS2");

									if (rsps.next())
									{
									%>							
		                              <tr> 
				                        <td onMouseOver="this.className='ctonlnk2';" OnClick = "location='planosussessorio.jsp?fun_codigo=<%=func%>'" width="200" height="22" align=center class="botver"><a href="planosussessorio.jsp?fun_codigo=<%=func%>" class="txbotver">
										<%=trd.Traduz("PLANO SUCESSORIO")%></a></td>
								      </tr>
									<%
									}
									else
									{%>
		                              <tr> 
				                        <td onMouseOver="this.className='ctonlnk2';" OnClick = "return semplano();" width="200" height="22" align=center class="botver"><a href="#" class="txbotver">
										<%=trd.Traduz("PLANO SUCESSORIO")%></a></td>
								      </tr>
									<%}
								}

                                                                if(rsps != null){
                                                                    rsps.close();
                                                                    conexao.finalizaConexao(session.getId()+"RS2");
                                                                }

							%>
							</table>
                          </td>
                          <td width="10">&nbsp;</td>
                          <td> 
                            <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
			<%

				if(per.contains("SOLICITACAO - REPROGRAMACAO"))
				{
					botao4 = true;
						%>
		                        	<tr> 
				        	  <td onMouseOver="this.className='ctonlnk2';" OnClick="location='reprogramacao.jsp?fun_codigo=<%=func%>'" width="200" height="22" align=center class="botver"><a href="reprogramacao.jsp?fun_codigo=<%=func%>" class="txbotver"><%=trd.Traduz("REPROGRAMACAO")%></a></td>
		                        	</tr>
						<%
				}
			%>
                            </table>
                          </td>
                        </tr>
                      </table>
                    </center>
<% }//if(bloquear == false)
rsf = conexao.executaConsulta(queryf, session.getId()+"RS3");
if (rsf.next())
{
%>
                    <p><span class="ftverdanacinza">
					<%=trd.Traduz("FUNCIONARIO")%>:</span> <span class="ftverdanapreto"><%=rsf.getString(2)%></span> </p>
<%
}

if(rsf != null){
    rsf.close();
    conexao.finalizaConexao(session.getId()+"RS3");
}

%>
<%
rs = conexao.executaConsulta(query,session.getId()+"RS4");
if (rs.next())
{%>

                    <table border="0" cellspacing="1" cellpadding="2" width="100%">
                      <tr>
						<% if(bloquear == false) { %>
	                      	<td width="3%" class="celtittab" height="28"></td> 
						<%	} %> 		
                        <td width="38%" class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("Nome do Curso")%></div>
                        </td>
                        <td width="10%" class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("PrevisAo")%></div>
                        </td>
                        <td width="12%" class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("Custo")%></div>
                        </td>
                        <td width="10%" class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("DuraCAo")%></div>
                        </td>
                        <td width="12%" class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("Data Inicial")%></div>
                        </td>
                        <td width="23%" class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("Data Final")%></div>
                        </td>
                      </tr>

	<%do
	{
		if (!(rs.getString(9) == null))
		{
			%>
			<tr class="celnortabv"> 
			<%
		}
		else
		{
			if (!(rs.getString(10) == null))
			{
				%>
				<tr class="celnortaba"> 
				<%
			}
			else
			{
				%>
				<tr class="celnortab"> 
				<%
			}
		}
		 if(bloquear == false) { 
			if((!(rs.getString(8) == null)) || (!(rs.getString(9) == null)) || (!(rs.getString(10) == null)))
			{
				%> <td width="3%">&nbsp;</td> <%
			}
			else
			{
				contador++;
			
				if((botao1 == true) || (botao2 == true) || (botao3 == true) || (botao4 == true))
				{
					%>
					<td width="3%"><input type="checkbox" name="checkbox<%=contador%>" 	value="<%=rs.getString(12)%>"></td>
					<input type="hidden" name="curso<%=contador%>" value="<%=rs.getString(11)%>">
					<input type="hidden" name="hd<%=contador%>" value="origem=result_solics&extra=N&fun_codigo=<%=rs.getString(12)%>&selectass=<%=rs.getString(14)%>&selecttit=<%=rs.getString(13)%>&selectcur=<%=rs.getString(11)%>&contador=1&operacao=U&curso1=<%=rs.getString(11)%>&checkbox1=1&fun_cod_fun=<%=func%>">
	            	<%
				}
			}
		}//if(bloquear == false)
		%>
		<td width="38%"><%=rs.getString(3)%></td>
		<td width="10%" align="center"><%=rs.getString(4)%></td>
		<td width="12%" align="right"><%=ReaistoStr(rs.getFloat(6),moeda)%></td>
		<td width="10%" align="right"><%=convHora(rs.getFloat(5))%></td>
		<%
		String dataf = new String();
		if (!(rs.getString(7) == null))
		{
			java.util.Date diai = rs.getDate(7);
			SimpleDateFormat data1 = new SimpleDateFormat("dd/MM/yyyy");
			dataf = data1.format(diai);
		}				
		if (!(rs.getString(7) == null))
		{
			%>
			<td width="12%" align="center"><%=dataf%></td>
			<%
		}
		else
		{
			%>
			<td width="12%"></td>
			<%
		}
		dataf = "";
		if (!(rs.getString(8) == null))
		{
			java.util.Date dia = rs.getDate(8);
			SimpleDateFormat datafi = new SimpleDateFormat("dd/MM/yyyy");
			dataf = datafi.format(dia);
			%>
			<td width="20%" align="center"><%=dataf%></td>
			<%
		}
		else
		{
			%>
			<td width="20%" align="right">&nbsp;
			
			</td>
			<%
		
		}
		%>
	</tr>
	<%
	}while (rs.next());

}
else
{
%>
                     <table border="0" cellspacing="1" cellpadding="2" width="100%">
                      <tr>
                      	<td width="38%" class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...</div>
                        </td>
                        
                      </tr>
<%
}

if(rs != null){
    rs.close();
    conexao.finalizaConexao(session.getId()+"RS4");
}

%>
                    </table>
                    
                  </td>
                </tr>
                <tr> 
                  <td class="cthdivb" colspan="3" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
                </tr>
                <tr> 
                  <td colspan="3">&nbsp;</td>
                </tr>          	
			<%
				if((botao1 == true) || (botao2 == true) || (botao3 == true))
				{
					%>
						<tr align="center">
          					<td align="center">
			          			<input type="button" class="botcin" value=<%=("\""+trd.Traduz("ALTERAR")+"\"")%> OnClick="return altera(<%=func%>);">
          						<input type="button" class="botcin" value=<%=("\""+trd.Traduz("EXCLUIR")+"\"")%> OnClick="return deleta();">
	            			</td>
						</tr>
				    <%
				}
 		    %>
          	
                <tr> 
                  <td colspan="3">&nbsp;</td>
                </tr>
                
              </table>
          </td>
          
	<input type="hidden" name="contador" value="<%=contador%>">
	<input type="hidden" name="fun_codigo" value="<%=func%>">
	<input type="hidden" name="origem" value="result_solics">
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
          <td> <%  if(ponto.equals("..")){%>
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
//} catch(Exception e){
//  out.println("Erro: "+e);
//}
%>