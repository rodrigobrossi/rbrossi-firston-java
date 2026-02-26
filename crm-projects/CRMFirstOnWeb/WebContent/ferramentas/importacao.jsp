<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
%>


<%@page import="firston.eval.components.FOLocalizationBean"%><%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Processos")%> - <%=trd.Traduz("ImportaCAo")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<script language="JavaScript">
function valida()
{

    if(document.form.tf_txt.value == "")
    {
      alert("Selecione um Arquivo TXT");
      return false;
    } 

  if(document.form.checkbox2.checked)
  { 
    if(document.form.tf_txt2.value == "")
    {
      alert("Selecione um Arquivo TXT");
      return false;
    }  
  }

  if(document.form.checkbox3.checked)
  { 
    if(document.form.tf_txt3.value == "")
    {
      alert("Selecione um Arquivo TXT");
      return false;
    }  
  }

  if(document.form.checkbox4.checked)
  { 
    if(document.form.tf_txt4.value == "")
    {
      alert("Selecione um Arquivo TXT");
      return false;
    }  
  }

  if(document.form.checkbox5.checked)
  { 
    if(document.form.tf_txt5.value == "")
    {
      alert("Selecione um Arquivo TXT");
      return false;
    }  
  }

  if(document.form.checkbox6.checked)
  { 
    if(document.form.tf_txt6.value == "")
    {
      alert("Selecione um Arquivo TXT");
      return false;
    }  
  }

  if(document.form.checkbox7.checked)
  { 
    if(document.form.tf_txt7.value == "")
    {
      alert("Selecione um Arquivo TXT");
      return false;
    }  
  }

  if(document.form.checkbox8.checked)
  { 
    if(document.form.tf_txt8.value == "")
    {
      alert("Selecione um Arquivo TXT");
      return false;
    }  
  }

  if(document.form.checkbox9.checked)
  { 
    if(document.form.tf_txt9.value == "")
    {
      alert("Selecione um Arquivo TXT");
      return false;
    }  
  }

  if(document.form.checkbox10.checked)
  { 
    if(document.form.tf_txt10.value == "")
    {
      alert("Selecione um Arquivo TXT");
      return false;
    }  
  }

  if(document.form.checkbox11.checked)
  { 
    if(document.form.tf_txt11.value == "")
    {
      alert("Selecione um Arquivo TXT");
      return false;
    }  
  }

  if(document.form.checkbox12.checked)
  { 
    if(document.form.tf_txt12.value == "")
    {
      alert("Selecione um Arquivo TXT");
      return false;
    }  
  }

document.form.checkbox.disabled = false;
form.action ="executa_importacao.jsp";
form.submit();
}

function restore()
{
form.action ="executa_restore.jsp";
form.submit();
}

</script>
<%
	//recupera da sessAo//
	request.getSession();
	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
%>

