<% 
//***********************************************OBSERVACAO**********************************************************//
//**																											   **//
//** PEGA O NUMERO DE INSCRITOS NO TREINAMENTO, MULTIPLICA POR 12 (NUMERO DE MESES). ESTE RESULTADO DEVE SER IGUAL **//
//** AO NUMERO DE REGISTROS ENCONTRADOS NA TABELA LANCAMENTO COM O MESMO "TEF_CODIGO" DA TABELA TREINAMENTO        **//
//**																											   **//
//*******************************************************************************************************************//

response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1"))
    response.setHeader("Cache-Control", "no-cache");
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
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

String moeda = prm.buscaparam("MOEDA");

//try {

//variaveis
ResultSet rs = null, rs2 = null, rs_plano = null, rsC = null, rsCC = null, rsD = null;

String 	query="", query_aux="", query_reg="", query_filtro="", query_func="", filtros="", 
		turma_grid="", cor="", classe="", turma = "";
boolean muda=true, tupla=false;
int cont=0;
SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
float custo_total = 0, logistica_total = 0, total_total = 0, total_parcial = 0;
int integrantes = 0, total = 0, contador = 0;
//Recuperacao de valores de filtro
String filial           = (request.getParameter("sel_filial")		==null)?"": (String)request.getParameter("sel_filial");
String depto            = (request.getParameter("sel_depto") 		==null)?"": (String)request.getParameter("sel_depto");
String tabela1          = (request.getParameter("sel_tabela1")		==null)?"": (String)request.getParameter("sel_tabela1");
String tabela2          = (request.getParameter("sel_tabela2")		==null)?"": (String)request.getParameter("sel_tabela2");
String tabela3          = (request.getParameter("sel_tabela3")		==null)?"": (String)request.getParameter("sel_tabela3");
String tabela4          = (request.getParameter("sel_tabela4")		==null)?"": (String)request.getParameter("sel_tabela4");
String tabela5          = (request.getParameter("sel_tabela5")		==null)?"": (String)request.getParameter("sel_tabela5");
String tabela6          = (request.getParameter("sel_tabela6")		==null)?"": (String)request.getParameter("sel_tabela6");
String tabela7          = (request.getParameter("sel_tabela7")		==null)?"": (String)request.getParameter("sel_tabela7");
String tabela8          = (request.getParameter("sel_tabela8")		==null)?"": (String)request.getParameter("sel_tabela8");
String cargo            = (request.getParameter("sel_cargo")		==null)?"": (String)request.getParameter("sel_cargo");
String tipo             = (request.getParameter("sel_tipo")			==null)?"": (String)request.getParameter("sel_tipo");
String entidade         = (request.getParameter("sel_entidade")		==null)?"": (String)request.getParameter("sel_entidade");
String curso            = (request.getParameter("sel_curso")		==null)?"": (String)request.getParameter("sel_curso");
String titulo           = (request.getParameter("sel_titulo")		==null)?"": (String)request.getParameter("sel_titulo");
String funcionario      = (request.getParameter("sel_funcion")		==null)?"": (String)request.getParameter("sel_funcion");
String solicitante      = (request.getParameter("sel_solic")		==null)?"": (String)request.getParameter("sel_solic");
String dt_inicio        = (request.getParameter("text_datainicio")	==null)?"": (String)request.getParameter("text_datainicio");
String dt_fim           = (request.getParameter("text_datafinal")	==null)?"": (String)request.getParameter("text_datafinal");
String status_ok        = (request.getParameter("chk_part_ok")		==null)?"": (String)request.getParameter("chk_part_ok");
String status_maior     = (request.getParameter("chk_part_maior")	==null)?"": (String)request.getParameter("chk_part_maior");
String status_menor     = (request.getParameter("chk_part_menor")	==null)?"": (String)request.getParameter("chk_part_menor");
String status_reg       = (request.getParameter("chk_part_reg")		==null)?"": (String)request.getParameter("chk_part_reg");
String tipo_relatorio   = (request.getParameter("rdo_tipo_rel")		==null)?"": (String)request.getParameter("rdo_tipo_rel");
String turma_ant        = (request.getParameter("chk_turma_ant")	==null)?"": (String)request.getParameter("chk_turma_ant");
String turma_longa      = (request.getParameter("chk_turma_longa")	==null)?"": (String)request.getParameter("chk_turma_longa");

