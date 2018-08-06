<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
  response.setHeader("Cache-Control", "no-cache");
}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*,java.util.*"%>
<jsp:useBean id="cmb" scope="page" class="firston.eval.components.FODynamicComboBean" />

<%
Vector per = (Vector)session.getAttribute("vetorPermissoes");

request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");

String aplicacao = (String) session.getAttribute("aplicacao");
String usu_tipo  = (String) session.getAttribute("usu_tipo"); 
String usu_nome  = (String) session.getAttribute("usu_nome"); 
String usu_login = (String) session.getAttribute("usu_login"); 
Integer usu_fil  = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi  = (Integer)session.getAttribute("usu_idi"); 
Integer usu_cod  = (Integer)session.getAttribute("usu_cod");

boolean existe = false,
mostraCheck = true, 
checa = false;

String ativa = "";
if (usu_tipo.equals("F")){
  ativa = "disabled";
}

String cod_pla = "", filial = usu_fil.toString(), codigo = usu_cod.toString();
if(request.getParameter("cod")!=null){
  cod_pla = request.getParameter("cod");
}

String query = "", plano = "";
ResultSet rs = null, rsC = null, rsF = null;

query = "SELECT PER_CODIGO, PLA_NOME FROM PLANO WHERE PLA_CODIGO = "+cod_pla; 
rsC = conexao.executaConsulta(query, session.getId() + "RS1");
if (rsC.next()) plano = rsC.getString(2);

if(rsC != null){
  rsC.close();
  conexao.finalizaConexao(session.getId() + "RS1");
}
//try {
%>


<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Cadastro")%> - <%=trd.Traduz("DADOS MENSAIS")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<script>

function altera(){
    if(frm.sel_filial.value == "") {
      alert(<%=("\""+trd.Traduz("FAVOR ESCOLHER A FILIAL")+"\" ! ")%>);
      return false;
    } else {
  frm.action ="alteradado.jsp";
  frm.submit();
  return false; 
    }
}

</script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

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
                if(ponto.equals("..")){
                  %><jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="CA"/></jsp:include> <%
                }
                else{
                  %><jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="CA"/></jsp:include> <%
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
      if (request.getParameter("op") == null)
        oi = "../menu/menu.jsp?op="+"C";
      else
        oi = "../menu/menu.jsp?op="+request.getParameter("op");
      if (request.getParameter("opt") == null)
        oia = "../menu/menu1.jsp?opt="+"PT";
      else
        oia = "../menu/menu1.jsp?opt="+request.getParameter("opt");
    }
    else{
      if (request.getParameter("op") == null)
        oi = "/menu/menu.jsp?op="+"C";
      else
                    oi = "/menu/menu.jsp?op="+request.getParameter("op");
      if (request.getParameter("opt") == null)
                    oia = "/menu/menu1.jsp?opt="+"PT";
        else
          oia = "/menu/menu1.jsp?opt="+request.getParameter("opt");
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
                <td class="trontrk" width="297" align="center"><%=trd.Traduz("PERIODOS DE")%> <%=plano%></td>
                <td width="29"><img src="../art/bit.gif" width="13" height="15"></td>
              </tr>
            </table>
          </td>
          <!--<td width="20">&nbsp;</td>-->
        </tr>
        <tr> 
          <td width="20" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
          <td valign="top" class="ctvdiv"><img src="../art/bit.gif" width="1" height="1"></td>
          <td width="20"><img src="../art/bit.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td width="20" valign="top"></td>
    <FORM name="frm">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">              
              <tr>                 
              </tr>
              <tr> 
                  <td align="center"><br>
                <% 
                query = "SELECT QBR_CODIGO, PER_CODIGO, QBR_ORDEM, QBR_NOME FROM QUEBRA WHERE PER_CODIGO = 3"; 
                rs = conexao.executaConsulta(query,session.getId() + "RS2");
    if (rs.next())
        existe=true;/*Atribuie valor para existe*/
    %>     
                   <table border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                        <td width="12">&nbsp;</td>
                        <td width="133"> 
                          <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                            <tr> 
                              <td onMouseOver="this.className='ctonlnk2';" onClick="return altera()" width="127" height="22" align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("ALTERAR")%></a></td>
                            </tr>
                          </table>
                        </td>
                      </tr>
        </table>
                    <p>
                    <table border="0" cellspacing="1" cellpadding="2" width="100%">

                      <tr>
                      <!--///////////////////////FILIAL///////////////////////////-->
                      <td width="18%" colspan="2" class="ftverdanacinza" align="center"><%=trd.Traduz("FILIAL")%>:
                      <select name="sel_filial">
                        <option value="" selected><%=trd.Traduz("Selecione")%></option>           
<%              if(usu_tipo.equals("F"))
                            query = cmb.montaCombo("Filial", "null", "null", aplicacao);  
                          if(usu_tipo.equals("P") || usu_tipo.equals("G"))
                            query = cmb.montaCombo("Filial", filial, "null", aplicacao);  
                          if(usu_tipo.equals("S"))
                            query = cmb.montaCombo("Filial", filial, codigo, aplicacao);
                          rsF = conexao.executaConsulta(query,session.getId() + "RS3");
                          if(rsF.next())  {
                            do {
                              if (filial.equals(rsF.getString(1))) {%>
                                <option value="<%=rsF.getInt(1)%>" selected <%=ativa%>><%=rsF.getString(2)%></option>
<%                            } else {%>
                                <option value="<%=rsF.getInt(1)%>"><%=rsF.getString(2)%></option>
<%                            }
                            } while(rsF.next());
                          }%>
                      </select>
                      </td>
                      <tr><td>&nbsp;</td></tr>
                      </tr>
                    </table>
                    <table border="0" cellspacing="1" cellpadding="2" width="40%">  
                      <tr> 
                        <td width="3%">&nbsp;</td>
                        <%
                        if(existe){
                          %><td width="97%" class="celtittab">&nbsp;<%=trd.Traduz("PERIODOS")%><%
                        }
                        else{
                          %><td width="97%" class="celtittab" align="center">&nbsp;<%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...<%
                        }
                        %>
                        </td>
                      </tr>
                      <%
      if(existe){
        do{
          %>
                            <tr class="celnortab"> 
                              <td width="3%">
                              <%
                            if(mostraCheck){
                              if(checa == false){
                                checa = true;
                                %>
                                <input type="radio" name="cod" checked value="<%= rs.getString(1) %>">
                                <%
                              }
                              else{
                                %>
                                <input type="radio" name="cod" value="<%= rs.getString(1) %>">
                                <%
                              }
                              }
                              else{
                                %>&nbsp;<%
                              }
                                %>
                            </td>
                            <%
                            if (rs.getString(2) != null){
                              %><td width = "97%">&nbsp;<%= rs.getString(4)%></td><% 
                            }
            else{
              %><td width = "97%">&nbsp;</td><%
                            }
        }while(rs.next());
      }
      %>
                      </tr>
                    </table>
                    <br>
                    &nbsp;
                  </td>
              </tr>
            </table>
          </td>
      <input type="hidden" name="tipo">
      <input type="hidden" name="codigo" value="<%=cod_pla%>">
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
        <%
  if(ponto.equals("..")){
            %><jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include><%
  }
  else{
    %><jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include><%
  }
  %>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table> 

<%

if(rs != null){
  rs.close();
  conexao.finalizaConexao(session.getId() + "RS2");
}

if(rsF != null){
  rsF.close();
  conexao.finalizaConexao(session.getId() + "RS3");
}

//} catch (Exception e) {  out.println(e);}
%>

</body>
</html>
