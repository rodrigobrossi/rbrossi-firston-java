<%
    response.setHeader("Pragma", "no-cache");
    if (request.getProtocol().equals("HTTP/1.1"))
    {
      response.setHeader("Cache-Control", "no-cache");
    }
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*"%>

<%
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 
String aplicacao = (String)session.getAttribute("aplicacao");

//Variaveis
String query="", funcionario_cod="", funcionario_nome="", cbo_func="", cbo_tipo="", txt_login="", tipo_op="";
String inc_alt="";
ResultSet rs = null; 

//Recupera parametros
if (request.getParameter("codigo") != null) {
  funcionario_cod = request.getParameter("codigo");
  query = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = " +funcionario_cod+ " ";
  rs = conexao.executaConsulta(query,session.getId());
  if (rs.next())
    funcionario_nome = rs.getString(1).trim();
}
if(rs!=null){
rs.close();
conexao.finalizaConexao(session.getId());


}
//Recupera parametros da pagina anterior (inclusaodesolicitante.jsp)
if (request.getParameter("cbo_func") != null)
  cbo_func = request.getParameter("cbo_func");
if (request.getParameter("cbo_tipo") != null) 
  cbo_tipo = request.getParameter("cbo_tipo");
if (request.getParameter("txt_login") != null) 
  txt_login = request.getParameter("txt_login");
if (request.getParameter("inc_alt") != null) 
  inc_alt = request.getParameter("inc_alt");
if(request.getParameter("tipo_op") != null)
  tipo_op = request.getParameter("tipo_op");
String parametros = "cbo_func=" +cbo_func+ "&cbo_tipo=" +cbo_tipo+ "&txt_login=" +txt_login;
%>

<script language="JavaScript">
function inclui(){
	if(frm_inc_solic.cbo_fil.value == ""){
		alert(<%=("\""+trd.Traduz("FAVOR ESCOLHER UMA FILIAL")+"\"")%>);
		return false;
	}
	else{
		window.open("inclusaodesolicitante_sql.jsp?tipo_op=IF&tipo_op2=<%=tipo_op%>&<%=parametros%>&fil_cod="+frm_inc_solic.cbo_fil.value+"&padrao="+frm_inc_solic.padrao.checked+"&inc_alt=<%=inc_alt%>", "_parent");
		return true;
	}
}

  function cancela() {
    //window.open("inclusaodesolicitante.jsp?cbo_func=<%=funcionario_cod%>&cbo_tipo=<%=cbo_tipo%>", "_parent");
    history.go(-1);
  }
</script>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Cadastro")%> - <%=trd.Traduz("InclusAo de Filial - Solicitante")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','art/onenglish.gif','art/onespanol.gif')">
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

      <table border="0" cellspacing="2" cellpadding="0" bgcolor="c0c0c0">
        <tr>
        <%if(ponto.equals("..")){%>
	   <jsp:include page="../menu/menu_solicitante.jsp" flush="true"><jsp:param value="op" name="C"/></jsp:include>
	   <%}else{%>
	   <jsp:include page="/menu/menu_solicitante.jsp" flush="true"><jsp:param value="op" name="C"/></jsp:include>
	   <%}%>
        </tr>
      </table>
      
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="20">&nbsp;</td>
          <td width="100%" align="center"> 
            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="ftverdanacinza" colspan="100%" align="center"><%=trd.Traduz("InclusAo de Filial - Solicitante")%></td>
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
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
	  <FORM name="frm_inc_solic" action="inclusaodesolicitante.jsp">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1">&nbsp;<br><center>
                <table border="0" cellspacing="2" cellpadding="2" width="60%">
                  <tr align="center">
                    <td class="ftverdanacinza" align="right"><%=trd.Traduz("Funcionario")%>:&nbsp;
                    </td>
                    <td align="left">
                      <input type="text" disabled name="txt_func_off" value="<%=funcionario_nome%>" size="40">
                    </td>
                  </tr>
                  <tr align="center">
                    <td class="ftverdanacinza" align="right"><%=trd.Traduz("Filial")%>:&nbsp;
                    </td>
                    <td align="left">
                      <select name="cbo_fil">
                        <option value=""></option>
<%                        query = "SELECT FIL_CODIGO, FIL_NOME "+
                                  "FROM FILIAL "+
                                  "ORDER BY FIL_NOME";
                          rs = conexao.executaConsulta(query,session.getId()+"RS");
                          if (rs.next()) {
                            do {%>
                                <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
<%                          } while (rs.next());
                          }
                           if(rs!=null){
                            rs.close();
                            conexao.finalizaConexao(session.getId()+"RS");
                            } 
                            %>
                      </select>
                    </td>
                  </tr>
                  <tr><td>&nbsp;</td></tr>
                  <tr align="center" >
                    <td class="ftverdanacinza" colspan="2">
                      <input type="checkbox" name="padrao">&nbsp;
                      <%=trd.Traduz("Padrao")%>
                    </td>
                  </tr>
                  <tr> 
                    <td align="center" colspan="2">&nbsp;<br>
                      <input type="button" class="botcin" value="      <%=trd.Traduz("OK")%>      " onclick="inclui();">
                      &nbsp; &nbsp; 
                      <input type="button" class="botcin" value=<%=("\""+trd.Traduz("CANCELA")+"\"")%> onclick="cancela();">
                    </td>
                  </tr>
                </table><p>&nbsp;
              </center>
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

<%
%>

</body>
</html>