//query de turmas nao registradas
query = "SELECT DISTINCT U.TUR_CODIGO, C.CUR_NOME, U.TUR_DATAINICIO, U.TUR_DATAFINAL, U.TUR_PARTICIPMAX, U.TUR_VAGAS, U.TUR_CUSTO, "+
        "U.TUR_CUSTO2, U.TUR_DURACAO, U.TTR_CODIGO, U.TUR_REGISTRADA, P.TTR_NOME "+
        "FROM CURSO C, TIPOTREINAMENTO P, TURMA U, EMPRESA E "+
		"WHERE C.CUR_CODIGO = U.CUR_CODIGO "+
        "AND P.TTR_CODIGO = U.TTR_CODIGO "+
        "AND U.TUR_REGISTRADA = 'N' "+
		"AND U.PLA_CODIGO = "+usu_plano+" ";

query_reg = " UNION SELECT DISTINCT U.TUR_CODIGO, C.CUR_NOME, U.TUR_DATAINICIO, U.TUR_DATAFINAL, U.TUR_PARTICIPMAX, U.TUR_VAGAS, U.TUR_CUSTO, "+
            "U.TUR_CUSTO2, U.TUR_DURACAO, U.TTR_CODIGO, U.TUR_REGISTRADA, P.TTR_NOME "+
            "FROM CURSO C, TIPOTREINAMENTO P, TURMA U, EMPRESA E  "+
            "WHERE C.CUR_CODIGO = U.CUR_CODIGO "+
            "AND P.TTR_CODIGO = U.TTR_CODIGO "+
            "AND U.TUR_REGISTRADA = 'S' "+
            "AND U.PLA_CODIGO = "+usu_plano+" ";

//filtros
if (!filial.equals("")) {
    query_filtro = query_filtro + "AND U.FUN_CODIGO IN (SELECT FUN_CODIGO FROM FUNCIONARIO WHERE FIL_CODIGO = " +filial+ ") ";
    query_aux = "SELECT FIL_NOME FROM FILIAL WHERE FIL_CODIGO = "+filial;

    rs2 = conexao.executaConsulta(query_aux,session.getId()+"F-1");

    if(rs2.next()) filtros = filtros + "<BR>" + trd.Traduz("FILIAL") + ": " + rs2.getString(1);

    if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"F-1");
        }
}

if (!depto.equals("")) {
    query_filtro = query_filtro + "AND U.FUN_CODIGO IN (SELECT FUN_CODIGO FROM FUNCIONARIO WHERE DEP_CODIGO = " +depto+ ") ";
    query_aux = "SELECT DEP_NOME FROM DEPTO WHERE DEP_CODIGO = "+depto;

    rs2 = conexao.executaConsulta(query_aux,session.getId()+"F0");

    if(rs2.next()) filtros = filtros + "<BR>" + trd.Traduz("DEPARTAMENTO") + ": " + rs2.getString(1);

    if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"F0");
    }
}

if (!tabela1.equals("")) {
    query_filtro = query_filtro + "AND U.FUN_CODIGO IN (SELECT FUN_CODIGO FROM FUNCIONARIO WHERE TB1_CODIGO = " +tabela1+ ") ";
    query_aux = "SELECT TB1_NOME FROM TABELA1 WHERE TB1_CODIGO = "+tabela1;
    rs2 = conexao.executaConsulta(query_aux,session.getId()+"F1");
    if(rs2.next()) filtros = filtros + "<BR>" + trd.Traduz("TABELA1") + ": " + rs2.getString(1);
    if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"F1");
    }
}

if (!tabela2.equals("")) {
    query_filtro = query_filtro + "AND U.FUN_CODIGO IN (SELECT FUN_CODIGO FROM FUNCIONARIO WHERE TB2_CODIGO = " +tabela2+ ") ";
    query_aux = "SELECT TB2_NOME FROM TABELA2 WHERE TB2_CODIGO = "+tabela2;
    rs2 = conexao.executaConsulta(query_aux,session.getId()+"F2");
    if(rs2.next()) filtros = filtros + "<BR>" + trd.Traduz("TABELA2") + ": " + rs2.getString(1);
    if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"F2");
    }
}

