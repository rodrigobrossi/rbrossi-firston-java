<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*"%>

<jsp:useBean id="cmb" scope="page" class="firston.eval.components.FODynamicComboBean" />

<%
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
String aplicacao = (String) session.getAttribute("aplicacao");
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 
Integer usu_cod  = (Integer)session.getAttribute("usu_cod");

ResultSet rs = null, rsf = null;

String filial = ""+usu_fil;
String codigo = ""+usu_cod;

String query = "", func = "", querys = ""; 

if (!(request.getParameter("fun_codigo") == null)){
 func = request.getParameter("fun_codigo");
} else {
 func="0";
}

query = "SELECT FUN_CODIGO, FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = " + func + " ";

querys = "SELECT CAR_CODIGO, CAR_NOME FROM CARGO WHERE CAR_CODIGO IN (SELECT CAR_CODIGO FROM PLANO_SUCESSORIO WHERE FUN_CODIGO = " + func + ") ORDER BY CAR_NOME";	
%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("SolicitaCAo")%> - <%=trd.Traduz("Plano SucessOrio")%></title>
<script language="JavaScript" src="scripts.js"></script>
<script language="JavaScript">
function envia()
	{
	frm.action ="porcompetencias.jsp";
	frm.submit();
	return false;	
	}
</script>
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
	      %>
              <%if(ponto.equals("..")){%>
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
                  oia = "../menu/menu1.jsp?opt="+"S&op=S";
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
			                  oia = "/menu/menu1.jsp?opt="+"S&op=S";
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
                <td class="trontrk" width="297" align="center"><%=trd.Traduz("PLANO SUCESSORIO")%></td>
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
		  <FORM name = "frm" method="POST">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
                </tr>

                <tr> 
                  <td>
                    <p>&nbsp;<br>

<%
rsf = conexao.executaConsulta(query,session.getId()+"RS1");
if (rsf.next())
{
%>
                      <span class="ftverdanacinza"><%=trd.Traduz("FUNCIONARIO")%>:</span> <span class="ftverdanapreto"><a class="lnk" href="result_solics.jsp?fun_codigo=<%=func%>"><%=rsf.getString(2)%></a></span> </p>
<%
}

%>
                    <p><span class="ftverdanacinza"><%=trd.Traduz("CARGO")%>: </span>
                      <select name="selectcar">
                       <%
					   rs = conexao.executaConsulta(querys,session.getId()+"RS2");
                       if (rs.next())
                       {
                        do
                        {%>

						   <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>

                        <%
                        }
                        while (rs.next());
                        
                        }
                        
                        if(rs != null){
                            rs.close();
                            conexao.finalizaConexao(session.getId()+"RS2");
                        }

                        %>
                      </select>
                      &nbsp; 
					  <input type="button" onClick="return envia();"  value=<%=("\""+trd.Traduz("FILTRAR")+"\"")%> class="botcin" name="button">

                    </p>
                    <p> 
					<center>
                    </center>
                    <br>
                    &nbsp; </td>
                </tr>
              </table>
          </td>
    	    <input type="hidden" name="fun_codigo" value = "<%=func%>">
			<input type="hidden" name="origemp" value = "planosussessorio">
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
		  <%}else{%><jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>
		  
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
if(rsf != null){
    rsf.close();
    conexao.finalizaConexao(session.getId()+"RS1");
}
%>