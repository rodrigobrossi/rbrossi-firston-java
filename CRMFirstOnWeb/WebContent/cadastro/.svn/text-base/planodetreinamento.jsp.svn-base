<!--
Nome do arquivo: cadastro/planodetreinamento.jsp
Nome da funcionalidade: cadastro de plano de treinamento
Função: exibe os planos de treinamentos e as funcionalidades para ele
Variáveis necessárias/ Requisitos: 
- sessao:usu_tipo("usu_tipo"), usu_nome("usu_nome"), usu_login("usu_login"),
         usu_fil("usu_fil"), usu_idi("usu_idi"), per("vetorPermissoes");
- parametro: 
Regras de negócio (pagina):
_________________________________________________________________________________________

Histórico
Data de atualizacao: 13/03/2003 - Desenvolvedor: Anderson Inoue
Atividade:
          - padronizacao da página;
_________________________________________________________________________________________
-->

<!--***DIRETRIZES DA PAGINA***-->
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<!--***IMPORTAÇOES E BEANS***-->
<%@page import=" java.sql.*,java.util.*"%>

<%
//*configuracao de cache*//
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
  response.setHeader("Cache-Control", "no-cache");
}

//***DECLARAÇÃO DE VARIÁVEIS***
boolean existe=false,mostraCheck=false, checa = false;
ResultSet rs = null;
String checado = "", query = "";

//***RECUPERCAO DE PARAMETROS***//
/*valores de sessao*/
request.getSession();
FOLocalizationBean trd   = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao = (FODBConnectionBean)session.getAttribute("Conexao");
String  usu_tipo   = (String) session.getAttribute("usu_tipo"); 
String  usu_nome   = (String) session.getAttribute("usu_nome"); 
String  usu_login  = (String) session.getAttribute("usu_login"); 
Integer usu_fil    = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi    = (Integer)session.getAttribute("usu_idi"); 
Vector  per        = (Vector) session.getAttribute("vetorPermissoes");

%>


<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Cadastro")%> - <%=trd.Traduz("ANO DE REFERENCIA")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<script>
function inclui(){
  document.frm.tipo.value = "I";
  frm.action ="inclusaodeplanodetrein.jsp";
  frm.submit();
  return false; 
}

function altera(){
  document.frm.tipo.value = "U";
  frm.action ="inclusaodeplanodetrein.jsp";
  frm.submit();
  return false; 
}

function exclui(){
  if (confirm(<%=("\""+trd.Traduz("DESEJA EXCLUIR O ITEM SELECIONADO?")+"\"")%>)){
    frm.action ="planotreinamentoexclui.jsp";
    frm.submit();
    return false; 
  }
}

function dados(){
  frm.action ="mostradado.jsp";
  frm.submit();
  return false; 
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
                if(request.getParameter("op") == null){
                  oi = "../menu/menu.jsp?op="+"C";
                }
                else {
                  oi = "../menu/menu.jsp?op="+request.getParameter("op");
                }
                if (request.getParameter("opt") == null){
                  oia = "../menu/menu1.jsp?opt="+"PT";
                }
                else {  
                  oia = "../menu/menu1.jsp?opt="+request.getParameter("opt");
                }
              }
              else{
                if (request.getParameter("op") == null) {
                  oi = "/menu/menu.jsp?op="+"C";
                }
                else {
                  oi = "/menu/menu.jsp?op="+request.getParameter("op");
                }
                if (request.getParameter("opt") == null){
                  oia = "/menu/menu1.jsp?opt="+"PT";
                }
                else {  
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
                <td class="trontrk" width="297" align="center"><%=trd.Traduz("ANO DE REFERENCIA")%></td>
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
                query = "SELECT PLA_CODIGO, PLA_NOME FROM PLANO ORDER BY PLA_NOME"; 
                rs = conexao.executaConsulta(query, session.getId() + "RS1");
                if (rs.next()){
                  existe=true;/*Atribuie valor para existe*/
                } 
                if (per.contains("CADASTRO PLANO - MANUTENCAO")) {
                  mostraCheck=true;
                  %>     
                   <table border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <%
                        if(!usu_tipo.equals("P")){
                          %>
                          <td width="133"> 
                            <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                              <tr> 
                                <td onMouseOver="this.className='ctonlnk2';" onClick="return inclui()" width="127" height="22" align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("INCLUIR")%></a></td>
                              </tr>
                            </table>
                            <%
                         }
                         if(existe){
                            if(!usu_tipo.equals("P")){
                            %>
                            </td>           
                          <td width="12">&nbsp;</td>
                          <td width="133"> 
                            <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                              <tr> 
                                <td onMouseOver="this.className='ctonlnk2';" onClick="return exclui()" width="127" height="22" align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("EXCLUIR")%></a></td>
                              </tr>
                            </table>
                          </td>
                          <td width="12">&nbsp;</td>
                          <td width="133"> 
                            <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                              <tr> 
                                <td onMouseOver="this.className='ctonlnk2';" onClick="return altera()" width="127" height="22" align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("ALTERAR")%></a></td>
                              </tr>
                            </table>
                          <%}%>
                            
                          <td width="12">&nbsp;</td>
                          <td width="133"> 
                            <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                              <tr> 
                                <td onMouseOver="this.className='ctonlnk2';" onClick="return dados()" width="127" height="22" align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("DADOS MENSAIS")%></a></td>
                              </tr>
                            </table>
                      <%}%>
                        </td>
                      </tr>
                    </table>
                  <%}%>
                    <p>
                    <table border="0" cellspacing="1" cellpadding="2" width="80%">
                      <tr> 
                        <td width="3%">&nbsp;</td>
                        <%
                        if(existe){
                          %>
                          <td width="97%" class="celtittab">
                          <%=trd.Traduz("ANO DE REFERENCIA")%>
                          <%
                        }
                        else{
                          %>
                          <td width="97%" class="celtittab" align="center">
                          <%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...
                          <%
                        }
                        %>
                        </td>
                      </tr>
                      <%
                      if(existe){
                        do{
                          if(checa == false){
                            checado = "checked";
                            checa = true;
                          }
                          else{
                            checado = "";
                          }
                          %>
                          <tr class="celnortab"> 
                           <td width="3%">
                            <%
                            if(mostraCheck){
                                %><input type="radio" name="cod" <%=checado%> value="<%= rs.getString(1) %>"><%
                            }
                            else{
                              %>&nbsp;<%
                            }%>
                        </td>
                        <% 
                        if (rs.getString(2) != null){
                          %><td width = "97%"><%= rs.getString(2)%></td><%
                        }
                        else{
                          %><td width = "97%">&nbsp;</td><%
                        }
                      }while(rs.next());
                    }%> 
                      </tr>
                    </table>
                    <br>
                    &nbsp;
                  </td>
              </tr>
            </table>
          </td>
      <input type="hidden" name="tipo">
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
          }%>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table> 
<%
if(rs != null){
  rs.close();
}
//*FINALIZAÇÕES*//
conexao.finalizaConexao(session.getId() + "RS1");
%>
</body>
</html>
