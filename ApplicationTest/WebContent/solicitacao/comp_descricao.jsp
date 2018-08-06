<%
    response.setHeader("Pragma", "no-cache");
    if (request.getProtocol().equals("HTTP/1.1"))
    {
      response.setHeader("Cache-Control", "no-cache");
    }
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.util.*"%>

<%
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 

//Variaveis
String comp_cod="", query="";
ResultSet rs = null;

//Recupera codigo da competencia
if (request.getParameter("rdo_desc") != null)
  comp_cod = request.getParameter("rdo_desc");
%>

<script language="JavaScript">
  function fecha() {
    window.close();
  }
</script>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title><%=trd.Traduz("Descricao de Competencias")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body  onunload='return fecha();'  bgcolor="#FFFFFF" text="#000000">

<table width="100%"  height="20%" border="0" align="center">
<tr>
  <td>
    <form name="frm_desc_comp">
        <table width="90%" border="0" align="center" leftmargin=0 rightmargin=0 marginwidth=0 marginheight=0 topmargin=0>
<%      query = "SELECT CMP_OBSERVACAO, CMP_DESCRICAO FROM COMPETENCIA WHERE CMP_CODIGO = " +comp_cod+" ";
	rs = conexao.executaConsulta(query,session.getId()+"RS1");
	if (rs.next()) {%>
          <tr>
            <td width="16%" class="celtittab" align="center"><%=rs.getString(2)%></td>
          </tr>
          <tr class="celnortab"> 
            <td>
              <%=rs.getString(1)%>
            </td>
          </tr>
<%	}%>
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="100%" align ="center"> 
              <input type="button" name="ok" OnClick="fecha();" value=<%=("\""+trd.Traduz("FECHAR")+"\"")%> class="botcin">
            </td>
          </tr>
        </table>
    </form>
  </td>
</tr>
</table>
</body>
</html>
<%
if(rs != null){
	rs.close();
        conexao.finalizaConexao(session.getId()+"RS1");
}
%>