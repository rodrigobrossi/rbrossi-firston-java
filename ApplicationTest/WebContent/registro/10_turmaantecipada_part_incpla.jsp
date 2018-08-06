<%
    response.setHeader("Pragma", "no-cache");
    if (request.getProtocol().equals("HTTP/1.1"))
    {
      response.setHeader("Cache-Control", "no-cache");
    }
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.lang.Math.*, java.util.*, java.text.*"%>

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

String codigo_comp = "", codigo_trein = "";
int tam_codigo = 0;
boolean virgula = false;

ResultSet rs = null, rsgrid = null, rsc = null, rs_uni = null, rs_dir = null, rs_cel = null, rs_tim = null;

String turma = request.getParameter("turma");

String origem = request.getParameter("origem");

int pag = Integer.parseInt((String)session.getAttribute("pagina"));
String usu_plano = "";
usu_plano = usu_plano.valueOf(session.getAttribute("usu_plano")); 

String filial = ""+usu_fil;
String codigo = ""+usu_cod;

//try {

//VariAveis para as Queryes
String query = "", query_grid = "", query_c = "", loc = "";
String lotacao = "", unidade = "", diretoria = "", celula = "", time = "";
String opt_filtro = "", campo = "", filtro_q = "", vcampo = "";
int sel = -1, cont = 0;

//Filtros lotacao
Vector querys = new Vector();
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
if (request.getParameter("select2") != null) 
{  
 	opt_filtro = (String)request.getParameter("select2");
    
	//if(usu_tipo.equals("F"))
		query = cmb.montaCombo(opt_filtro, "null", "null", aplicacao);

	/*if(usu_tipo.equals("P") || usu_tipo.equals("G"))
		query = cmb.montaCombo(opt_filtro, filial, "null", aplicacao);	
	
	if(usu_tipo.equals("S"))
		query = cmb.montaCombo(opt_filtro, filial, codigo, aplicacao);	*/

	//CARGO
	if(opt_filtro.equals("Cargo"))
	{
		if(lotacao.equals("S"))
		{
			//if(usu_tipo.equals("F"))
				querys = pos.montaCombo(opt_filtro, "null", "null", aplicacao, unidade, diretoria, celula, time);	
	
			/*if(usu_tipo.equals("P") || usu_tipo.equals("G"))
				querys = pos.montaCombo(opt_filtro, filial, "null", aplicacao, unidade, diretoria, celula, time);	
	
			if(usu_tipo.equals("S"))
				querys = pos.montaCombo(opt_filtro, filial, codigo, aplicacao, unidade, diretoria, celula, time);	*/
		}

		else
		{
			//if(usu_tipo.equals("F"))
				query = cmb.montaCombo(opt_filtro, "null", "null", aplicacao);	

			/*if(usu_tipo.equals("P") || usu_tipo.equals("G"))
				query = cmb.montaCombo(opt_filtro, filial, "null", aplicacao);	
	
			if(usu_tipo.equals("S"))
				query = cmb.montaCombo(opt_filtro, filial, codigo, aplicacao);	*/
		}		
	}
}
else
{
	//Filtro Padrao
	opt_filtro = "Tabela2";
	
	if(opt_filtro.equals("Cargo"))
	{
	  if(lotacao.equals("S")) 
	  {
		//if(usu_tipo.equals("F")) Alterado para a VCP 10/06/2003
			querys = pos.montaCombo(opt_filtro, "null", "null", aplicacao, unidade, diretoria, celula, time);	
	
		/*if(usu_tipo.equals("P") || usu_tipo.equals("G"))
			querys = pos.montaCombo(opt_filtro, filial, "null", aplicacao, unidade, diretoria, celula, time);	

		if(usu_tipo.equals("S"))
			querys = pos.montaCombo(opt_filtro, filial, codigo, aplicacao, unidade, diretoria, celula, time);	*/
	  }
	}
	else
	{
		//if(usu_tipo.equals("F"))
		
			query = cmb.montaCombo(opt_filtro, "null", "null", aplicacao);	

		/*if(usu_tipo.equals("P") || usu_tipo.equals("G"))
			query = cmb.montaCombo(opt_filtro, filial, "null", aplicacao);	
	
		if(usu_tipo.equals("S"))
			query = cmb.montaCombo(opt_filtro, filial, codigo, aplicacao);	*/
	}
}

//Checagem de ativos e terceiros
String dem_ter = "";
if(request.getParameter("Check1") != null && request.getParameter("Check2") != null)//ativo+terceiro
  dem_ter = " AND (FUNCIONARIO.FUN_TERCEIRO = 'S' OR FUNCIONARIO.FUN_TERCEIRO = 'N') ";
