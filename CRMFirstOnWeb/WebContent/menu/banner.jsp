<%
  response.setHeader("Pragma", "no-cache");
  if (request.getProtocol().equals("HTTP/1.1"))
  {
    response.setHeader("Cache-Control", "no-cache");
  }
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*"%>


<%
request.getSession();
FOLocalizationBean trd3  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");   

//conexaoFIL.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"), (String)session.getAttribute("s_driverbanco")); 
//conexaoPLA.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"), (String)session.getAttribute("s_driverbanco")); 
//conexaoTIP.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"), (String)session.getAttribute("s_driverbanco")); 
//conexaoAjuda.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"), (String)session.getAttribute("s_driverbanco")); 

String  usu_tipo  = (String) session.getAttribute("usu_tipo"); 
String  usu_nome  = (String) session.getAttribute("usu_nome"); 
String  usu_login = (String) session.getAttribute("usu_login"); 
Integer usu_plano = (Integer)session.getAttribute("usu_plano");
Integer usu_fil   = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi   = (Integer)session.getAttribute("usu_idi");
String  apl       = (String) session.getAttribute("aplicacao");

ResultSet rs = null, rsFIL = null, rsPLA = null, rsTIP = null, rsAjuda = null;

String query = "SELECT IDI_NOME FROM LNG_IDIOMA WHERE IDI_CODIGO = "+usu_idi;
rs = conexao.executaConsulta(query,session.getId()+"RS_1");
if(rs.next());


String queryFIL = "SELECT FIL_NOME FROM FILIAL WHERE FIL_CODIGO = "+usu_fil;
rsFIL = conexao.executaConsulta(queryFIL,session.getId()+"RS_2");
if(rsFIL.next());


String queryPLA = "SELECT PLA_NOME FROM PLANO WHERE PLA_CODIGO = "+usu_plano;
rsPLA = conexao.executaConsulta(queryPLA,session.getId()+"RS_3");
if(rsPLA.next());

String queryTIP = "SELECT TIP_DESCRICAO FROM TIPOUSUARIO WHERE TIP_TIPO = '"+usu_tipo+"'";
rsTIP = conexao.executaConsulta(queryTIP,session.getId()+"RS_4");
if(rsTIP.next());

String in = "";

if(request.getParameter("opt") != null)
{
  in = request.getParameter("opt");

  if(in.equals("R"))
  {
    in = "";
  }
  else
  {
    in = "../";
  }
}
%>              


<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><td width="20"><img src="<%=in%>art/bit.gif" width="20" height="48"></td>
<td width="100%" valign="middle"><img src="<%=in%>art/Logo_Cliente_Banner.gif"></td>
<td width="20"><img src="<%=in%>art/bit.gif" width="20" height="15"></td>
<td align="right" valign="bottom">

<table width="400" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td class="hcfont" align="right"><b><%=rsTIP.getString(1)%>: <%=usu_nome%></b> </td>
    <td width="20"><img src="<%=in%>art/bit.gif" width="20" height="15"></td>
  </tr>
  <tr> 
  <%
  if(apl.equals("EM"))
  {
    %>
    <td class="hcfont" align="right"><%=trd3.Traduz("FILIAL")%>: <%=rsFIL.getString(1)%> </td>
    <td width="20"><img src="<%=in%>art/bit.gif" width="20" height="15"></td>
    <%
  }
  else
  {
    %>
    <td class="hcfont" align="right"><%=trd3.Traduz("FILIAL")%>: <%=rsFIL.getString(1)%> | <%=trd3.Traduz("IDIOMA")%>: <%=rs.getString(1)%></td>
    <td width="20"><img src="<%=in%>art/bit.gif" width="20" height="15"></td>
    <%
  }
  %>

  </tr>
  <tr>
    <td class="hcfont" align="right">
      <%=trd3.Traduz("LOGIN")%>: <%=usu_login%> | <%=trd3.Traduz("IDIOMA")%>: <%=rs.getString(1)%> | <%=trd3.Traduz("PLANO")%>: <%=rsPLA.getString(1)%>  
    </td>
    <td width="20"><img src="<%=in%>art/bit.gif" width="20" height="15"></td>
  </tr>
  
</table>

<table border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="8" colspan="6"><img src="<%=in%>art/bit.gif" width="8" height="8"></td>
  </tr>
  <tr>
    <td>&nbsp;&nbsp;</td>
    <td height="20" nowrap><a href="JavaScript:window.open('<%=in%>main.jsp','_parent');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','<%=in%>art/ico_home_on.gif',1)" class="hclinkb"><img name="home" border="0" src="<%=in%>art/ico_home.gif" width="15" height="11" align="absmiddle"><%=trd3.Traduz("HOME")%></a></td>
    <td width="10"><img src="<%=in%>art/bit.gif" width="13" height="10"></td>
    <td nowrap>
      <%
      String queryAjuda = "SELECT APL_AJUDA FROM APLICACAO WHERE APL_SIGLA = '"+apl+"'";
      rsAjuda = conexao.executaConsulta(queryAjuda,session.getId()+"RS_5");
      String ajuda="";
      if(rsAjuda.next()){
        ajuda = (((String)rsAjuda.getString(1)==null)?"":(String)rsAjuda.getString(1));
        if(ajuda.equals("S")){
          %>
          <a href="JavaScript:MM_openBrWindow('../iconbar/ajuda.htm','popup','scrollbars=yes,width=384,height=400,left=200,top=100')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ajuda','','<%=in%>art/ico_ajuda_on.gif',1)" class="hclinkb">
          <img name="ajuda" border="0" src="<%=in%>art/ico_ajuda.gif" width="11" height="11" align="absmiddle">
          <%=trd3.Traduz("AJUDA")%>
          </a>
          <%
        }
        else{
          %>&nbsp;<%
        }
      }     

      if(rs != null){
        rs.close();
        conexao.finalizaConexao(session.getId()+"RS_1");
        }
      if(rsFIL!=null){
        rsFIL.close();
        conexao.finalizaConexao(session.getId()+"RS_2");
        }
       if( rsPLA!=null){
        rsPLA.close();
        conexao.finalizaConexao(session.getId()+"RS_3");
        }
       if(rsTIP!=null){
        rsTIP.close();       
        conexao.finalizaConexao(session.getId()+"RS_4");
        }
       if(rsAjuda!=null){
        rsAjuda.close();
        conexao.finalizaConexao(session.getId()+"RS_5");
        }
      %>  
    </td>
    <td width="20"><img src="<%=in%>art/bit.gif" width="20" height="10"></td> 
  </tr>
</table>
