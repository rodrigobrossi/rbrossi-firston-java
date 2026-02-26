<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1"))
    response.setHeader("Cache-Control", "no-cache");
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.text.*"%>

<%
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 

ResultSet rs = null, rs2 = null;
%>


<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Ferramentas")%> - <%=trd.Traduz("CADASTRO DE TERMOS")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','solicitacao/../art/onenglish.gif','solicitacao/../art/onespanol.gif')">
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
          %>
                  <jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="FE"/></jsp:include> </tr>
          <%
                }
                else{
                  %>
                  <jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="FE"/></jsp:include> </tr>
                  <%
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
              <%if(ponto.equals("..")){%>
                <jsp:include page="../menu/menu.jsp" flush="true"><jsp:param value="op" name="F"/></jsp:include> 
                <%}else{%>
                <jsp:include page="/menu/menu.jsp" flush="true"><jsp:param value="op" name="F"/></jsp:include> 
                <%}%>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      
      <table border="0" cellspacing="2" cellpadding="0" bgcolor="c0c0c0">
        <tr> 
        <%if(ponto.equals("..")){%>
          <jsp:include page="../menu/menu_ferramentas.jsp" flush="true">
          <jsp:param value="op" name="D"/>
          </jsp:include>
          <%}else{%>
          <jsp:include page="/menu/menu_ferramentas.jsp" flush="true">
          	<jsp:param value="op" name="D"/>
          </jsp:include>
          <%}%>
        </tr>
      </table>
      
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="20">&nbsp;</td>
          <td width="100%"> 
            
      <center>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="20">&nbsp;</td>
          <td width="100%" align="center"> 
            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
                <td class="trontrk" width="297" align="center"><%=trd.Traduz("CADASTRO DE TERMOS")%></td>
                <td width="29"><img src="../art/bit.gif" width="13" height="15"></td>
              </tr>
            </table>
          </td>
          <td width="20">&nbsp;</td>
        </tr>
      </table>
      </center>
            
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
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                        <td height="13"><img src="../art/bit.gif" width="1" height="1"></td>
                    </tr>
                    <tr> 
                        <td height="20" class="ctfontc" align="left">
          <%
          
          String op = (((String)request.getParameter("op")==null)?"E":(String)request.getParameter("op"));
          String termo = (((String)request.getParameter("termo")==null)?"":(String)request.getParameter("termo"));
          String tradu = (((String)request.getParameter("tradu")==null)?"":(String)request.getParameter("tradu"));
          String codigo_traducao =(((String)request.getParameter("codt")==null)?"1" : (String)request.getParameter("codt"));
          String ident =  (((String)request.getParameter("id")==null)?"":(String)request.getParameter("id"));
          String desc =  (((String)request.getParameter("desc"+ident)==null)?"DescriCAo":(String)request.getParameter("desc"+ident));
          String trad = (( (String)request.getParameter("trad"+ident)==null)?"TraduCAo":(String)request.getParameter("trad"+ident));
          
          if(op.equals("I")){
          %>                
      <FORM name="altera" action ="altera_traducao.jsp" method ="POST">
      <td valign="top"> <img src="../art/bit.gif" width="159" height="1">&nbsp;<br><center>
      <table border="0" cellspacing="2" cellpadding="3" width="90%">
        <tr class="celnortab"> 
          <td colspan="3" height="150" align="left"> 
            <p><%=trd.Traduz("TERMO")%>:
            <%
              out.println("<b>"+desc+"</b>");
            %>
                          <p><%=trd.Traduz("TRADUCAO")%>: 
                          <%
                          String recupera= "SELECT TRD_TRADUCAO FROM LNG_TRADUCAO WHERE TRD_CODIGO="+ident;
                          rs = conexao.executaConsulta(recupera,session.getId()+"RS1");
                          if(rs.next()){
                            trad=rs.getString(1);
                          }
                          
                          if(rs != null){
                           rs.close();
                           conexao.finalizaConexao(session.getId()+"RS1");
                          }

                          out.println("<b>"+trad+"</b>");%>
                          <p><%=trd.Traduz("DIGITE A NOVA TRADUCAO")%>: 
            <input type="hidden" name="cod" value="<%=ident%>">
            <input type ="text" size="75" name ="traduz"  maxlength="200" onBlur="aspa2(this)" onKeyUp="aspa(this)">&nbsp;&nbsp; 
          </td>
         </TR>
         <TR>
          <td align="center" >&nbsp;<br>
                            <input type="submit" class="botcin" value=<%=("\""+trd.Traduz("GRAVAR")+"\"")%> >
                            <input type="button" class="botcin" value=<%=("\""+trd.Traduz("CANCELAR")+"\"")%> onClick="JavaScript:window.open('traducao.jsp','_self');" >
                          </td>
        </tr>
      </table> 
      <p>
      &nbsp;
                  </center>     
                    </FORM> 
                  <%
                  }
                  else if(op.equals("E")){
                  %>
                  <center>
               <form name ="filtrar" action="traducao.jsp?codt?=<%=codigo_traducao%>" method="POST">  
                    
                    <%=trd.Traduz("LOCALIZAR POR TERMO")%>:
                      <input type ="text" name ="termo"  value="<%=termo%>" onBlur="aspa2(this)" onKeyUp="aspa(this)">&nbsp;&nbsp;
                    <%=trd.Traduz("LOCALIZAR POR TRADUCAO")%>:
                      <input type ="text" name ="tradu"  value="<%=tradu%>" onBlur="aspa2(this)" onKeyUp="aspa(this)">&nbsp;&nbsp;
                        <input type="submit" class="botcin" value=<%=("\""+trd.Traduz("FILTRAR")+"\"")%> >
               </FORM>        
               </center>
               <%}%>
                  </td>
              </tr>
 
              <tr> 
                <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                <td class="ctvdiv" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                  <%
                  if(op.equals("E")){
                  
                
        String query2=  "SELECT T.TRD_CODIGO, R.TRM_NOME, T.TRD_TRADUCAO "+
                "FROM LNG_TRADUCAO T, LNG_TERMO R, LNG_IDIOMA I "+
                "WHERE T.IDI_CODIGO = "+usu_idi+" "+ 
                "AND T.IDI_CODIGO = I.IDI_CODIGO "+
                "AND T.TRM_CODIGO = R.TRM_CODIGO "+
                "AND R.TRM_NOME >=('"+termo+"') "+
                "AND T.TRD_TRADUCAO  >=('"+tradu+"')"+" "+
                "ORDER BY R.TRM_NOME ";

        
                rs2 = conexao.executaConsulta(query2,session.getId()+"RS2");
                boolean check = false, existe = false;
                if(rs2.next()){
                  existe = true;
                }

                if(rs2 != null){
                    rs2.close();
                    conexao.finalizaConexao(session.getId()+"RS2");
                }  
                  
                  
                  %>
                 
                 <td align="center">&nbsp;<br>
                  <!--OpCOes -->
                  <table border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td width="10">&nbsp;</td>
        <td> 
             <table border="0" cellspacing="0" cellpadding="1" >
              <tr>
              <%
              if(existe){
              %>
               <td>
           <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
          <tr> 
           <td onMouseOver="this.className='ctonlnk2';" onClick="return altera();" width="127" height="22" align=center class="botver">
            <a href="#" class="txbotver"><%=trd.Traduz("ALTERAR")%></a></td>
          </tr>
           </table>
               </td>
               <%}%>
              </tr>
         </table>
        </td>
        <td width="10">&nbsp;</td>
      </tr>                
    </table>
    <!--Fim das opCOes em botOes -->
    
                    
          <form  name="frm"   action ="traducao.jsp?op=I" method="POST">
            <table border="0" cellspacing="1" cellpadding="2" width="80%">
              <tr> 
                <%
        if(existe){
                %>
                    <td width="4%">&nbsp;</td>
                    <td width="48%" class="celtittab"><%=trd.Traduz("TERMO")%></td>
                    <td width="48%" class="celtittab"><%=trd.Traduz("TRADUCAO")%></td>
                  </tr>
          <%
                    rs2 = conexao.executaConsulta(query2,session.getId()+"RS3");
                    while(rs2.next()){
                      %>
                      <tr class="celnortab"> 
                      <td width="4%"> 
                      <%
                      if(check==false){
                        %>
                        <input type="radio" name="id" value="<%=rs2.getInt(1)%>" checked>
                        <%
                        check=true;
                      }
                      else{
                        %>
                        <input type="radio" name="id" value="<%=rs2.getInt(1)%>" >
                        <%
                      }
                      %>
                        </td>
                        <td width="48%"><%=rs2.getString(2)%></td>
                        <td width="48%"><%=rs2.getString(3)%></td>
                        </tr>
                        <input type="hidden" name="desc<%=rs2.getInt(1)%>" value="<%=rs2.getString(2)%>">
                        <input type="hidden" name="trad<%=rs2.getInt(1)%>" value="<%=rs2.getString(3)%>">
                        <%
          }
        }
        else {
          %>
                <td colspan="100%" align="center" class="celtittab"><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...</td>
                </tr>
                    <%
        }

         if(rs2 != null){
             rs2.close();
             conexao.finalizaConexao(session.getId()+"RS3");
         }  

                %>
                </table>
                </form><br>&nbsp;
                </td>
                <%
                }
                %>
              </tr>
            </table>
          </td>
    
          <td width="20" valign="top"></td>
        </tr>
      </table>
          
    </td>

  </tr>
  <tr> 
    <td align="right" height="30" class="difundo"> 
    <%if(ponto.equals("..")){%>
    <jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include>
    <%}else{%>
    <jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>
    <%}%>
    </td>
  </tr>
</table>
</body>
<!--FunCOes declaradas  para resolver aCOes importantes deste formulArio-->
<script language="JavaScript">

function altera(){
  frm.submit();
  return false;
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
  var aux = campo.value;
  var tam = aux.length;
  k = 0;
  while(tam>0){
    aux2 = aux.substring(tam-1,tam);
    if(aux2 == "\"" || aux2 == "\'")
      k = k+1;
    tam--;
  }
  if(k != 0){
    alert(<%=("\""+trd.Traduz("NAO E PERMITIDO DIGITAR ASPA SIMPLES OU DUPLA")+"\"")%>);
    campo.focus();
    campo.value = "";
  }
}
  
</script> 
<!--Fim da declaraCAo das funCOes principais -->

<%
%>

</html>