if(request.getParameter("Check1") != null && request.getParameter("Check2") == null)//ativo
  dem_ter = " AND FUNCIONARIO.FUN_TERCEIRO = 'N' ";
if(request.getParameter("Check1") == null && request.getParameter("Check2") != null)//terceiro
  dem_ter = " AND FUNCIONARIO.FUN_TERCEIRO = 'S' ";
if(request.getParameter("Check1") == null && request.getParameter("Check2") == null)//primeira visita a pagina
  dem_ter = " AND FUNCIONARIO.FUN_TERCEIRO = 'N' ";

//Monta a query do Grid
if (!(query.equals("")))
  if (opt_filtro.equals("Solicitante"))
    campo = query.substring(36,48) + " = ";
  else
    campo = query.substring(7,17) + " = ";
if (!(request.getParameter("select") == null)){
  if (!(request.getParameter("select").equals("Todos"))){
    sel = Integer.parseInt(request.getParameter("select"));
    filtro_q = " FUNCIONARIO." + campo + request.getParameter("select") + " ";
  }
  else
  {
    filtro_q = " 0=0 ";
  }
}
else
{
filtro_q = " 0=0 ";
}

if (!(request.getParameter("textfield") == null)){
loc = request.getParameter("textfield").trim();
  if (!(loc == null)){
   filtro_q = filtro_q + "AND FUNCIONARIO.FUN_NOME >= '" + loc + "' ";
  }
  else
  {
   loc = "";
  }
}
else
{
loc = "";
}
String par = "";
 
if(usu_tipo.equals("F"))
	par = "";
else{
	if(usu_tipo.equals("P") || usu_tipo.equals("G"))
		/*par = " AND FUNCIONARIO.FIL_CODIGO = " + usu_fil + " "; Alterado para a VCP 10/06/03*/
	    par = "";
	else{
  		if (usu_tipo.equals("S"))
			/*par = " AND FUNCIONARIO.FIL_CODIGO = " + usu_fil + " AND FUNCIONARIO.FUN_CODSOLIC = " + usu_cod + " "; Alterado para a VCP 10/06/03*/
            par = "";
	}
}

query_grid = "SELECT FUNCIONARIO.FUN_CODIGO, FUNCIONARIO.FUN_CHAPA, FUNCIONARIO.FUN_NOME, " + 
"CARGO.CAR_NOME, DEPTO.DEP_NOME, TABELA3.TB3_DESCRICAO, TABELA2.TB2_NOME, " + 
"FILIAL.FIL_NOME, SOLICITANTE.FUN_NOME, TREINAMENTO.TEF_CODIGO, FUNCIONARIO.FUN_DEMITIDO, FUNCIONARIO.FUN_TERCEIRO " + 
"FROM FUNCIONARIO, FUNCIONARIO SOLICITANTE, CARGO, DEPTO, TABELA3, TABELA2, FILIAL, TREINAMENTO " + 
"WHERE FUNCIONARIO.FUN_CODSOLIC OUTER SOLICITANTE.FUN_CODIGO AND " + 
"CARGO.CAR_CODIGO = FUNCIONARIO.CAR_CODIGO AND " + 
"DEPTO.DEP_CODIGO = FUNCIONARIO.DEP_CODIGO AND " + 
"FUNCIONARIO.TB3_CODIGO OUTER TABELA3.TB3_CODIGO AND " + 
"FUNCIONARIO.TB2_CODIGO OUTER TABELA2.TB2_CODIGO AND " + 
"FUNCIONARIO.FIL_CODIGO OUTER FILIAL.FIL_CODIGO AND " + 
"TREINAMENTO.FUN_CODIGO = FUNCIONARIO.FUN_CODIGO AND " + 
"FUNCIONARIO.FUN_DEMITIDO = 'N' AND " +
"FUNCIONARIO.FUN_CODIGO NOT IN (SELECT FUN_CODIGO FROM TREINAMENTO WHERE TUR_CODIGO_PLAN_ANT = "+turma+") AND " +
" " + filtro_q + par + dem_ter + " AND " +
"TREINAMENTO.CUR_CODIGO IN (SELECT CUR_CODIGO FROM TURMA WHERE TUR_CODIGO = " + turma + ") AND TREINAMENTO.TTR_CODIGO <> 2 " + 
"ORDER BY FUNCIONARIO.FUN_NOME";

