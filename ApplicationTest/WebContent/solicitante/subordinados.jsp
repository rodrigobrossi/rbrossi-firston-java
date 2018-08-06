<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
	response.setHeader("Cache-Control", "no-cache");
	}
%>


<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*,java.util.*"%>

<%
//try{

request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");

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
boolean existe=false,mostraCheck=true;

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
    window.open("solicitantes.jsp?filtro="+cod, "_parent");
    return false;
  }

  function inclui_sub() {
    document.cad_solic.action = "inclusaodesubordinados.jsp";
    document.cad_solic.submit();
  }

  function exclui_sub() {
	var teste = 0;
	for(i=1;i<=cad_solic.contador.value;i++) {
  		if(eval("cad_solic.chk"+i+".checked")==true) {
   			teste = teste+1;
		}
	}
  	if(teste == 0) {
  		alert(<%=("\""+trd.Traduz("NENHUM ITEM SELECIONADO")+"\"")%>);
  		return false;
 	}
 	else{
		if(confirm(<%=("\""+trd.Traduz("DESEJA EXCLUIR O ITEM SELECIONADO")+"\"")%>)){ 	
			document.cad_solic.tipo_op.value = "ESUB";
			document.cad_solic.action = "inclusaodesolicitante_sql.jsp";
			document.cad_solic.submit();
		}
	}
  }


  function remaneja() {
	var teste = 0;
	for(i=1;i<=cad_solic.contador.value;i++) {
    		if(eval("cad_solic.chk"+i+".checked")==true) {
    		teste = teste+1;
		}
	}
  	if(teste == 0) {
  		alert(<%=("\""+trd.Traduz("NENHUM ITEM SELECIONADO")+"\"")%>);
  		return false;
 	}
 	else{
		document.cad_solic.action = "remanejamento.jsp";
		document.cad_solic.submit();
	}
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
					<td align="left">&nbsp;
					<table border="0" cellspacing="1" cellpadding="2" width="80%" align="left">
						<tr align="left">
							<td align="left" class="ftverdanacinza" width="50%">
							<%
							query = "SELECT F.FUN_CODIGO, F.FUN_NOME, C.CAR_NOME, T.TIP_DESCRICAO, FI.FIL_NOME "+
								"FROM FUNCIONARIO F, TIPOUSUARIO T, FUNC_USUARIO FU, CARGO C, APLICACAO A, FILIAL FI "+
								"WHERE FU.TIP_TIPO = T.TIP_TIPO "+
								"AND T.APL_CODIGO = A.APL_CODIGO "+
								"AND A.APL_SIGLA = '"+aplicacao+"' "+
								"AND FU.FUN_CODIGO = F.FUN_CODIGO "+
								"AND FI.FIL_CODIGO = F.FIL_CODIGO "+
								"AND F.CAR_CODIGO = C.CAR_CODIGO " +
								"AND F.FUN_CODIGO = "+filtro;
									
								rs = conexao.executaConsulta(query,session.getId());
								rs.next();
							%>
							<b><%=trd.Traduz("USUARIO")%></b>: <%=(rs.getString(2)==null)?"":rs.getString(2)%>
							&nbsp;&nbsp;&nbsp;&nbsp;
							</td>
							<td align="left" class="ftverdanacinza" width="50%">
							<b><%=trd.Traduz("TIPO")%></b>: <%=(rs.getString(4)==null)?"":rs.getString(4)%>
							</td>
							<tr>
							<td align="left" class="ftverdanacinza" width="50%">
							<b><%=trd.Traduz("FILIAL")%></b>: <%=(rs.getString(5)==null)?"":rs.getString(5)%>
							&nbsp;&nbsp;&nbsp;&nbsp;
							</td>
							<td align="left" class="ftverdanacinza" width="50%">
							<b><%=trd.Traduz("CARGO")%></b>: <%=(rs.getString(3)==null)?"":rs.getString(3)%>
							</td>
						</tr>

					</table>
					</td>
				</tr>	
					
					<%
					if (!filtro.equals(""))
					{
						query = "SELECT DISTINCT F.FUN_CODIGO, F.FUN_CHAPA, F.FUN_NOME, C.CAR_NOME, F.FUN_DEMITIDO, F.FUN_TERCEIRO "+
							"FROM FUNCIONARIO F, CARGO C "+
							"WHERE F.FUN_CODSOLIC = " +filtro+ " "+
							"AND F.CAR_CODIGO = C.CAR_CODIGO "+
							"ORDER BY F.FUN_NOME";
						if(rs != null){
                                                    rs.close();
                                                    conexao.finalizaConexao(session.getId());
                                                    }
						rs = conexao.executaConsulta(query,session.getId());
						if (rs.next()){
							existe = true;
						}
						
						
							%>
							<tr><td>&nbsp;</td></tr>
							<tr>
								<td class="ctvdiv" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							
							<tr>
							<td align="center" class="ctfontc"><font size="1">
							** - <%=trd.Traduz("DEMITIDO")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							* - <%=trd.Traduz("TERCEIRO")%>
							</font>
							</td>
							</tr>
							
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td class="ctvdiv" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
									<%	
									//if(existe){	
									%>
							
							<tr>
							<td align="center">
							
							<table border="0" cellspacing="0" cellpadding="0">
								<tr> 
									<td>
									<table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
										<tr> 
											<td onMouseOver="this.className='ctonlnk2';" onClick="inclui_sub();" width="127" height="22" align=center class="botver">
											<a href="#" class="txbotver"><%=trd.Traduz("INCLUIR")%></a></td>
										</tr>
									</table>
									</td>
								<%
								if(existe){
								%>
									<td width="10">&nbsp;</td>
									<td> 
									<table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
										<tr> 
											<td onMouseOver="this.className='ctonlnk2';" onClick="exclui_sub();" width="127" height="22" align=center class="botver">
											<a href="#" class="txbotver"><%=trd.Traduz("EXCLUIR")%></a></td>
										</tr>
									</table>
									</td>
									<td width="10">&nbsp;</td>
									<td> 
									<table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
										<tr> 
											<td onMouseOver="this.className='ctonlnk2';" onClick="return remaneja();" width="127" height="22" align=center class="botver">
											<a href="#" class="txbotver"><%=trd.Traduz("REMANEJAR")%></a></td>
										</tr>
									</table>
									</td>
								<%}%>
								
								
								</tr>
							</table>
							<br>
							</td>
							</tr>
							</table>
							<table border="0" cellspacing="1" cellpadding="2" width="80%" align="center">
								<tr class="celtittabcin" align="center"> 
									<td colspan="100%"><%=trd.Traduz("SUBORDINADOS")%></td>
								</tr>
								<tr class="celtittab"> 
								<%
								if(existe){
									%>
									<td width="4%">&nbsp;</td>
									<td width="18%"><%=trd.Traduz("Chapa")%></td>
									<td width="48%"><%=trd.Traduz("Nome")%></td>
									<td width="30%"><%=trd.Traduz("Cargo")%></td>
									<%
								}
								else{
									%>
									<td colspan="100%" align="center"><%=trd.Traduz("NAO CONTEM SUBORDINADOS")%></td>
									<%
									mostraCheck = false;
								}
								%>
								</tr>
								<%
								if(existe){
									do{
										cont++;
										%>
										<tr class="celnortab"> 
											<td width="4%" align="center">
												<%
												if(mostraCheck){
													%>
													<input type="checkbox" name="chk<%=cont%>" value="<%=rs.getString(1)%>">
													<%
												}
												else{
													%>
													&nbsp;
													<%
												}
												%>
											</td>
											<td width="18%"><%=rs.getString(2)%></td>
											<td width="48%">
											<%
											if(rs.getString(5).equals("S")){
												%>**<%
											}
											else if(rs.getString(6).equals("S")){
												%>*<%
											}
											%>
											<%=rs.getString(3)%></td>
											<td width="30%"><%=rs.getString(4)%></td>
										</tr>
										<%
									}while (rs.next());
								}
						%>
				<tr>
					<td align="center">&nbsp;</td>
				</tr>
				<%
					}
					%>
			</table>
		</tr>
		<tr>
			<td colspan="3">&nbsp;</td>
		</tr>
	</table>
	</td>
	<input type="hidden" name="tipo_op">
	<input type="hidden" name="chk_solic" value="<%=filtro%>">
	<input type="hidden" name="contador" value="<%=cont%>">
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
</body>
</html>
<%
if(rs != null){
    rs.close();
    conexao.finalizaConexao(session.getId());
}

//} catch(Exception e){
//out.println("Erro: "+e);
//}
%>