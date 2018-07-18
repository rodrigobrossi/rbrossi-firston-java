<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*"%>

<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
  response.setHeader("Cache-Control", "no-cache");
}

request.getSession();
FOLocalizationBean trd   = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao = (FODBConnectionBean)session.getAttribute("Conexao");

String usu_tipo   = (String) session.getAttribute("usu_tipo"); 
String usu_nome   = (String) session.getAttribute("usu_nome"); 
String usu_login  = (String) session.getAttribute("usu_login"); 
Integer usu_fil   = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi   = (Integer)session.getAttribute("usu_idi");  

//try{
%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn</title>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<body  onunload='return fecha();' >

<%
String sar_codigo="",query = "", sar_descricao = "", sar_nome = "";
ResultSet rs;
sar_codigo = request.getParameter("sar_codigo");

query = "SELECT SAR_OBSERVACAO, SAR_DESCRICAO FROM SARATOGA WHERE SAR_CODIGO="+sar_codigo;
rs = conexao.executaConsulta(query);
if(rs.next()){
  if(rs.getString(1) != null){
    sar_descricao = rs.getString(1);
  }
  if(rs.getString(2) != null){
    sar_nome = rs.getString(2);
  }
}
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr> 
    <td valign="middle" align="center"> 
      <table width="90%" border="0" cellspacing="2" cellpadding="0">
        <tr> 
          <td class="celtittab" align="center" colspan="100%"> 
          <%=trd.Traduz("CLASSIFICACAO SARATOGA")%>     
          </td>
        </tr>
        <tr> 
          <td class="celnortab" colspan="100%"> 
          &nbsp;
          </td>
        </tr>
        <tr> 
          <td class="celnortab"> 
            <b><%=trd.Traduz("NOME")%></b>
          </td>
          <td class="celnortab"> 
            <%=sar_nome%>
          </td>
        </tr>
        <tr>
          <td class="celnortab" valign="top">
            <b><%=trd.Traduz("DESCRICAO")%><b/>
          </td>
          <td class="celnortab"> 
          <%=sar_descricao%>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td colspan="100%" align="center">
      <input type="button" class="botcin" value=<%=("\""+trd.Traduz("FECHAR")+"\"")%> onClick="JavaScript:window.close();">
    </td>
  </tr>
</table>
</body>
</html>
<%
//}catch(Exception e){out.println("ERRO: "+e);}
%>