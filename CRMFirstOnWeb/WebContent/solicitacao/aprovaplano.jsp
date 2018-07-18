<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
	response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*"%>

<%
//try{

request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_cod = (Integer)session.getAttribute("usu_cod");
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 

ResultSet rsProcuraAprovados = null, rs = null;

//*************** PEGA O TAMANHO DO CAMPO ***************
int tam_justificativa = 0;
String query = "SELECT LENGTH COLUNA FROM SYSCOLUMNS WHERE NAME = 'SOP_JUSTIFICATIVA'";
rs = conexao.executaConsulta(query, session.getId() + "RS1");		
if(rs.next()){
	tam_justificativa = rs.getInt(1);
}

if(rs != null){
   rs.close();
   conexao.finalizaConexao(session.getId()+"RS1");
}

//out.println("tamanho: "+tam_justificativa);

%>


<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("SolicitaCAo")%> - <%=trd.Traduz("APROVACAO DO PLANO")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<script language="JavaScript1.1">
function abl(quem){
if(quem=="1"){
	
		frm.textarea.disabled=true;
		frm.justificativa1.checked=true;
		frm.justificativa2.checked=false;
		frm.textarea.value="";
		frm.aprovado.value="S";
		return true;
}

else {
		frm.textarea.disabled=false;
		frm.justificativa1.checked=false;
		frm.justificativa2.checked=true;
		frm.textarea.value="";
		frm.aprovado.value="N";
		return true;
	}

}
function linkar(codigo,fil_codigo){
	if(showModalDialog){
		sRtn = showModalDialog("../impressoes/02_planodetreinamento.jsp?sel_solic="+codigo+"&sel_funcion=0&sel_depto=0&sel_filial="+fil_codigo+"&sel_curso=0&sel_tipo=0&sel_empresa=0&sel_cargo=0&sel_titulo=0&sel_tabela1=0&sel_tabela2=0&sel_tabela3=0&sel_tabela4=0&sel_tabela5=0&sel_tabela6=0&sel_tabela7=0&sel_tabela8=0&rb_imp=T&rb_ord=S","","center=yes;status=no;dialogWidth=800px;dialogHeight=600px");
		if (sRtn!=""){
		}
	}
	else{
		alert("Internet Explorer 4.0 ou superior E necessArio.");
	}
	return false;
}