query_c = "SELECT COUNT(*) " + 
"FROM FUNCIONARIO, FUNCIONARIO SOLICITANTE, CARGO, DEPTO, TABELA3, TABELA2, FILIAL, TREINAMENTO " + 
"WHERE FUNCIONARIO.FUN_CODSOLIC OUTER SOLICITANTE.FUN_CODIGO AND " + 
"CARGO.CAR_CODIGO = FUNCIONARIO.CAR_CODIGO AND " + 
"DEPTO.DEP_CODIGO = FUNCIONARIO.DEP_CODIGO AND " + 
"FUNCIONARIO.TB3_CODIGO OUTER TABELA3.TB3_CODIGO AND " + 
"FUNCIONARIO.TB2_CODIGO OUTER TABELA2.TB2_CODIGO AND " + 
"FUNCIONARIO.FIL_CODIGO OUTER FILIAL.FIL_CODIGO AND " + 
"TREINAMENTO.FUN_CODIGO = FUNCIONARIO.FUN_CODIGO AND " + 
"FUNCIONARIO.FUN_DEMITIDO = 'N' AND " +
"FUNCIONARIO.FUN_CODIGO NOT IN (SELECT FUN_CODIGO FROM TREINAMENTO WHERE TUR_CODIGO_PLAN_ANT = "+turma+") AND " +
" " + filtro_q + par + dem_ter + " AND " +
"TREINAMENTO.CUR_CODIGO IN (SELECT CUR_CODIGO FROM TURMA WHERE TUR_CODIGO = " + turma +  ") AND TREINAMENTO.TTR_CODIGO <> 2 ";


//out.println("query_grid = " + query_grid);

//ConecCAo com o Banco pelo Statement para a PaginaCAo com suas variaveis
String primeiro = "1";
int ult = 0;
int tot = 0;
int irpag = 0;
int irpagtot = 0;
int pagatual = 0;
int pagtotal = 0;
boolean existe = false;
//Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
//Connection conn = DriverManager.getConnection((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"));

//Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
//                                      ResultSet.CONCUR_UPDATABLE);
rsgrid = conexao.paginacao(pag,query_grid,session.getId()+"PAG");
//Para contar as linhas da query
rsc = conexao.executaConsulta(query_c,session.getId());
if(rsgrid.next()){
	existe = true;
}


//VariAveis de controle de pAgina
if (request.getParameter("pa") != null){
    primeiro = (String)request.getParameter("pa");
}

int valor = Integer.parseInt(primeiro);
int valorAnt = Integer.parseInt(primeiro) - pag;

if (request.getParameter("ia") != null){ 
	if (Integer.parseInt(request.getParameter("ia")) > 0){ 
     irpag = Integer.parseInt(request.getParameter("ia"));
     irpagtot = ((irpag*pag)-pag)+1;
     primeiro = primeiro.valueOf(irpagtot);
     valor = Integer.parseInt(primeiro);
     valorAnt = Integer.parseInt(primeiro) - pag;
	}
}

//Para nAo tentar mover para a linha zero
if(Integer.parseInt(primeiro) <= 0){
primeiro = "1";
}

//Move o Cursor para a PosiCAo
if(primeiro.equals("1")){
rsgrid.absolute(Integer.parseInt(primeiro));
rsgrid.previous();
}
else
{
rsgrid.absolute(Integer.parseInt(primeiro));
rsgrid.previous();
}

//Calcula a Ultima pagina
if (rsc.next()) {
  tot = rsc.getInt(1);
  ult = ((tot/pag)*pag)+1;
  pagatual = (Integer.parseInt(primeiro)/pag)+1;
  Math e=null;
  pagtotal = e.round((tot/pag)+0.5f);
  if ((tot%pag)==0) pagtotal--;//evita erros no numero de paginas
}

//Busca e Insere dados no vetor de funcionArios selecionados
String n = "";
Vector funcvet = new Vector();
if(request.getParameter("apagavetor") != null){ 
  request.getSession();
  funcvet = (Vector)session.getAttribute("funcs");
  //insere os elementos no vetor
  for(int k=0 ; k<=pag;k++) {
    if ((request.getParameter("checkbox" + n.valueOf(k)) != null)) {
		codigo_comp = request.getParameter("checkbox" + n.valueOf(k));
		tam_codigo = codigo_comp.length();

		for(int w = 0; w < tam_codigo; w++) {
			if(codigo_comp.charAt(w) == ',') {
				codigo_trein = codigo_comp.substring(0, w);
				virgula = true;
			}
			else {
				if(virgula == false)
					codigo_trein = request.getParameter("checkbox" + n.valueOf(k));
			}
		}

      if (!(funcvet.contains(codigo_trein)))
        funcvet.add(codigo_trein);
    }
  }
} else {
  funcvet.clear();
}