if (!tabela3.equals("")) {
    query_filtro = query_filtro + "AND U.FUN_CODIGO IN (SELECT FUN_CODIGO FROM FUNCIONARIO WHERE TB3_CODIGO = " +tabela3+ ") ";
    query_aux = "SELECT TB3_DESCRICAO FROM TABELA3 WHERE TB3_CODIGO = "+tabela3;
    rs2 = conexao.executaConsulta(query_aux,session.getId()+"F3");
    if(rs2.next()) filtros = filtros + "<BR>" + trd.Traduz("TABELA3") + ": " + rs2.getString(1);
if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"F3");
        }
}
if (!tabela4.equals("")) {
    query_filtro = query_filtro + "AND U.FUN_CODIGO IN (SELECT FUN_CODIGO FROM FUNCIONARIO WHERE TB4_CODIGO = " +tabela4+ ") ";
    query_aux = "SELECT TB4_DESCRICAO FROM TABELA4 WHERE TB4_CODIGO = "+tabela4;
    rs2 = conexao.executaConsulta(query_aux,session.getId()+"F4");
    if(rs2.next()) filtros = filtros + "<BR>" + trd.Traduz("TABELA4") + ": " + rs2.getString(1);
if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"F4");
        }
}
/*if (!tabela5.equals("")) {
    query = query + "AND  " +tabela5+ " ";

}
if (!tabela6.equals("")) {
    query = query + "AND  " +tabela6+ " ";

}
if (!tabela7.equals("")) {
    query = query + "AND  " +tabela7+ " ";

}
if (!tabela8.equals("")) {
    query = query + "AND  " +tabela8+ " ";

}*/
if (!cargo.equals("")) {
    query_filtro = query_filtro + "AND U.FUN_CODIGO IN (SELECT FUN_CODIGO FROM FUNCIONARIO WHERE CAR_CODIGO = " +cargo+ ") ";
    query_aux = "SELECT CAR_NOME FROM CARGO WHERE CAR_CODIGO = "+cargo;
    rs2 = conexao.executaConsulta(query_aux,session.getId()+"F5");
    if(rs2.next()) filtros = filtros + "<BR>" + trd.Traduz("CARGO") + ": " + rs2.getString(1);
if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"F5");
        }
}
if (!tipo.equals("")) {
    query_filtro = query_filtro + "AND U.TTR_CODIGO = " +tipo+ " ";
    query_aux = "SELECT TTR_NOME FROM TIPOTREINAMENTO WHERE TTR_CODIGO = "+tipo;
    rs2 = conexao.executaConsulta(query_aux,session.getId()+"F6");
    if(rs2.next()) filtros = filtros + "<BR>" + trd.Traduz("TIPO") + ": " + rs2.getString(1);
if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"F7");
        }
}
if (!entidade.equals("")) {
    query_filtro = query_filtro + "AND C.EMP_CODIGO = " +entidade+ " ";
    query_aux = "SELECT EMP_NOME FROM EMPRESA WHERE EMP_CODIGO = "+entidade;
    rs2 = conexao.executaConsulta(query_aux,session.getId()+"F8");
    if(rs2.next()) filtros = filtros + "<BR>" + trd.Traduz("EMPRESA") + ": " + rs2.getString(1);
    if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"F9");
        }
}
if (!curso.equals("")) {
    query_filtro = query_filtro + "AND C.CUR_CODIGO = " +curso+ " ";
    query_aux = "SELECT CUR_NOME FROM CURSO WHERE CUR_CODIGO = "+curso;
    rs2	= conexao.executaConsulta(query_aux,session.getId()+"F10");
    if(rs2.next()) filtros = filtros + "<BR>" + trd.Traduz("CURSO") + ": " + rs2.getString(1);
if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"F11");
        }
}
if (!titulo.equals("")) {
    query_filtro = query_filtro + "AND C.TIT_CODIGO = " +titulo+ " ";
    query_aux = "SELECT TIT_NOME FROM TITULO WHERE TIT_CODIGO = "+titulo;
    rs2 = conexao.executaConsulta(query_aux,session.getId()+"F12");
    if(rs2.next()) filtros = filtros + "<BR>" + trd.Traduz("TITULO") + ": " + rs2.getString(1);
if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"F13");
        }
}
if (!funcionario.equals("")) {
    query_filtro = query_filtro + "AND TUR_CODIGO IN (SELECT TUR_CODIGO_PLAN_ANT FROM TREINAMENTO WHERE FUN_CODIGO = " +funcionario+ ") ";
    query_aux = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = "+funcionario;
    rs2 = conexao.executaConsulta(query_aux,session.getId()+"F14");
    if(rs2.next()) filtros = filtros + "<BR>" + trd.Traduz("FUNCIONARIO") + ": " + rs2.getString(1);
if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"F14");
        }
}
if (!solicitante.equals("")) {
    query_filtro = query_filtro + "AND TUR_CODIGO IN (SELECT TUR_CODIGO_PLAN_ANT FROM TREINAMENTO WHERE FUN_CODIGO IN (SELECT FUN_CODIGO FROM FUNCIONARIO WHERE FUN_CODSOLIC = " +solicitante+ ")) ";
    query_aux = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = "+solicitante;
    rs2 = conexao.executaConsulta(query_aux,session.getId()+"F15");
    if(rs2.next()) filtros = filtros + "<BR>" + trd.Traduz("SOLICITANTE") + ": " + rs2.getString(1);
if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"F15");
        }
}
if (!dt_inicio.equals("")) {
    query_filtro = query_filtro + "AND U.TUR_DATAINICIO >= DATEFMT("+dt_inicio+") ";
    filtros = filtros + "<BR>" + trd.Traduz("DATA INICIAL") + ": " +dt_inicio;
}
if (!dt_fim.equals("")) {
    query_filtro = query_filtro + "AND U.TUR_DATAINICIO <= DATEFMT("+dt_fim+") ";
    filtros = filtros + "<BR>" + trd.Traduz("DATA FINAL") + ": " +dt_fim;
}
query_reg = query_reg + query_filtro;
query_filtro = query_filtro + "AND (";
if (!status_ok.equals("")) {
    query_filtro = query_filtro + "U.TUR_VAGAS = 0 ";
    filtros = filtros + "<BR>" + trd.Traduz("NUMERO DE PARTICIPANTES OK");
    tupla = true;
}
if (!status_maior.equals("")) {
    if (tupla) {
        query_filtro = query_filtro + "OR U.TUR_VAGAS < 0 ";
    } else {
        query_filtro = query_filtro + "U.TUR_VAGAS < 0 ";
        tupla = true;
    }
    filtros = filtros + "<BR>" + trd.Traduz("NUMERO DE PARTICIPANTES EXCEDIDO");
}
if (!status_menor.equals("")) {
    if (tupla)
        query_filtro = query_filtro + "OR U.TUR_VAGAS > 0 ";
    else
        query_filtro = query_filtro + "U.TUR_VAGAS > 0 ";
    filtros = filtros + "<BR>" + trd.Traduz("NUMERO DE PARTICIPANTES ABAIXO");
    tupla = true;
}
if (tupla)
    query_filtro = query_filtro + ") AND (";
