
<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1"))
  response.setHeader("Cache-Control", "no-cache");
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.util.*"%>

<%
//try {

request.getSession(); 
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 

//VariAveis para as Queryes
String query="", solic_cod="", filtro_subordinado="";
boolean existe = false;
ResultSet rs = null;
int i=0;

//Recupera valores
if (request.getParameter("chk_solic") != null)
  solic_cod = request.getParameter("chk_solic");
if (request.getParameter("filtro") != null)
  filtro_subordinado = request.getParameter("filtro");

query = "SELECT F.FUN_CODIGO, F.FUN_CHAPA, F.FUN_NOME, C.CAR_NOME, D.DEP_NOME, T2.TB2_NOME, T3.TB3_DESCRICAO, FI.FIL_NOME, F.FUN_TERCEIRO "+
        "FROM FUNCIONARIO F, CARGO C, DEPTO D, TABELA2 T2, TABELA3 T3, FILIAL FI "+
        "WHERE C.CAR_CODIGO = F.CAR_CODIGO AND D.DEP_CODIGO = F.DEP_CODIGO "+
        "AND F.TB2_CODIGO OUTER T2.TB2_CODIGO AND F.TB3_CODIGO OUTER T3.TB3_CODIGO "+
        "AND FI.FIL_CODIGO = F.FIL_CODIGO AND F.FUN_CODSOLIC IS NULL "+
        "AND F.FUN_DEMITIDO = 'N' ";

if (!filtro_subordinado.equals(""))
    query = query + "AND F.FUN_NOME >= '"+filtro_subordinado+"' ";

query = query + "ORDER BY F.FUN_NOME ";
%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("USUARIOS")%> - <%=trd.Traduz("CADASTRO DE USUARIO")%> - <%=trd.Traduz("SUBORDINADO")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>

<script language="JavaScript">
function cancelar() {
	window.open("subordinados.jsp?filtro=<%=solic_cod%>", "_parent");
	return true;
}

function incluir(){
	var teste = 0;
	for(i=1;i<=frm_sub.contador.value;i++) {
		if(eval("frm_sub.chk_sub_"+i+".checked")==true)
			teste = teste+1;
	}
  	if(teste == 0){
  		alert(<%=("\""+trd.Traduz("NENHUM ITEM SELECIONADO")+"\"")%>);
  		return false;
 	}
 	else{
		frm_sub.tipo_op.value = "ISUB";
		frm_sub.chk_solic.value = <%=solic_cod%>;
    		frm_sub.action = "inclusaodesolicitante_sql.jsp";
    		frm_sub.submit();
	}
}

function filtrar(){
	window.open("inclusaodesubordinados.jsp?filtro="+frm_sub.filtro_sub.value+"&chk_solic=<%=solic_cod%>", "_parent");
	return true;
}
</script>

