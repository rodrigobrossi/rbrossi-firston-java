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

String cursos = "";
if (!(request.getParameter("cod") == null)){ 
  cursos = request.getParameter("cod");
}

//Pega o Curso
String curso = "";
if (!(request.getParameter("cod") == null)){ 
 curso = " AND CURSO.CUR_CODIGO = " + request.getParameter("cod") + " ";
}

//Verifica se foi digitado algum filtro
String filtro = "";
if (!(request.getParameter("filtro") == null)){ 
 filtro = " AND PAUTA.PAU_DESCRICAO >= '" + request.getParameter("filtro") + "' ";
}

ResultSet rs = null;
String query = "SELECT PAUTA.PAU_CODIGO, PAUTA.PAU_DESCRICAO, CURSO.CUR_NOME FROM PAUTA, CURSO WHERE CURSO.CUR_CODIGO = PAUTA.CUR_CODIGO " + curso + filtro + " ORDER BY CURSO.CUR_NOME"; 
//conexao.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco")); 
rs = conexao.executaConsulta(query);
%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Cadastro")%> - <%=trd.Traduz("Cadastro de Pauta de Curso")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<script language="JavaScript">
function filtra(){
  document.frm.tipo.value = "F";
  frm.action ="pautacurso.jsp";
  frm.submit();
  return false; 
  }
function inclui(){
    document.frm.tipo.value = "I";
  frm.action ="inclusaodepauta.jsp";
  frm.submit();
  return false; 
  }
function altera(){
  document.frm.tipo.value = "U";
  frm.action ="inclusaodepauta.jsp";
  frm.submit();
  return false; 
  }
function exclui(){
  document.frm.tipo.value = "E";
  frm.action ="pautagrava.jsp";
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
          %>
              <%if(ponto.equals("..")){%>
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
                    oia = "../menu/menu1.jsp?opt="+"PC";
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
                          oia = "/menu/menu1.jsp?opt="+"PC";
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
                <td class="trcurso" width="60"><%=trd.Traduz("CADASTRO")%></td>
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
                <td width="1" class="trhdiv"><img src="../art/bit.gif" width="1" height="1"></td>
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
                <td class="trontrk" width="229"><%=trd.Traduz("CADASTRO DE PAUTA DE CURSO")%></td>
                <td width="56"><img src="../art/bit.gif" width="13" height="15"></td>
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
      <FORM name = "frm">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                  <td height="20" class="ctfontc" align="center">&nbsp; <%=trd.Traduz("DESCRICAO DA PAUTA")%>: 
                    <input type="text" name="filtro">&nbsp; &nbsp; &nbsp; 
                    <input type="button" onClick="return filtra();"  value=<%=("\""+trd.Traduz("FILTRAR")+"\"")%> class="botcin" name="button1">  
                  </td>
              </tr>
              <tr> 
                <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                <td class="ctvdiv" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr>            
                  <td align="center">&nbsp;<br>
                    <table border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                        <td> 
                          <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                            <tr> 
                              <td onMouseOver="this.className='ctonlnk2';" onClick="return inclui()" width="127" height="22" align=center class="botver"><a href="#" onClick="return inclui()" class="txbotver"><%=trd.Traduz("INCLUIR")%></a></td>
                            </tr>
                          </table>
                        </td>

            <%
            if (rs.next()){
      %>
                        <td width="10">&nbsp;</td>
                        <td> 
                          <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                            <tr> 
                              <td onMouseOver="this.className='ctonlnk2';" onClick="return exclui()" width="127" height="22" align=center class="botver"><a href="#" onClick="return exclui()" class="txbotver"><%=trd.Traduz("EXCLUIR")%></a></td>
                            </tr>
                          </table>
                        </td>
            <td width="10">&nbsp;</td>
                        <td> 
                          <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                            <tr> 
                              <td onMouseOver="this.className='ctonlnk2';" onClick="return altera()" width="127" height="22" align=center class="botver"><a href="#" onClick="return altera()" class="txbotver"><%=trd.Traduz("ALTERAR")%></a></td>
                            </tr>
                          </table>
                        </td>
                      </tr>                
                    </table>
                    &nbsp; &nbsp; 
                    <p>
                    <table border="0" cellspacing="1" cellpadding="2" width="80%">
                      <tr> 
                        <td width="4%">&nbsp;</td>
                        <td width="40%" class="celtittab"><%=trd.Traduz("NOME DO CURSO")%></td>
                        <td width="56%" class="celtittab"><%=trd.Traduz("NOME DA PAUTA")%></td>
                      </tr>                     
                  <%                 
              boolean check = false;
                   do
                    {
                    %>
                      <tr class="celnortab"> 
                        <td width="4%"> 
            <%if (check == false)
              {check = true;%>
                          <input type="radio" name="codi" checked value="<%=rs.getString(1)%>">
            <%}
                 else
               {check = true;%>
                          <input type="radio" name="codi" value="<%=rs.getString(1)%>">
                         <%}%>
                        </td>
                        <td width="40%"><%=rs.getString(3)%></td>
            <td width="56%"><%=rs.getString(2)%></td>
                      </tr>                    
                    <%
                    }
                   while (rs.next());
      }
                  %>
                    </table>
                    <br>&nbsp;
                  </td>
              </tr>
            </table>
          </td> 
      <input type="hidden" name="tipo"> 
      <input type="hidden" name="cursos" value="<%=cursos%>"> 
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
if(rs != null)
  rs.close();
conexao.finalizaConexao();
%>