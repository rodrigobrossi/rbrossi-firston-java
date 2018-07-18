<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

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

//try {

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
float pag_horas = (request.getParameter("horas")==null)?0:Float.parseFloat(request.getParameter("horas"));

ResultSet rs = null, rs2 = null;

String query="", query2="", query_dt="", ord="",  classe="ftverdanapreto2", departamento_cod="", departamento="";
String cor="", filtros="", str_curso="", str_dtinic="", str_funcion="", str_data="", str_data2="", data_inicial="", data_final="", planoTitulo="";
int solic = 0, depto = 0, plano = 0, tabela1 = 0, tabela2 = 0, tabela3 = 0, tabela4 = 0, tabela5 = 0, tabela6 = 0, tabela7 = 0;
int tabela8 = 0, filial = 0, tipo = 0, cargo = 0, curso = 0, titulo = 0, empresa = 0, funcion = 0, int_turma = 0, primeira = 0;
int zero=0, um=0, dois=0, tres=0, quatro=0, mais=0, total=0, t_zero=0, t_um=0, t_dois=0, t_tres=0, t_quatro=0, t_mais=0, t_total=0;
float tot_horas = 0, tot_custo = 0,  custo_curso = 0;
DecimalFormat formato = new DecimalFormat("0.00");
formato.setMaximumFractionDigits(2);
String tit_curso="";
String moeda = prm.buscaparam("MOEDA");

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

//filtro
filtros = trd.Traduz("HORAS/DIA") + ": " + pag_horas;
if(!(pag_dt_inicio.equals(""))) {
    data_inicial = pag_dt_inicio;
    query_dt = "AND T.TEF_INICIO >= CONVERT(DATETIME, '"+data_inicial+"', 103) ";
    filtros = filtros + "<BR>" + trd.Traduz("DATA INICIAL") + ": " + data_inicial;
}

if(!(pag_dt_fim.equals(""))) {
    data_final = pag_dt_fim;
    query_dt = query_dt + "AND T.TEF_FIM <= CONVERT(DATETIME, '"+data_final+"', 103) ";
    filtros = filtros + "<BR>" + trd.Traduz("DATA FINAL") + ": " + data_final;
}

//RelatOrio Detalhado
if (pag_rdo_dados.equals("D")) {
	query = "SELECT DISTINCT F.FUN_CHAPA, F.FUN_NOME, SUM(U.TUR_DURACAO) AS HORAS, "+
			"(SUM(U.TUR_CUSTO)+SUM(U.TUR_CUSTO2)) AS CUSTO, F.FUN_DEMITIDO, F.FUN_TERCEIRO, P.TTR_NOME, "+
			"L.LAN_REEMBOLSO "+
		    "FROM TREINAMENTO T, FUNCIONARIO F, CARGO A, DEPTO D, TIPOTREINAMENTO P, CURSO C, TITULO TI, "+
			"TURMA U, LANCAMENTO L "+
	        "WHERE F.FUN_CODIGO = T.FUN_CODIGO " + query_dt +
			"AND T.TEF_CODIGO *= L.TEF_CODIGO "+
			"AND T.TUR_CODIGO_REAL = U.TUR_CODIGO "+
			"AND P.TTR_CODIGO = T.TTR_CODIGO "+
		    "AND T.TUR_CODIGO_REAL IS NOT NULL "+
			"AND C.CUR_CODIGO = T.CUR_CODIGO "+ 
			"AND F.CAR_CODIGO = A.CAR_CODIGO "+ 
		    "AND C.TIT_CODIGO = TI.TIT_CODIGO "+
			"AND F.DEP_CODIGO = D.DEP_CODIGO " + fun_filtro;
} 

//RelatOrio Resumido
else if (pag_rdo_dados.equals("R")) {
	query = "SELECT DISTINCT F.DEP_CODIGO, D.DEP_NOME, SUM(U.TUR_DURACAO), F.FUN_CODIGO "+
		    "FROM TREINAMENTO T, FUNCIONARIO F, CARGO A, DEPTO D, TIPOTREINAMENTO P, CURSO C, TITULO TI, "+
			"TURMA U "+
	        "WHERE F.FUN_CODIGO = T.FUN_CODIGO "+
		    "AND T.TUR_CODIGO_REAL = U.TUR_CODIGO "+
			"AND P.TTR_CODIGO = T.TTR_CODIGO "+
	        "AND T.TUR_CODIGO_REAL IS NOT NULL "+
		    "AND C.CUR_CODIGO = T.CUR_CODIGO "+
			"AND F.CAR_CODIGO = A.CAR_CODIGO "+
	        "AND C.TIT_CODIGO = TI.TIT_CODIGO "+
		    "AND F.DEP_CODIGO = D.DEP_CODIGO ";
}

