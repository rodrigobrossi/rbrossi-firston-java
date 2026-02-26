<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
	response.setHeader("Cache-Control", "no-cache");
}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.util.*"%>

<jsp:useBean id="cmb" scope="page" class="firston.eval.components.FODynamicComboBean" />
<jsp:useBean id="pos" scope="page" class="firston.eval.components.FOUserPositionBean" />

<%
//try{

request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");

String usu_tipo  = (String) session.getAttribute("usu_tipo"); 
String usu_nome  = (String) session.getAttribute("usu_nome"); 
String usu_login = (String) session.getAttribute("usu_login"); 
String aplicacao = (String) session.getAttribute("aplicacao");
Integer usu_fil  = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi  = (Integer)session.getAttribute("usu_idi");
Integer usu_cod  = (Integer)session.getAttribute("usu_cod");

ResultSet rs = null, rs_uni = null, rs_dir = null, rs_cel = null, rs_tim = null;

String reload = "";
if(request.getParameter("reload") != null)
    reload = request.getParameter("reload");

//Checagem de demitidos e terceiros
String fun_filtro = "";

if(request.getParameter("check_d") != null)//demitido
	fun_filtro = " AND FUNCIONARIO.FUN_DEMITIDO = 'S' ";

if((request.getParameter("check_a") != null) || (reload.equals("")))//ativo
	fun_filtro = " AND FUNCIONARIO.FUN_TERCEIRO = 'N' AND FUNCIONARIO.FUN_DEMITIDO = 'N' ";

if(request.getParameter("check_t") != null)//terceiro
	fun_filtro = " AND FUNCIONARIO.FUN_TERCEIRO = 'S' ";

if((request.getParameter("check_d") != null) && (request.getParameter("check_a") != null))//demitido e ativo
	fun_filtro = " AND ((FUNCIONARIO.FUN_DEMITIDO = 'S') OR (FUNCIONARIO.FUN_TERCEIRO = 'N' AND FUNCIONARIO.FUN_DEMITIDO = 'N')) ";

if((request.getParameter("check_d") != null) && (request.getParameter("check_t") != null))//demitido e terceiro
	fun_filtro = " AND ((FUNCIONARIO.FUN_DEMITIDO = 'S') OR (FUNCIONARIO.FUN_TERCEIRO = 'S')) ";

if((request.getParameter("check_a") != null) && (request.getParameter("check_t") != null))//ativo e terceiro
	fun_filtro = " AND ((FUNCIONARIO.FUN_TERCEIRO = 'N' AND FUNCIONARIO.FUN_DEMITIDO = 'N') OR (FUNCIONARIO.FUN_TERCEIRO = 'S')) ";

if((request.getParameter("check_d") != null) && (request.getParameter("check_a") != null) && (request.getParameter("check_t") != null))//demitido, ativo e terceiro
	fun_filtro = " AND ((FUNCIONARIO.FUN_DEMITIDO = 'S') OR (FUNCIONARIO.FUN_TERCEIRO = 'N' AND FUNCIONARIO.FUN_DEMITIDO = 'N') OR (FUNCIONARIO.FUN_TERCEIRO = 'S')) ";
	
//VariAveis para as Queryes
String query = "", lotacao = "", unidade = "", diretoria = "", celula = "", time = "", teste = "";
String opt_filtro = "", tiposolic = "";
 
String filial = ""+usu_fil;
String codigo = ""+usu_cod;

Vector querys = new Vector();

if(request.getParameter("opt") != null)
	tiposolic = request.getParameter("opt");

if (request.getParameter("op_uni") != null)
	unidade = request.getParameter("op_uni");
else
	unidade = ""+usu_fil;

if (request.getParameter("op_dir") != null)
	diretoria = request.getParameter("op_dir");
if (request.getParameter("op_cel") != null)
	celula = request.getParameter("op_cel");
if (request.getParameter("op_tim") != null)
	time = request.getParameter("op_tim");

	lotacao = prm.buscaparam("LOTACAO");