function valida(){
	if(frm.textarea.value=="Justifique aqui!"){
		frm.textarea.value="";
	}
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

function aspa2(campo, tam_limite){
	aux = campo.value;
	tam = aux.length;
	aux2 = aux.substring(tam-1,tam);
	//verifica o tamanho da string//	
	if(tam >= tam_limite){
		alert("ESTE CAMPO DEVE CONTER, NO MAXIMO, "+tam_limite+" CARACTERES.");
		campo.focus(); 
	}
    /////////////////////////////////

	i = 0;
	nova = "";
	while(i != tam){
		aux2 = aux.substring(i,i+1);
		if(aux2 == "\"" || aux2 == "\'")
			nova = nova;
		else
			nova = nova + aux2;
		i++;
		
	}
	campo.value = nova;
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
              <tr>    <%
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
			if (request.getParameter("op") == null)
				menu = "../menu/menu.jsp?op=S";
			else
				menu = "../menu/menu.jsp?op=S";
			if (request.getParameter("opt") == null)
				opMenu = "../menu/menu1.jsp?opt=AP&op=S";
			else
				opMenu = "../menu/menu1.jsp?opt=AP&op=S";
		}
		else{
			if (request.getParameter("op") == null)
				menu = "/menu/menu.jsp?op=S";
			else
				menu = "/menu/menu.jsp?op=S";
			if (request.getParameter("opt") == null)
				opMenu = "/menu/menu1.jsp?opt=AP&op=S";
			else
				opMenu = "/menu/menu1.jsp?opt=AP&op=S";
		}			
		%>
               <jsp:include page="<%=menu%>" flush="true"></jsp:include>
              </tr>
            </table>    
          </td>
        </tr>
       <jsp:include page="<%=opMenu%>" flush="true"></jsp:include>
      </table>
      
      <table border="0" cellspacing="0" cellpadding="0" bgcolor="c0c0c0">
        <tr>
	   
        </tr>
      </table>
      <form name="filtro" method="POST" action="aprovaplano.jsp">
     
      <table width="90%" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr> 
          <td colspan="4"> 
            <div align="center"><font class="trontrk"><%=trd.Traduz("APROVACAO DO PLANO")%></font></div>
          </td>
        </tr>
        <tr> 
          <td colspan="4"> 
            <hr  >
          </td>
        </tr>
        <tr> 
          <td width="11%" height="21">&nbsp;</td>
          <td width="40%" height="21"> 
            <div align="right"><font class="ctfontc"><%=trd.Traduz("LOCALIZAR POR FUNCIONARIO")%>:</font></div>
          </td>
          <td width="18%" height="21"> 
            <div align="center"><input type="text" name="filtro" value="<%=(((String)request.getParameter("filtro")==null)?"":(String)request.getParameter("filtro"))%>"></div>
          </td>
          <td width="31%" height="21"> 
            <input type="submit" name="Filtrar" value=<%=("\""+trd.Traduz("FILTRAR")+"\"")%> class="botcin">
          </td>
        </tr>
        <tr> 
          <td colspan="4"><hr  ></td>
        </tr>
      </table>
      </form>
      <br>
      <br>
      <form name="frm" action="valida_aprovacao.jsp" method="POST"> 
      <table width="80%" border="0" cellspacing="1" cellpadding="0" align="center">
        <tr class="celtittabcin"> 
          <td height="19" width="2%" bgcolor="#FFFFFF">&nbsp;</td>
          <td colspan="4" width="98%"> 
            <div align="center"><font class="trontrk"><%=trd.Traduz("SOLICITANTES")%></font></div>
          </td>
	</tr>
        <%
        String aplicacao	= (String)session.getAttribute("aplicacao");
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
	  par = " AND F.FIL_CODIGO = " + usu_fil + " AND (F.FUN_CODSOLIC = " + usu_cod +  ") "; 
	}
        
        query = "SELECT DISTINCT F.FUN_CODIGO, F.FUN_CHAPA, F.FUN_NOME, C.CAR_NOME, S.SOP_APROVADO, F.FIL_CODIGO "+
				"FROM FUNCIONARIO F, TIPOUSUARIO T, FUNC_USUARIO FU, CARGO C, APLICACAO A,SOLIC_PLANO S "+
				"WHERE FU.TIP_TIPO = T.TIP_TIPO "+
				"AND FU.TIP_TIPO = 'S' "+
				"AND T.APL_CODIGO = A.APL_CODIGO "+
				"AND A.APL_SIGLA = '"+aplicacao+"' "+
				"AND FU.FUN_CODIGO = F.FUN_CODIGO "+
				"AND F.CAR_CODIGO = C.CAR_CODIGO " + 
				"AND F.FUN_CODIGO OUTER S.FUN_CODIGO " +
				par + "  AND F.FUN_NOME >= ('"+(((String)request.getParameter("filtro")==null)?"":(String)request.getParameter("filtro"))+"') ORDER BY F.FUN_NOME";
	boolean primeiro = true;
	rsProcuraAprovados = conexao.executaConsulta(query,session.getId()+"RS2");
	
	if(rsProcuraAprovados.next()){
	%>
	        <tr class="celtittab"> 
	          <td height="19" width="2%" bgcolor="#FFFFFF">&nbsp;</td>
	          <td height="19" width="20%"><%=trd.Traduz("CHAPA")%></td>
	          <td height="19" width="38%"><%=trd.Traduz("NOME")%></td>
	          <td height="19" width="35%"><%=trd.Traduz("CARGO")%></td>
	          <td height="19" width="5%"><%=trd.Traduz("APROVADO")%></td>
	        </tr>
	<%
	
	
        do{
        	%>
			<tr class="celnortab"> 
			<%
			if(primeiro){
				%>
				<td width="2%">
				 <input type="radio" name="func" value="<%=((rsProcuraAprovados.getInt(1)==0)?0:rsProcuraAprovados.getInt(1))%>" checked>
				</td>
				<%
				primeiro=false;
			}
			else{
				%>
				<td width="2%">
				 <input type="radio" name="func" value="<%=((rsProcuraAprovados.getInt(1)==0)?0:rsProcuraAprovados.getInt(1))%>">
				</td>
				<%
			}
			%>
			 <td width="20%"align="center"><%=((rsProcuraAprovados.getString(2)==null)?"":rsProcuraAprovados.getString(2))%></td>
			<%
			int teste = ((rsProcuraAprovados.getInt(1)==0)?0:rsProcuraAprovados.getInt(1));
			String linkNome=""+teste;
			String fil_codigo = ((rsProcuraAprovados.getString(6)==null)?"":rsProcuraAprovados.getString(6));
			%>
			<td width="38%"align="left"><a href="#" onClick="return linkar(<%=linkNome%>,<%=fil_codigo%>);" class="lnk" title=<%=("\""+trd.Traduz("VISUALIZA RELATORIO DE PLANO DE TREINAMENTO")+"\"")%>><%=((rsProcuraAprovados.getString(3)==null)?"":rsProcuraAprovados.getString(3))%></a></td>
			<td width="35%"align="left"><%=((rsProcuraAprovados.getString(4)==null)?"":rsProcuraAprovados.getString(4))%></td>
			<%
			String ap =((rsProcuraAprovados.getString(5)==null)?"N":rsProcuraAprovados.getString(5));
			if(ap.equals("S"))
				ap=trd.Traduz("SIM");
			else
				ap=trd.Traduz("NAO");
			%>
			<td width="5%" align="center"><%=ap%></td>
			</tr>
			<input type="hidden" name="mostra" value="S">
			<%
		}while(rsProcuraAprovados.next());
	}
	else{
		%>
		<tr class="celtittab"> 
	 	 <td height="20" bgcolor="#FFFFFF"></td>
		 <td height="20" colspan="4" align="center"><b><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...</b></td>
		</tr>
		<input type="hidden" name="mostra" value="N">
	 	<%
	 }
         if(rsProcuraAprovados != null){
             rsProcuraAprovados.close();
             conexao.finalizaConexao(session.getId()+"RS2");
         } 

