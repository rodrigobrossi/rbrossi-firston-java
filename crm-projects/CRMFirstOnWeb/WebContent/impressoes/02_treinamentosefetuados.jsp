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
String pag_rdo_ord = (request.getParameter("rb_ord")==null)?"":request.getParameter("rb_ord");
String pag_rdo_dados = (request.getParameter("rb_dados")==null)?"":request.getParameter("rb_dados");
String pag_rdo_relat = (request.getParameter("rb_relat")==null)?"E":request.getParameter("rb_relat");
String pag_plano = (request.getParameter("sel_plano")==null)?"":request.getParameter("sel_plano");
String pag_tipo = (request.getParameter("sel_tipo")==null)?"":request.getParameter("sel_tipo");

ResultSet rs = null, rs2 = null;
String query="", query2="", query_anteriores="", query_longa="", query_dt="", query_dt_ant="", ord="",  classe="ftverdanapreto2";
String cor="", filtros="", str_curso="", str_dtinic="", str_funcion="", str_data="", str_data2="", data_inicial="", data_final="", planoTitulo="";
int solic = 0, depto = 0, plano = 0, tabela1 = 0, tabela2 = 0, tabela3 = 0, tabela4 = 0, tabela5 = 0, tabela6 = 0, tabela7 = 0;
int tabela8 = 0, filial = 0, tipo = 0, cargo = 0, curso = 0, titulo = 0, empresa = 0, funcion = 0, int_turma = 0;
int planejado = 0, nplanejado = 0, total_plan = 0, total_nplan = 0, primeira = 0, int_dec=0;
boolean muda = true, ou = false;
float duracao=0, custo=0, total_custo=0, total_dur = 0, custo_cur = 0, custo_log = 0, total_custo_cur = 0, total_custo_log = 0;
SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");

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

if(!(pag_dt_inicio.equals(""))) {
    data_inicial = pag_dt_inicio;
    query_dt = "AND U.TUR_DATAINICIO >= DATEFMT("+data_inicial+") ";
    query_dt_ant = "AND T.TEF_INICIO >= DATEFMT("+data_inicial+") ";
    filtros = filtros + "<BR>" + trd.Traduz("DATA INICIAL") + ": " + data_inicial;
}

if(!(pag_dt_fim.equals(""))) {
    data_final = pag_dt_fim;
    query_dt = query_dt + "AND U.TUR_DATAFINAL <= DATEFMT("+data_final+") ";
    query_dt_ant = query_dt_ant + "AND T.TEF_FIM <= DATEFMT("+data_final+") ";
    filtros = filtros + "<BR>" + trd.Traduz("DATA FINAL") + ": " + data_final;
}

query = "SELECT DISTINCT F.FUN_CHAPA, F.FUN_NOME, U.TUR_CODIGO, C.CUR_NOME, P.TTR_NOME, U.TUR_VERSAO, "+
	"U.TUR_DATAINICIO , U.TUR_DATAFINAL, U.TUR_DURACAO, U.TUR_CUSTO, T.TUR_CODIGO_REAL, T.TEF_PLANEJADO, U.TUR_CUSTO2, F.FUN_DEMITIDO, F.FUN_TERCEIRO "+ 
	"FROM TREINAMENTO T, FUNCIONARIO F, CURSO C, CARGO A, DEPTO D, " +
	"FILIAL I, TIPOTREINAMENTO P, TURMA U, EMPRESA E, TITULO TI "+
	"WHERE F.FUN_CODIGO = T.FUN_CODIGO " + query_dt +
	"AND P.TTR_CODIGO = T.TTR_CODIGO "+
        "AND T.TUR_CODIGO_REAL = U.TUR_CODIGO "+ //"AND C.CUR_CODIGO = U.CUR_CODIGO "+
	"AND C.CUR_CODIGO = T.CUR_CODIGO "+ 
	"AND F.CAR_CODIGO = A.CAR_CODIGO "+ 
	"AND F.DEP_CODIGO = D.DEP_CODIGO "+
	"AND TI.TIT_CODIGO = C.TIT_CODIGO "+ fun_filtro;

