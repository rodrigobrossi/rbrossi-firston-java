<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
  response.setHeader("Cache-Control", "no-cache");
}
%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.util.*, java.io.*"%>
<jsp:useBean id="cmb" scope="page" class="firston.eval.components.FODynamicComboBean" />
<%
request.getSession();
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
String usu_tipo  = (String) session.getAttribute("usu_tipo"); 
String usu_nome  = (String) session.getAttribute("usu_nome"); 
String usu_login = (String) session.getAttribute("usu_login"); 
String aplicacao = (String) session.getAttribute("aplicacao");
Integer usu_fil  = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi  = (Integer)session.getAttribute("usu_idi"); 
Integer usu_cod  = (Integer)session.getAttribute("usu_cod");

ResultSet rs = null;
String query = "";
String filial = ""+usu_fil;
String codigo = ""+usu_cod;


%>

<script language="JavaScript">

function valida(teste) {
  if(document.form_t.cargo.checked){
    document.form_t.select_sol.disabled = true;
    document.form_t.select_cargo.disabled = false;
    document.form_t.select_sol.value  = "0";
    return true;
  }
  else if(document.form_t.sol.checked){
    document.form_t.select_cargo.disabled = true;
    document.form_t.select_sol.disabled = false;
    document.form_t.select_cargo.value  = "0";
    return true;
  }
}

function reload(){
  if(document.form_t.sol.checked){
    document.form_t.select_sol.disabled = false;
    document.form_t.select_cargo.disabled = true;
  }
  if(document.form_t.cargo.checked){
    document.form_t.select_cargo.disabled = false;
    document.form_t.select_sol.disabled = true;
  }
}

