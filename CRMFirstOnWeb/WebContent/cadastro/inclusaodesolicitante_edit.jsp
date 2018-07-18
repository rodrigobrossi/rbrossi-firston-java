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
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 
String aplicacao = (String)session.getAttribute("aplicacao");

//Variaveis
String query="", funcionario_cod="", tipo_cod="", nome="", login="", senha="";
ResultSet rs = null; 
boolean repete=true, primeiro=true;
int cont=0;

//Recupera parametros
if (request.getParameter("chk_solic") != null) {
  funcionario_cod = request.getParameter("chk_solic");
  query = "SELECT FUN_NOME, FUN_LOGIN, FUN_SENHA FROM FUNCIONARIO WHERE FUN_CODIGO = " +funcionario_cod+ " ";
  rs = conexao.executaConsulta(query);
  if (rs.next()) {
    nome = rs.getString(1);
    login = rs.getString(2);
    senha = rs.getString(3);
  }
  rs = null;
  query = "SELECT F.TIP_TIPO FROM FUNC_USUARIO F, TIPOUSUARIO T, APLICACAO A "+
          "WHERE A.APL_SIGLA = '" +aplicacao+ "' AND A.APL_CODIGO = T.APL_CODIGO "+
          "AND T.TIP_TIPO = F.TIP_TIPO AND F.FUN_CODIGO = " +funcionario_cod+ " ";
  rs = conexao.executaConsulta(query);
  if (rs.next())
    tipo_cod = rs.getString(1);
}
%>

<script language="JavaScript">

  function altera() {
    if (document.frm_alt_solic.cbo_tipo.value == "") {
      alert(<%=("\""+trd.Traduz("Favor escolher o tipo!")+"\"")%>);
      return false;
    }
    if (document.frm_alt_solic.txt_login.value == "") {
      alert(<%=("\""+trd.Traduz("Favor escolher o login!")+"\"")%>);
      return false;
    }
    if (document.frm_alt_solic.senha.value == "") {
      alert(<%=("\""+trd.Traduz("Favor escolher a senha!")+"\"")%>);
      return false;
    }
    document.frm_alt_solic.tipo_op.value = "AS";
    document.frm_alt_solic.action = "inclusaodesolicitante_sql.jsp";
    document.frm_alt_solic.submit();
  }

  function cancela () {
    window.open("solicitantes.jsp", "_parent");
    return true;
  }

  function inclui_filial() {
    document.frm_alt_solic.action = "inclusaodefilial_solicitante.jsp";
    document.frm_alt_solic.submit();
    return true;
  }

  function exclui(f_cod) {
    window.open("inclusaodesolicitante_sql.jsp?tipo_op=E&cod="+f_cod+"&fun_cod="+frm_inc_solic.codigo.value+"&cbo_tipo="+frm_inc_solic.cbo_tipo.value+"&txt_login="+frm_inc_solic.txt_login.value, "_parent");
    return true;    
  }
</script>


<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Cadastro")%> - <%=trd.Traduz("AlteracAo de Solicitante")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
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
            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="ftverdanacinza" colspan="100%" align="center"><%=trd.Traduz("AlteracAo Solicitante")%></td>
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
    <FORM name="frm_alt_solic" action="inclusaodesolicitante.jsp">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1">&nbsp;<br><center>
                <table border="0" cellspacing="2" cellpadding="2" width="60%">
                  <tr>
                    <td align="center" class="ftverdanacinza"><%=trd.Traduz("Funcionario")%>:&nbsp;
                      <input type="text" name="fun_nome_dis" disabled value="<%=nome%>" size="45">
                    </td>
                  </tr>
                  <tr>
                    <td align="center" class="ftverdanacinza"><%=trd.Traduz("Tipo")%>:&nbsp;
                      <select name="cbo_tipo">
                        <option value=""></option>
