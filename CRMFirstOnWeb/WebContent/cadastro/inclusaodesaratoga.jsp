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
//try{
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi");  

//Pega o tipo de cadastro (inclusAo ou alteraCAo) e o codigo da Saratoga
String tipo = "";
String cod = "1";

if (!(request.getParameter("tipo") == null))
{ 
  tipo = request.getParameter("tipo");
}
if (!(request.getParameter("cod") == null))
{ 
  cod = request.getParameter("cod");
}

int tam = 0;
//Se for alteracao faz a query 
ResultSet rs = null;
String query = "SELECT SAR_CODIGO, SAR_DESCRICAO, SAR_OBSERVACAO "+
         "FROM SARATOGA " + 
         "WHERE SAR_CODIGO = " + cod + " ORDER BY SAR_DESCRICAO";     
         
         
String queryCol = "select length Coluna from syscolumns where name = 'sar_observacao'";
ResultSet rsCol= conexao.executaConsulta(queryCol,session.getId());
if(rsCol.next()) {
  tam = rsCol.getInt(1);
}
if(rsCol!=null){
    conexao.finalizaConexao(session.getId());
}
         
%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("CADASTRO")%> - 
<%
if(tipo.equals("I")){
  %>
  <%=trd.Traduz("INCLUSAO DE SARATOGA")%></title>
  <%
}
else{
  %>
  <%=trd.Traduz("ALTERACAO DE SARATOGA")%></title>
  <%
}
%>

<script language="JavaScript" src="/js/scripts.js"></script>

<script language="JavaScript">
function envia(){
  if(document.frm.sarnome.value==""){
    alert(<%=("\""+trd.Traduz("Digite a saratoga")+"\"")%>);
    return false;
  }
  else{
    frm.submit();
    return false;
  }
}

function cancela(){
  window.open("saratoga.jsp","_self");
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

function aspa2(campo, tam_limite){
  aux = campo.value;
  tam = aux.length;
  aux2 = aux.substring(tam-1,tam);
  //verifica o tamanho da string//  
  if(tam >= tam_limite){
    alert("ESTE CAMPO DEVE CONTER, NO MAXIMO, "+tam_limite+" CARACTERES.");
    campo.focus(); 
  }
    /////////////////////////////////

  i = 0;
  nova = "";
  while(i != tam){
    aux2 = aux.substring(i,i+1);
    if(aux2 == "\"" || aux2 == "\'")
      nova = nova;
    else
      nova = nova + aux2;
    i++;
    
  }
  campo.value = nova;
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
                              String ponto=(String)session.getAttribute("barra");
              if(ponto.equals("..")){%>
               <jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="CA"/></jsp:include>              </tr>
               <%}else{%>
               <jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="CA"/></jsp:include>              </tr>
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
    <%String oi = "", oia = "";
    if(ponto.equals("..")){
      if (request.getParameter("op") == null) {
                    oi = "../menu/menu.jsp?op="+"C";
      } else {
                    oi = "../menu/menu.jsp?op="+request.getParameter("op");
      }
      if (request.getParameter("opt") == null){
                    oia = "../menu/menu1.jsp?opt="+"ST";
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
                          oia = "/menu/menu1.jsp?opt="+"ST";
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
        <td class="trontrk">
        <%
        if (tipo.equals("I")){
          %>
                <%=trd.Traduz("INCLUSAO DE SARATOGA")%>
                <%
            }
            else{
                %>
                <%=trd.Traduz("ALTERACAO DE SARATOGA")%>
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
        <tr> 
          <td width="20" valign="top"></td>
      <FORM name = "frm" action="saratogagrava.jsp" method="POST">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1">&nbsp;<br><center>
                <table border="0" cellspacing="2" cellpadding="3" width="90%">
                  <tr class="celnortab"> 
                    <td>        
                      <p><%=trd.Traduz("SARATOGA")%><br>
                      <%
      if (tipo.equals("I")){
        String sarnome = (((String)request.getParameter("sarnome")==null)?"":(String)request.getParameter("sarnome"));
        %>
        <input type="text" name="sarnome" maxlength="30" size="70" value="<%=sarnome%>" onBlur="aspa2(this)" onKeyUp="aspa(this)">
        </td>
        </tr>
        <tr class="celnortab">
        <td>
        <%=trd.Traduz("DESCRICAO")%><br>
        <textarea name="txt_saratoga" cols="52" rows="7" onBlur="aspa2(this,<%=tam%>)" onKeyUp="aspa(this)"></textarea>
        
        <%
      }
      else{
        rs = conexao.executaConsulta(query,session.getId()+"RS_2");    
        if (rs.next()){ 
          %>
          <input type="text" name="sarnome" maxlength="30" size="70" value="<%=rs.getString(2)%>" onBlur="aspa2(this)" onKeyUp="aspa(this)">
          </td>
          </tr>
          <tr class="celnortab">
          <td>
          <%=trd.Traduz("DESCRICAO")%><br>
          <textarea name="txt_saratoga" cols="52" rows="7" onBlur="aspa2(this,<%=tam%>)" onKeyUp="aspa(this)"><%=(rs.getString(3)==null)?"":rs.getString(3)%></textarea>
          <%
        }
        if(rs!=null){
        conexao.finalizaConexao(session.getId()+"RS_2");
        }
      }
      %> &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
        
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
          <td><%if(ponto.equals("..")){%> 
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


//}catch(Exception e){out.println("ERRO: "+e);}
%>