session.setAttribute("funcs",funcvet);
%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Registro")%> - <%=trd.Traduz("INCLUIR PARTICIPANTES PLANEJADOS")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<script language="JavaScript">
function Filtro()
        {
        window.open("10_turmaantecipada_part_incpla.jsp?select2="+frm.select2.value+"&turma=<%=turma%>","_parent");
	return true;
        }        	

function Unidade()
{
	window.open("10_turmaantecipada_part_incpla.jsp?op_uni="+frm.select_uni.value+"&turma=<%=turma%>","_parent");
	return true;
}    

function Diretoria()
{
	window.open("10_turmaantecipada_part_incpla.jsp?op_uni="+frm.select_uni.value+"&op_dir="+frm.select_dir.value+"&turma=<%=turma%>","_parent");
	return true;
}    
function Celula()
{
	window.open("10_turmaantecipada_part_incpla.jsp?op_uni="+frm.select_uni.value+"&op_dir="+frm.select_dir.value+"&op_cel="+frm.select_cel.value+"&turma=<%=turma%>","_parent");
	return true;
}    
function Time()
{
	window.open("10_turmaantecipada_part_incpla.jsp?op_uni="+frm.select_uni.value+"&op_dir="+frm.select_dir.value+"&op_cel="+frm.select_cel.value+"&op_tim="+frm.select_tim.value+"&turma=<%=turma%>","_parent");
	return true;
}    

function ProximaPag(valor)
        {	
        document.frm.pa.value = valor.value;
        document.frm.ia.value = "-1";  
        frm.action ="10_turmaantecipada_part_incpla.jsp";
        frm.submit();
	    return false;
        }            
function AnteriorPag(valor)
        {	        
        document.frm.pa.value = valor.value;
		document.frm.ia.value = "-1";  
		frm.action ="10_turmaantecipada_part_incpla.jsp";
        frm.submit();
	    return false;
        }            
function PrimeiraPag()
        {
        document.frm.pa.value = "1";
		document.frm.ia.value = "-1";  
		frm.action ="10_turmaantecipada_part_incpla.jsp";
        frm.submit();
	    return false;
        }            
function envia()
	{
	document.frm.pa.value = "1";
        document.frm.ia.value = "-1";  
	frm.action ="10_turmaantecipada_part_incpla.jsp";
	frm.submit();
	return false;	
	}
function irpag()
{
	if(document.frm.textir.value == "")
	{
		alert(<%=("\""+trd.Traduz("Digite o nUmero da pAgina")+"\"")%>);
		frm.textir.focus();
	}
	else if((document.frm.textir.value > <%=pagtotal%>) || (document.frm.textir.value < 1))
	{
		alert("NUmero da pAgina invAlido");
		frm.textir.focus();
	}
	else
	{
		document.frm.pa.value = "1";
		document.frm.ia.value = document.frm.textir.value;
		frm.action = "10_turmaantecipada_part_incpla.jsp";
		frm.submit();
		return false;
	}
}            
function irpag2()
{
	if(document.frm.textir2.value == "")
	{
		alert(<%=("\""+trd.Traduz("Digite o nUmero da pAgina")+"\"")%>);
		frm.textir2.focus();
	}
	else if((document.frm.textir2.value > <%=pagtotal%>) || (document.frm.textir2.value < 1))
	{
		alert("NUmero da pAgina invAlido");
		frm.textir2.focus();
	}
	else
	{
		document.frm.pa.value = "1";
		document.frm.ia.value = document.frm.textir2.value;
		frm.action = "10_turmaantecipada_part_incpla.jsp";
		frm.submit();
		return false;
	}
} 

function solicex()
        {          
	document.frm.extra.value = "S";
	frm.action = "10_turmaantecipada_part_inc_gravapla.jsp";
        frm.submit();
	return false;
        }
 
