<%
    response.setHeader("Pragma", "no-cache");
    if (request.getProtocol().equals("HTTP/1.1"))
    {
      response.setHeader("Cache-Control", "no-cache");
    }
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*"%>

<script language="JavaScript">
function justifica()
{
 frm.action ="justificativa_return.jsp";
 frm.submit(); 
 return false;
}
</script>

<%
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 

//VariAveis para as Queryes
String query = "";
ResultSet rs = null;

int ii = Integer.parseInt(request.getParameter("contador"));
request.getSession(); 
session.setAttribute("contador", (String)request.getParameter("contador"));
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("SolicitaCAo")%> - <%=trd.Traduz("Escolha da Justificativa")%></title>
<script language="JavaScript" src="scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../art/onenglish.gif','../art/onespanol.gif')">
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
               <jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="SO"/></jsp:include> 
               <%}else{%>
               <jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="SO"/></jsp:include> 
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
                <%String oi = "", oia = "";
                if(ponto.equals("..")){
				if (request.getParameter("op") == null)
				{
                  oi = "../menu/menu.jsp?op="+"S";
				}
				else
				{
                  oi = "../menu/menu.jsp?op="+request.getParameter("op");
				}
				if (request.getParameter("opt") == null)
				{
                  oia = "../menu/menu1.jsp?opt="+"J&op=S";
				} 
				else
				{  
                  oia = "../menu/menu1.jsp?opt="+request.getParameter("opt")+"&op=S";
				}
		}else{
			if (request.getParameter("op") == null)
						{
		                  oi = "/menu/menu.jsp?op="+"S";
						}
						else
						{
		                  oi = "/menu/menu.jsp?op="+request.getParameter("op");
						}
						if (request.getParameter("opt") == null)
						{
		                  oia = "/menu/menu1.jsp?opt="+"J&op=S";
						} 
						else
						{  
		                  oia = "/menu/menu1.jsp?opt="+request.getParameter("opt")+"&op=S";
				}
		
		
		}
				%>
                <jsp:include page="<%=oi%>" flush="true"></jsp:include>
              </tr>
            </table>
          </td>
        </tr>
		<jsp:include page="<%=oia%>" flush="true"></jsp:include>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="20">&nbsp;</td>
          <td width="100%" align="center"> 
            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
                <td class="trontrk" width="297" align="center"><%=trd.Traduz("ESCOLHA DA JUSTIFICATIVA")%></td>
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
		  <FORM name="frm">
                    <%for(int i=1 ; i<=ii;i++)
                        {
                            if (request.getParameter("checkbox" + i) != null) {
                                //out.println("Apos IF: " + request.getParameter("checkbox" + i));
      
                                //session.setAttribute("checkbox"+i, (String)request.getParameter("checkbox"+i));
                                %> <input type=hidden name="h<%=i%>" value=<%=request.getParameter("checkbox" + i)%>>
                       <%   }
                        }%>


          <td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                  <td height="20" class="ctfontc" align="center">&nbsp; <%=trd.Traduz("JUSTIFICATIVA")%> :
                    <select name="select3">
                        <%
                          query = "SELECT * FROM JUSTIFICATIVA";
                          rs = conexao.executaConsulta(query,session.getId()+"RS1");
                          if (rs.next())
                          {
                            do
                          {
                            %>
                            <option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
                            <%
                          }
                            while (rs.next());
                          }

                          if(rs != null){
                              rs.close();
                              conexao.finalizaConexao(session.getId()+"RS1");
                          }
                        %>
                    </select>
                    <p> 
                      <input type="checkbox" name="radiobutton" value="S">
                      <%=trd.Traduz("Reprogramar para o prOximo ano ")%>
                <p><input type="button" onClick="return justifica();"  value=<%=("\""+trd.Traduz("Confirmar")+"\"")%> class="botcin" name="button">
                  </td>
              </tr>
              <tr> 
                <td height="15"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                  <td align="center">&nbsp;<br>
                    <br>
                    &nbsp;
                  </td>
              </tr>
            </table>
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
          <td> <%if(ponto.equals("..")){%>
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
<!--<script language="JavaScript1.2" src="HM_Loader.js" type='text/JavaScript'></script>-->
</body>
</html>
<%

%>