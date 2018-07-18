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
String usu_login  = (String)session.getAttribute("usu_login"); 
Integer usu_fil   = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 
String aplicacao  = (String)session.getAttribute("aplicacao");

//Variaveis
String query="", filtro="", filtro_solicitante="";
ResultSet rs = null;
int cont=0;
boolean primeiro = true;

//Filtros
if (request.getParameter("filtro") != null)
  filtro = request.getParameter("filtro");
if (request.getParameter("filtro_solic") != null)
  filtro_solicitante = request.getParameter("filtro_solic");

%>  

<script language="JavaScript">
  function exclui() {
    var conf;
    conf = confirm(<%=("\""+trd.Traduz("DESEJA EXCLUIR O ITEM SELECIONADO?")+"\"")%>);
    if (!conf) {
      return false;
    }
    document.cad_solic.tipo_op.value = "ES";
    document.cad_solic.action = "inclusaodesolicitante_sql.jsp";
    document.cad_solic.submit();
  }

  function altera() {
    document.cad_solic.action = "inclusaodesolicitante.jsp";
    document.cad_solic.submit();
  }

  function sub(cod) {
    window.open("solicitantes.jsp?filtro="+cod, "_parent");
    return false;
  }

  function inclui_sub() {
    document.cad_solic.action = "subordinados.jsp";
    document.cad_solic.submit();
  }

  function exclui_sub() {
    document.cad_solic.tipo_op.value = "ESUB";
    document.cad_solic.action = "inclusaodesolicitante_sql.jsp";
    document.cad_solic.submit();
  }

  function filtrar_solic(){
    //alert(cad_solic.filtro_solic.value);
    window.open("solicitantes.jsp?filtro_solic="+cad_solic.filtro_solic.value, "_parent");
    return true;
  }

  function inclui_solic(){
    window.open("inclusaodesolicitante.jsp", "_parent");
    return true;
  }
