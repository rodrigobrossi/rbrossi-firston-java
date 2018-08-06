<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
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

//Pega o tipo de cadastro (inclusAo ou alteraCAo) e o codigo do assunto
String tipo = "";
String cod = "-1";

if (!(request.getParameter("tipo") == null)){ 
tipo = request.getParameter("tipo");
}
if (!(request.getParameter("cod") == null)){ 
cod = request.getParameter("cod");
}

//Se for alteracao faz a query 
ResultSet rs = null;
String query = "SELECT ASS_CODIGO, ASS_NOME, ASS_ATIVO, ASS_AVALIAEFICACIA FROM ASSUNTO " + 
        " WHERE ASS_CODIGO = " + cod + " ORDER BY ASS_NOME"; 
%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Cadastro")%> - 
<%
if(tipo.equals("I")){
  %>
  <%=trd.Traduz("INCLUSAO DE ASSUNTO")%></title>
  <%
}
else{
  %>
  <%=trd.Traduz("ALTERACAO DE ASSUNTO")%></title>
  <%
}
%>
<script language="JavaScript" src="/js/scripts.js"></script>
<script language="JavaScript">
function envia(){
  if(document.frm.assnome.value==""){
    alert(<%=("\""+trd.Traduz("Digite o assunto")+"\"")%>);
    return false;
  }
  else{
    frm.submit();
    return false; 
  }
}

function cancela(){
  window.open("assuntos.jsp","_self");
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
    campo.value = "";
    campo.focus();
  }
}
  
</script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','art/onenglish.gif','art/onespanol.gif')">
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
                    oia = "../menu/menu1.jsp?opt="+"AS";
      } else {  
                    oia = "../menu/menu1.jsp?opt="+request.getParameter("opt");
      }
      }else{
        if (request.getParameter("op") == null) {
                          oi = "/menu/menu.jsp?op="+"C";
            } else {
                          oi = "/menu/menu.jsp?op="+request.getParameter("op");
            }
            if (request.getParameter("opt") == null){
                          oia = "/menu/menu1.jsp?opt="+"AS";
            } else {  
                          oia = "/menu/menu1.jsp?opt="+request.getParameter("opt");
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
                <td class="trontrk" align="center">
                <%
                if(tipo.equals("I")){
                  %>
                  <%=trd.Traduz("INCLUSAO DE ASSUNTO")%>
      <%
    }
    else{
      %>
      <%=trd.Traduz("ALTERACAO DE ASSUNTO")%>
      <%
    }
    %>
    </td>
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
      <FORM name = "frm" action="assuntosgrava.jsp" method="POST">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1">&nbsp;<br><center>
                <table border="0" cellspacing="2" cellpadding="3" width="90%">
                  <tr class="celnortab"> 
                    <td>        
                      <p><%=trd.Traduz("ASSUNTO")%><br>
                     <%
                     if (tipo.equals("I"))
                     {  
                      %> 
                        <input type="text" name="assnome" maxlength="50" size="70" onKeyUp="aspa(this)" onBlur="aspa2(this)">
                      <%
                     }
                     else
                     {
             rs = conexao.executaConsulta(query, session.getId() + "RS1");   
             if (rs.next()){
                      %> 
                        <input type="text" name="assnome" maxlength="50" size="70" value="<%=rs.getString(2)%>" onKeyUp="aspa(this)" onBlur="aspa2(this)">
                      <%}
                     }  
                     %>
                      &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
                     <%
                     if (tipo.equals("I"))
         {
         %> 
                     <input type="checkbox" name="ativo">
                     <%}else
           { 
              if (rs.getString(3).equals("S")){%>
                          <input type="checkbox" name="ativo" checked>
            <%}else{%>
                          <input type="checkbox" name="ativo">
            <%}
           }%>
                        <%=trd.Traduz("ATIVO")%>&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
                     <!--<%if (tipo.equals("I"))
           {%> 
                        <input type="checkbox" name="avalia">
                     <%}else
           {
            if (rs.getString(4).equals("S")){%>
                          <input type="checkbox" name="avalia" checked>
                        <%}else{%>
                          <input type="checkbox" name="avalia">
            <%}
           }%>
                       <%=trd.Traduz("SOFRE AVALIACAO")%></p>
                      <p>&nbsp; </p>-->
                      <input type="hidden" name="tipo" value="<%=tipo%>">
            <input type="hidden" name="cod" value="<%=cod%>">
                    </td>
                  </tr>
                  <tr> 
                    <td align="center">&nbsp;<br>
                      <input type="button" onClick="return envia();"  value="        <%=trd.Traduz("OK")%>        " class="botcin" name="buttonok"> 
                      &nbsp; <input type="button" onClick="return cancela()"  value=<%=("\""+trd.Traduz("CANCELAR")+"\"")%> class="botcin" name="buttoncancel"></td>
                  </tr>
                </table>
                <p>&nbsp;
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
</body>
</html>
<%
if(rs != null){
  rs.close();
  conexao.finalizaConexao(session.getId() + "RS1");
}
%>