

<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1"))
 response.setHeader("Cache-Control", "no-cache");
%>

<%@page import=" java.sql.*, java.text.*"%>

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
Integer usu_plano = (Integer)session.getAttribute("usu_plano");  

String from = "";

String moeda = prm.buscaparam("MOEDA");

try {

//Variaveis da pagina
String pag_filial = (request.getParameter("sel_filial")==null)?"":request.getParameter("sel_filial");
String pag_depto = (request.getParameter("sel_depto")==null)?"":request.getParameter("sel_depto");
String pag_tab2 = (request.getParameter("sel_tabela2")==null)?"":request.getParameter("sel_tabela2");
String pag_tab3 = (request.getParameter("sel_tabela3")==null)?"":request.getParameter("sel_tabela3");
String pag_cargo = (request.getParameter("sel_cargo")==null)?"":request.getParameter("sel_cargo");
String pag_tab1 = (request.getParameter("sel_tabela1")==null)?"":request.getParameter("sel_tabela1");
String pag_empresa = (request.getParameter("sel_empresa")==null)?"":request.getParameter("sel_empresa");
String pag_curso = (request.getParameter("sel_curso")==null)?"":request.getParameter("sel_curso");
String pag_titulo = (request.getParameter("sel_titulo")==null)?"":request.getParameter("sel_titulo");
String pag_tab4 = (request.getParameter("sel_tabela4")==null)?"":request.getParameter("sel_tabela4");
String pag_func = (request.getParameter("sel_funcionario")==null)?"":request.getParameter("sel_funcionario");
String pag_solic = (request.getParameter("sel_solic")==null)?"":request.getParameter("sel_solic");
String pag_dt_inicio = (request.getParameter("text_datainicio")==null)?"":request.getParameter("text_datainicio");
String pag_dt_fim = (request.getParameter("text_datafinal")==null)?"":request.getParameter("text_datafinal");
String pag_rdo_dados = (request.getParameter("rb_dados")==null)?"":request.getParameter("rb_dados");
String pag_rdo_relat = (request.getParameter("rb_relat")==null)?"E":request.getParameter("rb_relat");
String pag_plano = (request.getParameter("sel_plano")==null)?"":request.getParameter("sel_plano");
String pag_tipo = (request.getParameter("sel_tipo")==null)?"":request.getParameter("sel_tipo");
String pag_ord = (request.getParameter("rb_ord")==null)?"":request.getParameter("rb_ord");

ResultSet rs = null, rs2 = null;
String query="", query2="", query_dt="", ord="",  classe="ftverdanapreto2";
String cor="", filtros="", str_curso="", str_dtinic="", str_funcion="", str_data="", str_data2="", data_inicial="", data_final="", planoTitulo="",query_pla = "";
int solic = 0, depto = 0, plano = 0, tabela1 = 0, tabela2 = 0, tabela3 = 0, tabela4 = 0, tabela5 = 0, tabela6 = 0, tabela7 = 0;
int tabela8 = 0, filial = 0, tipo = 0, cargo = 0, curso = 0, titulo = 0, empresa = 0, funcion = 0, int_turma = 0;
int total_func = 0, primeira = 0;
//boolean muda = true, ou = false;
SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
String tit_curso="";

if(!pag_empresa.equals("")) 
	from = "EMPRESA E, ";
if(!pag_titulo.equals("")) 
	from = from + "TITULO TI, ";

//Checagem de demitidos e terceiros
String fun_filtro = "";

if(request.getParameter("check_d") != null && request.getParameter("check_a") == null && request.getParameter("check_t") == null) {//demitido
    fun_filtro = " AND F.FUN_DEMITIDO = 'S' ";
} else 
if(request.getParameter("check_d") == null && request.getParameter("check_a") != null && request.getParameter("check_t") == null) {//ativo
    fun_filtro = " AND F.FUN_TERCEIRO = 'N' AND F.FUN_DEMITIDO = 'N' ";
} else
if(request.getParameter("check_d") == null && request.getParameter("check_a") == null && request.getParameter("check_t") != null) {//terceiro
    fun_filtro = " AND F.FUN_TERCEIRO = 'S' ";
} else 
if(request.getParameter("check_d") != null && request.getParameter("check_a") != null && request.getParameter("check_t") == null) {//demitido e ativo
    fun_filtro = " AND ((F.FUN_DEMITIDO = 'S') OR (F.FUN_TERCEIRO = 'N' AND F.FUN_DEMITIDO = 'N')) ";
} else
if(request.getParameter("check_d") != null && request.getParameter("check_t") != null && request.getParameter("check_a") == null) {//demitido e terceiro
    fun_filtro = " AND ((F.FUN_DEMITIDO = 'S') OR (F.FUN_TERCEIRO = 'S')) ";
} else
if(request.getParameter("check_a") != null && request.getParameter("check_t") != null && request.getParameter("check_d") == null) {//ativo e terceiro
    fun_filtro = " AND ((F.FUN_TERCEIRO = 'N' AND F.FUN_DEMITIDO = 'N') OR (F.FUN_TERCEIRO = 'S')) ";
} else
if(request.getParameter("check_d") != null && request.getParameter("check_a") != null && request.getParameter("check_t") != null)//demitido, ativo e terceiro
    fun_filtro = " AND ((F.FUN_DEMITIDO = 'S') OR (F.FUN_TERCEIRO = 'N' AND F.FUN_DEMITIDO = 'N') OR (F.FUN_TERCEIRO = 'S')) ";

if(!(pag_dt_inicio.equals(""))) {
    data_inicial = pag_dt_inicio;
    query_dt = "AND T.TEF_INICIO >= DATEFMT("+data_inicial+") ";
    filtros = filtros + "<BR>" + trd.Traduz("DATA INICIAL") + ": " + data_inicial;
}

if(!(pag_dt_fim.equals(""))) {
    data_final = pag_dt_fim;
    query_dt = query_dt + "AND T.TEF_FIM <= DATEFMT("+data_final+") ";
    filtros = filtros + "<BR>" + trd.Traduz("DATA FINAL") + ": " + data_final;
}

if(!pag_plano.equals("")) {
  plano = Integer.parseInt(pag_plano);
  if(plano >= 0) {
    query_pla = "AND T.PLA_CODIGO = "+plano+" ";
  }
  else
  {
    query_pla = "";
  }
}
else
{
    query_pla = "";
}

String ftipo = "";
if(!pag_tipo.equals("")) {
  tipo = Integer.parseInt(pag_tipo);
  if(tipo > 0) {
    ftipo = "AND T.CUR_CODIGO IN (SELECT CUR_CODIGO FROM CURSO WHERE TCU_CODIGO = "+tipo+") ";
    //FILTRO
    query2 = "SELECT TCU_NOME FROM TIPOCURSO WHERE TCU_CODIGO = "+tipo;
    rs2 = conexao.executaConsulta(query2,session.getId()+"RS8");
    if(rs2.next())
      filtros = filtros + "<BR>" + trd.Traduz("TIPO CURSO") + ": " + rs2.getString(1);
    if(rs2 != null){
         rs2.close();
         conexao.finalizaConexao(session.getId()+"RS8");
    }
  }
}

String filtro_curso = "";
if(!pag_curso.equals("")) {
  curso = Integer.parseInt(pag_curso);
  if(curso > 0)	{
    filtro_curso = " AND C.CUR_CODIGO = "+curso+" ";
    
    //FILTRO
    query2 = "SELECT DISTINCT CUR_NOME FROM CURSO WHERE CUR_CODIGO = "+curso;
    rs2	= conexao.executaConsulta(query2,session.getId()+"RS10");
    if(rs2.next())
      filtros = filtros + "<BR>" + trd.Traduz("CURSO") + ": " + rs2.getString(1);
    if(rs2 != null){
         rs2.close();
         conexao.finalizaConexao(session.getId()+"RS10");
    }
  }
}

if(pag_curso.equals(""))
{
	query = "SELECT DISTINCT F.FUN_CHAPA, F.FUN_NOME, A.CAR_NOME, I.FIL_NOME, D.DEP_NOME, "+
			"T8.TB8_DESCRICAO, F.FUN_NOME, F.FUN_DEMITIDO, F.FUN_TERCEIRO "+ 
			"FROM "+from+" FUNCIONARIO F, CARGO A, DEPTO D, FILIAL I, TABELA8 T8 "+
			"WHERE F.FUN_CODIGO IN (SELECT DISTINCT T.FUN_CODIGO FROM TREINAMENTO T, "+
			"TIPOTREINAMENTO P WHERE T.TUR_CODIGO_REAL IS NULL AND P.TTR_CODIGO = T.TTR_CODIGO " + query_pla + " " + ftipo + ") "+
			"AND F.CAR_CODIGO = A.CAR_CODIGO AND A.TB8_CODIGO *= T8.TB8_CODIGO "+
			"AND F.DEP_CODIGO = D.DEP_CODIGO " + fun_filtro; 
}
else
{
	query = "SELECT DISTINCT F.FUN_CHAPA, F.FUN_NOME, A.CAR_NOME, I.FIL_NOME, D.DEP_NOME, "+
			"T8.TB8_DESCRICAO, F.FUN_NOME, F.FUN_DEMITIDO, F.FUN_TERCEIRO "+ 
			"FROM "+from+" FUNCIONARIO F, CARGO A, DEPTO D, FILIAL I, TABELA8 T8 "+
			"WHERE F.FUN_CODIGO IN (SELECT DISTINCT T.FUN_CODIGO FROM TREINAMENTO T, "+
			"TIPOTREINAMENTO P, CURSO C WHERE C.CUR_CODIGO = "+pag_curso+" AND T.TUR_CODIGO_REAL IS NULL "+
			"AND P.TTR_CODIGO = T.TTR_CODIGO AND C.CUR_CODIGO = T.CUR_CODIGO " + query_pla + " " + ftipo + ") "+
			"AND F.CAR_CODIGO = A.CAR_CODIGO AND A.TB8_CODIGO *= T8.TB8_CODIGO "+
			"AND F.DEP_CODIGO = D.DEP_CODIGO " + fun_filtro; 
}
// *********** FILTROS **********
if(!pag_solic.equals("")) {
  solic = Integer.parseInt(request.getParameter("sel_solic"));	
  if(solic > 0) {
    query = query + "AND F.FUN_CODSOLIC = "+solic+" "; 
    //FILTRO
    query2 = "SELECT DISTINCT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = "+solic;
    rs2 = conexao.executaConsulta(query2,session.getId()+"RS1");
    if(rs2.next())
      filtros = filtros + "<BR>" + trd.Traduz("SOLICITANTE") + ": " + rs2.getString(1);
    if(rs2 != null){
         rs2.close();
         conexao.finalizaConexao(session.getId()+"RS1");
    }
  }
}

if(!pag_depto.equals("")) {
  depto = Integer.parseInt(pag_depto);
  if(depto > 0) {
    query = query + "AND D.DEP_CODIGO = "+depto+" "+ 			
            "AND F.DEP_CODIGO = D.DEP_CODIGO ";
    //FILTRO
    query2 = "SELECT DEP_NOME FROM DEPTO WHERE DEP_CODIGO = "+depto;
    rs2 = conexao.executaConsulta(query2,session.getId()+"RS2");
    if(rs2.next())
      filtros = filtros + "<BR>" + trd.Traduz("DEPARTAMENTO") + ": " + rs2.getString(1);
    if(rs2 != null){
         rs2.close();
         conexao.finalizaConexao(session.getId()+"RS2");
    }
  }
}

if(!pag_tab1.equals("")) {
  tabela1 = Integer.parseInt(pag_tab1);
  if(tabela1 > 0) {
    query = query + " AND F.TB1_CODIGO = " +tabela1+ " ";
    //FILTRO
    query2 = "SELECT TB1_NOME FROM TABELA1 WHERE TB1_CODIGO = "+tabela1;
    rs2 = conexao.executaConsulta(query2,session.getId()+"RS3");
    if(rs2.next())		
      filtros = filtros + "<BR>" + trd.Traduz("TABELA1") + ": " + rs2.getString(1);
    if(rs2 != null){
         rs2.close();
         conexao.finalizaConexao(session.getId()+"RS3");
    }
  }
}

if(!pag_tab2.equals("")) {
  tabela2 = Integer.parseInt(pag_tab2);
  if(tabela2 > 0){
    query = query + "AND F.TB2_CODIGO = " +tabela2+ " ";
    //FILTRO
    query2 = "SELECT TB2_NOME FROM TABELA2 WHERE TB2_CODIGO = "+tabela2;
    rs2 = conexao.executaConsulta(query2,session.getId()+"RS4");
    if(rs2.next())
      filtros = filtros + "<BR>" + trd.Traduz("TABELA2") + ": " + rs2.getString(1);			
    if(rs2 != null){
         rs2.close();
         conexao.finalizaConexao(session.getId()+"RS4");
    }
  }
}

if(!pag_tab3.equals("")) {
  tabela3 = Integer.parseInt(pag_tab3);
  if(tabela3 > 0){
    query = query + "AND F.TB3_CODIGO = " +tabela3+ " ";
    //FILTRO
    query2 = "SELECT TB3_DESCRICAO FROM TABELA3 WHERE TB3_CODIGO = "+tabela3;
    rs2 = conexao.executaConsulta(query2,session.getId()+"RS5");
    if(rs2.next())
      filtros = filtros + "<BR>" + trd.Traduz("TABELA3") + ": " + rs2.getString(1);
    if(rs2 != null){
         rs2.close();
         conexao.finalizaConexao(session.getId()+"RS5");
    }
  }
}

if(!pag_tab4.equals("")) {
  tabela4 = Integer.parseInt(pag_tab4);
  if(tabela4 > 0){
    query = query + "AND F.TB4_CODIGO = " +tabela4+ " ";
    //FILTRO
    query2 = "SELECT TB4_DESCRICAO FROM TABELA4 WHERE TB4_CODIGO = "+tabela4;
    rs2 = conexao.executaConsulta(query2,session.getId()+"RS6");
    if(rs2.next())
      filtros = filtros + "<BR>" + trd.Traduz("TABELA4") + ": " + rs2.getString(1);
    if(rs2 != null){
         rs2.close();
         conexao.finalizaConexao(session.getId()+"RS6");
    }
  }
}

if(!pag_filial.equals("")) {
  filial = Integer.parseInt(pag_filial);
  if(filial > 0) {
    query = query + "AND I.FIL_CODIGO = "+filial+" "+
	    "AND F.FIL_CODIGO = I.FIL_CODIGO ";
    //FILTRO
    query2 = "SELECT FIL_NOME FROM FILIAL WHERE FIL_CODIGO = "+filial;
    rs2 = conexao.executaConsulta(query2,session.getId()+"RS7");
    if(rs2.next())
      filtros = filtros + "<BR>" + trd.Traduz("FILIAL") + ": " + rs2.getString(1);
    if(rs2 != null){
         rs2.close();
         conexao.finalizaConexao(session.getId()+"RS7");
    }
  }
}

if(!pag_cargo.equals("")) {
  cargo = Integer.parseInt(pag_cargo);
  if(cargo > 0) {
    query = query + "AND A.CAR_CODIGO = "+cargo+" "+
            "AND F.CAR_CODIGO = A.CAR_CODIGO "; 	
    //FILTRO
    query2 = "SELECT CAR_NOME FROM CARGO WHERE CAR_CODIGO = "+cargo;
    rs2 = conexao.executaConsulta(query2,session.getId()+"RS9");
    if(rs2.next())
      filtros = filtros + "<BR>" + trd.Traduz("CARGO") + ": " + rs2.getString(1);
    if(rs2 != null){
         rs2.close();
         conexao.finalizaConexao(session.getId()+"RS9");
    }
  }
}

if(!pag_titulo.equals("")) {
  titulo = Integer.parseInt(request.getParameter("sel_titulo"));
  if(titulo > 0) {
    query = query + "AND TI.TIT_CODIGO = "+titulo+" "+
                    "AND C.TIT_CODIGO = TI.TIT_CODIGO ";
    //FILTRO
    query2 = "SELECT TIT_NOME FROM TITULO WHERE TIT_CODIGO = "+titulo;
    rs2 = conexao.executaConsulta(query2,session.getId()+"RS11");
    if(rs2.next())
      filtros = filtros + "<BR>" + trd.Traduz("TITULO") + ": " + rs2.getString(1);
    if(rs2 != null){
         rs2.close();
         conexao.finalizaConexao(session.getId()+"RS11");
    }
  }
}

if(!pag_empresa.equals("")) {
  empresa = Integer.parseInt(pag_empresa);
  if(empresa > 0) {
    query = query + "AND E.EMP_CODIGO = "+empresa+" "+
		    "AND T.EMP_CODIGO = E.EMP_CODIGO ";
    //FILTRO
    query2 = "SELECT EMP_NOME FROM EMPRESA WHERE EMP_CODIGO = "+empresa;
    rs2 = conexao.executaConsulta(query2,session.getId()+"RS12");
    if(rs2.next())
      filtros = filtros + "<BR>" + trd.Traduz("EMPRESA") + ": " + rs2.getString(1);
    if(rs2 != null){
         rs2.close();
         conexao.finalizaConexao(session.getId()+"RS12");
    }
  }
}

if(!pag_func.equals("")) {
  funcion = Integer.parseInt(pag_func);
  if(funcion > 0) {
    query = query + "AND F.FUN_CODIGO = "+funcion+" ";
    //FILTRO
    query2 = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = "+funcion;
    rs2 = conexao.executaConsulta(query2,session.getId()+"RS13");
    if(rs2.next())
      filtros = filtros + "<BR>" + trd.Traduz("FUNCIONARIO") + ": " + rs2.getString(1);
   if(rs2 != null){
         rs2.close();
         conexao.finalizaConexao(session.getId()+"RS13");
    }
  }
}

if(!pag_plano.equals("")) {
  plano = Integer.parseInt(pag_plano);
  if(plano >= 0) {
    //FILTRO
    query2 = "SELECT PLA_NOME FROM PLANO WHERE PLA_CODIGO = "+plano;
    rs2 = conexao.executaConsulta(query2,session.getId()+"RS14");
    if(rs2.next()) {
      filtros = filtros + "<BR>" + trd.Traduz("PLANO") + ": " + rs2.getString(1);
      planoTitulo = rs2.getString(1);   
    }
    if(rs2 != null){
         rs2.close();
         conexao.finalizaConexao(session.getId()+"RS14");
    }
  }
} else {
  query2 = "SELECT PLA_NOME FROM PLANO ORDER BY PLA_NOME";
  rs2 = conexao.executaConsulta(query2,session.getId()+"RS15");
  if(rs2.next())
    do {
      if(!planoTitulo.equals(""))
        planoTitulo = planoTitulo + "-" + rs2.getString(1);
      else
        planoTitulo = planoTitulo + rs2.getString(1);
    } while (rs2.next());
  if(rs2 != null){
         rs2.close();
         conexao.finalizaConexao(session.getId()+"RS15");
  } 
}
// *********** FILTROS **********

//************ ORDENACAO **********
if (pag_ord.equals("C")) query = query + " ORDER BY F.FUN_CHAPA ";
if (pag_ord.equals("FU")) query = query + " ORDER BY F.FUN_NOME ";
if (pag_ord.equals("FI")) query = query + " ORDER BY I.FIL_NOME ";
if (pag_ord.equals("D")) query = query + " ORDER BY D.DEP_NOME ";
if (pag_ord.equals("T")) query = query + " ORDER BY T8.TB8_DESCRICAO ";
//************ ORDENACAO **********

if (filtros.equals(""))
  filtros = trd.Traduz("NENHUM");
%>

<%!//funcao para formatacao $$
public String ReaistoStr(float valor){
  DecimalFormat dcf = new DecimalFormat("0.00");
  dcf.setMaximumFractionDigits(2);
  String strReais = dcf.format(valor);
  return strReais;
}
%>

<%! public String convHora(float minutos) {
  Float ft = new Float(minutos);
  int min = ft.intValue();
  String total = "";
  float result;
  int inteiro = 0, decimal = 0;
  result = min / 60;
  Float ft2 = new Float(result);
  inteiro = ft2.intValue();
  decimal = min % 60;
  if((decimal < 10)||(decimal == 0))
    total = inteiro + ":0" + decimal;
  else
    total = inteiro + ":" + decimal;
  return total;
}
%>

<%!//funcao para somar totais de horas
public float somaHoras(float somando1, float somando2) {
  Float somando1_F = new Float(somando1);
  Float somando2_F = new Float(somando2);
  float resultado=0, decimal=0, inteiro=0;
  inteiro = somando2_F.intValue() + somando1_F.intValue();
  decimal = ((somando1 - somando1_F.intValue()) + (somando2 - somando2_F.intValue()));
  if (decimal >= 0.59f){
    resultado = 1 + (decimal - 0.60f) + inteiro;
  } else {
    resultado = decimal + inteiro;
  }
  return resultado;
}
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("ImpressOes")%> - <%=trd.Traduz("Relatorio de Treinamentos nao Efetuados")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../art/onenglish.gif','../art/onespanol.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="20">&nbsp;</td>
          <td width="100%"> 
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
              <tr> 
                <td class="trcurso" ><img src="../art/Logo_Cliente.gif" width="317" height="42"></td>                                            
              </tr>			  
	      <tr>
                <td class="trontrk" width="100%" align="center"><%=trd.Traduz("Relatorio de Treinamentos nao Efetuados")%> / <%=planoTitulo%></td>                              
              </tr>
            </table>
          </td>
          <td width="20">&nbsp;</td>
        </tr>        				
        <tr> 
          <td width="20" valign="top"></td>
	  <FORM name="frm">
          <td valign="top"> &nbsp;<br>
	    <table width="100%" border="0" cellspacing="1" cellpadding="3">                 
	      <tr>
		<td width="48%" class="ftverdanapreto"> <%=trd.Traduz("FILTROS ESCOLHIDOS")%>: <span class="ftverdanacinza"> <%=filtros%> </span></td>
              </tr>
              <tr>
		<td width="48%" class="ftverdanapreto">&nbsp;  </td>
		<td width="18%" class="ftverdanacinza"> ** - <%=trd.Traduz("DEMITIDO")%> </td>
		<td width="18%" class="ftverdanacinza"> * - <%=trd.Traduz("TERCEIRO")%> </td>
              </tr>
	    </table>

<%
	//out.println("query = " + query);
            rs = null;
	 	    rs = conexao.executaConsulta(query,session.getId()+"RS16");
            cor = "#FFFFFF";
            if(rs.next()) {
	      do {
				total_func++;
                if (primeira == 0) {%>
		<table width="100%" border="0" cellspacing="1" cellpadding="2">
		  <tr class="celtitrela"> 
                    <td width="5%"  align="center"><%=trd.Traduz("CHAPA")%></td>
                    <td width="20%"  align="center"><%=trd.Traduz("NOME")%></td>
                    <td width="15%"  align="center"><%=trd.Traduz("CARGO")%></td>
                    <td width="15%"  align="center"><%=trd.Traduz("FILIAL")%></td>
                    <td width="15%"  align="center"><%=trd.Traduz("DEPARTAMENTO")%></td>
                    <td width="15%"  align="center"><%=trd.Traduz("TIME")%></td>
                    <td width="15%"  align="center"><%=trd.Traduz("SOLICITANTE")%></td>
		  </tr>
<%              }
                  classe = "ftverdanapreto2";
				  %>

							
		<tr bgcolor="<%=cor%>">
		<td width="5%" class="<%=classe%>"> <%=((rs.getString(1)==null)?"":rs.getString(1))%></td>
		<td width="20%" class="<%=classe%>">							
<%		if(((rs.getString(8)==null)?"":rs.getString(8)).equals("S")) {%>
                    ** <%=((rs.getString(2)==null)?"":rs.getString(2))%></td>
<%              }
                else if(((rs.getString(9)==null)?"":rs.getString(9)).equals("S")) 
                {%>
                    *  <%=((rs.getString(2)==null)?"":rs.getString(2))%></td>
<%              }
                else
                {%>
                       <%=((rs.getString(2)==null)?"":rs.getString(2))%></td>
<%              }%>
		</td>
                <td width="15%"  class="<%=classe%>"> <%=((rs.getString(3)==null)?"":rs.getString(3))%> </td>
                <td width="15%" class="<%=classe%>"> <%=((rs.getString(4)==null)?"":rs.getString(4))%> </td>
                <td width="15%"  class="<%=classe%>"> <%=((rs.getString(5)==null)?"":rs.getString(5))%> </td>
                <td width="15%"  class="<%=classe%>"> <%=((rs.getString(6)==null)?"":rs.getString(6))%> </td>
                <td width="15%"  class="<%=classe%>"> <%=((rs.getString(7)==null)?"":rs.getString(7))%> </td>	
	      </tr>												
<%            if(cor.equals("#FFFFFF"))
		cor = "#EEEEEE";
	      else
		cor = "#FFFFFF";
              primeira++;
	    } while(rs.next());%>                                
	    <tr>
	      <td colspan="12"> &nbsp;  </td>
	    </tr>
	    <tr>
	      <td colspan="100%" class="celcin" align="center"><%=trd.Traduz("TOTAL DE FUNCIONARIOS")%> = <%=total_func%></td>
	    </tr>

<%            } else {%>
          <p>&nbsp;
          <table width="100%" border="0" cellspacing="1" cellpadding="2">
          <tr> 
            <td align="center" class="celbrarela"><%=trd.Traduz("NENHUM ITEM SELECIONADO")%></td>
          </tr>
          <tr> 
            <td align="center" class="celbrarela"><a class="lnk" href="01_treinamentos.jsp"><%=trd.Traduz("Voltar")%></a></tr>
          </tr>
        </table>
<%            }
              if(rs != null){
                  rs.close();
                  conexao.finalizaConexao(session.getId()+"RS16");
              }
 %>
	  </FORM>
          <td width="20" valign="top"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>     
</body>
</html>
<%

} catch (Exception e) {
  out.println(e);
}
%>