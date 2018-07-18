<%
    response.setHeader("Pragma", "no-cache");
    if (request.getProtocol().equals("HTTP/1.1"))
    {
      response.setHeader("Cache-Control", "no-cache");
    }
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.util.*"%>

<%
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 

//VariAveis para as Queryes
String query = ""; 
String opt_filtro = "";
 
ResultSet rs = null;

//try{

//Pegar parametros
if (request.getParameter("opcombo") != null)
{  
  opt_filtro = (String)request.getParameter("opcombo");
    
  //Select do Combo escolhido
  if (opt_filtro.equals("Cargo"))
  {
      query = "SELECT CAR_CODIGO, CAR_NOME FROM CARGO ORDER BY CAR_NOME";
    }

  if (opt_filtro.equals("Departamento"))
  {
      query = "SELECT DEP_CODIGO, DEP_NOME FROM DEPTO ORDER BY DEP_NOME";
  }

  if (opt_filtro.equals("Filial"))
  {
      query = "SELECT FIL_CODIGO, FIL_NOME FROM FILIAL ORDER BY FIL_NOME";
  }

  if (opt_filtro.equals("Tabela1"))
  {
      query = "SELECT TB1_CODIGO, TB1_NOME FROM TABELA1 ORDER BY TB1_NOME";
  }

    if (opt_filtro.equals("Tabela2"))
  {
      query = "SELECT TB2_CODIGO, TB2_NOME FROM TABELA2 ORDER BY TB2_NOME";
  }

    if (opt_filtro.equals("Tabela3"))
  {
      query = "SELECT TB3_CODIGO, TB3_DESCRICAO FROM TABELA3 ORDER BY TB3_DESCRICAO";
  }

    if (opt_filtro.equals("Tabela4"))
  {
      query = "SELECT TB4_CODIGO, TB4_DESCRICAO FROM TABELA4 ORDER BY TB4_DESCRICAO";
  }

    if (opt_filtro.equals("Tabela5"))
  {
      query = "SELECT TB5_CODIGO, TB5_DESCRICAO FROM TABELA5 ORDER BY TB5_DESCRICAO";
  }

    if (opt_filtro.equals("Tabela6"))
  {
      query = "SELECT TB6_CODIGO, TB6_DESCRICAO FROM TABELA6 ORDER BY TB6_DESCRICAO";
  }

    if (opt_filtro.equals("Tabela7"))
  {
      query = "SELECT TB7_CODIGO, TB7_DESCRICAO FROM TABELA7 ORDER BY TB7_DESCRICAO";
  }

    if (opt_filtro.equals("Tabela8"))
  {
      query = "SELECT TB8_CODIGO, TB8_DESCRICAO FROM TABELA8 ORDER BY TB8_DESCRICAO";
  }

  if (opt_filtro.equals("Solicitante"))
  {
      query = "SELECT FUN_CODIGO, FUN_NOME FROM FUNCIONARIO WHERE fun_tipousuario = 'S' ORDER BY FUN_NOME";
  }
}
else
{
   opt_filtro = "Cargo";
     query = "SELECT CAR_CODIGO, CAR_NOME FROM CARGO ORDER BY CAR_NOME";
}

rs = conexao.executaConsulta(query, session.getId() + "RS1");

%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("SolicitaCAo")%></title>
<script language="JavaScript" src="scripts.js">
  </script>

<script language="JavaScript">
function Filtro()
         {
         window.open("../cadastro/index.jsp?opcombo="+frm.select2.value,"_parent");
    return true;
        }            
function envia(){
  frm.submit();
  return false; 
  }
</script>