<%                        query = "SELECT T.TIP_TIPO, T.TIP_DESCRICAO "+
                                  "FROM TIPOUSUARIO T, APLICACAO A "+
                                  "WHERE A.APL_SIGLA = '" +aplicacao+ "' "+
                                  "AND A.APL_CODIGO = T.APL_CODIGO "+
                                  "ORDER BY TIP_DESCRICAO";
                          rs = conexao.executaConsulta(query);
                          if (rs.next()) {
                            do {
                              if (rs.getString(1).equals(tipo_cod)) {%>
                                <option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option>
<%                            } else {%>
                                <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
<%                            }
                            } while (rs.next());
                          }%>
                      </select>
                    </td>
                  </tr>
                  <tr> 
                    <td class="ftverdanacinza" align="center">
                      <%=trd.Traduz("Login")%>:
<%                    if (login.equals("")) {%>
                        <input type="text" name="txt_login" size="15" maxlength="20">
<%                    } else {%>
                        <input type="text" name="txt_login" size="15" maxlength="20" value="<%=login%>">
<%                    }%>
                    </td>
                  </tr>
                  <tr>
                    <td class="ftverdanacinza" align="center"> 
                      <%=trd.Traduz("Senha")%>:
<%                    if (senha.equals("")) {%>
                        <input type="text" name="senha" size="10">
<%                    } else {%>
                        <input type="text" name="senha" size="10" value="<%=senha%>">
<%                    }%>
                    </td>
                  </tr>
                  <tr> 
                    <td class="ftverdanacinza" align="center" colspan="2">&nbsp;<br>
                      <input type="button" name="btn" onclick="inclui_filial();" value=<%=("\""+trd.Traduz("INCLUIR")+"\"")%>>
                  </tr>
                </table><p>
<%              if (!funcionario_cod.equals("")) {%>
      <table border="0" cellspacing="1" cellpadding="2" width="60%">
                    <tr class="celtittab"> 
                      <td width="50%"><%=trd.Traduz("Filial")%></td>
                      <td colspan="2"><%=trd.Traduz("Padrao")%></td>
                    </tr>
<%                  query = "SELECT FI.FIL_NOME, FO.FCO_DEFAULT, FO.FCO_CODIGO "+
                            "FROM FILIAL FI, FOCOFILIAL FO "+
                            "WHERE FI.FIL_CODIGO = FO.FIL_CODIGO AND "+
                            "FO.FUN_CODIGO = " +funcionario_cod+ " "+
                            "ORDER BY FI.FIL_NOME";
                    rs = null;
                    rs = conexao.executaConsulta(query);
                    if (rs.next()) {
                      do {%>
                        <tr class="celnortab"> 
                          <td width="50%"><%=rs.getString(1)%></td>
<%                        if (rs.getString(2).equals("S")) {%>
                            <td width="44%"><%=trd.Traduz("Sim")%></td>
<%                        } else {%>
                            <td width="44%"><%=trd.Traduz("Nao")%></td>
<%                        }%>
                          <td width="6%">
                            <a href="#"><img border="0" src="../art/bot_exc.gif" width="23" height="17" hspace="1" onclick="exclui(<%=rs.getString(3)%>);"></a>
                          </td>
                        </tr>
<%                    } while (rs.next());
                    }%>
                  </table>
<%              }%>
                <p>
                <table width="60%" border="0" cellspacing="2" cellpadding="2">

                  <tr> 
                    <td align="center">&nbsp;<br>
                      <input type="button" value=<%=("\""+trd.Traduz("OK")+"\"")%> onclick="altera();">
                      &nbsp; &nbsp; 
                      <input type="button" value=<%=("\""+trd.Traduz("CANCELA")+"\"")%> onclick="cancela();">
                    </td>
                  </tr>
                </table><p>&nbsp;
              </center>
          </td>
          <input type="hidden" name="cbo_func" value="<%=funcionario_cod%>">
          <input type="hidden" name="codigo" value="<%=funcionario_cod%>">
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

<%
if(rs != null)
  rs.close();
conexao.finalizaConexao();
%>
</body>
</html>

