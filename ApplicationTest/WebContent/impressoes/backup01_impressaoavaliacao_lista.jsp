<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
	response.setHeader("Cache-Control", "no-cache");
}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.lang.Math.*, java.util.*, java.text.*"%>

<%
//try{

	String query = "", campo = "", query_grid = "", rdo_tipo = "", solic = "", depart = "", func = "", curso = "", dt_inicio = "", dt_fim = "";
	ResultSet rs = null, rsgrid = null;
	int ava_codigo = 0, que_codigo = 0;

	if(request.getParameter("rdo_tipo") != null)
		rdo_tipo = request.getParameter("rdo_tipo");
	if(request.getParameter("sel_avaliacao") != null)
		ava_codigo = Integer.parseInt(request.getParameter("sel_avaliacao"));
	if(request.getParameter("sel_questionario") != null)
		que_codigo = Integer.parseInt(request.getParameter("sel_questionario"));
	if(request.getParameter("cbo_solic") != null)
		solic = request.getParameter("cbo_solic");
	if(request.getParameter("cbo_departamento") != null)
		depart = request.getParameter("cbo_departamento");
	if(request.getParameter("cbo_func") != null)
		func = request.getParameter("cbo_func");
	if(request.getParameter("cbo_curso") != null)
		curso = request.getParameter("cbo_curso");
	if(request.getParameter("text_datainicio") != null)
		dt_inicio = request.getParameter("text_datainicio");
	if(request.getParameter("text_datafinal") != null)
		dt_fim = request.getParameter("text_datafinal");

	if(request.getParameter("rdo_tipo").equals("A")) {
		%>
		<script language = "JavaScript">													                     window.open("02_impressaoavaliacao.jsp?sel_avaliacao=<%=ava_codigo%>&sel_questionario=<%=que_codigo%>&rdo_tipo=<%=rdo_tipo%>&cbo_solic=<%=solic%>&cbo_departamento=<%=depart%>&cbo_func=<%=func%>&cbo_curso=<%=curso%>&text_datainicio=<%=dt_inicio%>&text_datafinal=<%=dt_fim%>", "_self");		
		</script>
		<%
	}
	
	else if(request.getParameter("rdo_tipo").equals("R")) {

request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");


String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_codigo = (Integer)session.getAttribute("usu_codigo");
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 

java.util.Date dt_atual = new java.util.Date();
SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");

String str_dt_atual = formato.format(dt_atual);

query_grid = "SELECT DISTINCT F.FUN_CODIGO, F.FUN_NOME, AVD.PRO_CODIGO, P.PRO_ENVLAUDO, P.PRO_FIM, "+
			 "Q.AVA_CODIGO, A.AVA_DESCRICAO, AVD.AVD_STATUS, Q.QUE_NOME, P.PRO_CODIGO, T.CUR_CODIGO, "+
			 "C.CUR_NOME "+
			 "FROM AVALIADO AVD, PROCESSO P, QUESTIONARIO Q, AVALIACAO A, FUNCIONARIO F, TURMA T, CURSO C, DEPTO D "+
			 "WHERE AVD.PRO_CODIGO = P.PRO_CODIGO "+
			 "AND F.FUN_CODIGO = AVD.FUN_CODIGO "+
			 "AND Q.QUE_CODIGO = P.QUE_CODIGO "+	
			 "AND A.AVA_CODIGO = Q.AVA_CODIGO "+
			 "AND A.AVA_CODIGO = "+ava_codigo+" "+
			 "AND Q.QUE_CODIGO = "+que_codigo+" "+
			 "AND P.TUR_CODIGO = T.TUR_CODIGO "+
			 "AND T.CUR_CODIGO = C.CUR_CODIGO "+
			 "AND (AVD.AVD_STATUS IS NULL OR AVD.AVD_STATUS = 'N')";
        
	if (!usu_tipo.equals("F"))
		query_grid = " AND F.FUN_CODIGO = " +usu_codigo.toString();

	//Filtro por Solicitante
	if(!request.getParameter("cbo_solic").equals(""))
	{
		query_grid = query_grid + " AND F.FUN_CODIGO = "+request.getParameter("cbo_solic")+" ";
	}

	//Filtro por Departamento
	if(!request.getParameter("cbo_departamento").equals(""))
	{
		query_grid = query_grid + " AND D.DEP_CODIGO = F.DEP_CODIGO "+
								  "AND D.DEP_CODIGO = "+request.getParameter("cbo_departamento")+" ";
	}		

	//Filtro por FuncionArio
	if(!request.getParameter("cbo_func").equals(""))
	{
		query_grid = query_grid + " AND F.FUN_CODIGO = "+request.getParameter("cbo_func")+" ";
	}		

	//Filtro por Curso
	if(!request.getParameter("cbo_curso").equals(""))
	{
		query_grid = query_grid + " AND C.CUR_CODIGO = "+request.getParameter("cbo_curso")+" ";
	}
							
	//Filtro por Data Inicial
	if(!request.getParameter("text_datainicio").equals(""))
	{
		query_grid = query_grid + " AND P.PRO_INICIO >= CONVERT(datetime, '"+request.getParameter("text_datainicio")+"', 103) ";
	}
							
	//Filtro por Data Final
	if(!request.getParameter("text_datafinal").equals(""))
	{
		query_grid = query_grid + " AND P.PRO_FIM <= CONVERT(datetime, '"+request.getParameter("text_datafinal")+"', 103) ";
	}	
                      
	query_grid = query_grid + " ORDER BY F.FUN_NOME";

	rsgrid = conexao.executaConsulta(query_grid,session.getId());
	%>

	<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
	<head>
	<title>FirstOn - <%=trd.Traduz("RELATORIOS")%> - <%=trd.Traduz("IMPRESSOES DAS AVALIACOES")%></title>
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
			        if(ponto.equals("..")) { %>
		               <jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="IM"/></jsp:include> 
				    <%
					}
					else { %>
		               <jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="IM"/></jsp:include> 
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
<%              String oi = "", oia = "";
		if(ponto.equals("..")){	  
				if (request.getParameter("op") == null)
				{
                  oi = "../menu/menu.jsp?op="+"I";
				}
				else
				{
                  oi = "../menu/menu.jsp?op="+request.getParameter("op");
				}
				if (request.getParameter("opt") == null)
				{
                  oia = "../menu/menu1.jsp?opt="+"IDA";
				} 
				else
				{  
                  oia = "../menu/menu1.jsp?opt="+request.getParameter("opt");
				}
		}else{
		
		if (request.getParameter("op") == null)
						{
		                  oi = "/menu/menu.jsp?op="+"I";
						}
						else
						{
		                  oi = "/menu/menu.jsp?op="+request.getParameter("op");
						}
						if (request.getParameter("opt") == null)
						{
		                  oia = "/menu/menu1.jsp?opt="+"IDA";
						} 
						else
						{  
		                  oia = "/menu/menu1.jsp?opt="+request.getParameter("opt");
				}
		}%>
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
		            <td class="trontrk" align="center"><%=trd.Traduz("IMPRESSOES DAS AVALIACOES")%></td>
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
			  <FORM name = "frm" method="POST">
	     <tr> 
          <td width="20" valign="top"></td>
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
                  <td align="center">&nbsp;<br>
                   <p>
                    <table border="0" cellspacing="1" cellpadding="2" width="98%">
                      <tr class="celtittab"> 
                       	<td width="30%"><%=trd.Traduz("FUNCIONARIO")%></td>
                       	<td width="15%" align="center"><%=trd.Traduz("CURSO")%></td>
                        <td width="15%" align="center"><%=trd.Traduz("AVALIACAO")%></td>
                        <td width="20%" align="center"><%=trd.Traduz("QUESTIONARIO")%></td>
                        <td width="10%" align="center"><%=trd.Traduz("DATA ENVIO")%></td>
                        <td width="10%" align="center"><%=trd.Traduz("DATA VENCIMENTO")%></td>
                      </tr>
                      <%		     
					      java.util.Date hoje = new java.util.Date();
						  String inicio = "", fim = "";
                           
			              if(rsgrid.next()) {
							  do {
								  java.util.Date data1 = rsgrid.getDate(4);
								  java.util.Date data2 = rsgrid.getDate(5);
								  inicio = formato.format(data1);
								  fim    = formato.format(data2);
					  %>
               			<tr class="celnortab">
						  <td width="30%">
							<a href="02_impressaoavaliacao.jsp?sel_avaliacao=<%=ava_codigo%>&sel_questionario=<%=que_codigo%>&rdo_tipo=<%=rdo_tipo%>&func=<%=rsgrid.getString(2)%>&curso=<%=rsgrid.getString(12)%>&avaliacao=<%=rsgrid.getString(7)%>&questionario=<%=rsgrid.getString(9)%>&pro_codigo=<%=rsgrid.getString(10)%>" class="lnk"><%=rsgrid.getString(2)%></a>
                      	  </td>
		             	  <td width="15%"><%=rsgrid.getString(12)%></td>	
				          <td width="15%"><%=rsgrid.getString(7)%></td>
						  <td width="20%"><%=rsgrid.getString(9)%></td>
		                  <td width="10%"><%=inicio%></td>
				          <td width="10%"><%=fim%></td>
                        </tr>
                    <%
				}while(rsgrid.next());
			}
			else{
            	%>
              	<tr class="celnortab">
                <td colspan="6"><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...</td>
                </tr>
                <%
            }
			%>	
                      
                    </table>
                    <br>&nbsp;
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

if(rsgrid!=null){
rsgrid.close();
conexao.finalizaConexao(session.getId());
}



}

//} catch(Exception e){
//	out.println("Erro: "+e);
//}
%>