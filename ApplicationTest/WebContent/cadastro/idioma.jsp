<%
   response.setHeader("Pragma", "no-cache");
   if (request.getProtocol().equals("HTTP/1.1")){
        response.setHeader("Cache-Control", "no-cache");
  }
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*,java.util.*"%>

<%
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 
String cod_car = (((String)request.getParameter("sel_competencia")==null)?"Todos":(String)request.getParameter("sel_competencia"));
String cod_tit  = (((String)request.getParameter("sel_titulo")==null)?"Todos":(String)request.getParameter("sel_titulo"));
boolean existe=false,mostraCheck=false;
Vector per = (Vector)session.getAttribute("vetorPermissoes");

ResultSet rs = null, rs2 = null;

String query = " SELECT idi_codigo,idi_nome" +
          " FROM lng_idioma ";
%>



<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("CADASTRO")%> - 
<%
String op =(((String)request.getParameter("op")==null)?"E":(String)request.getParameter("op"));
if(op.equals("I")){
  %>
  <%=trd.Traduz("INCLUSAO DE IDIOMA")%></title>
  <%
}
else{
  %>
  <%=trd.Traduz("CADASTRO DE IDIOMA")%></title>
  <%
}
%>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<script language="JavaScript">
function checa()
{
  if(idi.idioma.value=="")
  {
    alert("Digite um idioma");
    idi.idioma.focus();
        return true;
  }
  else 
  {
    idi.submit();
    return false; 
  }

}
function exclui()
{
  if(confirm(<%=("\""+trd.Traduz("DESEJA EXCLUIR O ITEM SELECIONADO?")+"\"")%>))
  {
    frm.submit();
  }
  else
  {
  return false;
  }
}

