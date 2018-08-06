<%
//Limpa memoria cache    
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")) {
  response.setHeader("Cache-Control", "no-cache");
}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.util.*, java.text.*"%>

<% 
//Inicializa variAveis
String query = "", func = "", querypa = "", pla_ant ="";
String filtroc = "T";

int i = 0;

//try {

//Recupera dados
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");

String usu_tipo   = (String) session.getAttribute("usu_tipo"); 
String usu_nome   = (String) session.getAttribute("usu_nome"); 
String usu_login  = (String) session.getAttribute("usu_login");
Integer usu_cod   = (Integer)session.getAttribute("usu_cod");
Integer usu_fil   = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi   = (Integer)session.getAttribute("usu_idi");
Integer usu_plano = (Integer)session.getAttribute("usu_plano");

ResultSet rs = null, rspa = null, rsA = null, rsN = null;

if (request.getParameter("cbocurso") != null)
  filtroc = request.getParameter("cbocurso");

if (!(request.getParameter("fun_codigo") == null)){
 func = request.getParameter("fun_codigo");
}
else
{
 func="0";
}

querypa = "SELECT PLA_ANTERIOR FROM PLANO WHERE PLA_CODIGO = " + usu_plano;
rspa = conexao.executaConsulta(querypa,session.getId()+"RS1");
if (rspa.next())
{
  pla_ant = rspa.getString(1);
}

if(rspa != null){
   rspa.close();
   conexao.finalizaConexao(session.getId()+"RS1");
}

//Limpa o vetor parametro 
Vector funcvet = new Vector();
session.setAttribute("funcs", funcvet);
%>

<script language="JavaScript">
function filtra()
{
 frm.action ="reprogramacao.jsp"
 frm.submit();
 return false; 
}

function reprograma()
{

		frm.action = "solic_extra.jsp";
		frm.submit();
		return false;
}
</script>
					
<%					
String queryA = "SELECT PLA_ANTERIOR FROM PLANO WHERE PLA_CODIGO = "+usu_plano;

rsA = conexao.executaConsulta(queryA,session.getId()+"RS2");
if (rsA.next()){
};

String queryN = "SELECT JUS_CODIGO FROM TREINAMENTO WHERE JUS_CODIGO IS NOT NULL "+
		"AND TEF_REPROGRAMAR = 'S' AND PLA_CODIGO = "+rsA.getString(1)+
		" AND FUN_CODIGO = " +func;