<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','solicitacao/../art/onenglish.gif','solicitacao/../art/onespanol.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	height="100%">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="59" class="hcfundo">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="20">&nbsp; height="48"></td>
						<td width="517" valign="bottom"><img border="0"
							src="../art/VCP%20Novo%20Logo1_Color.jpg"></td>
						<td width="27">&nbsp;</td>
						<td align="right" valign="bottom" width="439"><!-- #BeginLibraryItem "/Library/headerbar.lbi" -->
						<table width="350" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="hcfont" align="right"><b><%=usu_nome%></b> |
								Login: <%=usu_login%></td>
								<td width="20"></td>
							</tr>
						</table>
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="8" colspan="6"><img src="../art/bit.gif"
									width="8" height="8"></td>
							</tr>
							<tr>
								<td height="20" nowrap><a href="principal.jsp"
									onMouseOut="MM_swapImgRestore()"
									onMouseOver="MM_swapImage('home','','../art/ico_home_on.gif',1)"
									class="hclinkb"><img name="home" border="0"
									src="../art/ico_home.gif" width="15" height="11"
									align="absmiddle">HOME</a></td>
								<td width="10"><img src="../art/bit.gif" width="13"
									height="10"></td>
								<td nowrap><a
									href="JavaScript:MM_openBrWindow('../iconbar/ajuda.htm','popup','scrollbars=yes,width=384,height=400,left=200,top=100')"
									onMouseOut="MM_swapImgRestore()"
									onMouseOver="MM_swapImage('ajuda','','../art/ico_ajuda_on.gif',1)"
									class="hclinkb"><img name="ajuda" border="0"
									src="../art/ico_ajuda.gif" width="11" height="11"
									align="absmiddle">AJUDA</a></td>
								<td width="20"></td>
							</tr>
						</table>
						<!-- jspEndLibraryItem --></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="mnfundo"><img src="../art/bit.gif" width="12"
					height="5"></td>
			</tr>
			<tr>
				<td height="25" class="mnfundo">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<%
							String ponto = (String) session.getAttribute("barra");
							if (ponto.equals("..")) {
						%>
						<jsp:include page="../menu/menu.jsp" flush="true"><jsp:param
								value="op" name="F" /></jsp:include>
						<%
							} else {
						%>
						<jsp:include page="/menu/menu.jsp" flush="true"><jsp:param
								value="op" name="F" /></jsp:include>
						<%
							}
						%>
					</tr>
				</table>
				</td>
			</tr>
		</table>

		<table border="0" cellspacing="2" cellpadding="0" bgcolor="c0c0c0">
			<tr>
				<%
					if (ponto.equals("..")) {
				%>
				<jsp:include page="../menu/menu_ferramentas.jsp" flush="true">
					<jsp:param value="op" name="I" />
				</jsp:include>
				<%
					} else {
				%>
				<jsp:include page="/menu/menu_ferramentas.jsp" flush="true">
					<jsp:param value="op" name="I" />
				</jsp:include>
				<%
					}
				%>
			</tr>
		</table>

		<center>
		<table border="0" cellspacing="1" cellpadding="2" width="80%">
			<tr>
				<td align="center" colspan="5" width="60%">&nbsp;</td>
			</tr>
			<tr>
				<td>
				<div align="center" class="ftverdanacinza"><b><%=trd.Traduz("Cadastro de ImportaCAo")%></b></div>
				</td>
			</tr>
			<tr>
				<td colspan="5">&nbsp;</td>
			</tr>
		</table>
		</center>

		<form name="form" method="post">
		<table width="77%" border="0" cellspacing="4" cellpadding="0"
			align="center" height="475">
			<tr>
				<td width="6%">&nbsp;</td>
				<td width="33%" class="ftverdanacinza"><b>&nbsp;<%=trd.Traduz("TABELAS")%>:</b></td>
				<td width="49%" class="ftverdanacinza"><b><%=trd.Traduz("ARQUIVOS TXT")%>:</b>
				</td>
				<td width="12%">&nbsp;</td>
			</tr>
			<tr>
				<td width="6%" height="23">&nbsp;</td>
				<td width="33%" class="ftverdanacinza"><input type="checkbox"
					name="checkbox" value="FUNCIONARIO" checked disabled> <%=trd.Traduz("FUNCIONARIO")%>
				</td>
				<td width="49%" height="21"><input type="file" name="tf_txt"
					size="60"></td>
				<td width="12%" height="23">&nbsp;</td>
			</tr>
			<tr>
				<td height="3" width="6%">&nbsp;</td>
				<td height="3" width="33%" class="ftverdanacinza"><input
					type="checkbox" name="checkbox2" value="CARGO"> <%=trd.Traduz("CARGO")%>
				</td>
				<td height="3" width="49%"><input type="file" name="tf_txt2"
					size="60"></td>
				<td height="3" width="12%">&nbsp;</td>
			</tr>
			<tr>
				<td width="6%">&nbsp;</td>
				<td width="33%" class="ftverdanacinza"><input type="checkbox"
					name="checkbox3" value="DEP../artAMENTO"> <%=trd.Traduz("DEP../artAMENTO")%>
				</td>
				<td width="49%"><input type="file" name="tf_txt3" size="60">
				</td>
				<td width="12%">&nbsp;</td>
			</tr>
			<tr>
				<td width="6%">&nbsp;</td>
				<td width="33%" class="ftverdanacinza"><input type="checkbox"
					name="checkbox4" value="FILIAL"> <%=trd.Traduz("FILIAL")%>
				</td>
				<td width="49%"><input type="file" name="tf_txt4" size="60">
				</td>
				<td width="12%">&nbsp;</td>
			</tr>
			<tr>
				<td width="6%">&nbsp;</td>
				<td width="33%" class="ftverdanacinza"><input type="checkbox"
					name="checkbox5" value="TABELA1"> <%=trd.Traduz("TABELA1")%>
				</td>
				<td width="49%"><input type="file" name="tf_txt5" size="60">
				</td>
				<td width="12%">&nbsp;</td>
			</tr>
			<tr>
				<td width="6%">&nbsp;</td>
				<td width="33%" class="ftverdanacinza"><input type="checkbox"
					name="checkbox6" value="TABELA2"> <%=trd.Traduz("TABELA2")%>
				</td>
				<td width="49%"><input type="file" name="tf_txt6" size="60">
				</td>
				<td width="12%">&nbsp;</td>
			</tr>
			<tr>
				<td width="6%">&nbsp;</td>
				<td width="33%" class="ftverdanacinza"><input type="checkbox"
					name="checkbox7" value="TABELA3"> <%=trd.Traduz("TABELA3")%>
				</td>
				<td width="49%"><input type="file" name="tf_txt7" size="60">
				</td>
				<td width="12%">&nbsp;</td>
			</tr>
			<tr>
				<td width="6%">&nbsp;</td>
				<td width="33%" class="ftverdanacinza"><input type="checkbox"
					name="checkbox8" value="TABELA4"> <%=trd.Traduz("TABELA4")%>
				</td>
				<td width="49%"><input type="file" name="tf_txt8" size="60">
				</td>
				<td width="12%">&nbsp;</td>
			</tr>
			<tr>
				<td width="6%">&nbsp;</td>
				<td width="33%" class="ftverdanacinza"><input type="checkbox"
					name="checkbox9" value="TABELA5"> <%=trd.Traduz("TABELA5")%>
				</td>
				<td width="49%"><input type="file" name="tf_txt9" size="60">
				</td>
				<td width="12%">&nbsp;</td>
			</tr>
			<tr>
				<td width="6%">&nbsp;</td>
				<td width="33%" class="ftverdanacinza"><input type="checkbox"
					name="checkbox10" value="TABELA6"> <%=trd.Traduz("TABELA6")%>
				</td>
				<td width="49%"><input type="file" name="tf_txt10" size="60">
				</td>
				<td width="12%">&nbsp;</td>
			</tr>
			<tr>
				<td width="6%">&nbsp;</td>
				<td width="33%" class="ftverdanacinza"><input type="checkbox"
					name="checkbox11" value="TABELA7"> <%=trd.Traduz("TABELA7")%>
				</td>
				<td width="49%"><input type="file" name="tf_txt11" size="60">
				</td>
				<td width="12%">&nbsp;</td>
			</tr>
			<tr>
				<td align="center" width="6%">&nbsp;</td>
				<td width="33%" class="ftverdanacinza"><input type="checkbox"
					name="checkbox12" value="TABELA8"> <%=trd.Traduz("TABELA8")%>
				</td>
				<td align="center" width="49%"><input type="file"
					name="tf_txt112" size="60"></td>
				<td align="center" width="12%">&nbsp;</td>
			</tr>
			<tr>
				<td align="center" colspan="4" height="9">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="4" height="16">
				<div align="center"><input type="submit"
					value=<%=("\"" + trd.Traduz("RESTAURAR") + "\"")%> class="botcin"
					onClick="return restore()" name="submit1"> <input
					type="submit" value=<%=("\"" + trd.Traduz("IMPORTAR") + "\"")%>
					class="botcin" onClick="return valida()" name="submit"></div>
				</td>
			</tr>
		</table>
		</form>
		</td>
	</tr>
	<tr>
		<td align="right" height="30" class="difundo">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<%
				if (ponto.equals("..")) {
			%>
			<jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include>
			<%
				} else {
			%>
			<jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>
			<%
				}
			%>
		</table>
		</td>
	</tr>
</table>

</body>
</html>