<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../art/onenglish.gif','../art/onespanol.gif')">
 <FORM name="frm_sub">
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
              %><jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="SO"/></jsp:include> <%
              }
              else{
              %><jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="SO"/></jsp:include> <%
              }
              %>
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
              <%
              if(ponto.equals("..")){
              	%><jsp:include page="../menu/menu.jsp" flush="true"><jsp:param value="op" name="SO"/></jsp:include> <%
              }
              else{
              	%><jsp:include page="/menu/menu.jsp" flush="true"><jsp:param value="op" name="SO"/></jsp:include> <%
              }
              %>
              </tr>
            </table>
          </td>
        </tr>
      </table>
	<table border="0" cellspacing="2" cellpadding="0" bgcolor="c0c0c0">
	  <tr>
	    <td>
		<%if(ponto.equals("..")){
			%><jsp:include page="../menu/menu_solicitante.jsp" flush="true"><jsp:param value="op" name="C"/></jsp:include><%
		}
		else{
			%><jsp:include page="/menu/menu_solicitante.jsp" flush="true"><jsp:param value="op" name="C"/></jsp:include><%
		}
		%>
	    </td>
	  </tr>
	</table>

      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="20">&nbsp;</td>
          <td width="100%" align="center"> 
            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
                <td class="trontrk" width="297" align="center"><%=trd.Traduz("SUBORDINADO")%></td>
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
	 
          <td valign="top"><img src="../art/bit.gif" width="159" height="1"><br>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                  <td height="20" class="ctfontc" align="center">&nbsp; <%=trd.Traduz("LOCALIZAR POR FUNCIONARIO")%>: 
                    <input type="text" name="filtro_sub" value="<%=filtro_subordinado%>">&nbsp;
                    <input type="button" name="btn_filtro" class="botcin" value=<%=("\""+trd.Traduz("FILTRAR")+"\"")%> onclick="filtrar();">
                  </td>
              </tr>

              <tr><td>&nbsp;</td></tr>
	      <tr>
                <td align="center" class="ctfontc"><font size="1">* - <%=trd.Traduz("TERCEIRO")%></font></td>
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
                      <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                        <%
                      	rs = conexao.executaConsulta(query,session.getId());
                      	if(rs.next()){
                      		existe = true;
                      	}
                        if(existe){
                        %>
                          <td> 
                            <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                              <tr> 
                                <td onMouseOver="this.className='ctonlnk2';" onClick="return incluir();" width="127" height="22" align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("INCLUIR")%></a></td>
                              </tr>
                            </table>
                          </td>
                         <%}%>
                          <td>&nbsp;&nbsp;</td>
                          <td> 
                            <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                              <tr> 
                                <td onMouseOver="this.className='ctonlnk2';" onClick="return cancelar();" width="127" height="22" align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("CANCELAR")%></a></td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                      </table>
                    </center>
    		    <br>
                    <table border="0" cellspacing="1" cellpadding="2" width="100%">
                      <tr>
                      	<%
                      	//rs = conexao.executaConsulta(query);
                      	//if(rs.next()){
                      	if(existe){
                      		%>
                        	<td width="4%" height="28">&nbsp;</td>
                        	<td width="4%" class="celtittab" height="28"> 
                        	  <div align="center"><%=trd.Traduz("CHAPA")%></div>
                        	</td>
                        	<td width="20%" class="celtittab" height="28"> 
                        	  <div align="center"><%=trd.Traduz("NOME")%></div>
                        	</td>
                        	<td width="12%" class="celtittab" height="28"> 
                        	  <div align="center"><%=trd.Traduz("CARGO")%></div>
                        	</td>
                        	<td width="12%" class="celtittab" height="28"> 
                        	  <div align="center"><%=trd.Traduz("DEPARTAMENTO")%></div>
                        	</td>
							<%if (prm.buscaparam("USE_TB2").equals("S"))
                    		{%>
                        	<td width="12%" class="celtittab" height="28"> 
                        	  <div align="center"><%=trd.Traduz("TABELA2")%></div>
                        	</td>
							<%}%>
							<%if (prm.buscaparam("USE_TB3").equals("S"))
                    		{%>
                        	<td width="12%" class="celtittab" height="28"> 
                        	  <div align="center"><%=trd.Traduz("TABELA3")%></div>
                        	</td>
							<%}%>
                        	<td width="12%" class="celtittab" height="28"> 
                        	  <div align="center"><%=trd.Traduz("FILIAL")%></div>
                        	</td>
							<%                    
	                      	do{
                        		i++;
                        		%>
                        		<tr class="celnortab"> 
                          		 <td width="4%">
                          		  <input type="checkbox" name="chk_sub_<%=i%>" value="<%=rs.getInt(1)%>">
                          		 </td>
                          		 <td width="4%"><div align="center"><%=rs.getString(2)%></div></td>
								<%
								if(rs.getString(9).equals("S")){
									%><td width="20%">*<%=rs.getString(3)%></td><%
								}
								else {
									%><td width="20%"><%=rs.getString(3)%></td><%
								}
								%>
                            	<td width="12%"><%=rs.getString(4)%></td>
								<%
								if (rs.getString(5) != null) {
									%><td width="12%"><%=rs.getString(5)%></td><%
								}
								else{
									%><td width="12%"></td><%
								}
								if (prm.buscaparam("USE_TB3").equals("S")){
                          			if (rs.getString(6) != null) {
                          				%><td width="12%"><%=rs.getString(6)%></td><%
									}
									else {
										%><td width="12%"></td><%
									}
								}
								if (prm.buscaparam("USE_TB3").equals("S")){
                          			if (rs.getString(7) != null) {
                          				%><td width="12%"><%=rs.getString(7)%></td><%
									}
									else {
										%><td width="12%"></td><%
									}
								}
                    			if (rs.getString(8) != null) {
                    				%><td width="12%"><%=rs.getString(8)%></td><%
								}
								else {
									%><td width="12%"></td><%
								}
								%>
								</tr>
								<%
							}while (rs.next());
						}
                        else{
                        	%>
                        	<td colspan="100%" align="center" class="celtittab"><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...</td>
                        	<%
                        }
					%>
                    </table>
                  </td>
              </tr>
            </table>
          </td>
          <input type="hidden" name="tipo_op">
          <input type="hidden" name="chk_solic">
          <input type="hidden" name="contador" value="<%=i%>">
          
	 
          <td width="20" valign="top"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  <tr><td>&nbsp;</td></tr>
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
</table>
 </FORM>
</body>
</html>
<%
if(rs != null) {rs.close();
conexao.finalizaConexao(session.getId());
}

//} catch (Exception e) {
//  out.println("Erro: "+e);
//}
%>