else
    query_filtro = query_filtro + "1=1) AND (";
tupla = false;
query_reg = query_reg + " AND (";
if (!turma_ant.equals("")) {
    query_filtro = query_filtro + "U.TTR_CODIGO = " +turma_ant+ " ";
    query_reg = query_reg + "U.TTR_CODIGO = " +turma_ant+ " ";
    tupla = true;
    filtros = filtros + "<BR>" + trd.Traduz("TURMAS ANTECIPADAS");
}
if (!turma_longa.equals("")) {
    if (tupla) {
        query_filtro = query_filtro + "OR U.TTR_CODIGO = " +turma_longa+ " ";
        query_reg = query_reg + "OR U.TTR_CODIGO = " +turma_longa+ " ";
    } else {
        query_filtro = query_filtro + "U.TTR_CODIGO = " +turma_longa+ " ";
        query_reg = query_reg + "U.TTR_CODIGO = " +turma_longa+ " ";
    }
    filtros = filtros + "<BR>" + trd.Traduz("TURMAS LONGA DURACAO");
    tupla = true;
}
query_filtro = query_filtro + ") ";
query_reg = query_reg + ") ";
if (!status_reg.equals("")) {
    if (status_menor.equals("") && status_maior.equals("") && status_ok.equals(""))
        query = query + query_filtro + " AND 1=2 " + query_reg;
    else
        query = query + query_filtro + query_reg;
} else {
    query = query + query_filtro;
}

//Ordenacao
query = query + "ORDER BY U.TUR_CODIGO, C.CUR_NOME";

//out.println(query);
%>