</script>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Cadastro")%> - <%=trd.Traduz("Solicitantes")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../solicitacao/art/onenglish.gif','../solicitacao/art/onespanol.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%" align="center">
  <tr> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr> 
          <td height="59" class="hcfundo"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                 <%
                        String ponto = (String)session.getAttribute("barra");
                        if(ponto.equals("..")){
              %>
              <jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="CA"/></jsp:include> 
              <%}else{%>
              <jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="CA"/></jsp:include> 
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
                    oia = "../menu/menu1.jsp?opt="+"SO";
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
                          oia = "/menu/menu1.jsp?opt="+"SO";
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
  <td width="100%"> 
<center>
<table border="0" cellspacing="1" cellpadding="2" width="80%">
  <tr>
    <td>
      <div align="center" class="trontrk"><b><%=trd.Traduz("CADASTRO DE SOLICITANTE")%></b></div>
    </td>
  </tr>
</table>
</center>
</td>
</tr>
<tr>
  <FORM name="cad_solic">
  <td width="20" valign="top"></td>
  <td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td height="20" class="ctfontc" align="center">&nbsp; <%=trd.Traduz("Localizar por Solicitante")%>: 
        <input type="text" name="filtro_solic"> &nbsp; <input type="button" name="btn_filtro" class="botcin" value=<%=("\""+trd.Traduz("FILTRAR")+"\"")%> onclick="filtrar_solic();">
      </td>
    </tr>
    <tr> 
      <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
    </tr>
    <tr> 
      <td class="ctvdiv" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
    </tr>
    <tr> 
      <td align="center">&nbsp;
        <table border="0" cellspacing="1" cellpadding="2" width="80%" align="center">
        <tr>
          <td align="center" colspan="100%"> 
            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td> 
                  <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                    <tr> 
                      <td onMouseOver="this.className='ctonlnk2';" onClick="return inclui_solic()" width="127" height="22" align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("INCLUIR")%></a></td>
                    </tr>
                  </table>
                </td>
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
                      <td onMouseOver="this.className='ctonlnk2';" onClick="return altera()" width="127" height="22" align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("ALTERAR")%></a></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr> 
        <tr><td align="center">&nbsp;</td></tr>
        <tr class="celtittabcin" align="center"> 
          <td colspan="100%"><%=trd.Traduz("SOLICITANTES")%></td>
        </tr>
        <tr class="celtittab"> 
          <td width="5%"></td>
          <td width="18%"><%=trd.Traduz("Chapa")%></td>
          <td width="41%"><%=trd.Traduz("Nome")%></td>
          <td width="18%"><%=trd.Traduz("Cargo")%></td>
          <td width="18%"><%=trd.Traduz("UsuArio")%></td>
        </tr>
        <%                      query = "SELECT DISTINCT F.FUN_CODIGO, F.FUN_CHAPA, F.FUN_NOME, C.CAR_NOME, T.TIP_DESCRICAO "+
        "FROM FUNCIONARIO F, APLICACAO A, TIPOUSUARIO T, FUNC_USUARIO FU, CARGO C "+
        "WHERE F.FUN_TIPOUSUARIO IS NOT NULL "+
        "AND A.APL_SIGLA = '" +aplicacao+ "' "+
        "AND T.APL_CODIGO = A.APL_CODIGO "+
        "AND T.TIP_TIPO = F.FUN_TIPOUSUARIO "+
        "AND FU.FUN_CODIGO = F.FUN_CODIGO "+
        "AND F.CAR_CODIGO = C.CAR_CODIGO ";
        if (!filtro_solicitante.equals(""))
          query = query + "AND F.FUN_NOME >= '"+filtro_solicitante+"' ";
          query = query + "ORDER BY F.FUN_NOME";
          //out.println(query);
        rs = conexao.executaConsulta(query);
        if (rs.next()) {
        do {%>
          <tr class="celnortab">
<%                            if (primeiro || filtro.equals(rs.getString(1))) {
                                primeiro = false;%>
          <td width="5%" align="center"><input type="radio" name="chk_solic" value="<%=rs.getString(1)%>" checked></td>
<%                            } else {%>
          <td width="5%" align="center"><input type="radio" name="chk_solic" value="<%=rs.getString(1)%>">
          </td>
<%                         }%>
								<td width="18%"><%=rs.getString(2)%></td>
          <td width="41%"><a class="lnk" href="#" onclick="sub(<%=rs.getString(1)%>);" ><%=rs.getString(3)%></a></td>
          <td width="18%"><%=rs.getString(4)%></td>
          <td width="18%"><%=rs.getString(5)%></td>
        </tr>
<%                        } while (rs.next());
                        }%>
        </table>
      </td> 
        <p>
<%                  if (!filtro.equals("")) {
                      query = "SELECT DISTINCT F.FUN_CODIGO, F.FUN_CHAPA, F.FUN_NOME, C.CAR_NOME "+
                              "FROM FUNCIONARIO F, CARGO C "+
                              "WHERE F.FUN_CODSOLIC = " +filtro+ " "+
                              "AND F.CAR_CODIGO = C.CAR_CODIGO "+
                              "ORDER BY F.FUN_NOME";
                      rs = null; //out.println(query + "Filtro:" + filtro);
                      rs = conexao.executaConsulta(query);
    if (rs.next()) {%>
    <tr>
      <td class="ctvdiv" height="1"><img src="../art/bit.gif" width="1" height="1">
      </td>
    </tr>
    <tr><td>&nbsp;</td></tr>
  </table>  
  <table border="0" cellspacing="1" cellpadding="2" width="80%" align="center">
    <tr class="celtittabcin" align="center"> 
      <td colspan="100%"><%=trd.Traduz("SUBORDINADOS")%></td>
    </tr>
    <tr class="celtittab"> 
      <td width="4%">&nbsp;</td>
      <td width="18%"><%=trd.Traduz("Chapa")%></td>
      <td width="48%"><%=trd.Traduz("Nome")%></td>
      <td width="30%"><%=trd.Traduz("Cargo")%></td>
    </tr>
    <%  do {
      cont++;%>
    <tr class="celnortab"> 
      <td width="4%" align="center">
        <input type="checkbox" name="chk<%=cont%>" value="<%=rs.getString(1)%>">
      </td>
      <td width="18%"><%=rs.getString(2)%></td>
      <td width="48%"><%=rs.getString(3)%></td>
      <td width="30%"><%=rs.getString(4)%></td>
    </tr>
    <%} while (rs.next());
    } else {%>
    <tr>
      <td>
        <table border="0" width="80%">
          <tr class="celtittabcin" align="center"> 
            <td colspan="100%" ><%=trd.Traduz("NAO CONTEM SUBORDINADOS")%></td>
          </tr>
        </table>
      </td>
    </tr> 
    <% }%>
    <tr>
      <td align="center">&nbsp;</td>
    </tr>
    <tr align="center">
      <td colspan="100%" align="center">
        <a href="inclusaodesubordinados.jsp"><input type="button" name="btn_inc" class="botcin" value=<%=("\""+trd.Traduz("INCLUIR")+"\"")%> onclick="inclui_sub();"></a> 
        &nbsp; <input type="button" name="btn_exc" class="botcin" value=<%=("\""+trd.Traduz("EXCLUIR")+"\"")%> onclick="exclui_sub();"> <br>
      </td>
    </tr>
    <% }%>
    </table>
  </td>
  </tr>
<tr><td colspan="3">&nbsp;</td></tr>        
</table>
</td>
</tr>
</table>

          </td>
          <input type="hidden" name="tipo_op">
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

<%
if(rs != null)
  rs.close();
conexao.finalizaConexao();
%>
</body>
</html>
