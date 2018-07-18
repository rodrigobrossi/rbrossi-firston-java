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
//try{

request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");

String usu_tipo   = (String) session.getAttribute("usu_tipo"); 
String usu_nome   = (String) session.getAttribute("usu_nome"); 
String usu_login  = (String) session.getAttribute("usu_login"); 
Integer usu_fil   = (Integer)session.getAttribute("usu_fil");
Integer usu_cod   = (Integer)session.getAttribute("usu_cod");
Integer usu_idi   = (Integer)session.getAttribute("usu_idi");
Integer usu_plano = (Integer)session.getAttribute("usu_plano");

String filtroc = "T";
String filtroq = "T";
String cor = "";
String filtro = "";
String loc = "";

boolean bloquear = false;

String reload = "";
if(request.getParameter("reload") != null)
	reload = request.getParameter("reload");

if (request.getParameter("select") != null){
       filtroc = request.getParameter("select");
}
if (request.getParameter("select2") != null){
       filtroq = request.getParameter("select2");
}
if (request.getParameter("filtro") != null && !request.getParameter("filtro").equals("")){
       
       loc = request.getParameter("filtro");
       filtro = " AND F.FUN_NOME >= '"+loc+"' ";
}


//Checagem de demitidos e terceiros
String fun_filtro = "";

if(request.getParameter("check_d") != null)//demitido
	fun_filtro = " AND F.FUN_DEMITIDO = 'S' ";

if((request.getParameter("check_a") != null) || (reload.equals("")))//ativo
	fun_filtro = " AND F.FUN_TERCEIRO = 'N' AND FUN_DEMITIDO = 'N' ";

if(request.getParameter("check_t") != null)//terceiro
	fun_filtro = " AND F.FUN_TERCEIRO = 'S' ";

if((request.getParameter("check_d") != null) && (request.getParameter("check_a") != null))//demitido e ativo
	fun_filtro = " AND ((F.FUN_DEMITIDO = 'S') OR (F.FUN_TERCEIRO = 'N' AND F.FUN_DEMITIDO = 'N')) ";

if((request.getParameter("check_d") != null) && (request.getParameter("check_t") != null))//demitido e terceiro
	fun_filtro = " AND ((F.FUN_DEMITIDO = 'S') OR (F.FUN_TERCEIRO = 'S')) ";

if((request.getParameter("check_a") != null) && (request.getParameter("check_t") != null))//ativo e terceiro
	fun_filtro = " AND ((F.FUN_TERCEIRO = 'N' AND F.FUN_DEMITIDO = 'N') OR (F.FUN_TERCEIRO = 'S')) ";

if((request.getParameter("check_d") != null) && (request.getParameter("check_a") != null) && (request.getParameter("check_t") != null))//demitido, ativo e terceiro
	fun_filtro = " AND ((F.FUN_DEMITIDO = 'S') OR (F.FUN_TERCEIRO = 'N' AND F.FUN_DEMITIDO = 'N') OR (F.FUN_TERCEIRO = 'S')) ";
	

//VariAveis para as Queryes
String query = "";
ResultSet rs = null;

//Contador
int i = 0;

//Verifica Bloqueio de Funcionalidades
query = "SELECT PLA_JUSTIFICATIVA FROM PLANO WHERE PLA_CODIGO = "+usu_plano;
rs = conexao.executaConsulta(query, session.getId()+"RS1");
if (rs.next()) {
	if(rs.getString(1) != null) {
		if(rs.getString(1).equals("N"))
			bloquear = true;
	}
}

if(rs != null){
    rs.close();
    conexao.finalizaConexao(session.getId()+"RS1");
}

%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("SolicitaCAo")%> - <%=trd.Traduz("Justificativa")%></title>
<script language="JavaScript" src="scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<script language="JavaScript">
function filtra()
{
	if((frm.check_a.checked == false)&&(frm.check_d.checked == false)&&(frm.check_t.checked == false))
	{
		alert(<%=("\""+trd.Traduz("SELECIONE PELO MENOS UM TIPO DE FUNCIONARIO")+"\"")%>);
		return false;
	}
	else
	{
		frm.action ="justificativa.jsp"
		frm.reload.value = "1";
		frm.submit();
		return false; 
	}
}

