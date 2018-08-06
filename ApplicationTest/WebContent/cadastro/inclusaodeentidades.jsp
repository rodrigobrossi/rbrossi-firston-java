<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
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

String usu_tipo  = (String)session.getAttribute("usu_tipo"); 
String usu_nome  = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil  = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi  = (Integer)session.getAttribute("usu_idi");  

//Pega o tipo de cadastro (inclusAo ou alteraCAo) e o codigo da Entidade
String tipo = "";
String cod = "1";

if (!(request.getParameter("tipo") == null)){ 
  tipo = request.getParameter("tipo");
}
if (!(request.getParameter("cod") == null)){ 
  cod = request.getParameter("cod");
}

//Se for alteracao faz a query 
ResultSet rs = null, rsCID = null;
String e_codigo="", e_nome="", e_fantasia="", e_cgc="", e_inscrest="", e_email="", e_inscrmun="", e_fone1="", e_fone2="";
String e_fax="", e_endereco="", e_bairro="", e_municipio="", e_uf="", e_cep="", e_site="", e_contato="", e_tipo="";

String query =  "SELECT EMP_CODIGO, EMP_NOME, EMP_FANTASIA, EMP_CGC, EMP_INSCREST, EMP_EMAIL, EMP_INSCRMUN, EMP_FONE1, EMP_FONE2, "+
                "EMP_FAX, EMP_ENDERECO, EMP_BAIRRO, MUN_CODIGO, EMP_UF, EMP_CEP, EMP_SITE, EMP_CONTATO, EMP_TIPO "+
        "FROM EMPRESA " + 
        "WHERE EMP_CODIGO = " + cod + " ORDER BY EMP_NOME";
        
if (tipo.equals("U")){
  rs = conexao.executaConsulta(query, session.getId() + "RS1");
  if (rs.next()) {
    e_codigo = ((rs.getString(1) == null)?"":rs.getString(1));
    e_nome = ((rs.getString(2) == null)?"":rs.getString(2));
    e_fantasia = ((rs.getString(3) == null)?"":rs.getString(3));
    e_cgc = ((rs.getString(4) == null)?"":rs.getString(4));
    e_inscrest = ((rs.getString(5) == null)?"":rs.getString(5));
    e_email = ((rs.getString(6) == null)?"":rs.getString(6));
    e_inscrmun = ((rs.getString(7) == null)?"":rs.getString(7));
    e_fone1 = ((rs.getString(8) == null)?"":rs.getString(8));
    e_fone2 = ((rs.getString(9) == null)?"":rs.getString(9));
    e_fax = ((rs.getString(10) == null)?"":rs.getString(10));
    e_endereco = ((rs.getString(11) == null)?"":rs.getString(11));
    e_bairro = ((rs.getString(12) == null)?"":rs.getString(12));
    e_municipio = ((rs.getString(13) == null)?"":rs.getString(13));
    e_uf = ((rs.getString(14) == null)?"":rs.getString(14));
    e_cep = ((rs.getString(15) == null)?"":rs.getString(15));
    e_site = ((rs.getString(16) == null)?"":rs.getString(16));
    e_contato = ((rs.getString(17) == null)?"":rs.getString(17));
    e_tipo = ((rs.getString(18) == null)?"":rs.getString(18));
  }
}
String estados[] = {"AC","AL","AM","AP","BA","CE","DF","ES","GO","MA","MG","MS","MT","PA","PB","PE","PI","RN","PR","RJ","RS","SC","SE","SP","RO","RR","TO"}; 

%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Cadastro")%> - 
<%
if(tipo.equals("I")){
  %>
  <%=trd.Traduz("INCLUSAO DE ENTIDADE")%>
  <%
}
else{
  %>
  <%=trd.Traduz("ALTERACAO DE ENTIDADE")%>
  <%
}
%>
</title>

<script language="JavaScript" src="/js/scripts.js"></script>

<script language="JavaScript">
function envia(){
  
  if(document.frm.empnome.value=="") {
            alert(<%=("\""+trd.Traduz("Digite a RAZAO SOCIAL")+"\"")%>);
            return false;
  } else
        if(document.frm.empcidade.value=="") {
            alert(<%=("\""+trd.Traduz("Favor escolher a cidade")+"\"")%>);
            return false;
        }

  else{
    document.frm.submit();
    return false; 
  }
}

function cancela(){
  window.open("entidades.jsp","_self");
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

function tel(campo){
  aux = campo.value;
  tam = aux.length
  aux2 = aux.substring(tam-1,tam);
  if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" &&
     aux2 != "4" && aux2 != "5" && aux2 != "6" && aux2 != "7" &&
     aux2 != "8" && aux2 != "9" && aux2 != " " && aux2 != "-" &&
     aux2 != "(" && aux2 != ")" && aux2 != "."){
    aux = campo.value;
    aux = aux.length;
    aux = aux - 1;
    pal = campo.value;
    campo.value = pal.substring(0, aux);
  }
}

