<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.lang.*"%>
<%@page import="java.io.*"%>
<%@page import="firston.eval.components.FOLoginValidatorBean"%>

<%
    response.setHeader("Pragma", "no-cache");
    if (request.getProtocol().equals("HTTP/1.1"))
    {
      response.setHeader("Cache-Control", "no-cache");
    }

String login = (String) request.getParameter("login");

%>
<html>
<head>
<title>FirstOnEM</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="default.css">
</head>

<script language="JavaScript">
function Cancel()
{  
  if(confirm("Deseja realmente sair do cadastramento de senha?"))
  {
    document.cad_form.op.value="2";
    window.close();
  }
}
</script>

<script language="JavaScript">
function checa(){
    var aux = cad_form.senha.value;
    var tam = aux.length;
    var aut = "true";
    for(a = 0;a < tam; a++){
        var aux2 = aux.substring(a,a+1);
        if(aux2 == " "){
            aut = "false";
        }
    }
    if(cad_form.senha.value==""){
        alert("Digite uma senha");
	cad_form.senha.focus();
	return false;
    }
    else if(cad_form.csenha.value==""){
        alert("Confirme a senha");
	cad_form.csenha.focus();
	return false;
    }
    else if(cad_form.senha.value != cad_form.csenha.value){
        alert("A Confirmação da senha é invalida");
	cad_form.csenha.value = "";
        cad_form.csenha.focus();
	return false;
    }
    else if(aut == "false"){
        alert("A senha não pode conter o caracter SPACE");
        cad_form.senha.value = "";
        cad_form.csenha.value = "";
	cad_form.senha.focus();
	return false;
    }
    else {
        //window.open("checaSenha.jsp?login=<%=login%>&senha="+cad_form.senha.value ,"_self","center=yes;status=no;toolbar=no; width=1; height=10");
	//alert(cad_form.login.value);
	//alert(cad_form.senha.value);
	window.open("checaSenha.jsp?login="+cad_form.login.value+"&senha="+cad_form.senha.value ,"_self","");
	document.cad_form.op.value="1";
	window.close();
	//return false;
    }
}

</script>

<body onunload='return fecha();' bgcolor="#FFFFFF" text="#000000"
	leftmargin=0 rightmargin=0 marginwidth=0 marginheight=0 topmargin=0
	OnUnload="window.returnValue = document.cad_form.op.value;">
<!--Inicio de código de Administradores -->
<form name="cad_form" method="POST">
<table width="100%" height="100%" border="0" bgcolor="#FFFFFF"
	align="center">
	<tr>
		<td colspan="2" class="celtittab" align="center">DIGITE A SENHA
		PARA O USUÁRIO: <%=login%></td>
	</tr>
	<tr>
		<td colspan="2" align="center">&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#FFFFFF" align="right" class="ftverdanacinza"><b>SENHA
		: </b></td>
		<td bgcolor="#FFFFFF" align="center"><input class="ctinput"
			type="password" maxlength="10" size="30" name="senha"></td>
	</tr>
	<tr>
		<td bgcolor="#FFFFFF" align="right" class="ftverdanacinza"><b>CONFIRMAR
		SENHA : </b></td>
		<td bgcolor="#FFFFFF" align="center"><input class="ctinput"
			type="password" maxlength="10" size="30" name="csenha"></td>
	</tr>
	<tr>
		<td colspan="2" align="center">&nbsp;</td>
	</tr>

	<input type="hidden" name="login" value="<%=login%>">

	<tr>
		<td bgcolor="#FFFFFF" align="center" colspan="2"><input
			type="button" name="enviar" OnClick="checa();" value="  OK  "
			class="botcin"> <input type="button" name="cancelar"
			OnClick="Cancel();" value="Cancel" class="botcin"></td>
	</tr>
</table>
<input type="hidden" name="op" value="2"></form>
</body>
</html>