// *********** TIPOS DE TREINAMENTO **********
ou = false;
query = query + "AND (";
if(request.getParameter("cb_duracao") != null) { //longa duracao

    query_longa = " UNION SELECT DISTINCT F.FUN_CHAPA, F.FUN_NOME, U.TUR_CODIGO, C.CUR_NOME, P.TTR_NOME, NULL, "+
                  "LTRIM(STR(YEAR(T.TEF_INICIO))+'-'+LTRIM(STR(L.LAN_MES)+'-01')), NULL, L.LAN_DURACAO, L.LAN_REEMBOLSO, T.TUR_CODIGO_REAL, "+
                  "T.TEF_PLANEJADO, L.LAN_CUSTO, F.FUN_DEMITIDO, F.FUN_TERCEIRO "+
                  "FROM TREINAMENTO T, TURMA U, FUNCIONARIO F, CURSO C, CARGO A, DEPTO D, FILIAL I, TIPOTREINAMENTO P, EMPRESA E, TITULO TI, LANCAMENTO L "+
                  "WHERE F.FUN_CODIGO = T.FUN_CODIGO " + query_dt_ant +
                  "AND T.TUR_CODIGO_REAL = U.TUR_CODIGO " +
                  "AND P.TTR_CODIGO = T.TTR_CODIGO "+
                  "AND C.CUR_CODIGO = T.CUR_CODIGO "+ 
                  "AND F.CAR_CODIGO = A.CAR_CODIGO "+ 
                  "AND F.DEP_CODIGO = D.DEP_CODIGO "+
				  "AND TI.TIT_CODIGO = C.TIT_CODIGO "+
                  "AND T.TTR_CODIGO = 3 "+
                  "AND L.TEF_CODIGO = T.TEF_CODIGO " +fun_filtro;
    if (request.getParameter("cb_lista") == null && request.getParameter("cb_rapido") == null &&
        request.getParameter("cb_turma") == null && request.getParameter("cb_anteriores") == null) {
        query = query + " 1=2 ";
        ou = true;
    }
}

    if(request.getParameter("cb_lista") != null) {//lista de presenca
        if (ou) {
            query = query + " OR T.TTR_CODIGO = 1 ";
        } else {
            query = query + " T.TTR_CODIGO = 1 ";
        } 
        ou = true;
    }
    if(request.getParameter("cb_rapido") != null) {//rapido
        if (ou) {
            query = query + "OR T.TTR_CODIGO = 4 ";
        } else {
            query = query + " T.TTR_CODIGO = 4 ";
        }
        ou = true;
    }
    if(request.getParameter("cb_turma") != null) {//turma antecipada
        if (ou) {
            query = query + "OR T.TTR_CODIGO = 2 ";
        } else {
            query = query + "T.TTR_CODIGO = 2 ";
        }
        ou = true;
    }
    if(request.getParameter("cb_anteriores") != null) {//registros anteriores
        query_anteriores = " UNION SELECT DISTINCT F.FUN_CHAPA, F.FUN_NOME, T.TEF_CODIGO, C.CUR_NOME, P.TTR_NOME, NULL, " +
                           "T.TEF_INICIO , T.TEF_FIM, T.TEF_DURACAO, T.TEF_CUSTO, T.TUR_CODIGO_REAL, T.TEF_PLANEJADO, C.CUR_CUSTO2, F.FUN_DEMITIDO, F.FUN_TERCEIRO "+ 
                           "FROM TREINAMENTO T, FUNCIONARIO F, CURSO C, CARGO A, DEPTO D, " +
                           "FILIAL I, TIPOTREINAMENTO P, EMPRESA E, TITULO TI "+
                           "WHERE F.FUN_CODIGO = T.FUN_CODIGO " + query_dt_ant + " "+ 
                           "AND P.TTR_CODIGO = T.TTR_CODIGO "+
                           "AND C.CUR_CODIGO = T.CUR_CODIGO "+ 
                           "AND F.CAR_CODIGO = A.CAR_CODIGO "+ 
                           "AND F.DEP_CODIGO = D.DEP_CODIGO "+
						   "AND TI.TIT_CODIGO = C.TIT_CODIGO "+ fun_filtro + " AND ";
    if (ou) {
        query = query + " OR T.TTR_CODIGO = 5 ";
        query_anteriores = query_anteriores + " T.TTR_CODIGO = 5 ";
    } else {
        query = query + "T.TTR_CODIGO = 5";
        query_anteriores = query_anteriores + " T.TTR_CODIGO = 5 ";
    }
    ou = true;
    }