function tel2(campo){
  aux = campo.value;
  tam = aux.length;
  k = 0;
  while(tam>0){
    aux2 = aux.substring(tam-1,tam);
    if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" &&
       aux2 != "4" && aux2 != "5" && aux2 != "6" && aux2 != "7" &&
       aux2 != "8" && aux2 != "9" && aux2 != " " && aux2 != "-" &&
       aux2 != "(" && aux2 != ")" && aux2 != "."){
      k = k+1;
    }
    tam--;
  }
  if(k != 0){
    alert(<%=("\""+trd.Traduz("ESTE CAMPO POSSUI CARACTER NAO PERMITIDO")+"\"")%>);
    campo.focus();
    campo.value = "";
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
                    oia = "../menu/menu1.jsp?opt="+"ET";
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
                    oia = "/menu/menu1.jsp?opt="+"ET";
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
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
              <tr > 
                <td class="trontrk" width="100%" colspan="100%" align ="center"> 
      <%
    if (tipo.equals("I")){
      %><%=trd.Traduz("INCLUSAO DE ENTIDADE")%><%
    }
    else{
      %><%=trd.Traduz("ALTERACAO DE ENTIDADE")%><%
    }
    %>
                </td>
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
    <FORM name = "frm" action="entidadesgrava.jsp" method="POST">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1">&nbsp;<br><center>
                <table border="0" cellspacing="2" cellpadding="3" width="90%">
                  <tr class="celnortab">

                    <td colspan="2"><%=trd.Traduz("RAZAO SOCIAL")%><br>
      <%
      if (tipo.equals("I")){
          e_nome = (((String)request.getParameter("empnome")==null)?"":(String)request.getParameter("empnome"));
        %>
        <input type="text" maxlength="50" name="empnome" size="50" value="<%=e_nome%>"  onBlur="aspa2(this)" onKeyUp="aspa(this)">
        <%
      }
      else{
                                %>
        <input type="text" maxlength="50" name="empnome" size="50" value="<%=e_nome%>"  onBlur="aspa2(this)" onKeyUp="aspa(this)">
        <input type="hidden" name="name_old" value="<%=e_nome%>">
        <%
      }
      %>                      
                    </td>
              <td colspan="2"><%=trd.Traduz("NOME FANTASIA")%><br>
      <%
      if (tipo.equals("I")){
         e_fantasia = (((String)request.getParameter("empfantasia")==null)?"":(String)request.getParameter("empfantasia"));
        %> <input type="text" maxlength="50" name="empfantasia" size="50" value="<%=e_fantasia%>" onBlur="aspa2(this)" onKeyUp="aspa(this)"> <%
      }
      else{
        %> <input type="text" maxlength="50" name="empfantasia" size="50" value="<%=e_fantasia%>" onBlur="aspa2(this)" onKeyUp="aspa(this)"> <%
      }
      %>                      
                    </td>
    </tr>
    <tr class="celnortab"> 
      <td><%=trd.Traduz("CNPJ")%><br>
        <%
        if (tipo.equals("I")){
          e_cgc = (((String)request.getParameter("empcgc")==null)?"":(String)request.getParameter("empcgc"));
          %> <input type="text" maxlength="18" name="empcgc" value="<%=e_cgc%>" onBlur="tel2(this)" onKeyUp="tel(this)"> <%
        }
        else{
          %> <input type="text" maxlength="18" name="empcgc" value="<%=e_cgc%>" onBlur="tel2(this)" onKeyUp="tel(this)"> <%
        }
        %>                     
      </td>
      <td><%=trd.Traduz("INSCRICAO ESTADUAL")%><br>
        <%
        if (tipo.equals("I")){
          e_inscrest = (((String)request.getParameter("empie")==null)?"":(String)request.getParameter("empie"));
          %> <input type="text" maxlength="18" name="empie" value="<%=e_inscrest%>" onBlur="tel2(this)" onKeyUp="tel(this)"> <%
        }
        else{
          %> <input type="text" maxlength="18" name="empie" value="<%=e_inscrest%>" onBlur="tel2(this)" onKeyUp="tel(this)"> <%
        }
        %>                     
      </td>
      <td colspan="2"><%=trd.Traduz("EMAIL")%><br>
        <%
        if (tipo.equals("I")){
          e_email = (((String)request.getParameter("empemail")==null)?"":(String)request.getParameter("empemail"));
          %> <input type="text" maxlength="40" name="empemail" size="40" value="<%=e_email%>"  onBlur="aspa2(this)" onKeyUp="aspa(this)"> <%
        }
        else{
          %> <input type="text" maxlength="40" name="empemail" size="40" value="<%=e_email%>"  onBlur="aspa2(this)" onKeyUp="aspa(this)"> <%
        }
        %>                      
      </td>
    </tr>
    <tr class="celnortab"> 
      <td><%=trd.Traduz("INSCRICAO MUNICIPAL")%><br>
        <%
        if (tipo.equals("I")){
          e_inscrmun = (((String)request.getParameter("empim")==null)?"":(String)request.getParameter("empim"));
          %> <input type="text" maxlength="8" name="empim" value="<%=e_inscrmun%>" onBlur="tel2(this)" onKeyUp="tel(this)"> <%
        }
        else{
          %> <input type="text" maxlength="8" name="empim" value="<%=e_inscrmun%>" onBlur="tel2(this)" onKeyUp="tel(this)"> <%
        }
        %>                      
      </td>
      <td><%=trd.Traduz("TELEFONE1")%><br>
        <%
        if (tipo.equals("I")){
          e_fone1 = (((String)request.getParameter("empfone1")==null)?"":(String)request.getParameter("empfone1"));
          %> <input type="text" maxlength="30" name="empfone1" value="<%=e_fone1%>" onBlur="tel2(this)" onKeyUp="tel(this)"> <%
        }
        else{
          %> <input type="text" maxlength="30" name="empfone1" value="<%=e_fone1%>" onBlur="tel2(this)" onKeyUp="tel(this)"> <%
        }
        %>                      
      </td>
      <td><%=trd.Traduz("TELEFONE2")%><br>
        <%
        if (tipo.equals("I")){
          e_fone2 = (((String)request.getParameter("empfone2")==null)?"":(String)request.getParameter("empfone2"));
          %> <input type="text" maxlength="30" name="empfone2" value="<%=e_fone2%>" onBlur="tel2(this)" onKeyUp="tel(this)"> <%
        }
        else{
          %> <input type="text" maxlength="30" name="empfone2" value="<%=e_fone2%>" onBlur="tel2(this)" onKeyUp="tel(this)"> <%
        }
        %>                         
      </td>
      <td><%=trd.Traduz("FAX")%><br>
        <%
        if (tipo.equals("I")){
          e_fax = (((String)request.getParameter("empfax")==null)?"":(String)request.getParameter("empfax"));
          %> <input type="text" maxlength="30" name="empfax" value="<%=e_fax%>" onBlur="tel2(this)" onKeyUp="tel(this)"> <%
        }
        else {
          %> <input type="text" maxlength="30" name="empfax" value="<%=e_fax%>" onBlur="tel2(this)" onKeyUp="tel(this)"> <%
        }
        %>                     
      </td>
    </tr>
    <tr class="celnortab"> 
      <td colspan="2"><%=trd.Traduz("ENDERECO")%><br>
        <%
        if (tipo.equals("I")){
          e_endereco = (((String)request.getParameter("empendereco")==null)?"":(String)request.getParameter("empendereco"));
          %> <input type="text" maxlength="50" size="50" name="empendereco" value="<%=e_endereco%>"  onBlur="aspa2(this)" onKeyUp="aspa(this)"> <%
        }
        else{
          %> <input type="text" maxlength="50" size="50" name="empendereco" value="<%=e_endereco%>"  onBlur="aspa2(this)" onKeyUp="aspa(this)"> <%
        }
        %>                      
      </td>
      <td colspan="2"><%=trd.Traduz("BAIRRO")%><br>
        <%
        if (tipo.equals("I")){
          e_bairro = (((String)request.getParameter("empbairro")==null)?"":(String)request.getParameter("empbairro"));
          %> <input type="text" maxlength="50" name="empbairro" value="<%=e_bairro%>"  onBlur="aspa2(this)" onKeyUp="aspa(this)"> <%
        }
        else{
          %> <input type="text" maxlength="50" name="empbairro" value="<%=e_bairro%>"  onBlur="aspa2(this)" onKeyUp="aspa(this)"> <%
        }
        %>                      
      </td>
    </tr>
    <tr class="celnortab">
      <td><%=trd.Traduz("CIDADE")%><br>
                            <select name="empcidade">                        
                                <option value="" selected><%=trd.Traduz("SELECIONE")%></option>
        <%
        if (tipo.equals("I"))
                                    e_municipio = (((String)request.getParameter("empcidade")==null)?"":(String)request.getParameter("empcidade"));
        String queryCID = "SELECT MUN_CODIGO, MUN_NOME FROM MUNICIPIO ORDER BY MUN_NOME";
        rsCID = conexao.executaConsulta(queryCID, session.getId() + "RS2");
        if (rsCID.next()) {
                                    do {
                                        if(e_municipio.equals(rsCID.getString(1))){
                                            %>
                                            <option value="<%=rsCID.getString(1)%>" selected><%=rsCID.getString(2)%></option>
                                            <%
          } else {
                                            %>
                                            <option value="<%=rsCID.getString(1)%>"><%=rsCID.getString(2)%></option>
                                            <%
          }
                                    } while(rsCID.next());
                               }
                               %>
                               </select>

                    </td>
                    <td><%=trd.Traduz("CEP")%><br>
      <%
      if (tipo.equals("I")){
        e_cep = (((String)request.getParameter("empcep")==null)?"":(String)request.getParameter("empcep")); 
        %> <input type="text" maxlength="9" name="empcep" value="<%=e_cep%>" onBlur="tel2(this)" onKeyUp="tel(this)"> <%
      }
      else{
        %> <input type="text" maxlength="9" name="empcep" value="<%=e_cep%>" onBlur="tel2(this)" onKeyUp="tel(this)"> <%
      }
      %>                     
                    </td>
      <input type="hidden" name="tipo" value="<%=tipo%>">
      <input type="hidden" name="cod" value="<%=cod%>">
                    <td colspan="2"><%=trd.Traduz("SITE")%><br><%
      if (tipo.equals("I")){
        e_site = (((String)request.getParameter("site")==null)?"":(String)request.getParameter("site"));  
        %> <input type="text" maxlength="100" name="site" size="50" value="<%=e_site%>"  onBlur="aspa2(this)" onKeyUp="aspa(this)"> <%
      }
      else{
        %> <input type="text" maxlength="100" name="site" size="50" value="<%=e_site%>"  onBlur="aspa2(this)" onKeyUp="aspa(this)"> <%
      }
      %>                           
                    </td>
                  </tr>
                  <tr class="celnortab">
                    <td colspan="2"><%=trd.Traduz("CONTATO")%><br><%
      if (tipo.equals("I")){
        e_contato = (((String)request.getParameter("contato")==null)?"":(String)request.getParameter("contato")); 
        %> <input type="text" maxlength="50" name="contato" size="50" value="<%=e_contato%>"  onBlur="aspa2(this)" onKeyUp="aspa(this)"> <%
      }
      else{
        %> <input type="text" maxlength="50" name="contato" size="50" value="<%=e_contato%>"  onBlur="aspa2(this)" onKeyUp="aspa(this)"> <%
      }
      %>                           
                    </td>
                    <td colspan="2">
                    <%=trd.Traduz("TIPO")%><br>
                    <%
                    if(tipo.equals("I") || e_tipo.equals("") || e_tipo.equals("3")){
                      %>
                      <input type="radio" name="rad" id="r1" value="3" checked><%=trd.Traduz("FORNECEDOR DE CURSO")%><br>
                      <input type="radio" name="rad" id="r2" value="2"><%=trd.Traduz("FORNECEDOR DE MAO DE OBRA")%><br>
                      <input type="radio" name="rad" id="r3" value="1"><%=trd.Traduz("FORNECEDOR GERAL")%>
                      <%
                    }
                    else if(e_tipo.equals("2")){
                      %>
                      <input type="radio" name="rad" id="r1" value="3"><%=trd.Traduz("FORNECEDOR DE CURSO")%><br>
                      <input type="radio" name="rad" id="r2" value="2" checked><%=trd.Traduz("FORNECEDOR DE MAO DE OBRA")%><br>
                      <input type="radio" name="rad" id="r3" value="1"><%=trd.Traduz("FORNECEDOR GERAL")%>
                      <%
                    }
                    else if(e_tipo.equals("1")){
                      %>
                      <input type="radio" name="rad" id="r1" value="3"><%=trd.Traduz("FORNECEDOR DE CURSO")%><br>
                      <input type="radio" name="rad" id="r2" value="2"><%=trd.Traduz("FORNECEDOR DE MAO DE OBRA")%><br>
                      <input type="radio" name="rad" id="r3" value="1" checked><%=trd.Traduz("FORNECEDOR GERAL")%>
                      <%
                    }
                    %>
                    </td>
                  </tr>
                  <tr> 
                    <td colspan="4" align="center">&nbsp;<br>
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
</body>
</html>
<%

if(rs != null){
  rs.close();
  conexao.finalizaConexao(session.getId() + "RS1");
}

if(rsCID != null){
  rsCID.close();
  conexao.finalizaConexao(session.getId() + "RS2");
}

//}catch(Exception e){out.println(""+e);}
%>