<%!//funcao para formatacao $$
public String ReaistoStr(float valor, String moeda){
    DecimalFormat dcf = new DecimalFormat("0.00");
    dcf.setMaximumFractionDigits(2);
	DecimalFormatSymbols simbolo = new DecimalFormatSymbols();
    String strReais = dcf.format(valor);
    return moeda + strReais;
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

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("ImpressOes")%> - <%=trd.Traduz("RelatOrio Planejamento de Turmas")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../art/onenglish.gif','../art/onespanol.gif')">
<table width="100%" border="0" cellspacing="1" cellpadding="0" height="100%">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="1" cellpadding="0">
        <tr> 
          <td width="20">&nbsp;</td>
          <td width="100%"> 		  
            <table border="0" cellspacing="1" cellpadding="0" width="100%">
	      <tr> 
                <td class="trcurso" ><img src="../art/Logo_Cliente.gif" width="317" height="42"></td>  
              </tr>			  
<%	      
              String query_plano = "SELECT PLA_NOME FROM PLANO WHERE PLA_CODIGO = "+usu_plano;
	      rs_plano = conexao.executaConsulta(query_plano,session.getId()+"RS");
              if(rs_plano.next()) {%>
              <tr>
                <td class="trontrk" width="100%" align="center"><%=trd.Traduz("RelatOrio Planejamento de Turmas")%> / <%=rs_plano.getString(1)%> <br>
                <%
                if(tipo_relatorio.equals("R")){
                	out.println(trd.Traduz("RESUMIDO"));
                }
                else if(tipo_relatorio.equals("D")){
                	out.println(trd.Traduz("DETALHADO"));
                }
                %>                
                </td>
	      </tr>
<%            }
                if(rs_plano!=null){
                    rs_plano.close();
                    conexao.finalizaConexao(session.getId()+"RS");
                }
%>
            </table>
          </td>
	  <td width="20">&nbsp;</td>
	</tr>        				
        <FORM name="frm">
	<tr> 
          <td width="20" valign="top"></td>
          <td valign="top"> &nbsp;<br>
            <table width="100%" border="0" cellspacing="1" cellpadding="3">  						               
              <tr valign="top" class="ctfontb"> 
                <td colspan="100%" class="ftverdanapreto"><%=trd.Traduz("FILTROS ESCOLHIDOS")%>:<span class="ftverdanacinza"><%=filtros%></span></td>
              <tr>
              <tr valign="top" class="ctfontb"> 
                <td width="25%"><img src="../art/black.gif">&nbsp;= <%=trd.Traduz("Nº PARTICIPANTES OK")%></td>
                <td width="25%"><img src="../art/red.gif">&nbsp;=<%=trd.Traduz("Nº DE PARTICIPANTES EXCEDIDO")%></td>
                <td width="25%"><img src="../art/blue.gif">&nbsp;=<%=trd.Traduz("Nº DE PARTICIPANTES ABAIXO")%></td>
                <td width="25%"><img src="../art/green.gif">&nbsp;=<%=trd.Traduz("TURMA REGISTRADA")%></td>
              </tr>
<%            if (tipo_relatorio.equals("D")) {%>
              <tr>
		<td colspan="100%" class="ftverdanacinza" align="center" > * - <%=trd.Traduz("TERCEIRO")%> </td>
              </tr>
<%            }%>
            </table>
            <table width="100%" border="0" cellspacing="1" cellpadding="2">
			<%
                        //out.println("query = " + query);
			rs = conexao.executaConsulta(query,session.getId()+"RS_25");
			if(rs.next()){                            
				do{
					cont++;
					if(muda == true){
						muda = false;
						cor = "#FFFFFF";
					}
					else{
						muda = true;
						cor = "#EEEEEE";
					}
					if(((!turma_grid.equals(rs.getString(1))) && (tipo_relatorio.equals("D"))) || (cont == 1)){
						%>
						<tr>
						 <td colspan="100%" class="ftverdanapreto">&nbsp;</td>
						</tr>
						<tr class="celtitrela"> 
						 <td width="22%" align="center"><%=trd.Traduz("CURSO")%></td>
						 <td width="10%" align="center"><%=trd.Traduz("TIPO")%></td>
						 <td width="7%" align="center"><%=trd.Traduz("DURACAO")%></td>
						 <td width="9%" align="center"><%=trd.Traduz("DT. INICIO")%></td>
						 <td width="9%" align="center"><%=trd.Traduz("DT. FIM")%></td>
						 <td width="9%" align="center"><%=trd.Traduz("Nº PARTICIPANTES")%></td>
						 <td width="9%" align="center"><%=trd.Traduz("Nº VAGAS")%></td>
						 <td width="8%" align="center"><%=trd.Traduz("CUSTO CURSO")%></td>
						 <td width="8%" align="center"><%=trd.Traduz("CUSTO LOGISTICA")%></td>
						 <td width="8%" align="center"><%=trd.Traduz("CUSTO TOTAL")%></td>
						</tr>
						<%
					}
									
					turma_grid = rs.getString(1);
					if(rs.getInt(6) == 0)
						classe = "ftverdanacinza";
					else if(rs.getInt(6) > 0)
						classe = "ftverdanaazul";
					else if(rs.getInt(6) < 0)
						classe = "ftverdanaverm";
					if((rs.getString(11).equals("S")) && (!status_reg.equals("")))
						classe = "ftverdanaverde";
					
					
					if(rs.getString(12) != null)
						turma = rs.getString(12);
						
					if(turma.equals("LONGA DURACAO")){
						String queryC =	"SELECT DISTINCT T.TEF_CODIGO, T.FUN_CODIGO, F.FUN_NOME, FI.FIL_NOME, F.FUN_CHAPA "+
										"FROM TREINAMENTO T, FUNCIONARIO F, FILIAL FI "+
										"WHERE T.TUR_CODIGO_PLAN_ANT = "+rs.getString(1)+" "+
										"AND T.FUN_CODIGO = F.FUN_CODIGO "+
										"AND F.FIL_CODIGO = FI.FIL_CODIGO ";
	
						rsC = conexao.executaConsulta(queryC,session.getId()+"RS_3");
						integrantes = 0;
						total = 0;
						contador = 0;
						int contador_total = 0;
						if(rsC.next()){
							do{
								integrantes++;
								//out.println("<br>INTEGRANTES: "+rsC.getString(1));
								String queryCC = "SELECT COUNT(*) FROM LANCAMENTO WHERE TEF_CODIGO = "+rsC.getString(1);
								rsCC = conexao.executaConsulta(queryCC,session.getId()+"R");
								//out.println("QUERY:"+queryCC);
								if(rsCC.next()){
									do{
									contador = contador + rsCC.getInt(1);
									}while(rsCC.next());
								}
                                                                if(rsCC!=null){
                                                                    rsCC.close();   
                                                                    conexao.finalizaConexao(session.getId()+"R");
                                                                    }
								
							}while(rsC.next());
							total = integrantes * 12;
							if(total == contador){
								classe = "ftverdanaverde";
							}
						}
                                                if(rsC !=null){
                                                rsC.close();    
                                                conexao.finalizaConexao(session.getId()+"RS_3");
                                                }
					}
					
					%>
					<tr bgcolor=<%=cor%>>
					 <td width="22%" class="<%=classe%>"> <%=((rs.getString(2)==null)?"":rs.getString(2))%> </td>
					 <td width="10%" class="<%=classe%>"> <%=turma%> </td>
					 
					 <td width="7%" class="<%=classe%>" align="center"> <%=((rs.getString(9)==null)?"":convHora(rs.getFloat(9)))%> </td>
					 <td width="9%" class="<%=classe%>" align="center"> 
					<%
                	if(rs.getDate(3)!=null){
                		String str_ini = formato.format(rs.getDate(3));
                		out.println(str_ini);
                	}
                	%>
                	 </td>
                	 <td width="9%" class="<%=classe%>" align="center">
                	 <%
                	if(rs.getDate(4)!=null){
						String str_fim = formato.format(rs.getDate(4));
                		out.println(str_fim);
                	}
                	%>
					 </td>
					 <td width="9%" class="<%=classe%>" align="center"> <%=((rs.getString(5)==null)?"":rs.getString(5))%> </td>
                	 <td width="9%" class="<%=classe%>" align="center"> <%=((rs.getString(6)==null)?"":rs.getString(6))%> </td>
                	 <td width="8%" class="<%=classe%>">
                	<%
                	if(rs.getString(7)!=null){
                		custo_total = custo_total + rs.getFloat(7);
                		out.println(ReaistoStr(rs.getFloat(7),moeda));
                	}
                	%>
                	 </td>
                	 <td width="8%" class="<%=classe%>">
                	<%
                	if(rs.getString(8)!=null){
                		logistica_total = logistica_total + rs.getFloat(8);
                		out.println(ReaistoStr(rs.getFloat(8),moeda));
                	}
                	%>
                	 </td>
					 <td width="8%" class="<%=classe%>">
					<%
					total_parcial = rs.getFloat(7) + rs.getFloat(8);
					total_total = total_total + total_parcial;
					out.println(ReaistoStr(total_parcial,moeda));
					%>
					 </td>
					</tr>
					<%
					String queryD =	"SELECT DISTINCT T.FUN_CODIGO, F.FUN_NOME, FI.FIL_NOME, F.FUN_CHAPA "+
									"FROM TREINAMENTO T, FUNCIONARIO F, FILIAL FI "+
									"WHERE T.TUR_CODIGO_PLAN_ANT = "+rs.getString(1)+" "+
									"AND T.FUN_CODIGO = F.FUN_CODIGO "+
									"AND F.FIL_CODIGO = FI.FIL_CODIGO ";
						
					if(!filial.equals(""))
						queryD = queryD + "AND FI.FIL_CODIGO = "+filial+" ORDER BY F.FUN_NOME ";
               		else
               			queryD = queryD + " ORDER BY F.FUN_NOME ";
					rsD = conexao.executaConsulta(queryD,session.getId()+"RS_D");
					
					if(tipo_relatorio.equals("D")){
						if(rsD.next()){
							%>
							<tr height="6px" width="6px">
		                	 <td>
		                	 </td>
		                	 <td class="celtitrela" bgcolor="<%=cor%>">
		                	  <%=trd.Traduz("CHAPA")%>
		                	 </td>
		                	 <td class="celtitrela" colspan="4" bgcolor="<%=cor%>">
		                	  <%=trd.Traduz("NOME")%>
		                	 </td>
		                	 <td class="celtitrela" colspan="4" bgcolor="<%=cor%>">
		                	  <%=trd.Traduz("FILIAL PADRAO")%>
		                	 </td>
		                	</tr>
		                	<%
		                	do{
			            		%>
			            		<tr>
			            		 <td>
			            		  &nbsp;
			            		 </td>
			            		 <td bgcolor="<%=cor%>"><span class="ftverdanacinza"><%=rsD.getString(4)%></span></td>
			            		 <td colspan="4" bgcolor="<%=cor%>"><span class="ftverdanacinza"><%=rsD.getString(2)%></span></td>
			            		 <td colspan="4" bgcolor="<%=cor%>"><span class="ftverdanacinza"><%=rsD.getString(3)%></span></td>
			            		</tr>
								<%
							}while(rsD.next());
						}
 					}
                                        if(rsD!=null){
                                            rsD.close();
                                            conexao.finalizaConexao(session.getId()+"RS_D");
                                            }
                                        
				}while (rs.next());
            %>
            <tr><td colspan="100%">&nbsp;</td></tr>
            <tr class="celtitrela"><td colspan="100%" align="center"><%=trd.Traduz("TOTAL")%></td></tr>
            <tr class="celcin">
             <td colspan="3">
              <%=trd.Traduz("CUSTO CURSO")%> = <%=ReaistoStr(custo_total,moeda)%>
             </td>
             <td colspan="3">
              <%=trd.Traduz("CUSTO LOGISTICA")%> = <%=ReaistoStr(logistica_total,moeda)%>
             </td>
             <td colspan="4">
              <%=trd.Traduz("CUSTO TOTAL")%> = <%=ReaistoStr(total_total,moeda)%>
             </td>
             
            </tr>
            <%
        } else {%>
                  <tr><td>&nbsp;</td></tr>
                  <tr align="center"><td colspan="100%" class="ftverdanacinza"><%=trd.Traduz("Nenhum dado encontrado!")%></td></tr>
                  <tr><td>&nbsp;</td></tr>
<%      }

                    if(rs!=null){
                                            rs.close();
                                        conexao.finalizaConexao(session.getId()+"RS_25");
                                            }



%>
            </table> 
          </td>
        </tr>
        </FORM>        
        <td width="20" valign="top"></td>
      </table>
    </td>
  </tr>
</table>     
</body>
</html>
<%

/*} catch (Exception e) {
  out.println("EE"+e);
}*/
%>