//Pegar parametros
if (request.getParameter("opcombo") != null)
{
 	opt_filtro = (String)request.getParameter("opcombo");

	if(usu_tipo.equals("F"))
		query = cmb.montaCombo(opt_filtro, "null", "null", aplicacao);	

	if(usu_tipo.equals("P") || usu_tipo.equals("G"))
		query = cmb.montaCombo(opt_filtro, filial, "null", aplicacao);	
		
	if(usu_tipo.equals("S"))
		query = cmb.montaCombo(opt_filtro, filial, codigo, aplicacao);	
	
	//CARGO
	if(opt_filtro.equals("Cargo"))
	{
		if(lotacao.equals("S"))
		{
			if(usu_tipo.equals("F"))
				querys = pos.montaCombo(opt_filtro, "null", "null", aplicacao, unidade, diretoria, celula, time);	
	
			if(usu_tipo.equals("P") || usu_tipo.equals("G"))
				querys = pos.montaCombo(opt_filtro, filial, "null", aplicacao, unidade, diretoria, celula, time);	
	
			if(usu_tipo.equals("S"))
				querys = pos.montaCombo(opt_filtro, filial, codigo, aplicacao, unidade, diretoria, celula, time);	
		}

		else
		{
			if(usu_tipo.equals("F"))
				query = cmb.montaCombo(opt_filtro, "null", "null", aplicacao);	

			if(usu_tipo.equals("P") || usu_tipo.equals("G"))
				query = cmb.montaCombo(opt_filtro, filial, "null", aplicacao);	
	
			if(usu_tipo.equals("S"))
				query = cmb.montaCombo(opt_filtro, filial, codigo, aplicacao);	
		}		
	}
}
else
{
        //Filtro Padrao
	opt_filtro = "Tabela2";

       if( (opt_filtro.equals("Cargo"))&&(lotacao.equals("S")) )
       {
		if(usu_tipo.equals("F"))
			querys = pos.montaCombo(opt_filtro, "null", "null", aplicacao, unidade, diretoria, celula, time);	
	
		if(usu_tipo.equals("P") || usu_tipo.equals("G"))
			querys = pos.montaCombo(opt_filtro, filial, "null", aplicacao, unidade, diretoria, celula, time);	

		if(usu_tipo.equals("S"))
			querys = pos.montaCombo(opt_filtro, filial, codigo, aplicacao, unidade, diretoria, celula, time);	
	}
	else
	{
		if(usu_tipo.equals("F"))
			query = cmb.montaCombo(opt_filtro, "null", "null", aplicacao);	

		if(usu_tipo.equals("P") || usu_tipo.equals("G"))
			query = cmb.montaCombo(opt_filtro, filial, "null", aplicacao);	
	
		if(usu_tipo.equals("S"))
			query = cmb.montaCombo(opt_filtro, filial, codigo, aplicacao);	
	}
}
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("SolicitaCAo")%> - 
<%
	if(tiposolic.equals("E"))
	{
		%>
        	<%=trd.Traduz("CRIAR SOLICITACAO EXTRA")%>
		<%
	}
	else
	{
		%>
        	<%=trd.Traduz("CRIAR SOLICITACAO")%>
		<%
	}
%>	
</title>
<script language="JavaScript" src="scripts.js">
  </script>

