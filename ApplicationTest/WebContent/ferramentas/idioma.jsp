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
FODBConnectionBean conn  = (FODBConnectionBean)session.getAttribute("Conexao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");

String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 

ResultSet rs2 = null;
%>



<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Idioma")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<script language="JavaScript">
function checa(){
  if(idi.idioma.value==""){
    alert("Digite um idioma");
    idi.idioma.focus();
    return false;
    }
  else {
    return true;
    }

  }
function exclui(){
  frm.submit();
  return false;
  }
function inserir(){
window.open("idioma.jsp?op=I","_parent");
return false;
}

</script>

<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','solicitacao/../art/onenglish.gif','solicitacao/../art/onespanol.gif')">
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
               <jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="FE"/></jsp:include>               </tr>
               <%}else{%>
               <jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="FE"/></jsp:include>               </tr>
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
              <%if(ponto.equals("..")){%>
                <jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="C"/></jsp:include> 
                <%}else{%>
                <jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="op" name="C"/></jsp:include> 
                <%}%>
              </tr>
            </table>
          </td>
        </tr>
      </table>

      <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="c0c0c0" height="8">
        <tr>
        <%if(ponto.equals("..")){%>
          <jsp:include page="../menu/menu_cadastro.jsp" flush="true"><jsp:param value="op" name="I"/></jsp:include>
          <%}else{%>
          <jsp:include page="/menu/menu_cadastro.jsp" flush="true"><jsp:param value="op" name="I"/></jsp:include>
          <%}%>
        </tr>
      </table>
      
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="20">&nbsp;</td>
          <td width="100%"> 

      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td valign="top"></td>
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br></td>
          <td valign="top"></td>
        </tr>

      <center>
      <table border="0" cellspacing="1" cellpadding="2" width="80%">
        <tr> 
          <td align="center" colspan="5" width="60%">&nbsp;</td>
        </tr>
  <tr>
          <td>
            <div align="center" class="ftverdanacinza"><b><%=trd.Traduz("Cadastro de Idioma")%></b></div>
          </td>
        </tr>
      </table>
      </center>

          </td>
        </tr>
       
<%     String op =(((String)request.getParameter("op")==null)?"E":(String)request.getParameter("op"));
       if(op.equals("I")){%>
       <form name="idi" action ="valida_idioma.jsp" method="POST">
         <td width="20" valign="top"></td>
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1">&nbsp;<center>
     
      <table border="0" cellspacing="2" cellpadding="3" width="90%">
        <tr class="celnortab"> 
          <td colspan="3" height="150" align="center"> 
      <p><%=trd.Traduz("Digite a descricao do Idioma ")%>: 
      <br>
      <input type ="text" name ="idioma" class="ctinpt" value="">
      &nbsp;&nbsp;<p>
    </td>
        </tr>
        <tr> 

        <tr> 
          <td align="center" colspan="3">&nbsp;<br>
            <input type="submit" class="botcin" value=<%=("\""+trd.Traduz("Cadastrar")+"\"")%> onClick="return checa();" >&nbsp;
            <input type="button" class="botcin" value=<%=("\""+trd.Traduz("CANCELAR")+"\"")%> onClick="JavaScript:history.go(-1);" >
                      </td>
                    </tr>
                  </table> 
      <p>
      &nbsp;
                  </center>              
              </td>
              
             </tr> 
 </form>
              <tr> 
                <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              
              <%
              }
          if (op.equals("E")) {
        %>
         
         <tr> 
              <td width="20" valign="top"></td>
   
              <td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr> 
                      <td height="13"><img src="../art/bit.gif" width="1" height="1"></td>
                  </tr>
                  <tr> 
                      <td height="20" class="ctfontc" align="center">
                    &nbsp;&nbsp;
                      </td>
                  </tr>
                    <tr> 
                    <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
                  </tr>
    
    
    <tr> 
          
          </tr>
          
          <%}%>
              <tr> 
                  <td align="center">&nbsp;<br>
                  <!--OpCOes -->
                  <%  if (op.equals("E")) {
              %>
                  <table border="0" cellspacing="0" cellpadding="0">

          <td width="10">&nbsp;</td>
        <td> 
                      <table border="0" cellspacing="0" cellpadding="1" >
                        <tr> 
                                <td width="127" height="22" align=center ><input type="button" onCLick="return inserir();"  class="botcin" value=<%=("\""+trd.Traduz("INSERIR")+"\"")%>></td>
                              </tr>
          </table>
        </td>
        <td> 
                      <table border="0" cellspacing="0" cellpadding="1">
                              <tr> 
                                <td width="127" height="22" align=center ><input type="button" onClick="return altera();" class="botcin" value=<%=("\""+trd.Traduz("ALTERAR")+"\"")%> ></a></td>
                              </tr>
          </table>
        </td>
      </tr>                
    </table>
    <!--Fim das opCOes em botOes -->
    
                    <%
                    
                    %>
          <form  name="frm"   action ="deleta_comptitulo.jsp"method="POST">
                    <table border="0" cellspacing="1" cellpadding="2" width="80%">
                      <tr> 
                        <td width="4%">&nbsp;</td>
                        <td width="48%" class="celtittab"><%=trd.Traduz("IDIOMA_IDI")%></td>
                        
                      </tr>
                      
                   
                      <%

                        String query2=" SELECT idi_codigo,idi_nome" +
                      " FROM lng_idioma ";

            rs2 = conn.executaConsulta(query2);
      boolean check = false;
      if(rs2.next()){
        rs2 = conn.executaConsulta(query2);
        while(rs2.next()){%>
          <tr class="celnortab"> 
            <td width="4%"> <%
                                if(check==false){%>
                                  <input type="radio"   name="idi"    value="<%=rs2.getInt(1)%>" checked><%
                                  check=true;
                                  }
                                else{%>
                                  <input type="radio"   name="idi"    value="<%=rs2.getInt(1)%>" ><%
                                  }
                                %>
                              </td>
                              <td width="48%"><%=rs2.getString(2)%>
                              </td>
                            </tr>
                              <input type="hidden" name="desc<%=rs2.getInt(1)%>" value="<%=rs2.getString(2)%>">
          <%
                              }
                          }
                      else {
                          %>
                          <tr class="celnortab"> 
                      <td width="4%"> 
                        <input type="radio" name="idi" disabled>
                      </td>
                      <td width="48%">
                        <%=trd.Traduz("NAOENC_IDI")%>
                      </td>
              </tr>
              
                      <%}%>
                      </table>
                      
                    
                    
                <br>&nbsp;
                  </td>
              </tr>
            </table>
          </td>
     <%}%> 
          <td width="20" valign="top"></td>
        </tr>
      </table>
          </form>
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
</body>
<!--FunCOes declaradas  para resolver aCOes importantes deste formulArio-->
<script language="JavaScript">
function altera(){
    frm.action="altera_idioma.jsp";  
    frm.submit();
    return false;
  }
</script> 
<!--Fim da declaraCAo das funCOes principais -->

<%
if(rs2 != null)
  rs2.close();
conn.finalizaConexao();
%>
</html>
