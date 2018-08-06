<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@ page import ="java.io.*"%>

<%
    response.setHeader("Pragma", "no-cache");
    if (request.getProtocol().equals("HTTP/1.1"))
    {
      response.setHeader("Cache-Control", "no-cache");
    }

/*Tratamento de mensagem de erro*/
String msg_erro = "";
if (request.getParameter("msgerro") == null){
        msg_erro = "";
	}
else{
       msg_erro = request.getParameter("msgerro");
}

String EMAIL_DE_SUPORTE="", CLIMA="";
boolean nova_senha = false;

//*********************Recupera parâmetros de inicializacao do web.xml***********************
ServletContext context = pageContext.getServletContext();
CLIMA = context.getInitParameter("clima");
EMAIL_DE_SUPORTE = context.getInitParameter("emailSuporte");
//*******************************************************************************************
%>
<html>
<head>
<title>FirstOn</title>

<link rel="stylesheet" href="default.css" type="text/css">
</head>

<script language ="JavaScript1.1">
function envia(){
	login_form.submit();
	return false;	
	}
function popup(){
    WinPopUp=window.open('./configuracao.html','','tollbar=no,location=no,menubar=no,resizable=no,scrollbars=no,width=520px,height=200px,left=100,top=100');
	WinPopUp.focus();
    }

</script>

<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
 <form name="login_form" action="valida.jsp" method="POST"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr> 
    <td height="71" align=center> 
      <table border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td align=center>&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    
    <td height="54" align="center" class="lgfundo"> 
        
      <table border="0" cellspacing="0" cellpadding="0">
        
          <tr> 
            <td class="lgfont" width="50">Login</td>
            <td> 
              <input type="text" name="login" size="10" class="lginput">
            </td>
            <td width="30">&nbsp;</td>
            <td class="lgfont" width="55">Senha</td>
            <td> 
              <input type="password" name="senha" size="10" class="lginput">
            </td>
            <td width="10" align="center">&nbsp;</td>
                                  
            <td align="center"><input type="submit" onclick="return envia();"  value="Entrar" class="botcin"></td>
            <td>&nbsp;</td>
          </tr>
        
      </table>
    </td>
  </tr>
  <tr> 
    <td valign="top" height="308"> 
      <table border="0" cellspacing="0" cellpadding="0" height="100%" width="100%">
        <tr> 
          <td colspan="4" height="28" valign="center"> 
            <div align="center"><font face='Arial' color='red' > <b><i><%=msg_erro%></i></b></font></div>
          </td>
        </tr>
        <tr> 
		  <td colspan="2" width="50%" align="center" height="92"><img src="art/logo_ser.gif" width="190" height="97"></td>
       <!--   <td height="92" align="center">&nbsp;</td> -->
          <td colspan="2" height="92" align="center" width="50%"><img src="art/Logo_Cliente.gif"></td>
        </tr>
        <tr> 
		<td colspan="4" align="center" height="13" class="difont">
		
<table width="100%" border="0">
 <tr>
<!--                <td align="right" width="25%"><img src="art/atencao_login.gif" width="52" height="52"></td>
          <td colspan="0" align="center" height="0">&nbsp;</td> -->
                <td align="right" width="25%"><img src="art/indica_login1.jpg"></td>
                <td align="center" height="13" class="difont" width="50%"> <strong> 
                  <div> 
			 Recomenda-se utilizar resolução de video igual ou superior a <font color="red"><b>1024x768</b></font>.
			 </div>		
			 <div>
			 Deve-se utilizar Browser <font color="red"><b>Internet Explorer 6</b></font> ou superior.
			 </div>
			 <div><a href="JavaScript:popup()" class="dilink">
			 Configure corretamente seu Browser para uma melhor utilização.
			 </a></div>
		   </strong>
		   </td> 
<!--          <td colspan="0" align="center" height="0">&nbsp;</td> -->
     <td align="left" width="25%"><img src="art/indica_login2.jpg"></td>
  </tr>
</table>

        </td>
		</tr>
        <tr> 
          <td colspan="4" height="2" valign="bottom">&nbsp;</td>
        </tr>
        <tr align="right"> 
          <td colspan="4" class="difundo" height="30"> 
		    <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="17" width="676"> 
                  <table border="0" cellspacing="0" cellpadding="0" width="665">
                    <tr> 
                      <td width="23" height="13"><img src="art/bit.gif" width="20" height="10"></td>
                      <td width="11" nowrap height="13"><img src="art/bit.gif" width="10" height="10"></td>
                      <td nowrap class="difont" width="475" height="13">
                        <%
			if(!EMAIL_DE_SUPORTE.equals("")){
	 		%>
	 		<b>D&uacute;vidas?</b> 
	 		Entre em contato com:&nbsp;<a href="mailto:<%=EMAIL_DE_SUPORTE%>" class="dilink"><%=EMAIL_DE_SUPORTE%></a>
	  		<% } %>	 </td>
                      
                    <%

                    if(!CLIMA.equals("") && !CLIMA.equals("N")){
                    	%>
                    		<td nowrap class="difont" width="156" height="13"> <a href="lista_climaorg.jsp" class="dilink"> 
                    		Clima Organizacional </a> </td>
                    	<%
                    }%>

                    </tr>
                  </table>
                </td>
                        <td align="right" width="103" height="17"><img src="art/bit.gif" width="20" height="10"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</form>
</body>
</html>