/*
function valida(teste) {
  if(teste.value=="cargo"){
    document.form_t.select_sol.disabled = true;
    document.form_t.select_cargo.disabled = false;
    document.form_t.select_sol.value  = "0";
    //alert("cargo :"+teste.name) 
    return true;
  }
  else if(teste.value=="sol"){
    document.form_t.select_cargo.disabled = true;
    document.form_t.select_sol.disabled = false;
    document.form_t.select_cargo.value  = "0";
    return true;
  }
}
*/
function valida2() {
  if((document.form_t.select_sol.value=="0")&&(document.form_t.select_cargo.value=="0")) {
    alert(<%=("\""+trd.Traduz("Escolha um SOLICITANTE ou um CARGO")+"\"")%>);
    return false
  }
  else {
    form_t.action = "02_gestaodetreinamento.jsp";
    form_t.submit();
  }
}
</script>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("ImpressOes")%> - <%=trd.Traduz("GestAo de Treinamento")%></title>
<script language="JavaScript" src="scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="return reload(); MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','art/onenglish.gif','art/onespanol.gif')">
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
                if(ponto.equals("..")){
                  %><jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="IM"/></jsp:include>  <%
                }
                else{
                  %><jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="IM"/></jsp:include> <%
                }
                %>
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
                <%
                String oi = "", oia = "";
                if(ponto.equals("..")){
                  if (request.getParameter("op") == null){
                    oi = "../menu/menu.jsp?op="+"I";
                  }
                  else{
                    oi = "../menu/menu.jsp?op="+request.getParameter("op");
                  }
                  if (request.getParameter("opt") == null){
                    oia = "../menu/menu1.jsp?opt="+"G";
                  } 
                  else{  
                    oia = "../menu/menu1.jsp?opt="+request.getParameter("opt");
                  }
                }
                else{
                  if (request.getParameter("op") == null){
                    oi = "/menu/menu.jsp?op="+"I";
                  }
                  else{
                    oi = "/menu/menu.jsp?op="+request.getParameter("op");
                  }
                  if (request.getParameter("opt") == null){
                    oia = "/menu/menu1.jsp?opt="+"G";
                  } 
                  else{  
                    oia = "/menu/menu1.jsp?opt="+request.getParameter("opt");
                  }
                }
                %><jsp:include page="<%=oi%>" flush="true"></jsp:include>
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
                <td class="trontrk" align="center"><%=trd.Traduz("GestAo de Treinamento")%></td>
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
          <FORM name="form_t">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1">&nbsp;<br><center>
                <br>
                <table border="0" cellspacing="1" cellpadding="2" width="45%">
                  <tr valign="middle"> 
                  <%
                  if(usu_tipo.equals("S")){
                    %>
                    <td width="3%" class="ftverdanacinza">&nbsp;  </td>
                    <td width="10%" class="ftverdanacinza">&nbsp;  </td>
                    <td width="87%" class="ftverdanacinza">&nbsp;  </td>
                    <input name="select_sol" type="hidden" value="0">
                    <%
                  }
                  else{
                    %>
                    <td width="3%" class="ftverdanacinza">
                      <input type="radio" id="sol" name="radio1" value="sol" OnClick="return valida(this);" checked>
                    </td>
                    <td width="10%" class="ftverdanacinza">
                      <%=trd.Traduz("Solicitante")%>:
                    </td>
                    <td width="87%" class="ftverdanacinza">
                      <select name="select_sol">
                        <option value="0"><%=trd.Traduz("Escolha um Solicitante")%></option>
                        <%
                        if(usu_tipo.equals("F")){
                          query = cmb.montaCombo("Solicitante", "null", "null", aplicacao); 
                        }
                        if(usu_tipo.equals("P") || usu_tipo.equals("G")){
                          query = cmb.montaCombo("Solicitante", filial, "null", aplicacao); 
                        }
                        if(usu_tipo.equals("S")){
                          query = cmb.montaCombo("Solicitante", filial, codigo, aplicacao);     
                        }
                        rs = conexao.executaConsulta(query,session.getId());
                        if(rs.next()) {
                          do{
                            %><option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option><%
                          }
                          while(rs.next());
                         }
                         if(rs!=null){
                            rs.close();
                            conexao.finalizaConexao(session.getId());
                            }
                         %>     
                      </select>
                    </td>
                    <%
                    } //out.println(query);
                    %>
                  </tr>
                  <tr valign="middle">
                  <%
                  if(usu_tipo.equals("S")){
                    %>
                    <td width="3%" class="ftverdanacinza">
                      <input type="radio" id="cargo" name="radio1" value="cargo" checked OnClick="return valida(this);">
                    </td>
                    <%
                  }
                  else{
                    %>
                    <td width="3%" class="ftverdanacinza">
                      <input type="radio" id="cargo" name="radio1" value="cargo"  OnClick="return valida(this);">
                    </td>
                    <%
                  }
                  %>
                    <td width="10%" class="ftverdanacinza"><%=trd.Traduz("Cargo")%>:</td>
                    <td width="87%" class="ftverdanacinza"> 
                  <%
                  if(usu_tipo.equals("S")){
                    %><select name="select_cargo"><%
                  }
                  else{
                    %><select name="select_cargo" disabled><%
                  }
                  %>
                  <option value="0"><%=trd.Traduz("Escolha um Cargo")%></option>
                  <%
                  if(usu_tipo.equals("F")){
                    query = cmb.montaCombo("Cargo", "null", "null", aplicacao); 
                  }
                  if(usu_tipo.equals("P") || usu_tipo.equals("G")){
                    query = cmb.montaCombo("Cargo", filial, "null", aplicacao); 
                  }
                  if(usu_tipo.equals("S")){
                    query = cmb.montaCombo("Cargo", filial, codigo, aplicacao); 
                  }
                  rs = conexao.executaConsulta(query,session.getId());
                  if(rs.next()){
                    do{
                      %><option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option><%
                    }while(rs.next());
                  }
                    if(rs!=null){
                            rs.close();
                            conexao.finalizaConexao(session.getId());
                            }
                         
                  %>
                      </select>
                    </td>
                  </tr>
      
                  <tr>
                    <td colspan="3">&nbsp;</td>
                  </tr>
                  
                  <tr valign="middle"> 
                    <td align="center" class="ftverdanacinza" colspan="100%"> 
                      <input type="checkbox" name="fun_null" value="checkbox"><%=trd.Traduz("Incluir funcionArios sem curso")%>
                    </td>
                  </tr>

                  </table>
                  <br>         
        <%if(request.getParameter("check_a") == null){%>
                    <input type="checkbox" name="check_a">
                    <tt class="ftverdanacinza"> <%=trd.Traduz("VISUALIZAR ATIVO")%> &nbsp;&nbsp;&nbsp; </tt>
                    <%                  } else {%>
                    <input checked type="checkbox" name="check_a">
                    <tt class="ftverdanacinza"> <%=trd.Traduz("VISUALIZAR ATIVO")%> &nbsp;&nbsp;&nbsp; </tt>
                    <%}
           if (request.getParameter("check_t") != null) {%>
                        <input type="checkbox" name="check_t" checked> 
            <tt class="ftverdanacinza"> <%=trd.Traduz("VISUALIZAR TERCEIRO")%> &nbsp;&nbsp;&nbsp; </tt>
<%                  } else {%>
                        <input type="checkbox" name="check_t"> 
            <tt class="ftverdanacinza"> <%=trd.Traduz("VISUALIZAR TERCEIRO")%> &nbsp;&nbsp;&nbsp; </tt>
<%                  }%>
      <br><br>
                  <table border="0">
                  <tr> 
                    <td align="center">
                      <input type="button" value=<%=("\""+trd.Traduz("GERAR RELATORIO")+"\"")%> OnClick="return valida2()" class="botcin">
                    </td>
                  </tr>
                </table>
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
          <%  if(ponto.equals("..")){%>
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

<%

%>

</body>
</html>