<script language="JavaScript">
function Filtro()
{
	    window.open("../solicitacao/index.jsp?opcombo="+frm.select2.value+"&opt="+frm.opt.value,"_parent");
	    return true;
}            
function Unidade()
{
	window.open("../solicitacao/index.jsp?op_uni="+frm.select_uni.value+"&opt="+frm.opt.value,"_parent");
	return true;
}    
function Diretoria()
{
	window.open("../solicitacao/index.jsp?op_uni="+frm.select_uni.value+"&op_dir="+frm.select_dir.value+"&opt="+frm.opt.value,"_parent");
	return true;
}    
function Celula()
{
	window.open("../solicitacao/index.jsp?op_uni="+frm.select_uni.value+"&op_dir="+frm.select_dir.value+"&op_cel="+frm.select_cel.value+"&opt="+frm.opt.value,"_parent");
	return true;
}    
function Time()
{
	window.open("../solicitacao/index.jsp?op_uni="+frm.select_uni.value+"&op_dir="+frm.select_dir.value+"&op_cel="+frm.select_cel.value+"&op_tim="+frm.select_tim.value+"&opt="+frm.opt.value,"_parent");
	return true;
}    
function envia()
{
        frm.opt.value="<%=tiposolic%>";
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
                  oi = "../menu/menu.jsp?op="+"S";
				}
				else
				{
                  oi = "../menu/menu.jsp?op="+request.getParameter("op");
				}
				if (request.getParameter("opt") == null)
				{
                  oia = "../menu/menu1.jsp?opt="+"S"; //out.println("nulo = " + oia);
				} 
				else
				{  
                  oia = "../menu/menu1.jsp?opt="+request.getParameter("opt"); //out.println("cheio = " + oia);
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
				                  oia = "/menu/menu1.jsp?opt="+"S"; //out.println("nulo = " + oia);
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
          <td width="100%" align="center"> 
            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
					<%
						if(tiposolic.equals("E"))
						{
							%>
				                <td class="trontrk" width="297" align="center"><%=trd.Traduz("CRIAR SOLICITACAO EXTRA")%></td>
							<%
						}
						else
						{
							%>
			   	                <td class="trontrk" width="297" align="center"><%=trd.Traduz("CRIAR SOLICITACAO")%></td>
							<%
						}
					%>	
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
		  <FORM name = "frm" action="result_filtro.jsp" method="POST">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>              
			  <%
				  //CARGO
				  if(opt_filtro.equals("Cargo")){
					if(lotacao.equals("S")){
					  %>
					  <tr>
					  	<td class="ctfontc"> <%=trd.Traduz("TABELA5")%>: </td>						
						<td>
							<select name="select_uni" onChange="return Unidade();">		
								<%
						   		if(usu_tipo.equals("F")){
									%>
										<option value = "-1"><%=trd.Traduz("Todos")%></option> 
									<%
								}
					  			rs_uni = conexao.executaConsulta((String)querys.elementAt(1),session.getId()+"RS1");
								if (rs_uni.next()){
									do{
										if((rs_uni.getInt(1)) == (Integer.parseInt(unidade))){
											%>
												<option selected value = "<%=rs_uni.getInt(1)%>"><%=rs_uni.getString(2)%></option>
										    <%
										}
										else{
											%>
												<option value = "<%=rs_uni.getInt(1)%>"><%=rs_uni.getString(2)%></option>
										    <%
										}
									}while (rs_uni.next());
									%> </select> <%									
								}
                                                                if(rs_uni != null){
                                                                    rs_uni.close();
                                                                    conexao.finalizaConexao(session.getId()+"RS1");
                                                                }
							%>
						</td>
					  	<td class="ctfontc"> <%=trd.Traduz("TABELA6")%>: </td> 	
						<td>
							<select name="select_dir" onChange="return Diretoria();"> <option value = "-1"><%=trd.Traduz("Todos")%></option> 
							<%
							rs_dir = conexao.executaConsulta((String)querys.elementAt(2),session.getId()+"RS2");
							if (rs_dir.next()){
								do{
									if(!(diretoria.equals(""))){
										if((rs_dir.getInt(1)) == (Integer.parseInt(diretoria))){
											%>
											<option selected value = "<%=rs_dir.getInt(1)%>"><%=rs_dir.getString(2)%></option>
										    <%
										}
										else{
											%>
											<option value = "<%=rs_dir.getInt(1)%>"><%=rs_dir.getString(2)%></option>
										    <%		
										}
									}
									else{
										%>
										<option value = "<%=rs_dir.getInt(1)%>"><%=rs_dir.getString(2)%></option>
									    <%
									}
								}while (rs_dir.next());
								%> </select> <%									
							}
                                                        if(rs_dir != null){
                                                                    rs_dir.close();
                                                                    conexao.finalizaConexao(session.getId()+"RS2");
                                                        }
							%>
						</td>
					</tr>					
					<tr>
						<td class="ctfontc"> <%=trd.Traduz("TABELA7")%>: </td> 											
 					  	<td>
							<select name="select_cel" onChange="return Celula();"> <option value = "-1"><%=trd.Traduz("Todos")%></option>
							<%
								rs_cel = conexao.executaConsulta((String)querys.elementAt(3),session.getId()+"RS3");								
								if (rs_cel.next()){
									do{
										if(!(celula.equals(""))){
											if((rs_cel.getInt(1)) == (Integer.parseInt(celula))){
												%>
												<option selected value = "<%=rs_cel.getInt(1)%>"><%=rs_cel.getString(2)%></option>
											    <%
											}
											else{
												%>
												<option value = "<%=rs_cel.getInt(1)%>"><%=rs_cel.getString(2)%></option>
											    <%		
											}
										}
										else{
											%>
											<option value = "<%=rs_cel.getInt(1)%>"><%=rs_cel.getString(2)%></option>
										    <%
										}
									}while (rs_cel.next());
									%> </select> <%									
								}
                                                                if(rs_cel != null){
                                                                    rs_cel.close();
                                                                    conexao.finalizaConexao(session.getId()+"RS3");
                                                                }
							%>
						</td>
						<%
							/*
							out.println((String)querys.elementAt(4)); 
							*/
							
						%>
					  	<td class="ctfontc"> <%=trd.Traduz("TABELA8")%>: </td> 
						
						<td>
							<select name="select_tim" onChange="return Time();"> <option value = "-1"><%=trd.Traduz("Todos")%></option>
							<%
								rs_tim = conexao.executaConsulta((String)querys.elementAt(4),session.getId()+"RS4");
								if (rs_tim.next()){
									do{
										if(!(time.equals(""))){
											if(rs_tim.getString(1).equals(time)){
												%>
												<option selected value = "<%=rs_tim.getInt(1)%>"><%=rs_tim.getString(2)%></option>
											    <%
											}
											else{
												%>
												<option value = "<%=rs_tim.getInt(1)%>"><%=rs_tim.getString(2)%></option>
											    <%		
											}
										}
										else{	
											%>
											<option value = "<%=rs_tim.getInt(1)%>"><%=rs_tim.getString(2)%></option>
										    <%
										}
									}while (rs_tim.next());
									%> </select> <%									
								}
                                                                if(rs_tim != null){
                                                                    rs_tim.close();
                                                                    conexao.finalizaConexao(session.getId()+"RS4");
                                                                }
							%>
						</td>
					  </tr>
					  <% //out.println((String)querys.elementAt(4));				  
					}
				  }
				  %>
				  
				  <tr>
				  	<td colspan="4">&nbsp;  </td>
				  </tr>
				  				 
                  <td colspan = "4" height="20" class="ctfontc" align="center">&nbsp; <%=trd.Traduz("LOCALIZAR POR FUNCIONARIO")%>: 
                    <input type="text" name="textfield">
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
				<%
				 if (!(opt_filtro.equals("Solicitante")))
				 {
					//if((usu_tipo.equals("F")) || (usu_tipo.equals("P")) || (usu_tipo.equals("G") || (usu_tipo.equals("S"))))
					//{
						%>
							<option value ="Solicitante" ><%=trd.Traduz("SOLICITANTE")%></option>
						<%
					//}
				 }
				%>
                  </select>
                  &nbsp; <%=trd.Traduz("FILTRO")%>: <select name="select">
                      <option value="-1"><%=trd.Traduz("Todos")%></option>
<%
if(opt_filtro.equals("Cargo")){
	if(lotacao.equals("S")){
		rs = conexao.executaConsulta((String)querys.elementAt(0),session.getId()+"RS5");
	}
	else{
        rs = conexao.executaConsulta(query,session.getId()+"RS5");
    }
}
else	
	rs = conexao.executaConsulta(query,session.getId()+"RS5");

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
                  &nbsp; &nbsp; 
                  </td>
                </tr>
                <tr align="center" class="ctfontc"> 
                  <td align="right" colspan="6">&nbsp;</td>
                </tr>
                <tr align="center" class="ctfontc" border="3"> 
                  <td align="center" colspan="100%"> 
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
                  </td>
                </tr>
                <tr align="center"> 
                  <td class="ctfontc" colspan="100%">
                    <input type="button" onClick="return envia();"  value=<%=("\""+trd.Traduz("FILTRAR")+"\"")%> class="botcin" name="button">
                  </td>
                </tr>
              <tr> 
                <td height="12" colspan="100%"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                <td class="ctvdiv" height="1" colspan="100%"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
	        <td height="12" colspan="100%"><img src="../art/bit.gif" width="1" height="1"></td>
	      </tr>
              <tr align="center"><center>
                <td class="ctfontc" valign="middle" colspan="100%" align="center"><font size="1">
                ** - <%=trd.Traduz("DEMITIDO")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                * - <%=trd.Traduz("TERCEIRO")%>
                </font>
                </td></center>
              </tr>
              <tr> 
                <td height="12" colspan="100%"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                <td class="ctvdiv" height="1" colspan="100%"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
            </table>
          </td>
		<input type="hidden" name="opt" value="<%=tiposolic%>">
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
if(rs != null){
  rs.close();
  conexao.finalizaConexao(session.getId()+"RS5");
}

Vector limpa = new Vector();
session.setAttribute("funcs", limpa);

//} catch (Exception e) {
//  out.println(e);
//}
%>

