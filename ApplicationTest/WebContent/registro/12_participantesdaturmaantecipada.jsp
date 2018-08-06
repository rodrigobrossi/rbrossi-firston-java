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
<title>FirstOn - <%=trd.Traduz("Registro")%> - <%=trd.Traduz("Participantes da Turma Antecipada")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','art/onenglish.gif','art/onespanol.gif')">
 <FORM name="frm">
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
                  oia = "../menu/menu1.jsp?opt="+"LTA";
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
		                  oia = "/menu/menu1.jsp?opt="+"LTA";
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
                <td class="trontrk" width="297" align="center">Participantes da Turma Antecipada</td>
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
                <img src="../art/bot1_incluir.gif" width="127" height="22"> &nbsp; 
                <img src="../art/bot1_remanejar.gif" width="127" height="22"> 
                &nbsp; <img src="../art/bot1_excluir.gif" width="127" height="22"> 
                &nbsp; <a href="03_registrarlistadepresenca.jsp"><img src="../art/bot1_registrar.gif" width="127" height="22" border="0"></a> 
                <p>
                <table border="0" cellspacing="1" cellpadding="2" width="70%">
                  <tr class="celtittabcin"> 
                    <td colspan="4">4 linhas</td>
                            </tr>
                            <tr class="celtittab"> 
                              <td width="7%" align="center">&nbsp;</td>
                              
                    <td width="31%">Chapa</td>
                              
                    <td width="31%">Nome</td>
                              
                    <td width="31%">Cargo</td>
                            </tr>
                            <tr class="celnortab"> 
                              <td width="7%" align="center"> 
                                <input type="checkbox" name="checkbox" value="checkbox">
                              </td>
                              <td width="31%">0055</td>
                              <td width="31%">Dante Leal Amorim</td>
                              <td width="31%">Gerente de RH</td>
                            </tr>
                            <tr class="celnortab"> 
                              <td width="7%" align="center"> 
                                <input type="checkbox" name="checkbox" value="checkbox">
                              </td>
                              <td width="31%">0056</td>
                              <td width="31%">Denise Furlan</td>
                              <td width="31%">Estagi&aacute;ria</td>
                            </tr>
                            <tr class="celnortab"> 
                              <td width="7%" align="center"> 
                                <input type="checkbox" name="checkbox" value="checkbox">
                              </td>
                              <td width="31%">0057</td>
                              <td width="31%">Denise Alvez</td>
                              <td width="31%">Progamadora</td>
                            </tr>
                            <tr class="celnortab"> 
                              <td width="7%" align="center"> 
                                <input type="checkbox" name="checkbox" value="checkbox">
                              </td>
                              <td width="31%">0058</td>
                              <td width="31%">Elias Fausto J&uacute;nior</td>
                              <td width="31%">Gerente de Vendas</td>
                            </tr>
                          </table>
              </center>
          </td>
		  
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
</FORM>
</body>

</html>