function cancela()
        {
        window.open("10_turmaantecipada_reg.jsp?turma=<%=turma%>","_parent");
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
              <tr>            <%
	      	      	      String ponto = (String)session.getAttribute("barra");
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
                <%String oi = "", oia = "";
                 if(ponto.equals("..")){
				if (request.getParameter("op") == null)
				{
                  oi = "../menu/menu.jsp?op="+"R";
				}
				else
				{
                  oi = "../menu/menu.jsp?op="+request.getParameter("op");
				}
				if (request.getParameter("opt") == null)
				{
                  oia = "../menu/menu1.jsp?opt=CTA";
				} 
				else
				{  
                  oia = "../menu/menu1.jsp?opt="+request.getParameter("opt");
				}
		}else{
				if (request.getParameter("op") == null)
						{
		                  oi = "/menu/menu.jsp?op="+"R";
						}
						else
						{
		                  oi = "/menu/menu.jsp?op="+request.getParameter("op");
						}
						if (request.getParameter("opt") == null)
						{
		                  oia = "/menu/menu1.jsp?opt=CTA";
						} 
						else
						{  
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
          <td width="100%" align="center"> 
            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
                <td class="trontrk" align="center"><%=trd.Traduz("INCLUIR PARTICIPANTES PLANEJADOS")%></td>
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
		  <FORM name = "frm" method="POST">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
                   <%
				  //CARGO
				  if(opt_filtro.equals("Cargo"))
				  {
					if(lotacao.equals("S"))
					{
					  %>
					  <tr>
					  	<td class="ctfontc"> <%=trd.Traduz("TABELA5")%>: </td>						
						<td>
							<select name="select_uni" onChange="return Unidade();">		
								<%
						   		//if(usu_tipo.equals("F")) {
									%>
										<option value = "-1"><%=trd.Traduz("Todos")%></option> 
									<%
								//}
					  			rs_uni = conexao.executaConsulta((String)querys.elementAt(1),session.getId()+"RS_1");
								if (rs_uni.next())
								{										
									do
									{
										if((rs_uni.getInt(1)) == (Integer.parseInt(unidade)))
										{
											%>
												<option selected value = "<%=rs_uni.getInt(1)%>"><%=rs_uni.getString(2)%></option>
										    <%
										}
											
										else
										{
											%>
												<option value = "<%=rs_uni.getInt(1)%>"><%=rs_uni.getString(2)%></option>
										    <%
										}
									}while (rs_uni.next());
									%> </select> <%									
							
								}
                                                                if(rs_uni!=null){
                                                                    rs_uni.close();
                                                                    conexao.finalizaConexao(session.getId()+"RS_1");
                                                                }
							%>
						</td>
						
					  	<td class="ctfontc"> <%=trd.Traduz("TABELA6")%>: </td> 	
						
						<td>
							<select name="select_dir" onChange="return Diretoria();"> <option value = "-1"><%=trd.Traduz("Todos")%></option> 
							<%
							rs_dir = conexao.executaConsulta((String)querys.elementAt(2),session.getId()+"RS_2");
							if (rs_dir.next())
							{								
								do
								{									
									if(!(diretoria.equals("")))
									{
										if((rs_dir.getInt(1)) == (Integer.parseInt(diretoria)))
										{																				%>
												<option selected value = "<%=rs_dir.getInt(1)%>"><%=rs_dir.getString(2)%></option>
										    <%
										}
											
										else
										{
											%>
												<option value = "<%=rs_dir.getInt(1)%>"><%=rs_dir.getString(2)%></option>
										    <%		
										}
									}
									else
									{
										%>
											<option value = "<%=rs_dir.getInt(1)%>"><%=rs_dir.getString(2)%></option>
									    <%
									}
								}while (rs_dir.next());
								%> </select> <%									
							
							}
                                                        if(rs_dir!=null){
                                                            rs_dir.close();
                                                            conexao.finalizaConexao(session.getId()+"RS_2");
                                                        }
							%>
						</td>
					</tr>					
					
					<tr>
						<td class="ctfontc"> <%=trd.Traduz("TABELA7")%>: </td> 											
 					  	<td>
							<select name="select_cel" onChange="return Celula();"> <option value = "-1"><%=trd.Traduz("Todos")%></option>
							<%
								rs_cel = conexao.executaConsulta((String)querys.elementAt(3),session.getId()+"RS_3");
								if (rs_cel.next())
								{								
									do
									{
										if(!(celula.equals("")))
										{
											if((rs_cel.getInt(1)) == (Integer.parseInt(celula)))
											{																			%>
													<option selected value = "<%=rs_cel.getInt(1)%>"><%=rs_cel.getString(2)%></option>
											    <%
											}
											
											else
											{
												%>
													<option value = "<%=rs_cel.getInt(1)%>"><%=rs_cel.getString(2)%></option>
											    <%		
											}
										}
										else
										{
											%>
												<option value = "<%=rs_cel.getInt(1)%>"><%=rs_cel.getString(2)%></option>
										    <%
										}
									}while (rs_cel.next());
									%> </select> <%									
							
								}
                                                                if(rs_cel!=null){
                                                                    rs_cel.close();
                                                                    conexao.finalizaConexao(session.getId()+"RS_3");
                                                                } 
							%>
						</td>
						
					  	<td class="ctfontc"> <%=trd.Traduz("TABELA8")%>: </td> 
						
						<td>
							<select name="select_tim" onChange="return Time();"> <option value = "-1"><%=trd.Traduz("Todos")%></option>
							<%
								rs_tim = conexao.executaConsulta((String)querys.elementAt(4),session.getId()+"RS_4");
								if (rs_tim.next())
								{									
									do
									{
										if(!(time.equals("")))
										{
											if((rs_tim.getInt(1)) == (Integer.parseInt(time)))
											{																			%>
													<option selected value = "<%=rs_tim.getInt(1)%>"><%=rs_tim.getString(2)%></option>
											    <%
											}
											
											else
											{
												%>
													<option value = "<%=rs_tim.getInt(1)%>"><%=rs_tim.getString(2)%></option>
											    <%		
											}
										}
										else
										{	
											%>
												<option value = "<%=rs_tim.getInt(1)%>"><%=rs_tim.getString(2)%></option>
										    <%
										}
									}while (rs_tim.next());
									%> </select> <%									
							
								}
                                                                if(rs_tim!=null){
                                                                rs_tim.close();
                                                                conexao.finalizaConexao(session.getId()+"RS_4");
                                                                }
							%>
						</td>
					  </tr>
					  <%				  
					}
				  }
				  %>
				  
				  <tr>
				  	<td colspan="100%">&nbsp;  </td>
				  </tr>
				  				 
                  <td colspan = "4" height="20" class="ctfontc" align="center">&nbsp;  <%=trd.Traduz("LOCALIZAR POR FUNCIONARIO")%>: 
                    <input type="text" name="textfield" value="<%=loc%>">
					&nbsp; <%=trd.Traduz("OPCOES")%>: 
                    <select name="select2" class="form" onChange="return Filtro();">
					<option value ="<%=opt_filtro%>"><%=trd.Traduz(opt_filtro)%></option>				
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
                    &nbsp; <%=trd.Traduz("FILTRO")%>: <select name="select">
                      <option value = "Todos">Todos</option>
<%
if(opt_filtro.equals("Cargo"))
{
	if(lotacao.equals("S"))
	rs = conexao.executaConsulta((String)querys.elementAt(0),session.getId()+"RS_5");
	else
        rs = conexao.executaConsulta(query,session.getId()+"RS_5");
}
else	
	rs = conexao.executaConsulta(query,session.getId()+"RS_5");
if (rs.next())
{
 do
 {
	 if (sel == rs.getInt(1)){%>	 
                      <option value = "<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>  
     <%}else{%>
                      <option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>  
     <%}
 }
 while (rs.next());
}
if(rs!=null){
    rs.close();
    conexao.finalizaConexao(session.getId()+"RS_5");
}
%>
                    </select>                     
                    <br><br>

<%                  if (request.getParameter("primeira") != null) {
                        if(request.getParameter("Check1") == null){%>
                            <input type="checkbox" name="Check1">
                            <%=trd.Traduz("VISUALIZAR ATIVO")%> 
<%                      } else {%>
                            <input checked type="checkbox" name="Check1">
                            <%=trd.Traduz("VISUALIZAR ATIVO")%> 
<%                      }
                    } else {%>
                        <input checked type="checkbox" name="Check1">
                        <%=trd.Traduz("VISUALIZAR ATIVO")%>
<%                  }
                    if (request.getParameter("Check2") != null) {%>
                        <input type="checkbox" name="Check2" checked> 
                        <%=trd.Traduz("VISUALIZAR TERCEIRO")%>
<%                  } else {%>
                        <input type="checkbox" name="Check2"> 
                        <%=trd.Traduz("VISUALIZAR TERCEIRO")%>
<%                  }%>
                    <br>
                    &nbsp; &nbsp;<br> <input type="button" onClick="return envia();" value=<%=("\""+trd.Traduz("FILTRAR")+"\"")%> class="botcin" name="button">	
                  </td>
              </tr>
              
              <tr> 
                <td height="12" colspan="4"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                <td class="ctvdiv" colspan="4" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
	        <td height="12" colspan="4"><img src="../art/bit.gif" width="1" height="1"></td>
	      </tr>
              <tr align="center">
                <td class="ctfontc" valign="middle" colspan="4"> * - <%=trd.Traduz("TERCEIRO")%> </td>
              </tr>
              <tr> 
                <td height="12" colspan="4"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                <td class="ctvdiv" height="1" colspan="4"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              
              <tr> 
                <td height="12" colspan="4"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
	       </table>
	       		<center>
              <table border="0" width='100%'>
              <tr> 
                <td>&nbsp;
                    <center>
                      <table border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td> 
                            <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                              <tr> 
                                <td onMouseOver="this.className='ctonlnk2';" onClick="solicex();" width="127" height="22" align=center class="botver"><a href="#" onClick = "return solicex();" class="txbotver"><%=trd.Traduz("INCLUIR")%></a></td>
                              </tr>
                            </table>
                          </td>                          
                          <td>&nbsp;&nbsp;</td>
                          <td> 
                            <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                              <tr> 
                                <td onMouseOver="this.className='ctonlnk2';" onClick="cancela();" width="127" height="22" align=center class="botver"><a href="#" onClick = "return cancela();" class="txbotver"><%=trd.Traduz("CANCELAR")%></a></td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                      </table>
                    <br>
                    <table border="0" cellspacing="1" cellpadding="2" width="100%">
<%                    //Dados do curso escolhido
                      ResultSet rsTurma;
                      String queryTurma = "SELECT C.CUR_NOME, T.TUR_DATAINICIO, T.TUR_DATAFINAL, T.TUR_VAGAS " +
                                          "FROM TURMA T, CURSO C "+
                                          "WHERE T.CUR_CODIGO = C.CUR_CODIGO AND T.TUR_CODIGO = " +turma;
                      rsTurma = conexao.executaConsulta(queryTurma,session.getId()+"RS_6");
                      if (rsTurma.next()) {
                        String dataf="", datai="";
						SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
                        java.util.Date data1 = rsTurma.getDate(2);
                        java.util.Date data2 = rsTurma.getDate(3);
						datai = formato.format(data1);
						dataf = formato.format(data2);%>
                        <tr>
                            <td colspan="100%" align="left" class="ftverdanacinza"> <%=trd.Traduz("Curso")%>:<a class="lnk" href="10_turmaantecipada_reg.jsp?turma=<%=turma%>"> <%=rsTurma.getString(1)%>
                                &nbsp;
                                <%=trd.Traduz("Data inicial")%>:&nbsp;<%=datai%>
                                &nbsp;-&nbsp;
                                <%=trd.Traduz("Data final")%>:&nbsp;<%=dataf%>
                                &nbsp;-&nbsp;
                                <%=trd.Traduz("Vagas")%>:&nbsp;<%=rsTurma.getString(4)%>
                            </a></td>
                        </tr>
<%                    }
                        if(rsTurma!=null){
                        rsTurma.close();
                        conexao.finalizaConexao(session.getId()+"RS_6");
                        }
                        %>
                      <tr><td>&nbsp;</td></tr>
                      <tr>
                      	<%
                      	if(existe){
                      	%>
                        <td width="4%" height="28">&nbsp;</td>
                        <td width="4%" class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("CHAPA")%></div>
                        </td>
                        <td width="20%" class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("NOME")%></div>
                        </td>
                        <td width="12%" class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("CARGO")%></div>
                        </td>
                        <td width="12%" class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("FILIAL")%></div>
                        </td>
                        <td width="12%" class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("DEPARTAMENTO")%></div>
                        </td>
					<%if (prm.buscaparam("USE_TB2").equals("S"))
                    {%>
                        <td width="12%" class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("TABELA2")%></div>
                        </td>
					<%}%>
					<%if (prm.buscaparam("USE_TB3").equals("S"))
                    {%>
                        <td width="12%" class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("TABELA3")%></div>
                        </td>
					<%}%>
                        <td width="12%" class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("SOLICITANTE")%></div>
                        </td>
                        <%
                        }
                        else{
                        	%>
                        	<td class="celtittab" align="center" colspan="100%"><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...</td>
                        	<%
                        }
                        %>
                      </tr>

<%               //Faz o loop no nº de vezes da paginaCAo
                 //out.println(query_grid);
                 for(int i=1 ; i<=pag;i++) {
                     if (rsgrid.next()) {
                     valor = valor + 1;%>
                     <tr class="celnortab"> 
<%                      String teste = "";
                        if(rsgrid.getString(11) == null)
                          teste = "";
                        else
                          teste = rsgrid.getString(11);%>
<%                      if (funcvet.contains(rsgrid.getString(10))){%>                          
                            <td width="4%"><input type="checkbox" name="checkbox<%=i%>" value="<%=rsgrid.getString(10)%>" checked></td>
<%                          funcvet.remove(rsgrid.getString(10));
                        } else {%>
                            <td width="4%"><input type="checkbox" name="checkbox<%=i%>" value="<%=rsgrid.getString(10)%>"></td>
<%                      }%>
                        <td width="4%"><div align="center"><%=((rsgrid.getString(2)==null)?"":rsgrid.getString(2))%></div></td>                        	                        	
                        <td width="20%">
                        <%
                        if(rsgrid.getString(12).equals("S"))
                        {
                        	%>*
                        	<%=((rsgrid.getString(3)==null)?"":rsgrid.getString(3))%></td>
                        	<%
                        }
                        else
                        {
                        	%>
                        	<%=((rsgrid.getString(3)==null)?"":rsgrid.getString(3))%></td>
                        	<%
                        }
                        %>
                        <td width="12%"><%=((rsgrid.getString(4)==null)?"":rsgrid.getString(4))%></td>
                        <td width="12%"><%=((rsgrid.getString(8)==null)?"":rsgrid.getString(8))%></td>
                        <td width="12%"><%=((rsgrid.getString(5)==null)?"":rsgrid.getString(5))%></td>
					<%if (prm.buscaparam("USE_TB2").equals("S"))
                    {%>
                        <td width="12%"><%=((rsgrid.getString(7)==null)?"":rsgrid.getString(7))%></td>
					<%}%>
					<%if (prm.buscaparam("USE_TB3").equals("S"))
                    {%>
                        <td width="12%"><%=((rsgrid.getString(6)==null)?"":rsgrid.getString(6))%></td>
					<%}%>
                        <td width="12%"><%=((rsgrid.getString(9)==null)?"":rsgrid.getString(9))%></td>
                      </tr>
<%                    cont++;
                      }

                  }
                  %>
                    </table>
                  </td>
                  </center>
              </tr>
              <tr> 
                <td height="30" colspan="3"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="5">
                    <tr>
                        <td align="left" class="ctfontc" width="16%"><%=trd.Traduz("PAGINA")%> 
                          <b><%=pagatual%></b> <%=trd.Traduz("DE")%> <b><%=pagtotal%></b></td>
                        <td align="right" class="ctfontc" width="16%"><%=trd.Traduz("Total de")%> 
                          <b><%=tot%></b> <%=trd.Traduz("PESSOAS")%></td>
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
			<input type="hidden" name="pa">
			<input type="hidden" name="ia">
			<input type="hidden" name="extra">
			<input type="hidden" name="turma" value = "<%=turma%>">
                      <td class="ctfontc" width="17%"> <a href="#" onClick = "return PrimeiraPag();" class="ctoflnkb"><%=trd.Traduz("Primeira PAgina")%></a> </td>
					  <%if(!primeiro.equals("1")){%>
                        <td class="ctfontc" width="17%"><a href="#" value = "<%=valorAnt%>" onClick = "return AnteriorPag(this);" class="ctoflnkb"><%=trd.Traduz("PAgina Anterior")%></a></td> 
						<td class="ctfontc" width="17%"><a><%=trd.Traduz("PAGINA")%> <input type="text" name="textir2" size="3">
                        <input type="button" name="ir2" class="botcin" value="  <%=trd.Traduz("IR")%>  " onClick="return irpag2();"> </a></td>
                      <%}else{%>
                        <td class="ctfontc" width="17%"><a><%=trd.Traduz("PAgina Anterior")%></a></td>
                        <td class="ctfontc" width="17%"><a><%=trd.Traduz("PAGINA")%> <input type="text" name="textir" size="3">
                        <input type="button" name="ir" class="botcin" value="  <%=trd.Traduz("IR")%>  " onClick="return irpag();"> </a></td>
					  <%}
                       if (valor <= tot){%>
                        <td align="right" class="ctfontc" width="17%"><a href="#" value = "<%=valor%>"  onClick = "return ProximaPag(this);" class="ctoflnkb"><%=trd.Traduz("PrOxima PAgina")%></a></td>
                      <%}else
                      {%>
                        <td align="right" class="ctfontc" width="17%"><a><%=trd.Traduz("PrOxima PAgina")%></a></td>
                      <%}%>
                      <td align="right" class="ctfontc" width="16%"><a href="#" name="valor" value = "<%=((pagtotal*pag)-(pag-1))%>" onClick = "return ProximaPag(this);" class="ctoflnkb"><%=trd.Traduz("Ultima PAgina")%></a></td>
                    </tr>
                  </table>
                </td>
              </tr>
			  			  
            </table>
          </td>
                <input type="hidden" name="contador" value="<%=pag%>">				
				<input type="hidden" name="turma" value="<%=turma%>">
                <input type="hidden" name="origem" value="result_filtro">
                <input type="hidden" name="apagavetor" value="N">
                <input type="hidden" name="primeira" value="N">
		  </FORM>
          <td width="20" valign="top"></td>
        </tr>
      </table>
    </td>
  </tr>
  	<tr>
  		<td>&nbsp;
  		</td>
  	</tr>
  <tr> 
    <td align="right" height="30" class="difundo"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td> <%   if(ponto.equals("..")){%>
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

if(rsgrid != null) {
    rsgrid.close();
    conexao.finalizaConexao(session.getId()+"PAG");
}
//} catch(Exception t){
  //out.println(""+t);
//}
%>
