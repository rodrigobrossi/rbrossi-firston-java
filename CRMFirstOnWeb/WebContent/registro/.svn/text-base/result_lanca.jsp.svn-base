<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1"))
    response.setHeader("Cache-Control", "no-cache");
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*, java.lang.Math.*, java.util.*"%>

<%! public String convHora(float minutos)
{	
	Float ft = new Float(minutos);
	int min = ft.intValue();
	String total = "";
	float result;
	int inteiro = 0, decimal = 0;
	result = min / 60;
	Float ft2 = new Float(result);
	inteiro = ft2.intValue();
	decimal = min % 60;
	total = inteiro + ":" + decimal;
	return total;
}
%>

<%! 
public String ReaistoStr(float valor, String moeda){
	DecimalFormat dcf = new DecimalFormat("0.00");
	dcf.setMaximumFractionDigits(2);
	String strReais = dcf.format(valor);
	return moeda + strReais;
}
%>

<%! public String durhora(float valor){
	int ho = 0;
	Float h;
	h = new Float(valor);;
	ho = h.intValue();
	ho = ho / 60;
	String hora = "";
	hora = hora.valueOf(ho);
	return hora;
}
%>

<%! public String durmin(float valor){
	int mi =0;
	Float m;
	m = new Float(valor);
	mi = m.intValue();
	mi = mi % 60;
	String min = "";
	if(mi < 10){
		min = "0"+min.valueOf(mi);
	}
	else{
		min = min.valueOf(mi);
	}
	return min;
}
%>

<%
request.getSession();
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 

//variaveis
String fun_codigo = (request.getParameter("fun_codigo")==null)?"":request.getParameter("fun_codigo");
SimpleDateFormat data1 = new SimpleDateFormat("dd/MM/yyyy");

String moeda = prm.buscaparam("MOEDA");
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Registro")%> - <%=trd.Traduz("LanCamentos Anteriores")%></title>
<script language="JavaScript" src="scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','solicitacao/../art/onenglish.gif','solicitacao/../art/onespanol.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr> 
    <td valign="top" align="center"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="59" class="hcfundo"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
<%             String ponto = (String)session.getAttribute("barra");
      	       if(ponto.equals("..")){%>
               <jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="RG"/></jsp:include> 
               <%}else{%>
               <jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="RG"/></jsp:include> 
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
              <%if(ponto.equals("..")){%>
		<jsp:include page="../menu/menu.jsp" flush="true">
			<jsp:param value="op" name="R"/>
		</jsp:include>
		<%}else{%>
		<jsp:include page="/menu/menu.jsp" flush="true">
			<jsp:param value="op" name="R"/>
		</jsp:include>
		<%}%>
              </tr>
            </table>
          </td>
        </tr>
	   <jsp:include page="/menu/menu1.jsp" flush="true">
	   	<jsp:param value="opt" name="LA"/>
	   </jsp:include>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="20">&nbsp;</td>
          <td width="100%" align="center"> 
            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
                <td class="trontrk" align="center"><%=trd.Traduz("LanCamentos Anteriores")%></td>
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
      </table><br>
      <table border="0" cellspacing="1" cellpadding="2" width="95%">
        <tr>
          <td colspan="100%"><a href="14_lancamentosanteriores.jsp" class="lnk"><%=trd.Traduz("FuncionArio")%>:&nbsp;<%=request.getParameter("fun_nome")%></a></td> 
        </tr>
        <tr><td>&nbsp;</td></tr>
        <%
		String query =  "SELECT C.CUR_NOME, E.EMP_NOME, T.TEF_INICIO, T.TEF_FIM, T.TEF_CUSTO, T.TEF_DURACAO, T.TEF_CODIGO "+
						"FROM TREINAMENTO T, CURSO C, EMPRESA E "+
						"WHERE T.CUR_CODIGO = C.CUR_CODIGO "+
						"AND E.EMP_CODIGO = T.EMP_CODIGO "+
						"AND TTR_CODIGO = 5 "+
						"AND T.FUN_CODIGO = "+fun_codigo;	
		ResultSet rs = conexao.executaConsulta(query,session.getId()+"RS1");
		if(rs.next()) {
        %>
        <tr> 
          <td width="15%" class="celtittab"><%=trd.Traduz("Curso")%></td>
          <td width="15%" class="celtittab" align="center"><%=trd.Traduz("Entidade")%></td>
          <td width="15%" class="celtittab" align="center"><%=trd.Traduz("Data Inicio")%></td>
          <td width="15%" class="celtittab" align="center"><%=trd.Traduz("Data Final")%></td>
          <td width="15%" class="celtittab" align="center"><%=trd.Traduz("Custo")%></td>
          <td width="15%" class="celtittab" align="center"><%=trd.Traduz("Duracao")%></td>
          <td width="10%">&nbsp;</td>
        </tr>
		<%
            do {
            	%>
            	<tr class="celnortab">     
				<td width="30%"><%=rs.getString(1)%></td>
				<td width="10%" align="center"><%=rs.getString(2)%></td>
				<%
				String dataf = new String();
				if (!(rs.getString(3) == null)){
					java.util.Date diai = rs.getDate(3);
                    dataf = data1.format(diai);
				}
				if (!(rs.getString(3) == null)){
					%>
                    <td width="10%" align="center"><%=dataf%></td>
					<%
				}
				else{
					%>
                    <td width="10%"></td>
					<%
				}
				dataf = "";
				if (!(rs.getString(4) == null)){
                    java.util.Date diai = rs.getDate(4);
					dataf = data1.format(diai);
				}				
				if (!(rs.getString(4) == null)){
					%>
                    <td width="12%" align="center"><%=dataf%></td>
					<%
				}
				else {
					%>
                    <td width="12%"></td>
					<%
				}
				%>
				<td width="10%" align="center"><%=ReaistoStr(rs.getFloat(5),moeda)%></td>
				<td width="10%" align="center"><%=convHora(rs.getFloat(6))%></td>
              </tr>
				<%
			}while(rs.next());
		}
		else {
			%>
              <tr class="celtittab">
                <td colspan="6" align="CENTER"><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...</td>
              </tr>
			<%
		}
		if(rs != null){
                    rs.close();
                    conexao.finalizaConexao(session.getId()+"RS1");
                }
	%>
      </table>
    </tr>
    <tr><td>&nbsp;</td></tr>
    <tr> 
      <td align="right" height="30" class="difundo"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td> 
<%            if(ponto.equals("..")){%>
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