<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../art/onenglish.gif','../art/onespanol.gif')">
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
               <jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="SO"/></jsp:include> 
               <%}else{%>
               <jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="SO"/></jsp:include> 
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
        if (request.getParameter("op") == null)
        {
                  oi = "../menu/menu.jsp?op="+"C";
        }
        else
        {
                  oi = "../menu/menu.jsp?op="+request.getParameter("op");
        }
        if (request.getParameter("opt") == null)
        {
                  oia = "../menu/menu1.jsp?opt="+"FU"; //out.println("nulo = " + oia);
        } 
        else
        {  
                  oia = "../menu/menu1.jsp?opt="+request.getParameter("opt"); //out.println("cheio = " + oia);
        }
    }else{
    if (request.getParameter("op") == null)
            {
                      oi = "/menu/menu.jsp?op="+"C";
            }
            else
            {
                      oi = "/menu/menu.jsp?op="+request.getParameter("op");
            }
            if (request.getParameter("opt") == null)
            {
                      oia = "/menu/menu1.jsp?opt="+"FU"; //out.println("nulo = " + oia);
            } 
            else
            {  
                      oia = "/menu/menu1.jsp?opt="+request.getParameter("opt"); //out.println("cheio = " + oia);
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
                <td class="trcurso"><%=trd.Traduz("CADASTRO")%></td>
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
                <td width="1" class="trhdiv"><img src="../art/bit.gif" width="1" height="1"></td>
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
                <td class="trontrk"><%=trd.Traduz("CADASTRO DE FUNCIONARIOS")%></td>
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
      <FORM name = "frm" action="result_filtro.jsp" method="POST">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                  <td height="12" width="42%">&nbsp;</td>
                  <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                  <td height="20" class="ctfontc" align="center" colspan="3">&nbsp; <%=trd.Traduz("LOCALIZAR POR FUNCIONARIO")%>: 
                    <input type="text" name="textfield">
                    &nbsp; <%=trd.Traduz("FILTRO")%>: <select name="select">
                      <option>Todos</option>
  <%
  if (rs.next())
  {
     do
     {
        %>
                    <option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
        <%
     }
     while (rs.next());
  }
  %>



                    </select>

          &nbsp; <%=trd.Traduz("OPCOES")%>: <select name="select2" class="form" onChange="return Filtro();">
          <option value ="<%=opt_filtro%>" ><%=trd.Traduz(opt_filtro)%></option>
                 <%if (prm.buscaparam("USE_CARGO").equals("S"))
                 {%>
          <%if (!(opt_filtro.equals("Cargo"))){%>
                      <option value ="Cargo" ><%=trd.Traduz("CARGO")%></option>
          <%}
         }%>    
                 <%if (prm.buscaparam("USE_DEPARTAMENTO").equals("S"))
                 {%>
          <%if (!(opt_filtro.equals("Departamento"))){%>
                      <option value ="Departamento" ><%=trd.Traduz("DEPARTAMENTO")%></option>
          <%}
         }%>
                 <%if (prm.buscaparam("USE_FILIAL").equals("S"))
                 {%>
          <%if (!(opt_filtro.equals("Filial"))){%>
                      <option value ="Filial" ><%=trd.Traduz("FILIAL")%></option>
          <%}
         }%>
                 <%if (prm.buscaparam("USE_TB1").equals("S"))
                 {%>
          <%if (!(opt_filtro.equals("Tabela1"))){%>
                      <option value ="Tabela1" ><%=trd.Traduz("TABELA1")%></option>
          <%}
         }%>
                 <%if (prm.buscaparam("USE_TB2").equals("S"))
                 {%>
          <%if (!(opt_filtro.equals("Tabela2"))){%>
                      <option value ="Tabela2" ><%=trd.Traduz("TABELA2")%></option>
          <%}
         }%>
                 <%if (prm.buscaparam("USE_TB3").equals("S"))
                 {%>
          <%if (!(opt_filtro.equals("Tabela3"))){%>
            <option value ="Tabela3" ><%=trd.Traduz("TABELA3")%></option>
          <%}
         }%>
                 <%if (prm.buscaparam("USE_TB4").equals("S"))
                 {%>
          <%if (!(opt_filtro.equals("Tabela4"))){%>
                      <option value ="Tabela4" ><%=trd.Traduz("TABELA4")%></option>
          <%}
         }%>
                 <%if (prm.buscaparam("USE_TB5").equals("S"))
                 {%>
          <%if (!(opt_filtro.equals("Tabela5"))){%>
                      <option value ="Tabela5" ><%=trd.Traduz("TABELA5")%></option>
          <%}
         }%>
                 <%if (prm.buscaparam("USE_TB6").equals("S"))
                 {%>
          <%if (!(opt_filtro.equals("Tabela6"))){%>
            <option value ="Tabela6" ><%=trd.Traduz("TABELA6")%></option>
          <%}
         }%>
                 <%if (prm.buscaparam("USE_TB7").equals("S"))
                 {%>
          <%if (!(opt_filtro.equals("Tabela7"))){%>
                      <option value ="Tabela7" ><%=trd.Traduz("TABELA7")%></option>
          <%}
         }%>
                 <%if (prm.buscaparam("USE_TB8").equals("S"))
                 {%>
          <%if (!(opt_filtro.equals("Tabela8"))){%>
            <option value ="Tabela8" ><%=trd.Traduz("TABELA8")%></option>
          <%}
         }%>
          <%if (!(opt_filtro.equals("Solicitante"))){%>
                      <option value ="Solicitante" ><%=trd.Traduz("SOLICITANTE")%></option>
          <%}%>
                    </select>                  
                    &nbsp; &nbsp; </td>
                </tr>
                <tr align="center" class="ctfontc">
                  <td align="right" width="42%">&nbsp;</td>
                  <td align="right" width="15%">&nbsp;</td>
                  <td align="left" width="43%">&nbsp;</td>
                </tr>
                <tr align="center" class="ctfontc"> 
                  <td align="right" width="42%"> 
                    <input type="checkbox" name="Check1" value="S">
                    <%=trd.Traduz("DEMITIDO")%> </td>
                  <td align="right" width="15%">&nbsp; </td>
                  <td align="left" width="43%"> 
                    <input type="checkbox" name="Check2" value="S">
                    <%=trd.Traduz("TERCEIRO")%> </td>
                </tr>
                <tr align="center"> 
                  <td class="ctfontc" colspan="3">&nbsp;</td>
                </tr>
                <tr align="center"> 
                  <td class="ctfontc" colspan="3"> 
                    <input type="button" onClick="return envia();"  value=<%=("\""+trd.Traduz("FILTRAR")+"\"")%> class="botcin" name="button">
                  </td>
              </tr>
              <tr> 
                <td height="12" colspan="3"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                <td class="ctvdiv" height="1" colspan="3"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                <td height="20" class="ctfontc" colspan="3">&nbsp;</td>
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
          <%if(ponto.equals("..")){  %>
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
Vector limpa = new Vector();
session.setAttribute("funcs", limpa);
//}catch (Exception e){out.println(e);}
%>