rsN = conexao.executaConsulta(queryN,session.getId()+"RS3");
if(rsN.next())
{%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("SolicitaCAo")%> - <%=trd.Traduz("ReprogramaCAo")%></title>
<script language="JavaScript" src="scripts.js"></script>
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
	      String ponto = (String)session.getAttribute("barra");
	      %>
              <%if(ponto.equals("..")){%>
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
                  oi = "../menu/menu.jsp?op="+"S";
				}
				else
				{
                  oi = "../menu/menu.jsp?op="+request.getParameter("op");
				}
				if (request.getParameter("opt") == null)
				{
                  oia = "../menu/menu1.jsp?opt="+"S&op=S";
				} 
				else
				{  
                  oia = "../menu/menu1.jsp?opt="+request.getParameter("opt")+"&op=S";
				}
			}else{
			if (request.getParameter("op") == null)
							{
			                  oi = "/menu/menu.jsp?op="+"S";
							}
							else
							{
			                  oi = "/menu/menu.jsp?op="+request.getParameter("op");
							}
							if (request.getParameter("opt") == null)
							{
			                  oia = "/menu/menu1.jsp?opt="+"S&op=S";
							} 
							else
							{  
			                  oia = "/menu/menu1.jsp?opt="+request.getParameter("opt")+"&op=S";
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
            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
                <td class="trontrk" width="297" align="center"><%=trd.Traduz("REPROGRAMACAO")%></td>
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
    <FORM name="frm">
        <td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
                </tr>
              <tr> 
                  <td height="20" class="ctfontc" align="center">&nbsp; <%=trd.Traduz("Curso")%>: 
                    <select name="cbocurso">
                        <option value="T">Todos
                        <%
                          query = "SELECT CUR_CODIGO, CUR_NOME FROM CURSO ORDER BY CUR_NOME";
                          rs = conexao.executaConsulta(query,session.getId()+"RS4");
                          if (rs.next())
                          {
                          	do
                          	{
                          		if(filtroc.equals(rs.getString(1)))
                          		{
                          			%>
                          			<option selected value="<%=rs.getInt(1)%>"><%=rs.getString(2)%>
                          			<%
                          		}
                          		else
                          		{
                          			%>
                          			<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%>
                          			<%
                          		}
                          		
                            	}while (rs.next());
                          }
                          if(rs != null){
                              rs.close();
                              conexao.finalizaConexao(session.getId()+"RS4");
                          }                          
                        %>
                    </select> 
                    &nbsp; &nbsp; 
                    <input type="button" onClick="return filtra();"  value=<%=("\""+trd.Traduz("Filtrar")+"\"")%> class="botcin" name="button1"> 
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
                    <table border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                        <td> 
                          <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                            <tr> 
                              <td onMouseOver="this.className='ctonlnk2';" onClick = "return reprograma();" width="127" height="22" align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("REPROGRAMAR")%></a></td>
                            </tr>
                          </table>
                        </td>
                        <td width="10">&nbsp;</td>
                      </tr>
                      <tr>
                      <td>&nbsp;
                      
                      </td>
                      </tr>
                    </table>
                    </center>
		    <center>
                      <table border="0" cellspacing="1" cellpadding="2" width="80%">
                        <tr> 
                          <td width="4%" align="center" height="6">&nbsp;</td>                          
                          <td width="31%" class="celtittab" height="6"> 
                            <div align="center"><%=trd.Traduz("Curso")%></div>
                          </td>
                          <td width="31%" class="celtittab" height="6"> 
                            <div align="center"><%=trd.Traduz("Justificativa")%></div>
                          </td>
                          <td width="13%" class="celtittab" height="6"> 
                            <div align="center"><%=trd.Traduz("PrevisAo")%></div>
                          </td>
                        </tr>
                      <%
			String par = "";
			if (usu_tipo.equals("F"))
			{
				par = "";
			}
			else if (usu_tipo.equals("P"))
   			{
   				par = " AND F.FIL_CODIGO = " + usu_fil + " "; 
   			}
			else if (usu_tipo.equals("G"))
	        {
                par = " AND FUNCIONARIO.FIL_CODIGO = " + usu_fil + " "; 
            }
 			else if (usu_tipo.equals("S"))
  			{
				par = " AND F.FIL_CODIGO = " + usu_fil + " AND F.FUN_CODSOLIC = " + usu_cod + " "; 
			}
                      
                         query = "SELECT T.TEF_CODIGO, F.FUN_NOME, C.CUR_NOME, J.JUS_NOME, "+
								 "Q.QBR_NOME, C.CUR_CODIGO " +
                                 "FROM FUNCIONARIO F, TREINAMENTO T, CURSO C, QUEBRA Q, JUSTIFICATIVA J " +
                                 "WHERE F.FUN_CODIGO = T.FUN_CODIGO "+
								 "AND T.FUN_CODIGO = " + func + " "+
								 "AND C.CUR_CODIGO = T.CUR_CODIGO "+
                                 "AND T.TUR_CODIGO_REAL IS NULL " +
                                 "AND Q.QBR_CODIGO = T.QBR_CODIGO " +
                                 "AND T.JUS_CODIGO IS NOT NULL " +
                                 "AND T.JUS_CODIGO = J.JUS_CODIGO  " +
                                 "AND PLA_CODIGO = " + pla_ant + " " +par+ " " +
                                 "AND T.TEF_REPROGRAMAR = 'S' ";

                         //filtros
                          if (!(filtroc.equals("T")))
                             query = query + "AND T.CUR_CODIGO = " + filtroc + " ";
                          query = query + "ORDER BY C.CUR_NOME";
                          
                          rs = conexao.executaConsulta(query,session.getId()+"RS5");

                          boolean check = false;
  

                          if (rs.next())
                          {
                            do
                          {
                          i = i + 1;
                      %>
                        <tr class="celnortab"> 
                          <td width="4%" align="center">
						  <%if (check == false){
						  check = true;%>
                            <input type="radio" name="fun_codigo" checked value="<%=rs.getString(1)%>">
						  <%}else{%>
                            <input type="radio" name="fun_codigo" value="<%=rs.getString(1)%>">
						  <%}%>
                          </td>                          
                          
                      <td width="31%"><%=rs.getString(3)%></td>
                          <td width="31%"><%=rs.getString(4)%></td>
                          <td width="13%"> 
                            <div align="center"><%=rs.getString(5)%></div>
                          </td>
                          <input type="hidden" name="selectcur" value="<%=rs.getString(6)%>">
                        </tr>
                            <%
                          }
                            while (rs.next());
                          }

                          if(rs != null){
                              rs.close();
                              conexao.finalizaConexao(session.getId()+"RS5");
                          }
                          //out.println("query = " + query);
                        %>
                        </tr>
                      </table>
                    </center>
                    <br>
                    &nbsp; </td>
                </tr>
              </table>
          </td>
          <input type="hidden" name="extra" value="N">
          <input type="hidden" name="contador" value="<%=i%>">
          <input type="hidden" name="origem" value="reprogramacao">
          <input type="hidden" name="operacao" value="I">
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
<!--<script language="JavaScript1.2" src="HM_Loader.js" type='text/JavaScript'></script>-->
</body>
</html>
<%



} else {
%>
<script language="JavaScript">
alert(<%=("\""+trd.Traduz("NAO EXISTEM TREINAMENTOS A SEREM REPROGRAMADOS")+"\"")%>);
window.open("result_solics.jsp?fun_codigo=<%=func%>","_self");
</script>
<%
}

if(rsA != null){
   rsA.close();
   conexao.finalizaConexao(session.getId()+"RS2");
}

if(rsN != null){
   rsN.close();
   conexao.finalizaConexao(session.getId()+"RS3");
}

%>