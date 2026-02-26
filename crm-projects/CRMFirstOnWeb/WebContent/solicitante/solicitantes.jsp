<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
	response.setHeader("Cache-Control", "no-cache");
	}
%>


<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*,java.util.*"%>

<%
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");

//try {

String usu_tipo	= (String)session.getAttribute("usu_tipo"); 
String usu_nome	= (String)session.getAttribute("usu_nome"); 
String usu_login	= (String)session.getAttribute("usu_login"); 
Integer usu_fil		= (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi	= (Integer)session.getAttribute("usu_idi"); 
Integer usu_cod	= (Integer)session.getAttribute("usu_cod"); 
String aplicacao	= (String)session.getAttribute("aplicacao");
Vector per = (Vector)session.getAttribute("vetorPermissoes");

//Variaveis
String query="", filtro="", filtro_solicitante="";
ResultSet rs = null;
int cont=0;
boolean primeiro = true;
boolean existe=false,mostraCheck=false;

//Filtros
if (request.getParameter("filtro") != null)
  filtro = request.getParameter("filtro");
if (request.getParameter("filtro_solic") != null)
  filtro_solicitante = request.getParameter("filtro_solic");

%>  

<script language="JavaScript">
function exclui() {
	var conf;
	conf = confirm(<%=("\""+trd.Traduz("DESEJA EXCLUIR O ITEM SELECIONADO?")+"\"")%>);
  	if (!conf) {
    		return false;
  	}
  	document.cad_solic.tipo_op.value = "ES";
  	document.cad_solic.action = "inclusaodesolicitante_sql.jsp";
  	document.cad_solic.submit();
}

function altera() {
  	document.cad_solic.tipo_op.value = "AL";
  	document.cad_solic.action = "inclusaodesolicitante.jsp";
  	document.cad_solic.submit();
}

function sub(cod) {
  	window.open("subordinados.jsp?filtro="+cod, "_parent");
  	return false;
}

function inclui_sub() {
  	document.cad_solic.action = "subordinados.jsp";
  	document.cad_solic.submit();
}	

function exclui_sub() {
  	document.cad_solic.tipo_op.value = "ESUB";
  	document.cad_solic.action = "inclusaodesolicitante_sql.jsp";
  	document.cad_solic.submit();
}


function remaneja() {
  	document.cad_solic.action = "remanejamento.jsp";
  	document.cad_solic.submit();
}

function filtrar_solic(){
  	//alert(cad_solic.filtro_solic.value);
  	window.open("solicitantes.jsp?filtro_solic="+cad_solic.filtro_solic.value, "_parent");
  	return true;
}

function inclui_solic(){
  	window.open("inclusaodesolicitante.jsp", "_parent");
  	return true;
}

function aspa(campo){
	aux = campo.value;
	tam = aux.length
	aux2 = aux.substring(tam-1,tam);
	if(aux2 == "\"" || aux2 == "\'"){
		aux = campo.value;
		aux = aux.length;
		aux = aux - 1;
		pal = campo.value;
		campo.value = pal.substring(0, aux);
	}
}

function aspa2(campo){
	aux = campo.value;
	tam = aux.length;
	k = 0;
	while(tam>0){
		aux2 = aux.substring(tam-1,tam);
		if(aux2 == "\"" || aux2 == "\'")
			k = k+1;
		tam--;
	}
	if(k != 0){
		alert(<%=("\""+trd.Traduz("NAO E PERMITIDO DIGITAR ASPA SIMPLES OU DUPLA")+"\"")%>);
		campo.focus();
		campo.value = "";
	}
}
</script>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("USUARIOS")%> - <%=trd.Traduz("CADASTRO DE USUARIO")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../solicitacao/art/onenglish.gif','../solicitacao/art/onespanol.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%" align="center">
<tr>
	<td valign="top">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
		<tr> 
			<td height="59" class="hcfundo"> 
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			<%
			String ponto = (String)session.getAttribute("barra");
	      		if(ponto.equals("..")){%>
			<jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="CA"/></jsp:include> </tr>
			<%}else{%>
			<jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="CA"/></jsp:include> </tr>
			<%}%>
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
					<td>
					<%if(ponto.equals("..")){%>
					<jsp:include page="../menu/menu.jsp" flush="true"><jsp:param value="op" name="SO"/></jsp:include> 
					<%}else{%>
					<jsp:include page="/menu/menu.jsp" flush="true"><jsp:param value="op" name="SO"/></jsp:include> 
					<%}%>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table border="0" cellspacing="2" cellpadding="0" bgcolor="c0c0c0">
		<tr>
			<td>
			<%if(ponto.equals("..")){%>
			<jsp:include page="../menu/menu_solicitante.jsp" flush="true"><jsp:param value="op" name="C"/></jsp:include>
			<%}else{%>
			<jsp:include page="/menu/menu_solicitante.jsp" flush="true"><jsp:param value="op" name="C"/></jsp:include>
			<%}%>
			</td>
		</tr>
	</table>

	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr> 
			<td width="20">&nbsp;</td>
			<td width="100%"> 
			<center>
			<table border="0" cellspacing="1" cellpadding="2" width="80%">
				<tr>
					<td>
					<div align="center" class="trontrk"><b><%=trd.Traduz("CADASTRO DE USUARIO")%></b></div>
					</td>
				</tr>
				
			</table>
			</center>
			</td>
		</tr>
		<tr> 
			<td width="20"><img src="../art/bit.gif"></td>
			<td class="ctvdiv" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
		</tr>
		
		<tr>
			<FORM name="cad_solic">
			<td width="20" valign="top"></td>
			<td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr> 
					<td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
				</tr>
			
				<tr> 
					<td height="20" class="ctfontc" align="center">&nbsp; <%=trd.Traduz("Localizar por UsuArio")%>: 
					<input selected type="text" name="filtro_solic" onBlur="aspa2(this)" onKeyUp="aspa(this)" value="<%=filtro_solicitante%>">
					&nbsp; <input type="button" name="btn_filtro" class="botcin" value=<%=("\""+trd.Traduz("FILTRAR")+"\"")%> onclick="filtrar_solic();">
					</td>
				</tr>
				<tr> 
					<td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
				</tr>
				<tr> 
					<td class="ctvdiv" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
				</tr>
				<tr> 
					<td align="center">&nbsp;
					<table border="0" cellspacing="1" cellpadding="2" width="80%" align="center">
						<tr>
							<td align="center" colspan="100%"> 
							<table border="0" cellspacing="0" cellpadding="0">
								<tr> 
									<td>
									<%
									
									if (per.contains("SOLICITANTE - MANUTENCAO"))
									{
										mostraCheck = true;									
									%>
									<table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
										<tr> 
											<td onMouseOver="this.className='ctonlnk2';" onClick="return inclui_solic()" width="127" height="22" align=center class="botver"><a href="#" class="txbotver" onClick="return inclui_solic()"><%=trd.Traduz("INCLUIR")%></a></td>
										</tr>
									</table>
									</td>
									<td width="10">&nbsp;</td>
									<td> 
									<table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
										<tr> 
											<td onMouseOver="this.className='ctonlnk2';" onClick="return exclui();" width="127" height="22" align=center class="botver"><a href="#" class="txbotver" onClick="return exclui()"><%=trd.Traduz("EXCLUIR")%></a></td>
										</tr>
									</table>
									</td>
									<td width="10">&nbsp;</td>
									<td> 
									<table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
										<tr> 
											<td onMouseOver="this.className='ctonlnk2';" onClick="return altera()" width="127" height="22" align=center class="botver"><a href="#" class="txbotver" onClick="return altera()"><%=trd.Traduz("ALTERAR")%></a></td>
										</tr>
									</table>
									<%
									}
									%>
									
<%
String par = "";

if (usu_tipo.equals("F"))
{
   par = "";
}
else 
{
   if (usu_tipo.equals("P") || usu_tipo.equals("G"))
   {
	   par = " AND F.FIL_CODIGO = " + usu_fil + " "; 
    }
	else
	{
	 if (usu_tipo.equals("S"))
	 {
       par = " AND F.FIL_CODIGO = " + usu_fil + " AND (F.FUN_CODSOLIC = " + usu_cod + " OR F.FUN_CODIGO = " + usu_cod + ") "; 
     }
	}
}
%>									
									
									</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td align="center">&nbsp;</td>
						</tr>
						<tr class="celtittabcin" align="center"> 
							<td colspan="100%"><%=trd.Traduz("USUARIOS")%></td>
						</tr>
						<%
						query = "SELECT F.FUN_CODIGO, F.FUN_CHAPA, F.FUN_NOME, C.CAR_NOME, T.TIP_DESCRICAO "+
							"FROM FUNCIONARIO F, TIPOUSUARIO T, FUNC_USUARIO FU, CARGO C, APLICACAO A "+
							"WHERE FU.TIP_TIPO = T.TIP_TIPO "+
							"AND T.APL_CODIGO = A.APL_CODIGO "+
							"AND A.APL_SIGLA = '"+aplicacao+"' "+
							"AND FU.FUN_CODIGO = F.FUN_CODIGO "+
							"AND F.CAR_CODIGO = C.CAR_CODIGO " +
							"AND F.FUN_DEMITIDO = 'N' "+
							par + " ";

							if (!filtro_solicitante.equals(""))
								query = query + "AND F.FUN_NOME >= '"+filtro_solicitante+"' ";
							query = query + "ORDER BY F.FUN_NOME";
							rs = conexao.executaConsulta(query,session.getId());
							
							if(rs.next()){
								existe = true;
							}
							
							//out.println(query);
							if(existe){
								%>
								<tr class="celtittab"> 
									<td width="5%"></td>
									<td width="18%"><%=trd.Traduz("Chapa")%></td>
									<td width="41%"><%=trd.Traduz("Nome")%></td>
									<td width="18%"><%=trd.Traduz("Cargo")%></td>
									<td width="18%"><%=trd.Traduz("UsuArio")%></td>
								</tr>
								<%
								do{
									%>
									<tr class="celnortab">
									<%
									if(mostraCheck){
										if (primeiro || filtro.equals(rs.getString(1))){
											primeiro = false;
											%>
											<td width="5%" align="center"><input type="radio" name="chk_solic" value="<%=rs.getString(1)%>" checked></td>
											<%
											}
										else{
											%>
											<td width="5%" align="center"><input type="radio" name="chk_solic" value="<%=rs.getString(1)%>"></td>
											<%
										}
									}
									else{
										%>
										<td width="5%" align="center">&nbsp;</td>
										<%
									}
									%>
									<td width="18%"><%=rs.getString(2)%></td>
									<td width="41%"><a class="lnk" href="#" onclick="return sub(<%=rs.getString(1)%>);" ><%=rs.getString(3)%></a></td>
									<td width="18%"><%=rs.getString(4)%></td>
									<td width="18%"><%=rs.getString(5)%></td>
									</tr>
									<%
								}while (rs.next());
							}
							else{
								%>
								<td align="center" colspan="100%" class="celtittab"><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...</td>
								<%
							}
							%>
					</table>
					</td>
				</tr>	
					
			</table>
		</tr>
		<tr>
			<td colspan="3">&nbsp;</td>
		</tr>
	</table>
	</td>
	<input type="hidden" name="tipo_op">
	</FORM>
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
	</td>
</tr>
</table>

<%
if(rs != null) rs.close();
conexao.finalizaConexao(session.getId());

//} catch (Exception e) {
//  out.println(e);
//}
%>

</body>
</html>