function justifica()
{
	var checado = 0;
	for(i=1;i<=frm.cont.value;i++)
	{
		if(eval("frm.checkbox"+i+".checked") == true)
		{
			checado = checado + 1;
		}
	}	
	
	if(checado == 0)
	{
		alert(<%=("\""+trd.Traduz("NENHUM ITEM SELECIONADO")+"\"")%>);
		return false;
	}
	else
	{
		frm.action = "escolha_justificativa.jsp";
		frm.submit();
		return false;
	}
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
	aux = campo.value;
	tam = aux.length;
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
                  oi = "../menu/menu.jsp?op="+"S";
				}
				else
				{
                  oi = "../menu/menu.jsp?op="+request.getParameter("op");
				}
				if (request.getParameter("opt") == null)
				{
                  oia = "../menu/menu1.jsp?opt="+"J&op=S";
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
				                  oia = "/menu/menu1.jsp?opt="+"J&op=S";
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
                <td class="trontrk" width="297" align="center"><%=trd.Traduz("JUSTIFICATIVA")%></td>
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
              	  <td height="20" class="ctfontc" align="center">&nbsp; <%=trd.Traduz("LOCALIZAR POR FUNCIONARIO")%>: 
              	    <input type="text" name="filtro" value="<%=loc%>"  onBlur="aspa2(this)" onKeyUp="aspa(this)">
              	  </td>
              	  </tr>
              <tr> 
                <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              	  
              	  <tr>
                  <td height="20" class="ctfontc" align="center">&nbsp; <%=trd.Traduz("CURSOS")%>: 
                    <select name="select">
                      <option value = "T">Todos</option>
                        <%
                          query = "SELECT CUR_CODIGO, CUR_NOME FROM CURSO ORDER BY CUR_NOME";
                          rs = conexao.executaConsulta(query, session.getId()+"RS2");
                          if (rs.next()){
                          	do{
                          		if(filtroc.equals(rs.getString(1))){
                          			%>
                          			<option selected value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
                          			<%
                          		}
                          		else{
                          			%>
                          			<option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
                          			<%
    	                      		}
                          	}
                          	while (rs.next());
                          }
                          if(rs != null){
                              rs.close();
                              conexao.finalizaConexao(session.getId()+"RS2");
                          }
                        %>
                    </select>
                    &nbsp; &nbsp; &nbsp; &nbsp; <%=trd.Traduz("PREVISAO")%>: 
                    <select name="select2">
                      <option value = "T">Todos</option>
                      <%
                          query = "SELECT DISTINCT Q.QBR_CODIGO, Q.QBR_NOME FROM PLANO P, QUEBRA Q WHERE P.PLA_CODIGO = "+usu_plano+" AND Q.PER_CODIGO = P.PER_CODIGO ORDER BY Q.QBR_CODIGO";
                          rs = conexao.executaConsulta(query,session.getId()+"RS3");
                          if (rs.next())
                          {
                          	do
                          	{
                          		if(filtroq.equals(rs.getString(1)))
                          		{
                          			%>
                          			<option selected value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
                          			<%
                          		}
                          		else
                          		{
                          			%>
                          			<option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
                          			<%
                          		}
                          	}while (rs.next());
                          }
                          if(rs != null){
                              rs.close();
                              conexao.finalizaConexao(session.getId()+"RS3");
                          }
                        %>
                    </select>
                    <br>
                    <%
                    if((request.getParameter("check_a") != null) || (reload.equals("")))
                    {
                    	%>
                    	<input checked type="checkbox" name="check_a"><%=trd.Traduz("VISUALIZAR ATIVO")%>&nbsp;&nbsp;&nbsp;
                    	<%
                    }
                    else
                    {
                    	%>
                    	<input type="checkbox" name="check_a"><%=trd.Traduz("VISUALIZAR ATIVO")%>&nbsp;&nbsp;&nbsp;
                    	<%
                    }
                    if(request.getParameter("check_t") == null)
                    {
                    	%>
                    	<input type="checkbox" name="check_t"><%=trd.Traduz("VISUALIZAR TERCEIRO")%>&nbsp;&nbsp;&nbsp;
                    	<%
                    }
                    else
                    {
                    	%>
                    	<input checked type="checkbox" name="check_t"><%=trd.Traduz("VISUALIZAR TERCEIRO")%>&nbsp;&nbsp;&nbsp;
                    	<%
                    }
                    if(request.getParameter("check_d") == null)
                    {
                    	%>
                    	<input type="checkbox" name="check_d"><%=trd.Traduz("VISUALIZAR DEMITIDO")%>
                    	<%
                    }
                    else
                    {
                    	%>
                    	<input checked type="checkbox" name="check_d"><%=trd.Traduz("VISUALIZAR DEMITIDO")%>
                    	<%
                    }
                    %>
                    <br><br>
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
	        <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
	      </tr>
              <tr align="center">
                <td class="ctfontc" valign="middle"><font size="1">
                ** - <%=trd.Traduz("DEMITIDO")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                * - <%=trd.Traduz("TERCEIRO")%>
                </font>
                </td>
              </tr>
              <tr> 
                <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                <td class="ctvdiv" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
			  
			  <% if(bloquear == false) { %>
				  <tr>
					<td align="center"><br>
				      <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
				        <tr> 
					      <td onMouseOver="this.className='ctonlnk2';" OnClick="return justifica();" width="150" height="22" align=center class="botver">
		  		 		 	<a href="#" class="txbotver">
			 				  <%=trd.Traduz("JUSTIFICAR")%>
			 				</a>
						  </td>
			   			</tr>
			  		  </table>
		 		    </td>
	  	    	  </tr>
	  		<% }//if(bloquear == false) %>

              <tr> 
                  <td align="center">&nbsp;<br>
                    <table border="0" cellspacing="1" cellpadding="2" width="98%">
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
                      
                          query = "SELECT DISTINCT T.TEF_CODIGO, F.FUN_CHAPA, F.FUN_NOME, C.CUR_NOME, Q.QBR_NOME, T.JUS_CODIGO, F.FUN_DEMITIDO, "+
                          	  "F.FUN_TERCEIRO, CA.CAR_NOME, FI.FIL_NOME "+
                                  "FROM FUNCIONARIO F, TREINAMENTO T, CURSO C, QUEBRA Q, CARGO CA, FILIAL FI " +
                                  "WHERE T.FUN_CODIGO = F.FUN_CODIGO " + 
                                  "AND CA.CAR_CODIGO = F.CAR_CODIGO "+
                                  "AND FI.FIL_CODIGO = F.FIL_CODIGO "+
                                  "AND T.TUR_CODIGO_REAL IS NULL " + 
                                  "AND T.CUR_CODIGO = C.CUR_CODIGO " +
                                  "AND Q.QBR_CODIGO = T.QBR_CODIGO " +
                                  "AND PLA_CODIGO = " + usu_plano +" "+ par + " " +
                                  "AND (T.TTR_CODIGO = 1 OR T.TTR_CODIGO = 2 OR T.TTR_CODIGO = 3) " +
                                  "AND T.JUS_CODIGO IS NULL "+
                                  filtro + fun_filtro;
                              
                          //filtros
                          if (!(filtroc.equals("T"))) {
                             query = query + " AND T.CUR_CODIGO = " + filtroc;
                          }
                          if (!(filtroq.equals("T"))) {
                             query = query + " AND Q.QBR_CODIGO = " + filtroq;
                          }
                          query = query + " ORDER BY F.FUN_NOME";
                          //out.println(query);
                          rs = conexao.executaConsulta(query,session.getId()+"RS4");
                          if (rs.next())
                          {
                            %>
                   	   <tr> 
                   	     <td width="5%">&nbsp;</td>
                   	     <td width="7%" class="celtittab"><%=trd.Traduz("CHAPA")%></td>
                   	     <td width="25%" class="celtittab"><%=trd.Traduz("NOME DO FUNCIONARIO")%></td>
                   	     <td width="15%" class="celtittab"><%=trd.Traduz("CARGO")%></td>
                   	     <td width="15%" class="celtittab"><%=trd.Traduz("FILIAL")%></td>
                   	     <td width="42%" class="celtittab"><%=trd.Traduz("CURSO")%></td>
                   	     <td width="12%" class="celtittab"> 
                   	       <div align="center"><%=trd.Traduz("PREVISAO")%></div>
                   	     </td>
                   	   </tr>
                            
                            
                            <%
                            do
                          {
                          i = i + 1;
                          if (rs.getString(6) == null) {
                            cor = "celnortab"; } else {
                            cor = "celnortaba"; }
                         
                         	
                        %>
                            <tr class=<%=cor%>> 

                            <%
								if(bloquear == false) { 
									if (rs.getString(6) == null) { %>
										<td width="1%" align="center">
											<input type="checkbox" name="checkbox<%=i%>" value="<%=rs.getString(1)%>">
										</td>
                            <%		} 
								}//if(bloquear == false) 
								
								else {%>
									 <td width="1%" bgcolor="#FFFFFF">&nbsp;  </td>
								<%   }%>

                              <td width="12%"><%=((rs.getString(2)==null)?"":rs.getString(2))%></td>
                              <td width="25%">
                              <%
                              if(rs.getString(7).equals("S"))
                              {
                              	%>**
                              	<%=((rs.getString(3)==null)?"":rs.getString(3))%></td>
                              	<%
                              }
                              else if(rs.getString(8).equals("S"))
                              {
                              	%>*
                              	<%=((rs.getString(3)==null)?"":rs.getString(3))%></td>
                              	<%
                              }
                              else
                              {
                              	%>
                              	<%=((rs.getString(3)==null)?"":rs.getString(3))%></td>
                              	<%
                              }
                              %>
                              <td width="15%"><%=((rs.getString(9)==null)?"":rs.getString(9))%></td>
                              <td width="15%"><%=((rs.getString(10)==null)?"":rs.getString(10))%></td>
                              <td width="42%"><%=((rs.getString(4)==null)?"":rs.getString(4))%></td>
                              <td width="12%"> 
                                <div align="center"><%=((rs.getString(5)==null)?"":rs.getString(5))%></div>
                              </td>
                            </tr>
                            <%
                          }while (rs.next());
                          }
                          else
                          {
                          	%>
                          	<tr>
                          	  <td class="celtittab" colspan="100%" align="center">&nbsp;<%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...</td>
                          	</tr>
                          	<%
                          }
                          if(rs != null){
                              rs.close();
                              conexao.finalizaConexao(session.getId()+"RS4");
                          }
                        %>

                    </table>
                    <br>&nbsp;
                  </td>
              </tr>
            </table>
          </td>
          <%
            //contador de checks
            query = "SELECT COUNT(*) FROM FUNCIONARIO F, TREINAMENTO T, CURSO C, QUEBRA Q WHERE T.FUN_CODIGO = F.FUN_CODIGO AND T.TUR_CODIGO_REAL IS NULL AND T.CUR_CODIGO = C.CUR_CODIGO AND Q.QBR_CODIGO = T.QBR_CODIGO "+par+" ";
            rs = conexao.executaConsulta(query,session.getId()+"RS5");
            rs.next();
          %>
      <input type="hidden" name="contador" value="<%=rs.getString(1)%>">
      <input type="hidden" name="cont" value="<%=i%>">
      <input type="hidden" name="reload" value="<%=reload%>">

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
<!--<script language="JavaScript1.2" src="HM_Loader.js" type='text/JavaScript'></script>-->
</body>
</html>
<%
                          if(rs != null){
                              rs.close();
                              conexao.finalizaConexao(session.getId()+"RS5");
                          }

//} catch(Exception e){
//  out.println("Erro: "+e);
//}
%>