//}
query = query + ") ";

// *********** TIPOS DE TREINAMENTO **********

// *********** FILTROS **********
if(!pag_solic.equals("")) {
  solic = Integer.parseInt(request.getParameter("sel_solic"));	
  if(solic > 0) {
    query = query + "AND F.FUN_CODSOLIC = "+solic+" "; 
    query_anteriores = query_anteriores + "AND F.FUN_CODSOLIC = "+solic+" "; 
    //FILTRO
    query2 = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = "+solic;
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
    query_anteriores = query_anteriores + " AND D.DEP_CODIGO = "+depto+" "+
                       "AND F.DEP_CODIGO = D.DEP_CODIGO ";
    query_longa = query_longa + " AND D.DEP_CODIGO = "+depto+" "+
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
    query_anteriores = query_anteriores + " AND F.TB1_CODIGO = " +tabela1+ " ";
    query_longa = query_longa + " AND F.TB1_CODIGO = " +tabela1+ " ";
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
    query_anteriores = query_anteriores + " AND F.TB2_CODIGO = " +tabela2+ " ";
    query_longa = query_longa + " AND F.TB2_CODIGO = " +tabela2+ " ";

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
    query_anteriores = query_anteriores + "AND F.TB3_CODIGO = " +tabela3+ " ";
    query_longa = query_longa + "AND F.TB3_CODIGO = " +tabela3+ " ";
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
    query_anteriores = query_anteriores + "AND F.TB4_CODIGO = " +tabela4+ " ";
    query_longa = query_longa + "AND F.TB4_CODIGO = " +tabela4+ " ";
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
    query_anteriores = query_anteriores + "AND I.FIL_CODIGO = "+filial+" "+
  		       "AND F.FIL_CODIGO = I.FIL_CODIGO ";
    query_longa = query_longa + "AND I.FIL_CODIGO = "+filial+" "+
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
    query_anteriores = query_anteriores + "AND A.CAR_CODIGO = "+cargo+" "+
                       "AND F.CAR_CODIGO = A.CAR_CODIGO "; 	
    query_longa = query_longa + "AND A.CAR_CODIGO = "+cargo+" "+
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
    query_anteriores = query_anteriores + "AND C.CUR_CODIGO = "+curso+" "+
                       "AND C.CUR_CODIGO = T.CUR_CODIGO "; 
    query_longa = query_longa + "AND C.CUR_CODIGO = "+curso+" "+
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
    query_anteriores = query_anteriores + "AND TI.TIT_CODIGO = "+titulo+" "+
                       "AND C.TIT_CODIGO = TI.TIT_CODIGO ";
    query_longa = query_longa + "AND TI.TIT_CODIGO = "+titulo+" "+
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
    query_anteriores = query_anteriores + "AND E.EMP_CODIGO = "+empresa+" "+
		    "AND T.EMP_CODIGO = E.EMP_CODIGO ";
    query_longa = query_longa + "AND E.EMP_CODIGO = "+empresa+" "+
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
    query_anteriores = query_anteriores + "AND F.FUN_CODIGO = "+funcion+" ";
    query_longa = query_longa + "AND F.FUN_CODIGO = "+funcion+" ";
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
    query_anteriores = query_anteriores + "AND T.PLA_CODIGO = "+plano+" ";
    query_longa = query_longa + "AND T.PLA_CODIGO = "+plano+" ";
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

//insere UNION de anteriores
if(request.getParameter("cb_anteriores") != null) {
  if(!request.getParameter("cb_anteriores").equals(""))
    query = query + query_anteriores + " ";
}

//insere UNION de longa duracao
if(request.getParameter("cb_duracao") != null) {
  if(!request.getParameter("cb_duracao").equals(""))
    query = query + query_longa + " ";
}

if (filtros.equals(""))
  filtros = trd.Traduz("NENHUM");
// *********** FILTROS **********


// *********** ORDENACAO **********
if(!pag_rdo_ord.equals("")) {
  ord = pag_rdo_ord;
  if(ord.equals("C")) {
    query = query + "ORDER BY C.CUR_NOME, F.FUN_NOME";
  }
  else if(ord.equals("D")) {
    query = query + "ORDER BY U.TUR_DATAINICIO, F.FUN_NOME";
  }
  else if(ord.equals("T")) {
    query = query + "ORDER BY U.TUR_CODIGO, F.FUN_NOME";
  }
  else if(ord.equals("F")) {
    query = query + "ORDER BY F.FUN_NOME";
  }
  else if(ord.equals("A")) {
    query = query + "ORDER BY U.TUR_DATAFINAL, F.FUN_NOME";
  }
}

/*out.println("query = " + query);
out.println("query_anteriores = " + query_anteriores);*/

// *********** ORDENACAO **********
%>

<%!//funcao para formatacao $$
public String ReaistoStr(float valor){
  DecimalFormat dcf = new DecimalFormat("0.00");
  dcf.setMaximumFractionDigits(2);
  String strReais = dcf.format(valor);
  return strReais;
}
%>

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
<title>FirstOn - <%=trd.Traduz("ImpressOes")%> - <%=trd.Traduz("RelatOrio de Treinamentos Efetuados")%></title>
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
                <td class="trontrk" width="100%" align="center"><%=trd.Traduz("RELATORIO DE TREINAMENTOS EFETUADOS")%> / <%=planoTitulo%></td>                              
              </tr>
            </table>
          </td>
          <td width="20">&nbsp;</td>
        </tr>        				
        <tr> 
          <td width="20" valign="top"></td>
	  <FORM>
          <td valign="top"> &nbsp;<br>
	    <table width="100%" border="0" cellspacing="1" cellpadding="3">                 
	      <tr>
		<td width="48%" class="ftverdanapreto"> <%=trd.Traduz("FILTROS ESCOLHIDOS")%>: <span class="ftverdanacinza"> <%=filtros%> </span></td>
                <td width="18%" class="ftverdanacinza"><img src="../art/black.gif" width="17" height="17"> = <%=trd.Traduz("PLANEJADOS")%></td>
		<td width="18%" class="ftverdanacinza"><img src="../art/red.gif" width="17" height="17"> = <%=trd.Traduz("NAO PLANEJADOS")%></td> 
              </tr>
              <tr>
		<td width="48%" class="ftverdanapreto">&nbsp;  </td>
		<td width="18%" class="ftverdanacinza"> ** - <%=trd.Traduz("DEMITIDO")%> </td>
		<td width="18%" class="ftverdanacinza"> * - <%=trd.Traduz("TERCEIRO")%> </td>
              </tr>
	    </table>

<%          rs = null;
 	    rs = conexao.executaConsulta(query,session.getId()+"RS16");
            if(rs.next()) {
	      do { 
		if(ord.equals("C")) {
		  if(str_curso.equals(rs.getString(4)))
		    muda = false;
		  else
		    muda = true;
		}
		else if(ord.equals("D")) {
		  if(str_dtinic.equals(rs.getString(7)))
		    muda = false;
		  else
		    muda = true;
		}
		else if(ord.equals("T")) {
		  if(int_turma == rs.getInt(3))
		    muda = false;
		  else
		    muda = true;
		}
		else if(ord.equals("F")) {
		  if(str_funcion.equals(rs.getString(2)))
		    muda = false;
		  else
		    muda = true;
		}

		if(muda == true) {
		  cor = "#FFFFFF";

		if(primeira != 0) 
		{
			%>
		    <tr><td colspan="12" class="celtittab" align="center"><%=trd.Traduz("SUBTOTALIZACAO")%></td></tr>
		    <tr>
                        <td colspan="4" class="celcin" align="center"><%=trd.Traduz("PLANEJADOS")%> = <%=planejado%></td>
                        <td colspan="4" class="celcin" align="center"><%=trd.Traduz("NAO PLANEJADOS")%> = <%=nplanejado%></td>
			<td width="7%" class="celcin" align="right"> <%=convHora(duracao)%></td>
                        <td width="9%" class="celcin" align="right"> <%=ReaistoStr(custo_cur)%></td>
                        <td width="9%" class="celcin" align="right"> <%=ReaistoStr(custo_log)%></td>
                        <td width="9%" class="celcin" align="right"> <%=ReaistoStr(custo)%></td>
<%			total_custo = total_custo + custo;
			total_dur = total_dur + duracao;
			total_custo_cur = total_custo_cur + custo_cur;
		        total_custo_log = total_custo_log + custo_log;
			custo = 0; duracao = 0; custo_log = 0; custo_cur = 0;
%>
		  </tr>											
<%		}%>
		<table width="100%" border="0" cellspacing="1" cellpadding="3">  
		  <tr>
                    <td colspan="8" class="ftverdanapreto">&nbsp;<br><br>
<%                    if(ord.equals("C")){%>
			 <%=trd.Traduz("CURSO")%>: <%=rs.getString(4)%> 
<%		      }
		      else if(ord.equals("D")){%>
			 <%=trd.Traduz("DATA INICIAL")%>: <%=rs.getString(7)%> 
<%		      }
		      else if(ord.equals("T")){%>
		 	<%=trd.Traduz("TURMA")%>: <%=rs.getInt(3)%> 
<%		      }
		      else if(ord.equals("F")){%>
		        <%=trd.Traduz("FUNCIONARIO")%>: <%=rs.getString(2)%> 
<%                    }	

//<td width="6%"  align="center"><%=trd.Traduz("VERSAO")</td>
//<td width="6%"  class="<%=classe"> =((rs.getString(6)==null)?"":rs.getString(6)) </td>

%>
		    </td>
		  </tr>
		</table>				
		<table width="100%" border="0" cellspacing="1" cellpadding="2">
		  <tr class="celtitrela"> 
                    <td width="8%"  align="center"><%=trd.Traduz("CHAPA")%></td>
                    <td width="10%"  align="center"><%=trd.Traduz("NOME")%></td>
                    <td width="6%"  align="center"><%=trd.Traduz("TURMA")%></td>
                    <td width="18%"  align="center"><%=trd.Traduz("CURSO")%></td>
                    <td width="8%"  align="center"><%=trd.Traduz("TIPO")%></td>                    
                    <td width="8%"  align="center"><%=trd.Traduz("DTINICIAL")%></td>
                    <td width="8%"  align="center"><%=trd.Traduz("DTFINAL")%></td>
		    <td width="7%"  align="center"><%=trd.Traduz("DURACAO")%></td>
                    <td width="9%"  align="center"><%=trd.Traduz("CUSTO CURSO")%><%=" (" + moeda + ")"%></td>
                    <td width="9%"  align="center"><%=trd.Traduz("CUSTO LOGISTICA")%><%=" (" + moeda + ")"%></td>
		    <td width="9%"  align="center"><%=trd.Traduz("CUSTO TOTAL")%><%=" (" + moeda + ")"%></td>
		  </tr>

<%		  planejado = nplanejado = 0;
		}
		if(rs.getString(12) != null)  {
		  if(rs.getString(12).equals("S")) {
                    classe = "ftverdanapreto2";
                    planejado++;
                    total_plan++;
		  }
		  else if(rs.getString(12).equals("N")) {
		    classe = "ftverdanaverm";
		    nplanejado++;
		    total_nplan++;
		  }
		} else {
		  classe = "ftverdanaverm";
		  nplanejado++;
		  total_nplan++;
		}%>
							
		<tr bgcolor=<%=cor%>>
		<td width="8%" class="<%=classe%>"> <%=((rs.getString(1)==null)?"":rs.getString(1))%></td>
		<td width="10%" class="<%=classe%>">							
<%		if(((rs.getString(14)==null)?"":rs.getString(14)).equals("S")) {%>
                    ** <%=((rs.getString(2)==null)?"":rs.getString(2))%></td>
<%              }
                else if(((rs.getString(15)==null)?"":rs.getString(15)).equals("S")) 
                {%>
                    *  <%=((rs.getString(2)==null)?"":rs.getString(2))%></td>
<%              }
                else
                {%>
                       <%=((rs.getString(2)==null)?"":rs.getString(2))%></td>
<%              }%>
		</td>

                <td width="6%"  class="<%=classe%>"> <%=((rs.getString(3)==null)?"":rs.getString(3))%> </td>
                <td width="18%" class="<%=classe%>"> <%=((rs.getString(4)==null)?"":rs.getString(4))%> </td>
                <td width="8%"  class="<%=classe%>"> <%=((rs.getString(5)==null)?"":rs.getString(5))%> </td>                
                <td width="8%"  class="<%=classe%>"> <%=((rs.getString(7)==null)?"":formato.format(rs.getDate(7)))%> </td>	
                <td width="8%"  class="<%=classe%>"> <%=((rs.getString(8)==null)?"":formato.format(rs.getDate(8)))%> </td>
                <td width="7%"  align="right" class="<%=classe%>"> <%=((rs.getString(9)==null)?"":convHora(rs.getFloat(9)))%> </td>
<%
					float total_aux = 0;
					if(rs.getString(5).equals("LONGA DURACAO")) { //longa duracao
						total_aux = ((rs.getString(13)==null)?0:rs.getFloat(13));
				    }
					else {
						total_aux = (((rs.getString(10)==null)?0:rs.getFloat(10)) + ((rs.getString(13)==null)?0:rs.getFloat(13)));
					}
						%>
                <td width="9%"  align="right" class="<%=classe%>"> <%=((rs.getString(10)==null)?"":ReaistoStr(rs.getFloat(10)))%> </td>	
                <td width="9%"  align="right" class="<%=classe%>"> <%=((rs.getString(13)==null)?"":ReaistoStr(rs.getFloat(13)))%> </td>	
                <td width="9%"  align="right" class="<%=classe%>"> <%=ReaistoStr(total_aux)%> </td>	
	      </tr>												
<%            if(cor.equals("#FFFFFF"))
		cor = "#EEEEEE";
	      else
		cor = "#FFFFFF";
	      str_curso = rs.getString(4);
              if (rs.getString(7) != null) {
		str_dtinic = rs.getString(7);
              } else {
                str_dtinic = "";
              }
	      int_turma = rs.getInt(3);	
	      str_funcion = rs.getString(2);
              duracao = somaHoras(duracao, rs.getFloat(9));
	      custo = custo + rs.getFloat(10) + rs.getFloat(13);
		  custo_cur = custo_cur + rs.getFloat(10);
		  custo_log = custo_log + rs.getFloat(13);
              //total_custo = total_custo + (rs.getFloat(10) + rs.getFloat(13));
	      primeira = 1;
	    } while(rs.next());%>                                
	    <tr>
	      <td colspan="12"> &nbsp;  </td>
	    </tr>
	    <tr>					
	      <td colspan="12" class="celtittab" align="center"><%=trd.Traduz("SUBTOTALIZACAO")%></td> 
	    </tr>
	    <tr>
	      <td colspan="4" class="celcin" align="center"><%=trd.Traduz("PLANEJADOS")%> = 	<%=planejado%></td>
	      <td colspan="4" class="celcin" align="center"><%=trd.Traduz("NAO PLANEJADOS")%> = <%=nplanejado%></td>
	      <td width="7%" class="celcin" align="right"> <%=convHora(duracao)%></td>
              <td width="9%" class="celcin" align="right"> <%=ReaistoStr(custo_cur)%></td>
	      <td width="9%" class="celcin" align="right"> <%=ReaistoStr(custo_log)%></td>
	      <td width="9%" class="celcin" align="right"> <%=ReaistoStr(custo_cur + custo_log)%></td>
<%		total_custo = total_custo + custo;
        total_dur = total_dur + duracao;
		total_custo_cur = total_custo_cur + custo_cur;
		total_custo_log = total_custo_log + custo_log;%>
	    </tr>	
	    <tr>
	      <td colspan="10">&nbsp;  </td>
	    </tr>
	    <table width="100%" border="0" cellspacing="1" cellpadding="2" align="center">				 
	      <tr align="center"> 
                <td colspan="12">&nbsp;</td>
              </tr>
              <tr align="center"> 
                <td colspan="12" class="celtittabcin"><%=trd.Traduz("TOTAL GERAL")%></td>
              </tr>
              <tr> 
                <td align="center" colspan="4" class="celcin"><%=trd.Traduz("PLANEJADOS")%> = <%=total_plan%></td>
                <td align="center" colspan="4" class="celcin"><%=trd.Traduz("NAO PLANEJADOS")%> = <%=total_nplan%></td>
	        <td align="right" width="7%" class="celcin"> <%=convHora(total_dur)%> </td>
                <td align="right" width="9%" class="celcin"> <%=ReaistoStr(total_custo_cur)%></td>
		<td align="right" width="9%" class="celcin"> <%=ReaistoStr(total_custo_log)%></td>
                <td align="right" width="9%" class="celcin"> <%=ReaistoStr(total_custo)%></td>              
              </tr>
                <tr align="center"> 
                  <td colspan="10">&nbsp;</td>
              </tr>
            </table>              
          </td>
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
              if(rs2 != null){
                  rs2.close();
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