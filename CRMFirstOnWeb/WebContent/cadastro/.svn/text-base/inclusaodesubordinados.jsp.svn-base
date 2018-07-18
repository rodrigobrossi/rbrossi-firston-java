<%
    response.setHeader("Pragma", "no-cache");
    if (request.getProtocol().equals("HTTP/1.1"))
    {
      response.setHeader("Cache-Control", "no-cache");
    }
%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*"%>

<%
request.getSession();

FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 

%>

<%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Cadastro")%> - <%=trd.Traduz("InclusAo de Subordinados")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
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
                    oia = "../menu/menu1.jsp?opt="+"SU";
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
                          oia = "/menu/menu1.jsp?opt="+"SU";
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
                <td class="trcurso">Cadastro</td>
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
                <td width="1" class="trhdiv"><img src="../art/bit.gif" width="1" height="1"></td>
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
                <td class="trontrk">InclusAo de Subordinados</td>
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
      <FORM>
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
                </tr>
                <tr> 
                  <td height="20" class="ctfontc" align="center">&nbsp; Localizar 
                    por nome: 
                    <input type="text" name="textfield">
                    &nbsp; Filtro: 
                    <select name="select">
                      <option> 
                      <option>XXXXXXX 
                      <option>YYYYYYY 
                    </select>
                    &nbsp; OpCOes: 
                    <select name="select2">
                      <option> 
                      <option>Cargo 
                      <option>Departamento 
                      <option>NUcleo 
                      <option>LocaCAo 
                      <option>Filial 
                      <option>Solicitante 
                    </select>
                    &nbsp; &nbsp; <a href="#"><img src="../art/bot_filtrar.gif" border=0></a> 
                  </td>
                </tr>
                <tr> 
                  <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
                </tr>
                <tr> 
                  <td class="ctvdiv" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
                </tr>
                <tr> 
                  <td>&nbsp;<br>
                    <center>
                      <a href="solicitantes.jsp"><img src="../art/bot1_incluir.gif" border="0" width="127" height="22"></a> 
                    </center>
                    <br>
                    <table border="0" cellspacing="1" cellpadding="2" width="100%">
                      <tr> 
                        <td width="2%">&nbsp;</td>
                        <td width="14%" class="celtittab">C&oacute;digo</td>
                        <td width="14%" class="celtittab">Nome</td>
                        <td width="14%" class="celtittab">Cargo</td>
                        <td width="14%" class="celtittab">Departamento</td>
                        <td width="14%" class="celtittab">NUcleo</td>
                        <td width="14%" class="celtittab">Loca&ccedil;&atilde;o</td>
                        <td width="14%" class="celtittab">Solicitante</td>
                      </tr>
                      <tr class="celnortab"> 
                        <td width="2%"> 
                          <input type="checkbox" name="checkbox" value="checkbox">
                        </td>
                        <td width="14%">xxx</td>
                        <td width="14%">No non o nono</td>
                        <td width="14%">nonono</td>
                        <td width="14%">nono o nono</td>
                        <td width="14%">&nbsp;</td>
                        <td width="14%">&nbsp;</td>
                        <td width="14%">&nbsp;</td>
                      </tr>
                      <tr class="celnortab"> 
                        <td width="2%"> 
                          <input type="checkbox" name="checkbox" value="checkbox">
                        </td>
                        <td width="14%">yyy</td>
                        <td width="14%">FULANO DE TAL</td>
                        <td width="14%">Ajudante</td>
                        <td width="14%">no no nono no</td>
                        <td width="14%">&nbsp;</td>
                        <td width="14%">&nbsp;</td>
                        <td width="14%">&nbsp;</td>
                      </tr>
                      <tr class="celnortab"> 
                        <td width="2%"> 
                          <input type="checkbox" name="checkbox" value="checkbox">
                        </td>
                        <td width="14%">zzz</td>
                        <td width="14%">No nono nonon</td>
                        <td width="14%">nonono</td>
                        <td width="14%">nono onno no</td>
                        <td width="14%">&nbsp;</td>
                        <td width="14%">&nbsp;</td>
                        <td width="14%">&nbsp;</td>
                      </tr>
                      <tr class="celnortab"> 
                        <td width="2%"> 
                          <input type="checkbox" name="checkbox" value="checkbox">
                        </td>
                        <td width="14%">www</td>
                        <td width="14%">Nonoo nono</td>
                        <td width="14%">nonono</td>
                        <td width="14%">non non non</td>
                        <td width="14%">&nbsp;</td>
                        <td width="14%">&nbsp;</td>
                        <td width="14%">&nbsp;</td>
                      </tr>
                      <tr class="celnortab"> 
                        <td width="2%"> 
                          <input type="checkbox" name="checkbox" value="checkbox">
                        </td>
                        <td width="14%">kkk</td>
                        <td width="14%">No nono nono</td>
                        <td width="14%">nonono</td>
                        <td width="14%">no no nononon</td>
                        <td width="14%">&nbsp;</td>
                        <td width="14%">&nbsp;</td>
                        <td width="14%">&nbsp;</td>
                      </tr>
                      <tr class="celnortab"> 
                        <td width="2%"> 
                          <input type="checkbox" name="checkbox" value="checkbox">
                        </td>
                        <td width="14%">jjj</td>
                        <td width="14%">Nono nono no</td>
                        <td width="14%">nonono</td>
                        <td width="14%">nononono no</td>
                        <td width="14%">&nbsp;</td>
                        <td width="14%">&nbsp;</td>
                        <td width="14%">&nbsp;</td>
                      </tr>
                    </table>
                    <br>
                    &nbsp; </td>
                </tr>
                <tr> 
                  <td height="30" colspan="3"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="5">
                      <tr> 
                        <td class="ctfontc" width="17%">P&aacute;gina <b>1</b> 
                          de <b>6</b> (10 pessoas por p&aacute;gina)</td>
                        <td align="right" class="ctfontc" width="16%">Total de 
                          <b>52</b> pessoas</td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td class="cthdivb" colspan="3" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
                </tr>
                <tr> 
                  <td height="30" colspan="3" class="ctfundo"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="9">
                      <tr> 
                        <td class="ctfontc" width="17%">Primeira P&aacute;gina</td>
                        <td class="ctfontc" width="17%">P&aacute;gina Anterior</td>
                        <td align="center" class="ctfontc" width="33%">1&nbsp; 
                          <a href="#" class="ctoflnkb">2</a>&nbsp; <a href="#" class="ctoflnkb">3</a>&nbsp; 
                          <a href="#" class="ctoflnkb">4</a>&nbsp; <a href="#" class="ctoflnkb">5</a>&nbsp; 
                          <a href="#" class="ctoflnkb">6</a>&nbsp;</td>
                        <td align="right" class="ctfontc" width="17%"><a href="#" class="ctoflnkb">Pr&oacute;xima 
                          P&aacute;gina</a></td>
                        <td align="right" class="ctfontc" width="16%"><a href="#" class="ctoflnkb">&Uacute;ltima 
                          P&aacute;gina</a></td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td colspan="3">&nbsp;</td>
                </tr>
              </table>
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
