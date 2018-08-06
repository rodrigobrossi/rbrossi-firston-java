<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
  response.setHeader("Cache-Control", "no-cache");
}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*, java.util.*"%>

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
Integer usu_plano = (Integer)session.getAttribute("usu_plano"); 

String que_codigo = request.getParameter("que");

//Pega o tipo de cadastro (inclusAo ou alteraCAo) e o codigo do plano
String tipo = "", cod = "1",tipoOperacao="", query = "", ava_codigo = "";
Vector vetAvaliacao = new Vector();
Vector vetEnvio = new Vector();
Vector vetVencimento = new Vector();
Vector vetAmostra = new Vector();

vetAvaliacao  = (Vector)session.getAttribute("vetor_avaliacao");
vetEnvio      = (Vector)session.getAttribute("vetor_envio");
vetVencimento = (Vector)session.getAttribute("vetor_vencimento");
vetAmostra    = (Vector)session.getAttribute("vetor_amostra");

String checa1 = "checked", checa2 = "";
ResultSet rs = null;
%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<title>FirstOn</title>
<head>
<script language="JavaScript">
function vai(){
  if(frm.txt_env.value == ""){
    alert(<%=("\""+trd.Traduz("FAVOR PREENCHER OS DIAS PARA ENVIO")+"\"")%>);
  }
  else if(frm.txt_ven.value == ""){
    alert(<%=("\""+trd.Traduz("FAVOR PREENCHER OS DIAS PARA VENCIMENTO")+"\"")%>);
  }
  else if(frm.txt_amo.value == "" && frm.r1.checked == false){
    alert(<%=("\""+trd.Traduz("FAVOR PREENCHER O PERCENTUAL PARA AMOSTRAGEM")+"\"")%>); 
  }
  else if((frm.txt_amo.value >= 100 || frm.txt_amo.value <= 0) && (frm.r1.checked == false)){
    alert(<%=("\""+trd.Traduz("VALOR INVALIDO PARA AMOSTRAGEM")+"\"")%>); 
  }
  else{
    
    frm.action="incluidadosavaliacao2.jsp";
    frm.submit();
      window.returnValue = "2";
    window.close();
  }
}

