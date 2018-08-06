<%
    response.setHeader("Pragma", "no-cache");
    if (request.getProtocol().equals("HTTP/1.1"))
    {
      response.setHeader("Cache-Control", "no-cache");
    }
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*, java.lang.Math.*, java.util.*"%>

<%
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Registro")%> - <%=trd.Traduz("Alterar/Registrar Turma Antecipada")%></title>
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
	      if(ponto.equals("..")){%>
               <jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="RG"/></jsp:include> 
               <%}else{%>
               <jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="RG"/></jsp:include> 
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
                  oi = "../menu/menu.jsp?op="+"R";
				}
				else
				{
                  oi = "../menu/menu.jsp?op="+request.getParameter("op");
				}
				if (request.getParameter("opt") == null)
				{
                  oia = "../menu/menu1.jsp?opt="+"CTA";
				} 
				else
				{  
                  oia = "../menu/menu1.jsp?opt="+request.getParameter("opt");
				}
		}else{
		if (request.getParameter("op") == null)
						{
		                  oi = "/menu/menu.jsp?op="+"R";
						}
						else
						{
		                  oi = "/menu/menu.jsp?op="+request.getParameter("op");
						}
						if (request.getParameter("opt") == null)
						{
		                  oia = "/menu/menu1.jsp?opt="+"CTA";
						} 
						else
						{  
		                  oia = "/menu/menu1.jsp?opt="+request.getParameter("opt");
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
                <td class="trontrk" width="297" align="center">Alterar/Registrar Turma Antecipada</td>
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
		  <FORM>
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                  <td height="20" class="ctfontc" align="center">&nbsp; TITULO: 
                    <select name="select">
                      <option> </option>
                      <option>PO</option>
                      <option>PC</option>
                      <option>Windows</option>
                    </select>
					&nbsp; &nbsp; CURSO: <select name="select2">
                      <option> </option>
                      <option>PO.01.05.004 - Treinamento, Conscientiza&ccedil;&atilde;o 
                      e Qualifica&ccedil;&atilde;o - Rev.01</option>
                      <option>Windows</option>
                      <option>PO.01.05.001 - Bolsa de Estudos</option>
                      <option>Lideran&ccedil;a</option>
                    </select>
                    &nbsp; &nbsp; <img src="../art/bot_filtrar.gif" border=0>	
                  </td>
              </tr>
              <tr> 
                <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                <td class="ctvdiv" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                <td>&nbsp;<br>
			 	<center>
                      <table border="0" cellspacing="1" cellpadding="2" width="80%">
                        <tr class="celtittabcin"> 
                          <td colspan="6">4 linhas</td>
                        </tr>
                        <tr class="celtittab"> 
                          <td>Curso</td>
                          <td>Data Inicial</td>
                          <td>Data Final</td>
                          <td>Inscritos</td>
                          <td>M&aacute;ximo</td>
                          <td>Local</td>
                        </tr>
                        <tr class="celnortab"> 
                          <td><a class="lnk" href="12_participantesdaturmaantecipada.jsp">Windows 
                            2000 </a></td>
                          <td><a class="lnk" href="12_participantesdaturmaantecipada.jsp">21/12/2002</a></td>
                          <td><a class="lnk" href="12_participantesdaturmaantecipada.jsp">21/12/2002</a></td>
                          <td><a class="lnk" href="12_participantesdaturmaantecipada.jsp">01</a></td>
                          <td><a class="lnk" href="12_participantesdaturmaantecipada.jsp">10</a></td>
                          <td><a class="lnk" href="12_participantesdaturmaantecipada.jsp">Matriz</a></td>
                        </tr>
                        <tr class="celnortab"> 
                          <td><a class="lnk" href="12_participantesdaturmaantecipada.jsp">Lideran&ccedil;a</a></td>
                          <td><a class="lnk" href="12_participantesdaturmaantecipada.jsp">15/07/2002</a></td>
                          <td><a class="lnk" href="12_participantesdaturmaantecipada.jsp">15/07/2002</a></td>
                          <td><a class="lnk" href="12_participantesdaturmaantecipada.jsp">0</a></td>
                          <td><a class="lnk" href="12_participantesdaturmaantecipada.jsp">15</a></td>
                          <td><a class="lnk" href="12_participantesdaturmaantecipada.jsp">Matriz</a></td>
                        </tr>
                        <tr class="celnortab"> 
                          <td><a class="lnk" href="12_participantesdaturmaantecipada.jsp">PO.01.05.001 
                            - Bolsa de Estudos</a></td>
                          <td><a class="lnk" href="12_participantesdaturmaantecipada.jsp">16/09/2002</a></td>
                          <td><a class="lnk" href="12_participantesdaturmaantecipada.jsp">16/09/2002</a></td>
                          <td><a class="lnk" href="12_participantesdaturmaantecipada.jsp">5</a></td>
                          <td><a class="lnk" href="12_participantesdaturmaantecipada.jsp">10</a></td>
                          <td><a class="lnk" href="12_participantesdaturmaantecipada.jsp">Matriz</a></td>
                        </tr>
                      </table>
                    </center>
                    <br>
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
</body>
</html>