// *********** FILTROS **********
if(!pag_solic.equals("")) {
  solic = Integer.parseInt(request.getParameter("sel_solic"));	
  if(solic > 0) {
    query = query + "AND F.FUN_CODSOLIC = "+solic+" "; 
    //FILTRO
    query2 = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = "+solic;
    rs2 = conexao.executaConsulta(query2,session.getId()+"RS1");
    if(rs2.next())
      filtros = filtros + "<BR>" + trd.Traduz("SOLICITANTE") + ": " + rs2.getString(1);
    if(rs != null){
        rs.close();
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
    query = query + "AND F.FIL_CODIGO = "+filial+" ";
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

if(!pag_tipo.equals("")) {
  tipo = Integer.parseInt(pag_tipo);
  if(tipo > 0) {
    query = query + "AND C.TCU_CODIGO = "+tipo+" ";
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

if(!pag_curso.equals("")) {
  curso = Integer.parseInt(pag_curso);
  if(curso > 0)	{
    query = query + "AND C.CUR_CODIGO = "+curso+" "+
                    "AND C.CUR_CODIGO = T.CUR_CODIGO "; 
    //FILTRO
    query2 = "SELECT CUR_NOME FROM CURSO WHERE CUR_CODIGO = "+curso;
    rs2	= conexao.executaConsulta(query2,session.getId()+"RS10");
    if(rs2.next())
      filtros = filtros + "<BR>" + trd.Traduz("CURSO") + ": " + rs2.getString(1);
    if(rs2 != null){
         rs2.close();
         conexao.finalizaConexao(session.getId()+"RS10");
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
    query = query + "AND T.EMP_CODIGO = "+empresa+" ";
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
    query = query + "AND T.PLA_CODIGO = "+plano+" ";
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

//*********** ORDENACAO **********
if (pag_rdo_dados.equals("D"))
  query = query + " GROUP BY F.FUN_CHAPA, F.FUN_NOME, F.FUN_DEMITIDO, F.FUN_TERCEIRO, P.TTR_NOME, "+
		  "L.LAN_REEMBOLSO ORDER BY F.FUN_NOME ";
else if (pag_rdo_dados.equals("R"))
  query = query + " GROUP BY F.DEP_CODIGO, D.DEP_NOME, F.FUN_CODIGO ORDER BY F.DEP_CODIGO";
//*********** ORDENACAO **********

if (filtros.equals(""))
  filtros = trd.Traduz("NENHUM");
%>

<%!//funcao para formatacao $$
public String ReaistoStr(float valor, String moeda){
  DecimalFormat dcf = new DecimalFormat("0.00");
  dcf.setMaximumFractionDigits(2);
  String strReais = moeda + " " + dcf.format(valor);
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
<title>FirstOn - <%=trd.Traduz("ImpressOes")%> - <%=trd.Traduz("Relatorio de Treinamentos por Funcionario")%></title>
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
                <td class="trontrk" width="100%" align="center"><%=trd.Traduz("Relatorio de Treinamentos por Funcionario")%> / <%=planoTitulo%> <br>
<%              if (pag_rdo_dados.equals("D")) {%>
                  <%=trd.Traduz("Detalhado")%>
<%              } else {%>
                  <%=trd.Traduz("Resumido")%>
<%              }%>
                </td>
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
<%            if (pag_rdo_dados.equals("D")) {%>
              <tr>
		<td width="48%" class="ftverdanapreto">&nbsp;  </td>
		<td width="18%" class="ftverdanacinza"> ** - <%=trd.Traduz("DEMITIDO")%> </td>
		<td width="18%" class="ftverdanacinza"> * - <%=trd.Traduz("TERCEIRO")%> </td>
              </tr>
<%            }%>
	    </table>
<%          rs = null;
	 	    rs = conexao.executaConsulta(query,session.getId()+"RS16");
            cor = "#FFFFFF";
            if(rs.next()) {
              //******************** DETALHADO ********************
              if (pag_rdo_dados.equals("D")) {
				  do {
					  if(rs.getString(7).equals("LONGA DURACAO")) 
						  custo_curso = rs.getFloat(8);
					  else
						  custo_curso = rs.getFloat(4);

					  if (primeira == 0) {%>
		  <table width="100%" border="0" cellspacing="1" cellpadding="2">
		    <tr class="celtitrela"> 
                      <td width="10%" align="center"><%=trd.Traduz("CHAPA")%></td>
                      <td width="60%" align="center"><%=trd.Traduz("NOME")%></td>
                      <td width="10%" align="right"><%=trd.Traduz("Nº HORAS")%></td>
                      <td width="10%" align="right"><%=trd.Traduz("Nº DIAS")%></td>
                      <td width="10%" align="right"><%=trd.Traduz("CUSTO")%></td>
		    </tr>
<%                }%>
		  <tr bgcolor="<%=cor%>">
		    <td width="10%" class="<%=classe%>"> <%=((rs.getString(1)==null)?"":rs.getString(1))%></td>
		    <td width="60%" class="<%=classe%>">							
<%		      if(((rs.getString(5)==null)?"":rs.getString(5)).equals("S")) {%>
                        ** <%=((rs.getString(2)==null)?"":rs.getString(2))%></td>
<%                    }
                      else if(((rs.getString(6)==null)?"":rs.getString(6)).equals("S")) {%>
                        *  <%=((rs.getString(2)==null)?"":rs.getString(2))%></td>
<%                    } else {%>
                           <%=((rs.getString(2)==null)?"":rs.getString(2))%></td>
<%                    }%>
		    </td>
                    <td width="10%" class="<%=classe%>" align="right"> <%=((rs.getString(3)==null)?"-":convHora(rs.getFloat(3)))%> </td>
                    <td width="10%" class="<%=classe%>" align="right"> <%=((rs.getString(3)==null)?"-":(formato.format((rs.getFloat(3)/60)/pag_horas))+"")%> </td>
                    <td width="10%" class="<%=classe%>" align="right"> <%=((rs.getString(4)==null)?"-":(ReaistoStr(custo_curso, moeda)))%> </td>
	          </tr>
<%                tot_horas = tot_horas + rs.getFloat(3);
                  tot_custo = tot_custo + rs.getFloat(4);
                  if(cor.equals("#FFFFFF"))
		    cor = "#EEEEEE";
	          else
		    cor = "#FFFFFF";
                  primeira++;
	        } while(rs.next());%>
                <tr><td colspan="100%">
                  <table width="100%" border="0" cellspacing="1" cellpadding="2">
                    <tr>					
                      <td colspan="3" class="celtittab" align="center"><%=trd.Traduz("TOTAL")%></td> 
                    </tr>
	            <tr>
                      <td class="celcin" align="center" width="33%"><%=trd.Traduz("HORAS")%> = <%=convHora(tot_horas)%></td>
                      <td class="celcin" align="center" width="33%"><%=trd.Traduz("Nº DIAS")%> = <%=formato.format((tot_horas/60)/pag_horas)%></td>
                      <td class="celcin" align="center" width="34%"><%=trd.Traduz("CUSTO")%> = <%=ReaistoStr(tot_custo, moeda)%></td>
                    </tr>
                  </table>
                </td></tr>
<%            } else {
              //******************** RESUMIDO ********************
	        do {
                  if (primeira == 0) {%>
		  <table width="100%" border="0" cellspacing="1" cellpadding="2">
		    <tr class="celtitrela"> 
                      <td width="65%" align="left"><%=trd.Traduz("DEPARTAMENTO")%></td>
                      <td width="5%" align="right"><%=trd.Traduz("Nº PESSOAS TREINADAS")%></td>
                      <td width="5%" align="right"><%=trd.Traduz("0 DIA")%></td>
                      <td width="5%" align="right"><%=trd.Traduz("1 DIA")%></td>
                      <td width="5%" align="right"><%=trd.Traduz("2 DIAS")%></td>
                      <td width="5%" align="right"><%=trd.Traduz("3 DIAS")%></td>
                      <td width="5%" align="right"><%=trd.Traduz("4 DIAS")%></td>
                      <td width="5%" align="right"><%=trd.Traduz("5 OU MAIS")%></td>
		    </tr>
<%                }
                  if (!departamento_cod.equals(rs.getString(1)) && primeira != 0) {%>
		    <tr bgcolor="<%=cor%>">
		      <td width="65%" class="<%=classe%>"><%=(departamento_cod)%> - <%=(departamento)%> </td>
                      <td width="5%" class="<%=classe%>" align="right"> <%=total%> </td>
                      <td width="5%" class="<%=classe%>" align="right"> <%=zero%> </td>
                      <td width="5%" class="<%=classe%>" align="right"> <%=um%> </td>
                      <td width="5%" class="<%=classe%>" align="right"> <%=dois%> </td>   
                      <td width="5%" class="<%=classe%>" align="right"> <%=tres%> </td>
                      <td width="5%" class="<%=classe%>" align="right"> <%=quatro%> </td>
                      <td width="5%" class="<%=classe%>" align="right"> <%=mais%> </td>
	            </tr>
<%                  zero=0; um=0; dois=0; tres=0; quatro=0; mais=0; total=0;
                    if(cor.equals("#FFFFFF"))
		      cor = "#EEEEEE";
	            else
		      cor = "#FFFFFF";
                  }
                  if ((rs.getFloat(3)/60)<pag_horas) {
                    zero++;
                    t_zero++;
                  } else if ((rs.getFloat(3)/60)<(pag_horas*2)) {
                    um++;
                    t_um++;
                  } else if ((rs.getFloat(3)/60)<(pag_horas*3)) {
                    dois++;
                    t_dois++;
                  } else if ((rs.getFloat(3)/60)<(pag_horas*4)) {
                    tres++;
                    t_tres++;
                  } else if ((rs.getFloat(3)/60)<(pag_horas*5)) {
                    quatro++;
                    t_quatro++;
                  } else {
                    mais++;
                    t_mais++;
                  }
                  total++;
                  t_total++;
                  primeira++;
                  departamento_cod = rs.getString(1);
                  departamento = rs.getString(2);
	        } while(rs.next());%>                                
		<tr bgcolor="<%=cor%>">
		  <td width="65%" class="<%=classe%>"><%=(departamento_cod)%> - <%=(departamento)%> </td>
                  <td width="5%" class="<%=classe%>" align="right"> <%=total%> </td>
                  <td width="5%" class="<%=classe%>" align="right"> <%=zero%> </td>
                  <td width="5%" class="<%=classe%>" align="right"> <%=um%> </td>
                  <td width="5%" class="<%=classe%>" align="right"> <%=dois%> </td>   
                  <td width="5%" class="<%=classe%>" align="right"> <%=tres%> </td>
                  <td width="5%" class="<%=classe%>" align="right"> <%=quatro%> </td>
                  <td width="5%" class="<%=classe%>" align="right"> <%=mais%> </td>
	        </tr>
                <tr>
                  <td class="celcin"><%=trd.Traduz("TOTAL")%></td>
                  <td class="celcin" align="right"><%=t_total%></td>
                  <td class="celcin" align="right"><%=t_zero%></td>
                  <td class="celcin" align="right"><%=t_um%></td>
                  <td class="celcin" align="right"><%=t_dois%></td>
                  <td class="celcin" align="right"><%=t_tres%></td>
                  <td class="celcin" align="right"><%=t_quatro%></td>
                  <td class="celcin" align="right"><%=t_mais%></td>
                </tr>
<%            }
            } else {%>
            <p>&nbsp;
            <table width="100%" border="0" cellspacing="1" cellpadding="2">
              <tr> 
                <td align="center" class="celbrarela"><%=trd.Traduz("NENHUM ITEM SELECIONADO")%></td>
              </tr>
              <tr> 
                <td align="center" class="celbrarela"><a class="lnk" href="01_treinamentos.jsp"><%=trd.Traduz("Voltar")%></a></tr>
              </tr>
            </table>
<%          }

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


//} catch (Exception e) {
//  out.println(e);
//}
%>