<%
  response.setHeader("Pragma", "no-cache");
  if (request.getProtocol().equals("HTTP/1.1"))
  {
    response.setHeader("Cache-Control", "no-cache");
  }
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*"%>
<%
//try{

//recupera da sessAo//
request.getSession();
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");


String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 

ResultSet rs = null, rsF = null;
boolean existe = false;
  //Declaracao de variaveis
  String query="", fun_nomedb="", fil_nomedb="", fun_logindb="", fun_senhadb="", fun_cod="", filial_filtro="";
  int i = 0;

%>
<script language="JavaScript">
function limpa() {
    frm_limpa.action ="limpa_senha_sql.jsp";
    frm_limpa.submit();
}

function atualiza() {
    frm_limpa.action ="limpa_senha.jsp";
    frm_limpa.submit();
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
<title>FirstOn - <%=trd.Traduz("USUARIO")%> - <%=trd.Traduz("LIMPA SENHA")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">

</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','solicitacao/../art/onenglish.gif','solicitacao/../art/onespanol.gif')">
<form name="frm_limpa"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr>
    <td valign="top">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="59" class="hcfundo">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
              <%
		String ponto=(String)session.getAttribute("barra");
              if(ponto.equals("..")){%>
               <jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="CA"/></jsp:include>              
               <%}else{%>
               <jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="CA"/></jsp:include>              
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
              <%if(ponto.equals("..")){%>
               <jsp:include page="../menu/menu.jsp" flush="true"><jsp:param value="op" name="SO"/></jsp:include>
                <%}else{%>
               <jsp:include page="/menu/menu.jsp" flush="true"><jsp:param value="op" name="SO"/></jsp:include>
                <%}%>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      
      <table width="100%" border="0" cellspacing="2" cellpadding="0" bgcolor="c0c0c0" height="8">
        <tr>
        <%if(ponto.equals("..")){%>
          <jsp:include page="../menu/menu_solicitante.jsp" flush="true">
          	<jsp:param value="op" name="L"/>
          </jsp:include>
          <%}else{%>
          <jsp:include page="/menu/menu_solicitante.jsp" flush="true">
          	<jsp:param value="op" name="L"/>
          </jsp:include>
          <%}%>
        </tr>
      </table>
      

      <center>
      
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
             
        <tr> 
          <td width="20">&nbsp;</td>
          <td width="100%" align="center"> 
            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
                <td class="trontrk" width="297" align="center"><%=trd.Traduz("LIMPA SENHA")%></td>
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
      </table>
      
                <center>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
             <tr>
   	      	  <td>&nbsp;></td>
              <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
             </tr>
             <tr>
              <td><img src="../art/bit.gif"></td>
              <td width="40%" class="ctfontc" align="right"><%=trd.Traduz("NOME")%>: 
				<%
				String valorFiltro = (((String)request.getParameter("filtro")==null)?"":(String)request.getParameter("filtro"));
				%>
               <input type="text" name="filtro" value="<%=valorFiltro%>" onBlur="aspa2(this)" onKeyUp="aspa(this)">
              </td>
              <td>&nbsp;&nbsp;</td>
              <td width="60%" class="ctfontc" align="left"><%=trd.Traduz("FILIAL")%>
               <select name="cbo_filial">
                <option value=""><%=trd.Traduz("TODOS")%></option>
				<%
				query = "SELECT FIL_CODIGO, FIL_NOME FROM FILIAL ORDER BY FIL_NOME";
                rsF = conexao.executaConsulta(query,session.getId());
				while(rsF.next()){
					if(rsF.getString(1).equals(request.getParameter("cbo_filial"))){
						filial_filtro = request.getParameter("cbo_filial");
						%>
						<option selected value="<%=rsF.getString(1)%>"><%=rsF.getString(2)%></option>
						<%
					}
					else{
						%>
						<option value="<%=rsF.getString(1)%>"><%=rsF.getString(2)%></option>                  			
						<%
					}
				}
                if(rsF!=null){
                    rsF.close();
                    conexao.finalizaConexao(session.getId());
                }
                %>
               </select>
              </td>
              <td>&nbsp;></td>
             </tr>
             <tr>
              <td><img src="../art/bit.gif"></td>
              <td colspan="3" align="center"><input type="button" onClick="return atualiza();"  value=<%=("\""+trd.Traduz("FILTRAR")+"\"")%> class="botcin" name="button1"></td>
             </tr>
             <tr> 
              <td><img src="../art/bit.gif"></td>
              <td height="12" colspan="3"><img src="../art/bit.gif" width="1" height="1"></td>
             </tr>
             <tr align="center"> 
              <td><img src="../art/bit.gif"></td>
	    	  <td class="ctfontc" colspan="3">&nbsp;</td>
		     </tr>
	         <tr> 
	          <td><img src="../art/bit.gif"></td>
	     	  <td class="ctvdiv" height="1"colspan="3"><img src="../art/bit.gif" width="1" height="1"></td>
	     	 </tr>
	     	 <tr> 
	     	  <td height="12"colspan="4"><img src="../art/bit.gif" width="1" height="1"></td>
	     	 </tr>
	     	 <tr align="center">
	     	  <td class="ctfontc" valign="middle" colspan="4"><font size="1">
	     	    * - <%=trd.Traduz("TERCEIRO")%>
	     	  </font>
	     	  </td>
	     	 </tr>
	     	 <tr> 
	     	  <td height="12"colspan="4"><img src="../art/bit.gif" width="1" height="1"></td>
	     	 </tr>
	     	 <tr> 
	     	  <td><img src="../art/bit.gif"></td>
	     	  <td class="ctvdiv" height="1"colspan="3"><img src="../art/bit.gif" width="1" height="1"></td>
		     </tr>
            
             <tr>
             <td colspan="100%" align="center">
			<%
			query = "SELECT FUN.FUN_NOME, FIL.FIL_NOME, FUN.FUN_LOGIN, FUN.FUN_CODIGO, FUN_TERCEIRO,FUN_DEMITIDO "+
            	    "FROM FUNCIONARIO FUN, FILIAL FIL "+
            	    "WHERE FUN.FIL_CODIGO = FIL.FIL_CODIGO AND FUN_DEMITIDO <> 'S' ";
        	if (!valorFiltro.equals(""))
        		query = query + "AND FUN.FUN_NOME >= '"+valorFiltro+"' ";
			if (!filial_filtro.equals(""))
				query = query + "AND FIL.FIL_CODIGO = "+filial_filtro+" ";
			
			query = query + "ORDER BY FUN.FUN_NOME ";
			
	        rs = conexao.executaConsulta(query,session.getId());
			if(rs.next())
				existe = true;
			
			%>
			
             <br>
				<table border="0" cellspacing="0" cellpadding="0">
				 <tr>
				 <%
				 if(existe){
				 %>
				  <td>
				   <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
					<tr> 
				 	 <td onMouseOver="this.className='ctonlnk2';" onClick="return limpa();" width="127" height="22" align=center class="botver">
					  <a href="#" class="txbotver"><%=trd.Traduz("LIMPAR")%></a></td>
					</tr>
				   </table>
				  </td>
			     </tr>
			     <%}%>
				</table>
             </td>
             </tr>
            </table>
     <br>
     <table border="0" cellspacing="1" cellpadding="2" width="80%">
      <tr class="celtittab">
      	<%
      	if(existe){
      	%>
          <td align="center" width="5%"></td>
          <td align="center" width="40%"><%=trd.Traduz("NOME")%></td>
          <td align="center" width="35%"><div align="center"><%=trd.Traduz("FILIAL")%></div></td>
          <td align="center" width="15%"><%=trd.Traduz("LOGIN")%></td>
        </tr>
		<%
        	do{
        	  fun_nomedb = ""; 
        	  fil_nomedb = "";
        	  fun_logindb = "";
        	  fun_cod = "";
        	  String fun_ter="",fun_dem="";
        	  i=i + 1;
	
        	  if(rs.getString(1) != null)
        	    fun_nomedb  = rs.getString(1);
        	  if(rs.getString(2) != null)
        	    fil_nomedb  = rs.getString(2);
        	  if(rs.getString(3) != null)
        	    fun_logindb = rs.getString(3);
        	  if(rs.getString(4) != null)
        	    fun_cod  = rs.getString(4);
        	  if(rs.getString(5) != null)
        	    fun_ter  = rs.getString(5);
        	  if(rs.getString(6) != null)
        	    fun_dem  = rs.getString(6);
        	    %>
	          <tr class="celnortab">
	            <td align="left" width="5%"><input type="checkbox" name="chk<%=i%>" value="<%=fun_cod%>"></td>
	            <%if(fun_ter.equals("S")&&fun_dem.equals("N")){%>
	            <td align="left" width="40%">*<%=fun_nomedb%></td>
	            <%}else if(fun_ter.equals("N")&&fun_dem.equals("S")){%>
	            <td align="left" width="40%">**<%=fun_nomedb%></td>
	            <%}else{%>
	            <td align="left" width="40%"><%=fun_nomedb%></td>
	            <%}%>
	            
	            <td align="left" width="25%"><%=fil_nomedb%></td>
	            <td align="center" width="15%"><%=fun_logindb%></td>
	          </tr>
			<%
			}while (rs.next());
		}
		else{
			%>
			<tr>
			<td colspan="100%" align="center"><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...</td>
			</tr>
			<%
		}
%>	
      </table>
      <br>
        <input type="hidden" name="cont" value="<%=i%>">
                
      </center>
    </td>
  </tr>
  <tr>
    <td align="right" height="30" class="difundo">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <%if(ponto.equals("..")){%>
        <jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include>
        <%}else{%>
        <jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>
        <%}%>
      </table>
    </td>
  </tr>
</table>

<%
if(rs != null) {
    rs.close();
    conexao.finalizaConexao(session.getId());
}

//} catch(Exception e){
//  out.println("ERRO: "+e);
//}
%>
 </form> 
</body>
</html>
 