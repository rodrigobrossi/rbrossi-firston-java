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
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");

String usu_tipo 	= (String)session.getAttribute("usu_tipo"); 
String usu_nome	= (String)session.getAttribute("usu_nome"); 
String usu_login 	= (String)session.getAttribute("usu_login"); 
Integer usu_fil 	= (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi 	= (Integer)session.getAttribute("usu_idi"); 
Integer usu_cod 	= (Integer)session.getAttribute("usu_cod"); 

String querySeleicionaChefe= "SELECT FUN_CODSOLIC FROM FUNCIONARIO WHERE FUN_CODIGO="+usu_cod;
String cod_chef="";

ResultSet rsSelecChef = conexao.executaConsulta(querySeleicionaChefe, session.getId()+"RS1");
if(rsSelecChef.next()){
	cod_chef=((rsSelecChef.getString(1)==null)?"N":rsSelecChef.getString(1));
}

if(rsSelecChef != null){
     rsSelecChef.close();
     conexao.finalizaConexao(session.getId()+"RS1");
}

%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("SolicitaCAo")%> - <%=trd.Traduz("APROVACAO DO PLANO")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<script language="JavaScript">
function seta(form1){
frm.valor.value=form1.value;
return true;
}

function confirma(){
va = frm.valor.value;

	if(va=="1"){
		window.open("aprovaplano.jsp?opt=AP&op=S","_parent");
	}
	else if(va=="2"){
		window.open("valida_aprovacao.jsp?func=<%=cod_chef%>&meu=S","_parent");
	}
	
}



</script>

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
		<%String menu = "", opMenu = "";
		if(ponto.equals("..")){
			if (request.getParameter("op") == null){
				menu = "../menu/menu.jsp?op=S";
				}
			else{
				menu = "../menu/menu.jsp?op=S";
				}
			if (request.getParameter("opt") == null){
				opMenu = "../menu/menu1.jsp?opt=AP&op=S";
				} 
			else{  
				opMenu = "../menu/menu1.jsp?opt=AP&op=S";
				}
		}else{
		if (request.getParameter("op") == null){
						menu = "/menu/menu.jsp?op=S";
						}
					else{
						menu = "/menu/menu.jsp?op=S";
						}
					if (request.getParameter("opt") == null){
						opMenu = "/menu/menu1.jsp?opt=AP&op=S";
						} 
					else{  
						opMenu = "/menu/menu1.jsp?opt=AP&op=S";
				}
		
		}		
		%>
		<jsp:include page="<%=menu%>" flush="true"></jsp:include>
        	</tr>
            </table>
          </td>
        </tr>
	        <jsp:include page="<%=opMenu%>" flush="true"></jsp:include>
      </table>
<form method="POST" name="frm">
	<table width="90%" border="0" cellspacing="0" cellpadding="0" align="center">
		<tr> 
			<td colspan="4"> 
				<div align="center"><font class="trontrk"><%=trd.Traduz("APROVACAO DO PLANO")%></font></div>
			</td>
		</tr>
		<tr> 
			<td colspan="4"> 
				<hr >
			</td>
		</tr>
		<tr> 
			<td colspan="4"> 
				&nbsp;
			</td>
		</tr>
		<tr> 
			<td colspan="4"> 
				&nbsp;
			</td>
		</tr>
		<tr class="ctfont">
			<td width="25%"> 
				&nbsp;
			</td>
			<td width="2%"><input type="radio" name="esc" value="1" checked onClick="return seta(this);">&nbsp;
			</td>
			<td width="48%" title=<%=("\""+trd.Traduz("SELECIONE UMA OPCAO")+"\"")%>>
			<%=trd.Traduz("APROVAR PLANO DE DESENVOLVIMENTO")%>
			</td>
			<td width="25%"> 
				&nbsp;
			</td>
		</tr>
		<tr> 
			<td colspan="4"> 
				&nbsp;
			</td>
		</tr>
		<%if(!cod_chef.equals("N")){%>
		<tr class="ctfont">
			<td width="25%"> 
				&nbsp;
			</td>		
			<td width="2%"><input type="radio" name="esc" value="2" onClick="return seta(this);">&nbsp;
			</td>
			<td width="48%"  title=<%=("\""+trd.Traduz("SELECIONE UMA OPCAO")+"\"")%>>
			<%=trd.Traduz("SOLICITAR APROVACAO DO PLANO DE DESENVOLVIMENTO")%>
			</td>
			<td width="25%"> 
				&nbsp;
			</td>
		</tr>
		<%}%>
		<tr> 
			<td colspan="4"> 
				&nbsp;
			</td>
		</tr>
		<tr> 
			<td colspan="4"> 
				&nbsp;
			</td>
		</tr>
		<tr> 
			<td colspan="4"> 
				<hr >
			</td>
		</tr>
		<tr> 
			<td colspan="4"> 
				&nbsp;
			</td>
		</tr>
		<tr> 
			<td colspan="4"> 
				<div align="center"> 
					<input type="button" class="botcin" name="confirmar" value=<%=("\""+trd.Traduz("CONFIRMAR")+"\"")%> onClick="return confirma();">
				</div>
      			</td>
		</tr>
	</table>
	<input type="hidden" name="valor" value="1">
    </form>
    </td>
  </tr>
  <tr> 
    <td align="right" height="30" class="difundo"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td> 
          <%	if(ponto.equals("..")){%>
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