function checa(campo){
  if(frm.r1.checked == true){
    frm.txt_amo.value = "100";
    frm.txt_amo.disabled = true;
  }
  else{
    frm.txt_amo.value = "";
    frm.txt_amo.disabled = false;
  }
}
function numero2(campo){
  aux = campo.value;
  tam = aux.length;
  i = 0;
  nova = "";
  while(i != tam){
    aux2 = aux.substring(i,i+1);
    if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" && aux2 != "4" &&
       aux2 != "5" && aux2 != "6" && aux2 != "7" && aux2 != "8" && aux2 != "9"){
      nova = nova;
    }
    else{
      nova = nova + aux2;
    }
    i++;
  }
  campo.value = nova;
}
function numero(campo){
  aux = campo.value;
  tam = aux.length
  aux2 = aux.substring(tam-1,tam);
  if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" && aux2 != "4" &&
     aux2 != "5" && aux2 != "6" && aux2 != "7" && aux2 != "8" && aux2 != "9"){
    aux = campo.value;
    aux = aux.length;
    aux = aux - 1;
    pal = campo.value;
    campo.value = pal.substring(0, aux);
  }
}
</script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<body  onunload='return fecha();'  scroll="no">
<form name="frm" method="post">
<table border="0" width="100%" height="100%">
 <tr>
  <td align="center" valign="middle">
   <table border="0" width="50%" cellspacing="2" cellpadding="2">
    <tr>
     <td colspan="2" class="celtittab" align="center">
      &nbsp;<%=trd.Traduz("DADOS DA AVALIACAO")%>
     </td>
  </tr>

  <%
    query = "SELECT PLV_DIASENVIO, PLV_DIASVENC, PLV_PORCENTAGEM "+
    "FROM PLANO_AVALIA P "+
    "WHERE QUE_CODIGO = "+que_codigo+" "+
    "AND PLA_CODIGO = " + usu_plano;

    rs = conexao.executaConsulta(query,session.getId()+"RS25");    

    if(rs.next()) {
      %>
        <tr>
          <td width="70%" class="celnortab">
            &nbsp;<%=trd.Traduz("ENVIO")%>:
            </td>
            <td width="30%" class="celnortab">
            <input type="text" name="txt_env" size="5" maxlength="5" onBlur="numero2(this);" onKeyUp="numero(this)" value="<%=rs.getString(1)%>">
          </td>
        </tr>
        <tr>
          <td width="70%" class="celnortab">
            &nbsp;<%=trd.Traduz("VENCIMENTO")%>:
            </td>
          <td width="30%" class="celnortab">
            <input type="text" name="txt_ven" size="5" maxlength="5" onBlur="numero2(this);" onKeyUp="numero(this)" value="<%=rs.getString(2)%>">
          </td>
        </tr>
        <tr>          
          <%
            if(rs.getString(3).equals("100")) { %>
              <td width="70%" class="celnortab">
                <input type="radio" id="r1" checked onClick="return checa(this);" name="rad" value="1"><%=trd.Traduz("TOTAL")%>
                <input type="radio" id="r2" onClick="return checa(this);" name="rad" value="2"><%=trd.Traduz("AMOSTRAGEM")%>
              </td>
              <td width="30%" class="celnortab">
                <input type="text" name="txt_amo" disabled size="5" value="100" maxlength="3" onBlur="numero2(this);" onKeyUp="numero(this)" value="<%=rs.getString(3)%>"><b>%</b>
              <%              
            }
            else { %>
              <td width="70%" class="celnortab">
                <input type="radio" id="r1" onClick="return checa(this);" name="rad" value="1"><%=trd.Traduz("TOTAL")%>
                <input type="radio" id="r2" checked onClick="return checa(this);" name="rad" value="2"><%=trd.Traduz("AMOSTRAGEM")%>
              </td>
              <td width="30%" class="celnortab">
                <input type="text" name="txt_amo" size="5" value="<%=rs.getString(3)%>" maxlength="3" onBlur="numero2(this);" onKeyUp="numero(this)"><b>%</b>
                <%              
              } %>
              </td>
          </tr>
      <%
    }

    else {
      %>
        <tr>
          <td width="70%" class="celnortab">
            &nbsp;<%=trd.Traduz("ENVIO")%>:
            </td>
            <td width="30%" class="celnortab">
            <input type="text" name="txt_env" size="5" maxlength="5" onBlur="numero2(this);" onKeyUp="numero(this)">
          </td>
        </tr>
        <tr>
          <td width="70%" class="celnortab">
            &nbsp;<%=trd.Traduz("VENCIMENTO")%>:
            </td>
          <td width="30%" class="celnortab">
            <input type="text" name="txt_ven" size="5" maxlength="5" onBlur="numero2(this);" onKeyUp="numero(this)">
          </td>
        </tr>
        <tr>
          <td width="70%" class="celnortab">
            <input type="radio" id="r1" checked onClick="return checa(this);" name="rad" value="1"><%=trd.Traduz("TOTAL")%>
            <input type="radio" id="r2" onClick="return checa(this);" name="rad" value="2"><%=trd.Traduz("AMOSTRAGEM")%>
          </td>
          <td width="30%" class="celnortab">
            <input type="text" name="txt_amo" disabled size="5" value="100" maxlength="3" onBlur="numero2(this);" onKeyUp="numero(this)"><b>%</b>
              </td>
          </tr>
      <%
    }
    %>

      <input type="hidden" name="apagavetor" value="N">
   </table><br>
   <input type="button" value="        <%=trd.Traduz("OK")%>        " class="botcin" onClick="return vai();">
  </td>
 </tr>
</table>
</form>
</body>
</html>
<%

if(rs != null){
  rs.close();
}
//*FINALIZAÇÕES*//
conexao.finalizaConexao(session.getId() + "RS25");

//}catch(Exception e){out.println("Erro: "+e);}
%>