%>
      </table>
      <br><br>
      <table width="30%" border="0" cellspacing="1" cellpadding="0" align="center" height="50">
        <tr class="celtittab"> 
          <td colspan="5" height="19"> 
            <div align="center"><%=trd.Traduz("APROVAR PLANO")%></div>
          </td>
        </tr>
        <tr > 
          <td width="13%" height="13"> 
            <div align="right"> </div>
          </td>
          <td width="12%" height="13"> 
            <input type="checkbox" name="justificativa1" value="S" onClick="return abl(1);">
          </td>
          <td width="26%" height="13" class="ctfontc"><%=trd.Traduz("SIM")%></td>
          <td width="12%" height="13"> 
            <input type="checkbox" name="justificativa2" value="N" onClick="return abl(2);" checked>
          </td>
          <td width="37%" height="13" class="ctfontc"><%=trd.Traduz("NAO")%></td>
        </tr>
        <tr  class="ctfontb" align="left">
        <td colspan="5" height="19" align="left"> <%=trd.Traduz("JUSTIFICATIVA")%>:</td>
	</tr> 
        <tr> 
          <td colspan="5" height="14"> 
            <div align="center">
              <textarea cols="50" rows="4" name="textarea" onBlur="aspa2(this, <%=tam_justificativa%>)" onKeyUp="aspa(this)"></textarea>
            </div>
            
          </td>
        </tr>
         <tr  class="ctfontb" align="left">
	        <td colspan="5" height="19" align="left"> &nbsp;</td>
	</tr> 
	<tr>
          <td colspan="5" height="5">
      <div align="center"> 
              <input type="button" class="botcin" name="confirmar" value=<%=("\""+trd.Traduz("CONFIRMAR")+"\"")%> onClick="return valida();">
            </div>
            <div align="center"> </div></td>
        </tr>
</table>
<input type="hidden" value="N" name="aprovado">
</form>      
<br>
<br>
      <script language="JavaScript">
      
      if(frm.mostra.value=="N"){
      frm.confirmar.disabled=true;
      }
      </script>
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
</body>
</html>
<%
//}catch(Exception ex){out.println("<tt class=\"ctfontc\">Contate o Fabricante: </tt>"+ex);}
%>
