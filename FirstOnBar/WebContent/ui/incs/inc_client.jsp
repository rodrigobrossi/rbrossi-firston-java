<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type="text/javascript" src="script/scripts.js">
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body  >

<form name="frmCli" method="POST" action="../../Client"> 
<table>
	<tr>
		<td>Nome:</td><td><input type="text" name="name" id="name" size="30"></input></td>
	</tr>
	<tr>
		<td>CPF:</td><td><input type="text" name="txtCpf" size="11" maxlength="11" onblur="return validacpf();" /></td>
	</tr>
	<tr>
		<td>Telefone:</td><td><input type="text" name="phone" id="phone" size="15"></input></td>
		</tr>
	<tr>
		<td>Email:</td><td><input type="text" name="cep" id="cep" size="15"></input></td>
	</tr>
	<tr>
		<td> <input type="submit" value="Incluir" /></td>
	</tr>
</table>
<input type="hidden" name="op" id="op" value="i" />
</form>
</body>
</html>