function altera(codigo)
{
  window.open("idioma.jsp?op='A'&idi_codigo="+codigo)
  
  
}
</script>
<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../solicitacao/art/onenglish.gif','../solicitacao/art/onespanol.gif')">
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
               <jsp:include page="../menu/banner.jsp" flush="true">
           	<jsp:param value="opt" name="CA"/>
               </jsp:include>             
               <%}else{%>
               <jsp:include page="/menu/banner.jsp" flush="true">
            <jsp:param value="opt" name="CA"/>   
               </jsp:include>             
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
      if (request.getParameter("op") == null) {
                    oi = "../menu/menu.jsp?op="+"C";
      } else {
                    oi = "../menu/menu.jsp?op="+request.getParameter("op");
      }
      if (request.getParameter("opt") == null){
                    oia = "../menu/menu1.jsp?opt="+"ID";
      } else {  
                    oia = "../menu/menu1.jsp?opt="+request.getParameter("opt");
      }
      }
    else{
      if(ponto.equals("..")){
            if (request.getParameter("op") == null) {
                          oi = "/menu/menu.jsp?op="+"C";
            } else {
                          oi = "/menu/menu.jsp?op="+request.getParameter("op");
            }
            if (request.getParameter("opt") == null){
                          oia = "/menu/menu1.jsp?opt="+"ID";
            } else {  
                          oia = "/menu/menu1.jsp?opt="+request.getParameter("opt");
      }
      
      
      
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
                <td class="trontrk">
      <%
      if(op.equals("I"))
      {
        %>
                  <%=trd.Traduz("INCLUSAO DE IDIOMA")%>
                  <%
                }
                else
                {
                  %>
                  <%=trd.Traduz("CADASTRO DE IDIOMA")%>                 
                  <%
                }
                %>
                </td>
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
       <%
       
       if(op.equals("I"))
       {
          %>
          <tr> 
              <td width="20" valign="top"></td>
        <form name="idi" action ="valida_idioma.jsp" method="POST">
                  <td valign="top"> <img src="../art/bit.gif" width="159" height="1">&nbsp;<br><center>
            <table border="0" cellspacing="2" cellpadding="3" width="90%">
              <tr class="celnortab"> 
                <td colspan="3" height="150"> 
                  <p>
                  <%=trd.Traduz("IDIOMA")%>: <br><br>
                  <input type ="text" name ="idioma" class="ctinpt" value="">
                  &nbsp;&nbsp;<p>
                </td>
              </tr>
              <tr> 
            </td>
          <td height="20" class="ctfontc" align="center"> </td>
        </tr>
        <tr> 
          <td align="center" colspan="3">&nbsp;<br>
            
            
            <input type="button" class="botcin" value="      <%=trd.Traduz("OK")%>      " onClick="return checa();" >&nbsp;
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


         if (op.equals("E"))
          {
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
                    <td class="ctvdiv" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
                  </tr>
            <%
          }
          %>
              <tr> 
              <td align="center">&nbsp;<br>
              <!--OpCOes -->
          <%
          if (op.equals("E"))
          {
              %>
              
                          
  <% rs = conexao.executaConsulta(query, session.getId() + "RS1");
    if (rs.next()){
      existe=true;/*Atribuie valor para existe*/
      }

    if(rs != null){
        rs.close();
        conexao.finalizaConexao(session.getId()+"RS1");
    }
    
    if (per.contains("CADASTRO IDIOMA - MANUTENCAO")) {
    mostraCheck=true;
    %>     
              <table border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="10">&nbsp;</td>
        
        <td> 
                      <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                        <tr> 
                                <td onMouseOver="this.className='ctonlnk2';" Onclick = "location='idioma.jsp?op=I'" width="127" height="22" align=center class="botver"><a href="idioma.jsp?op=I"  class="txbotver"><%=trd.Traduz("INCLUIR")%></a></td>
                              </tr>
          </table>
        </td>
        <%if(existe){%>
      <td width="10">&nbsp;</td>
        
        <td> 
                      <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                              <tr> 
                                <td onMouseOver="this.className='ctonlnk2';" onClick="return exclui();" width="127" height="22" align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("EXCLUIR")%></a></td>
                              </tr>
          </table>
        </td>

      <td width="10">&nbsp;</td>
        
        <td> 
                      <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                              <tr> 
                                <td onMouseOver="this.className='ctonlnk2';" onClick="return altera();" width="127" height="22" align=center class="botver"><a href="#"  onClick="return altera();" class="txbotver"><%=trd.Traduz("ALTERAR")%></a></td>
                              </tr>
          </table>
        <%}%> 
        </td>

      </tr>                
    </table>
    <%}%>
    
    <!--Fim das opCOes em botOes -->
    
                    
          <form  name="frm"   action ="deleta_idioma.jsp" method="POST">
                    <table border="0" cellspacing="1" cellpadding="2" width="80%">
                      <tr> 
                        <td width="4%">&nbsp;</td>
                        <td width="96%" class="celtittab"><%=trd.Traduz("IDIOMA")%></td>
                        
                      </tr>
                      
                   
                      <%
                        String query2=" SELECT idi_codigo,idi_nome" + " FROM lng_idioma ";                        
            rs2 = conexao.executaConsulta(query2, session.getId() + "RS2");
      boolean check = false;
      if(existe){
      
      if(rs2.next()){
        if(rs2 != null){
            rs2.close();
            conexao.finalizaConexao(session.getId()+"RS2");
        }
        rs2 = conexao.executaConsulta(query2, session.getId() + "RS3");
        while(rs2.next()){%>
          <tr class="celnortab"> 
            <td width="4%"> <%
            if(mostraCheck){
                                if(check==false){%>
                                  <input type="radio"   name="idi"    value="<%=rs2.getInt(1)%>" checked><%
                                  check=true;
                                  }
                                else{%>
                                  <input type="radio"   name="idi"    value="<%=rs2.getInt(1)%>" ><%
                                  }
                              }else{%>&nbsp;<%}   
                                %>
                              </td>
                              <td width="96%"><%=rs2.getString(2)%>
                              </td>
                            </tr>
                              <input type="hidden" name="desc<%=rs2.getInt(1)%>" value="<%=rs2.getString(2)%>">
          <%
                              }
                              if(rs2 != null){
                                  rs2.close();
                                  conexao.finalizaConexao(session.getId()+"RS3");
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
              
                      <%}
                      
                      }
                      %>
                      
                      
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
    </td>
  </tr>
</table>
</body>
<script language="JavaScript">
function altera(){
    frm.action="altera_idioma.jsp";  
    frm.submit();
    return false;
  }
</script> 

<%

%>

</html>
