<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1"))
  response.setHeader("Cache-Control", "no-cache");
%>

<%@page import=" java.sql.*, java.text.*, java.util.*"%>
<html>

<%
//*******OBSERVACOES******* 
/*Itens a se considerar:
- Internet Explorer 6 ou superior (para impressao)
- Nao necessita do plug-in Java, mas se este estiver instalado na maquina em uma versao supeior a 1.3 (Ex. 1.4)
  este sera iniciado mas nao utilizado, podendo tornar o grafico mais lento
- Para imprimir a legenda corretamente, configurar o browser para "Imprimir imagens e cores do plano de fundo",
  em Ferramentas, Opcoes da Internet, Avancado, Impressoes
- Impressoras preto e branco podem apresentar problemas de impressao
- Se no cliente estiver instalado algum plug-in java, este deverA estar ativado (painel de controle)
- O plug in deve estar configurado para o browser utilizado
*/
//*************************

//Recupera dados da sessao
request.getSession();
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");


String usu_tipo = (String)session.getAttribute("usu_tipo");
String usu_nome = (String)session.getAttribute("usu_nome");
String usu_login = (String)session.getAttribute("usu_login");
Integer usu_fil = (Integer)session.getAttribute("usu_fil");
Integer usu_idi = (Integer)session.getAttribute("usu_idi");
Integer usu_plano = (Integer)session.getAttribute("usu_plano");
String plano_atual = "";
DecimalFormat dcf = new DecimalFormat("0.00");

ResultSet rs_plano = null, rs, rs_filtro = null, rs_legenda = null;

String query_plano = "SELECT PLA_NOME FROM PLANO WHERE PLA_CODIGO = "+usu_plano;
rs_plano = conexao.executaConsulta(query_plano,session.getId()+"RS_1");
if(rs_plano.next()){
    plano_atual = rs_plano.getString(1);
}
if(rs_plano!=null){
rs_plano.close();
conexao.finalizaConexao(session.getId()+"RS_1");
}

//variaveis
String query="", query_filtro="", query_legenda="", grupo="", group="", filtro="", tipo_valor="", agrupamento="", eixoY="", filtros="", titulo="", largura="";
String 	tit1="", tit2="", tit3="", tit4="", tit5="", tit6="", tit7="", tit8="", tit9="", tit10="";
String tit11="", tit12="", tit13="", tit14="", tit15="", tit16="", tit17="", tit18="";

float maior=0f;
int cont=0;
Float escala;
Vector dados = new Vector();
Vector cor = new Vector();
Vector legenda = new Vector();

//cor das barras do grAfico - vetor com 137 cores
cor.addElement("#0000FF"); cor.addElement("#8A2BE2"); cor.addElement("#A52A2A"); cor.addElement("#5F9EA0"); cor.addElement("#7FFF00");
cor.addElement("#D2691E"); cor.addElement("#FF7F50"); cor.addElement("#6495ED"); cor.addElement("#FFF8DC"); cor.addElement("#DC143C");
cor.addElement("#00FFFF"); cor.addElement("#00008B"); cor.addElement("#008B8B"); cor.addElement("#B8860B"); cor.addElement("#A9A9A9");
cor.addElement("#006400"); cor.addElement("#BDB76B"); cor.addElement("#8B008B"); cor.addElement("#556B2F"); cor.addElement("#FF8C00");
cor.addElement("#9932CC"); cor.addElement("#8B0000"); cor.addElement("#E9967A"); cor.addElement("#8FBC8F"); cor.addElement("#483D8B");
cor.addElement("#2F4F4F"); cor.addElement("#00CED1"); cor.addElement("#9400D3"); cor.addElement("#FF1493"); cor.addElement("#00BFFF");
cor.addElement("#696969"); cor.addElement("#1E90FF"); cor.addElement("#B22222"); cor.addElement("#FFFAF0"); cor.addElement("#228B22");
cor.addElement("#FF00FF"); cor.addElement("#DCDCDC"); cor.addElement("#F8F8FF"); cor.addElement("#FFD700"); cor.addElement("#DAA520");
cor.addElement("#808080"); cor.addElement("#008000"); cor.addElement("#ADFF2F"); cor.addElement("#F0FFF0"); cor.addElement("#FF69B4");
cor.addElement("#CD5C5C"); cor.addElement("#4B0082"); cor.addElement("#FFFFF0"); cor.addElement("#F0E68C"); cor.addElement("#E6E6FA");
cor.addElement("#FFF0F5"); cor.addElement("#7CFC00"); cor.addElement("#FFFACD"); cor.addElement("#ADD8E6"); cor.addElement("#F08080");
cor.addElement("#E0FFFF"); cor.addElement("#FAFAD2"); cor.addElement("#90EE90"); cor.addElement("#D3D3D3"); cor.addElement("#FFB6C1");
cor.addElement("#FFA07A"); cor.addElement("#20B2AA"); cor.addElement("#87CEFA"); cor.addElement("#778899"); cor.addElement("#B0C4DE");
cor.addElement("#FFFFE0"); cor.addElement("#00FF00"); cor.addElement("#32CD32"); cor.addElement("#FAF0E6"); cor.addElement("#FF00FF");
cor.addElement("#800000"); cor.addElement("#66CDAA"); cor.addElement("#0000CD"); cor.addElement("#9370D8"); cor.addElement("#3CB371");
cor.addElement("#7B68EE"); cor.addElement("#00FA9A"); cor.addElement("#48D1CC"); cor.addElement("#C71585"); cor.addElement("#191970");
cor.addElement("#F5FFFA"); cor.addElement("#FFE4E1"); cor.addElement("#FFE4B5"); cor.addElement("#FFDEAD"); cor.addElement("#000080");
cor.addElement("#FDF5E6"); cor.addElement("#808000"); cor.addElement("#688E23"); cor.addElement("#FFA500"); cor.addElement("#FF4500");
cor.addElement("#DA70D6"); cor.addElement("#EEE8AA"); cor.addElement("#98FB98"); cor.addElement("#AFEEEE"); cor.addElement("#D87093");
cor.addElement("#FFEFD5"); cor.addElement("#FFDAB9"); cor.addElement("#CD853F"); cor.addElement("#FFC0CB"); cor.addElement("#DDA0DD");
cor.addElement("#B0E0E6"); cor.addElement("#800080"); cor.addElement("#FF0000"); cor.addElement("#BC8F8F"); cor.addElement("#4169E1");
cor.addElement("#8B4513"); cor.addElement("#FA8072"); cor.addElement("#F4A460"); cor.addElement("#2E8B57"); cor.addElement("#FFF5EE");
cor.addElement("#A0522D"); cor.addElement("#C0C0C0"); cor.addElement("#87CEEB"); cor.addElement("#6A5ACD"); cor.addElement("#708090");
cor.addElement("#FFFAFA"); cor.addElement("#00FF7F"); cor.addElement("#4682B4"); cor.addElement("#D2B48C"); cor.addElement("#008080");
cor.addElement("#D8BFD8"); cor.addElement("#FF6347"); cor.addElement("#40E0D0"); cor.addElement("#EE82EE"); cor.addElement("#F5DEB3");
cor.addElement("#336688"); cor.addElement("#F0F8FF"); cor.addElement("#FAEBD7"); cor.addElement("#00FFFF"); cor.addElement("#7FFFD4");
cor.addElement("#F0FFFF"); cor.addElement("#F5F5DC"); cor.addElement("#FFE4C4"); cor.addElement("#DEB887"); cor.addElement("#FFEBCD");
cor.addElement("#FFFFFF"); cor.addElement("#F5F5F5");

//try {

//Agrupamento (tipo dos dados)
//**************************REALIZADOS******************************
if(request.getParameter("cbo_grupo") != null) {
	if(request.getParameter("cbo_grupo").equals("AS")) {//Assunto
	  query = "SELECT A.ASS_NOME, ";
	  group = " AND (SELECT COUNT(*) FROM ASSUNTO) <> 0 GROUP BY A.ASS_NOME ";
	  grupo = "AS";
	  titulo = trd.Traduz("ASSUNTO");
	  agrupamento = "R";
	}
	if(request.getParameter("cbo_grupo").equals("CA")) {//Cargo
	  query = "SELECT CA.CAR_NOME, ";
	  group = " AND (SELECT COUNT(*) FROM CARGO) <> 0 GROUP BY CA.CAR_NOME ";
	  grupo = "CA";
	  titulo = trd.Traduz("CARGO");
	  agrupamento = "R";
	}
	if(request.getParameter("cbo_grupo").equals("CU")) {//Curso
	  query = "SELECT CU.CUR_NOME, ";
	  group = " AND (SELECT COUNT(*) FROM CURSO) <> 0 GROUP BY CU.CUR_NOME ";
	  grupo = "CU";
	  titulo = trd.Traduz("CURSO");
	  agrupamento = "R";
	}
	if(request.getParameter("cbo_grupo").equals("DE")) {//Departamento
	  query = "SELECT D.DEP_NOME, ";
	  group = " AND (SELECT COUNT(*) FROM DEPTO) <> 0 GROUP BY D.DEP_NOME ";
	  grupo = "DE";
	  titulo = trd.Traduz("DEPARTAMENTO");
	  agrupamento = "R";
	}
	if(request.getParameter("cbo_grupo").equals("FI")) {//Filial
	  query = "SELECT FI.FIL_NOME, ";
	  grupo = "FI";
	  titulo = trd.Traduz("FILIAL");
	  group = " AND (SELECT COUNT(*) FROM FILIAL) <> 0 GROUP BY FI.FIL_NOME ";
	  agrupamento = "R";
	}
	if(request.getParameter("cbo_grupo").equals("FU")) {//Funcionario
	  query = "SELECT F.FUN_NOME, ";
	  grupo = "FU";
	  titulo = trd.Traduz("FUNCIONARIO");
	  group = " AND (SELECT COUNT(*) FROM FUNCIONARIO) <> 0 GROUP BY F.FUN_NOME ";
	  agrupamento = "R";
	}
	if(request.getParameter("cbo_grupo").equals("SO")) {//Solicitante
	  query = "SELECT F.FUN_CODSOLIC, ";
	  grupo = "SO";
	  titulo = trd.Traduz("SOLICITANTE");
	  group = " AND (SELECT COUNT(*) FROM FUNCIONARIO) <> 0 GROUP BY F.FUN_CODSOLIC ";
	  agrupamento = "R";
	}
	if(request.getParameter("cbo_grupo").equals("T1")) {//Tabela1
	  query = "SELECT T1.TB1_NOME, ";
	  grupo = "T1";
	  titulo = trd.Traduz("TABELA1");
	  group = " AND (SELECT COUNT(*) FROM TABELA1) <> 0 GROUP BY T1.TB1_NOME ";
	  agrupamento = "R";
	}
	if(request.getParameter("cbo_grupo").equals("T2")) {//Tabela2
	  query = "SELECT T2.TB2_NOME, ";
	  grupo = "T2";
	  titulo = trd.Traduz("TABELA2");
	  group = " AND (SELECT COUNT(*) FROM TABELA2) <> 0 GROUP BY T2.TB2_NOME ";
	  agrupamento = "R";
	}
	if(request.getParameter("cbo_grupo").equals("T3")) {//Tabela3
	  query = "SELECT T3.TB3_DESCRICAO, ";
	  grupo = "T3";
	  titulo = trd.Traduz("TABELA3");
	  group = " AND (SELECT COUNT(*) FROM TABELA3) <> 0 GROUP BY T3.TB3_DESCRICAO ";
	  agrupamento = "R";
	}
	if(request.getParameter("cbo_grupo").equals("TP")) {//Tipo
	  query = "SELECT TP.TTR_NOME, ";
	  grupo = "TP";
	  titulo = trd.Traduz("TIPO");
	  group = " AND (SELECT COUNT(*) FROM TIPOTREINAMENTO) <> 0 GROUP BY TP.TTR_NOME ";
	  agrupamento = "R";
	}
	if(request.getParameter("cbo_grupo").equals("TI")) {//Titulo
	  query = "SELECT TI.TIT_NOME, ";
	  grupo = "TI";
	  titulo = trd.Traduz("TITULO");
	  group = " AND (SELECT COUNT(*) FROM TITULO) <> 0 GROUP BY TI.TIT_NOME ";
	  agrupamento = "R";
	}
}
//**************************PLANEJADOS******************************
if(request.getParameter("cbo_grupo") != null) {
	if(request.getParameter("cbo_grupo").equals("RJ")) {//Realizado x Pranejado
	  query = "SELECT T.TEF_CODIGO, T.TUR_CODIGO_REAL, T.JUS_CODIGO, ";
	  grupo = "RJ";
	  titulo = trd.Traduz("REALIZADO X PLANEJADO");
	  group = "GROUP BY T.TEF_CODIGO, T.TUR_CODIGO_REAL, T.JUS_CODIGO ";
	  agrupamento = "P";
	}
}

//Distincao de valores (H: Hora, V:Valor($) e T:Treinamentos
String valor = "";
if(request.getParameter("rdo_valor") != null)
	valor = request.getParameter("rdo_valor");
if(valor.equals("H")) { //Hora
  query = query + "SUM (T.TEF_DURACAO) ";
  tipo_valor = "H";
  eixoY = trd.Traduz("Horas de Treinamento");
} else if (valor.equals("V")) { //Valor
  query = query + "SUM (T.TEF_CUSTO) ";
  tipo_valor = "V";
  eixoY = trd.Traduz("Valor dos treinamentos");
} else if (valor.equals("T")) { //Treinamentos
  query = query + "COUNT(*) AS QTDE ";
  tipo_valor = "T";
  eixoY = trd.Traduz("NUmero de treinamentos");
  dcf = new DecimalFormat("0");
}

//Consulta dos dados
query = query + "FROM ASSUNTO A, TITULO TI, CURSO CU, TREINAMENTO T, CARGO CA, FUNCIONARIO F, DEPTO D, FILIAL FI, "+
                "TABELA1 T1, TABELA2 T2, TABELA3 T3, TIPOTREINAMENTO TP "+
                "WHERE T.PLA_CODIGO = "+usu_plano+" "+
                "AND TI.ASS_CODIGO = A.ASS_CODIGO "+
                "AND TI.TIT_CODIGO = CU.TIT_CODIGO "+
                "AND CU.CUR_CODIGO = T.CUR_CODIGO "+
                "AND T.FUN_CODIGO = F.FUN_CODIGO "+
                "AND CA.CAR_CODIGO = F.CAR_CODIGO "+
                "AND F.FIL_CODIGO = FI.FIL_CODIGO "+
                "AND F.DEP_CODIGO = D.DEP_CODIGO "+
                "AND F.TB1_CODIGO OUTER T1.TB1_CODIGO "+
                "AND F.TB2_CODIGO OUTER T2.TB2_CODIGO "+
                "AND F.TB3_CODIGO OUTER T3.TB3_CODIGO "+
                "AND TP.TTR_CODIGO = T.TTR_CODIGO ";
if (agrupamento.equals("R"))//realizados
  query = query + "AND T.TUR_CODIGO_REAL IS NOT NULL ";
if(request.getParameter("cbo_grupo") != null) {
	if (request.getParameter("cbo_grupo").equals("SO"))
	  query = query + "AND F.FUN_CODSOLIC IS NOT NULL ";
}

//filtros
if(request.getParameter("cbo_solic") != null) {
	if (!request.getParameter("cbo_solic").equals("")){ //filtro solicitante
	  query = query + "AND F.FUN_CODSOLIC = " + request.getParameter("cbo_solic") + " ";
	  query_filtro = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = " +request.getParameter("cbo_solic")+ " 	";
	  rs_filtro = conexao.executaConsulta(query_filtro,session.getId()+"RS_2");
	  if (rs_filtro.next())
	   filtros = filtros + trd.Traduz("SOLICITANTE") + ": " + rs_filtro.getString(1) + "<BR>";
	  }
          if(rs_filtro!=null){
            rs_filtro.close();
            conexao.finalizaConexao(session.getId()+"RS_2");
            }
}
if(request.getParameter("cbo_tipo") != null) {
	if (!request.getParameter("cbo_tipo").equals("")){ //filtro tipo curso
	  query = query + "AND CU.TCU_CODIGO = " + request.getParameter("cbo_tipo") + " ";
	  query_filtro = "SELECT TCU_NOME FROM TIPOCURSO WHERE TCU_CODIGO = " +request.getParameter("cbo_tipo")+ " ";
	  rs_filtro = conexao.executaConsulta(query_filtro,session.getId()+"RS_3");
	  if (rs_filtro.next())
	    filtros = filtros + trd.Traduz("TIPO DE CURSO") +": " + rs_filtro.getString(1) + "<BR>";
	  }
          if(rs_filtro!=null)  {
            rs_filtro.close(); 
            conexao.finalizaConexao(session.getId()+"RS_3");
          }
}
if(request.getParameter("cbo_departamento") != null) {
	if (!request.getParameter("cbo_departamento").equals("")){ //filtro departamento
	  query = query + "AND F.DEP_CODIGO = " + request.getParameter("cbo_departamento") + " ";
	  query_filtro = "SELECT DEP_NOME FROM DEPTO WHERE DEP_CODIGO = " +request.getParameter("cbo_departamento")+ " ";
	  rs_filtro = conexao.executaConsulta(query_filtro,session.getId()+"RS_4");
	  if (rs_filtro.next())
	    filtros = filtros + trd.Traduz("DEPARTAMENTO") +": " + rs_filtro.getString(1) + "<BR>";
	}
        if(rs_filtro!=null)  {
            rs_filtro.close(); 
            conexao.finalizaConexao(session.getId()+"RS_4");
          }
        
}
if(request.getParameter("cbo_cargo") != null) {
	if (!request.getParameter("cbo_cargo").equals("")){ //filtro cargo
	  query = query + "AND F.CAR_CODIGO = " + request.getParameter("cbo_cargo") + " ";
	  query_filtro = "SELECT CAR_NOME FROM CARGO WHERE CAR_CODIGO = " +request.getParameter("cbo_cargo")+ " ";
	  rs_filtro = conexao.executaConsulta(query_filtro,session.getId()+"RS_5");
	  if (rs_filtro.next())
	    filtros = filtros + trd.Traduz("CARGO") +": " + rs_filtro.getString(1) + "<BR>";
	}
        if(rs_filtro!=null)  {
            rs_filtro.close(); 
            conexao.finalizaConexao(session.getId()+"RS_5");
          }
}
if(request.getParameter("cbo_curso") != null) {
	if (!request.getParameter("cbo_curso").equals("")){ //filtro curso
	  query = query + "AND T.CUR_CODIGO = " + request.getParameter("cbo_curso") + " ";
	  query_filtro = "SELECT CUR_NOME FROM CURSO WHERE CUR_CODIGO = " +request.getParameter("cbo_curso")+ " ";
	  rs_filtro = conexao.executaConsulta(query_filtro,session.getId()+"RS_5");
	  if (rs_filtro.next())
	    filtros = filtros + trd.Traduz("CURSO") +": " + rs_filtro.getString(1) + "<BR>";
	}
}
if(request.getParameter("cbo_filial") != null) {
	if (!request.getParameter("cbo_filial").equals("")){ //filtro filial
	  query = query + "AND F.FIL_CODIGO = " + request.getParameter("cbo_filial") + " ";
	  query_filtro = "SELECT FIL_NOME FROM FILIAL WHERE FIL_CODIGO = " +request.getParameter("cbo_filial")+ " ";
	  rs_filtro = conexao.executaConsulta(query_filtro,session.getId()+"RS_6");
	  if (rs_filtro.next())
	    filtros = filtros + trd.Traduz("FILIAL") +": " + rs_filtro.getString(1) + "<BR>";
	}
        if(rs_filtro!=null)  {
            rs_filtro.close(); 
            conexao.finalizaConexao(session.getId()+"RS_6");
          }
}
if(request.getParameter("cbo_titulo") != null) {
	if (!request.getParameter("cbo_titulo").equals("")){ //filtro titulo
	  query = query + "AND CU.TIT_CODIGO = " + request.getParameter("cbo_titulo") + " ";
	  query_filtro = "SELECT TIT_NOME FROM TITULO WHERE TIT_CODIGO = " +request.getParameter("cbo_titulo")+ " ";
	  rs_filtro = conexao.executaConsulta(query_filtro,session.getId()+"RS_7");
	  if (rs_filtro.next())
	     filtros = filtros + trd.Traduz("TITULO")  +": " + rs_filtro.getString(1) + "<BR>";
	}
        if(rs_filtro!=null)  {
            rs_filtro.close(); 
            conexao.finalizaConexao(session.getId()+"RS_7");
          }
}
if(request.getParameter("cbo_regiao") != null) {
	if (!request.getParameter("cbo_regiao").equals("")){ //filtro regiao
	  query = query + "AND FI.REG_CODIGO = " + request.getParameter("cbo_regiao") + " ";
	  query_filtro = "SELECT REG_NOME FROM REGIAO WHERE REG_CODIGO = " +request.getParameter("cbo_regiao")+ " ";
	  rs_filtro = conexao.executaConsulta(query_filtro,session.getId()+"RS_8");
	  if (rs_filtro.next())
	    filtros = filtros + trd.Traduz("REGIAO") +": " + rs_filtro.getString(1) + "<BR>";
	}
        if(rs_filtro!=null)  {
            rs_filtro.close(); 
            conexao.finalizaConexao(session.getId()+"RS_8");
          }

}
if(request.getParameter("cbo_entidade") != null) {
	if (!request.getParameter("cbo_entidade").equals("")){ //filtro entidade
	  query = query + "AND T.EMP_CODIGO = " + request.getParameter("cbo_entidade") + " ";
	  query_filtro = "SELECT EMP_NOME FROM EMPRESA WHERE EMP_CODIGO = " +request.getParameter("cbo_entidade")+ " ";
	  rs_filtro = conexao.executaConsulta(query_filtro,session.getId()+"RS_9");
	  if (rs_filtro.next())
	    filtros = filtros + trd.Traduz("ENTIDADE") +": " + rs_filtro.getString(1) + "<BR>";
	}
         if(rs_filtro!=null)  {
            rs_filtro.close(); 
            conexao.finalizaConexao(session.getId()+"RS_9");
          }
}
if(request.getParameter("cbo_func") != null) {
	if (!request.getParameter("cbo_func").equals("")){ //filtro funcionario
	  query = query + "AND F.FUN_CODIGO = " + request.getParameter("cbo_func") + " ";
	  query_filtro = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = " +request.getParameter("cbo_func")+ " ";
	  rs_filtro = conexao.executaConsulta(query_filtro,session.getId()+"RS_10");
	  if (rs_filtro.next())
		filtros = filtros + trd.Traduz("FUNCIONARIO") +": " + rs_filtro.getString(1) + "<BR>";
	}
        if(rs_filtro!=null)  {
            rs_filtro.close(); 
            conexao.finalizaConexao(session.getId()+"RS_10");
          }
}
if(request.getParameter("cbo_tb1") != null) {
	if (!request.getParameter("cbo_tb1").equals("")){ //filtro tabela1
	  query = query + "AND F.TB1_CODIGO = " + request.getParameter("cbo_tb1") + " ";
	  query_filtro = "SELECT TB1_NOME FROM TABELA1 WHERE TB1_CODIGO = " +request.getParameter("cbo_tb1")+ " ";
	  rs_filtro = conexao.executaConsulta(query_filtro,session.getId()+"RS");
	  if (rs_filtro.next())
	    filtros = filtros + trd.Traduz("TABELA1") +": " + rs_filtro.getString(1) + "<BR>";
	}
        if(rs_filtro!=null)  {
            rs_filtro.close(); 
            conexao.finalizaConexao(session.getId()+"RS");
          }
}
if(request.getParameter("cbo_tb2") != null) {
	if (!request.getParameter("cbo_tb2").equals("")){ //filtro tabela2
	  query = query + "AND F.TB2_CODIGO = " + request.getParameter("cbo_tb2") + " ";
	  query_filtro = "SELECT TB2_NOME FROM TABELA2 WHERE TB2_CODIGO = " +request.getParameter("cbo_tb2")+ " ";
	  rs_filtro = conexao.executaConsulta(query_filtro,session.getId()+"RS_11");
	  if (rs_filtro.next())
	    filtros = filtros + trd.Traduz("TABELA2") +": " + rs_filtro.getString(1) + "<BR>";
	}
        if(rs_filtro!=null)  {
            rs_filtro.close(); 
            conexao.finalizaConexao(session.getId()+"RS_11");
          }
}
if(request.getParameter("cbo_tb3") != null) {
	if (!request.getParameter("cbo_tb3").equals("")){ //filtro tabela3
	  query = query + "AND F.TB3_CODIGO = " + request.getParameter("cbo_tb3") + " ";
	  query_filtro = "SELECT TB3_DESCRICAO FROM TABELA3 WHERE TB3_CODIGO = " +request.getParameter("cbo_tb3")+ " ";
	  rs_filtro = conexao.executaConsulta(query_filtro,session.getId()+"RS_12");
	  if (rs_filtro.next())
	    filtros = filtros + trd.Traduz("TABELA3") +": " + rs_filtro.getString(1) + "<BR>";
            }
          if(rs_filtro!=null)  {
            rs_filtro.close(); 
            conexao.finalizaConexao(session.getId()+"RS_12");
          }
}
if(request.getParameter("cbo_tb4") != null) {
	if (!request.getParameter("cbo_tb4").equals("")){ //filtro tabela4
	  query = query + "AND F.TB4_CODIGO = " + request.getParameter("cbo_tb4") + " ";
	  query_filtro = "SELECT TB4_DESCRICAO FROM TABELA4 WHERE TB4_CODIGO = " +request.getParameter("cbo_tb4")+ " ";
	  rs_filtro = conexao.executaConsulta(query_filtro,session.getId()+"RS_13");
	  if (rs_filtro.next())
	    filtros = filtros + trd.Traduz("TABELA4") +": " + rs_filtro.getString(1) + "<BR>";
	}
        if(rs_filtro!=null)  {
            rs_filtro.close(); 
            conexao.finalizaConexao(session.getId()+"RS_13");
          }
}
/*if (!request.getParameter("cbo_tb5").equals("")){ //filtro tabela5
  query = query + "AND F.TB5_CODIGO = " + request.getParameter("cbo_tb5") + " ";
  query_filtro = "SELECT TB5_DESCRICAO FROM TABELA5 WHERE TB5_CODIGO = " +request.getParameter("cbo_tb5")+ " ";
  rs_filtro = conexaofiltro.executaConsulta(query_filtro);
  if (rs_filtro.next())
    filtros = filtros + trd.Traduz("TABELA5")  +": " + rs_filtro.getString(1) + "<BR>";
}
if (!request.getParameter("cbo_tb6").equals("")){ //filtro tabela6
  query = query + "AND F.TB6_CODIGO = " + request.getParameter("cbo_tb6") + " ";
  query_filtro = "SELECT TB6_DESCRICAO FROM TABELA6 WHERE TB6_CODIGO = " +request.getParameter("cbo_tb6")+ " ";
  rs_filtro = conexaofiltro.executaConsulta(query_filtro);
  if (rs_filtro.next())
    filtros = filtros + trd.Traduz("TABELA6") +": " + rs_filtro.getString(1) + "<BR>";
}
if (!request.getParameter("cbo_tb7").equals("")){ //filtro tabela7
  query = query + "AND F.TB7_CODIGO = " + request.getParameter("cbo_tb7") + " ";
  query_filtro = "SELECT TB7_DESCRICAO FROM TABELA7 WHERE TB7_CODIGO = " +request.getParameter("cbo_tb7")+ " ";
  rs_filtro = conexaofiltro.executaConsulta(query_filtro);
  if (rs_filtro.next())
    filtros = filtros + trd.Traduz("TABELA7")  +": " + rs_filtro.getString(1) + "<BR>";
}
if (!request.getParameter("cbo_tb8").equals("")){ //filtro tabela8
  query = query + "AND F.TB8_CODIGO = " + request.getParameter("cbo_tb8") + " ";
  query_filtro = "SELECT TB8_DESCRICAO FROM TABELA8 WHERE TB8_CODIGO = " +request.getParameter("cbo_tb8")+ " ";
  rs_filtro = conexaofiltro.executaConsulta(query_filtro);
  if (rs_filtro.next())
    filtros = filtros + trd.Traduz("TABELA8")  +": " + rs_filtro.getString(1) + "<BR>";
}*/
query = query + group;

titulo = titulo + " / " + plano_atual;
if (filtros.equals("")) filtros = trd.Traduz("NENHUM");
%>

<%!//converte minutos em hora
public String convHora(float minutos){ 
  Float ft = new Float(minutos);
  int min = ft.intValue();
  String total = "";
  float result;
  int inteiro = 0, decimal = 0;
  result = min / 60;
  Float ft2 = new Float(result);
  inteiro = ft2.intValue();
  decimal = min % 60;
  total = inteiro + "." + decimal;
  return total;
}%>

<%
//out.println(query);
rs = conexao.executaConsulta(query,session.getId()+"RS_14");

//********************************
//caso exista dados para o grAfico
if (rs.next()) {
//****REALIZADOS****
  if (agrupamento.equals("R")) {
    do {
      if (tipo_valor.equals("H")) {
        dados.addElement(convHora(rs.getFloat(2)));
      } else {
        dados.addElement(rs.getString(2));
      }
      if (rs.getFloat(2) > maior)
        maior = rs.getFloat(2);
	  if(request.getParameter("cbo_grupo") != null) {
	      if (request.getParameter("cbo_grupo").equals("SO")) {
		    query_legenda = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = "+rs.getString(1);
			rs_legenda = conexao.executaConsulta(query_legenda,session.getId()+"RS_15");
	        if (rs_legenda.next()) legenda.addElement(rs_legenda.getString(1));
		  } else {
			legenda.addElement(rs.getString(1));
	      }
              if(rs_legenda!=null){
                rs_legenda.close();
                conexao.finalizaConexao(session.getId()+"RS_15");
                }
	  }
      cont++;
    } while (rs.next());
  }
//****PLANEJADOS****      T.TEF_CODIGO, T.TUR_CODIGO_REAL, T.JUS_CODIGO
  if (agrupamento.equals("P")) {
    float plan=0, real=0, just=0;
    if (grupo.equals("RJ")) {
      do {
        if (tipo_valor.equals("T")) {//qtde treinamentos
          if (rs.getString(2) != null) {
            real=real+1; 
          } else {
            if (rs.getString(3) != null)
              just=just+1;
            else
              plan=plan+1;
          }
        } else {//hora e valor
          if (rs.getString(2) != null) {
            real=real+rs.getFloat(4); 
          } else {
            if (rs.getString(3) != null)
              just=just+rs.getFloat(4);
            else
              plan=plan+rs.getFloat(4);
          }
        }
      } while (rs.next());
      if (tipo_valor.equals("H")) {//hora
        dados.addElement(convHora(real));
        dados.addElement(convHora(plan));
        dados.addElement(convHora(just));
      } else {//treinamento e valor
        dados.addElement(real+"");
        dados.addElement(plan+"");
        dados.addElement(just+"");
      }
      legenda.addElement(trd.Traduz("REALIZADOS"));
      legenda.addElement(trd.Traduz("PLANEJADOS"));
      legenda.addElement(trd.Traduz("JUSTIFICADOS"));
    }
    if (real > plan && real > just) maior=real;
    if (plan > real && plan > just) maior=plan;
    if (just > plan && just > real) maior=just;

  }

  //valor de percuntuais para o grAfico
  float maior_graf = 0;
  for(int i=0;dados.size() > i;i++)
   if (Float.valueOf(dados.elementAt(i)+"").floatValue() >= maior_graf) 
      maior_graf = Float.valueOf(dados.elementAt(i)+"").floatValue();

  if(maior_graf <= 0) maior_graf = 1;

  //largura das barras
  if (dados.size() < 15)
    largura = "      ";
  else if (dados.size() < 22)
    largura = "    ";
  else if (dados.size() < 29)
    largura = "   ";
  else
    largura = "  ";
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%>
<head>
<title>FirstOn - <%=trd.Traduz("ImpressOes")%> - <%=trd.Traduz("GrAficos")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<script language="JavaScript1.1">
function OnLoadPage() {

    // GrAfico de Barras - Vertical
    if(BarGraph.setHeader("<%=titulo%>", BarGraph.VERTICAL, "#FFFFFF", <%=dados.size()%>)) {
       // Adiciona as colunas do GrAfico.
       //BarGraph.setAttributes(1, "Jan", "15", 15, BarGraph.SOLID, "#EE3838");
        <%for(int i=0;dados.size() > i;i++){%>
       	<%="BarGraph.setAttributes("+(i+1)+", \""+largura+"\",\""+dcf.format(Float.valueOf(dados.elementAt(i)+"").floatValue())+"\", "+((Float.valueOf(dados.elementAt(i)+"").floatValue()*100)/maior_graf)+", BarGraph.SOLID, \""+cor.elementAt(i)+"\");"%>
	<%}%>    

       // Desenha o grAfico
       BarGraph.draw();
    }
    return;
}

function imprimir(){
    window.print();
    return false;
}
</script>
<body  onunload='return fecha();'  onload="OnLoadPage()">
<center>
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
                <td class="trontrk" width="100%" align="center"><%=titulo%><br><%=eixoY%></td>                              
              </tr>
            </table>
          </td>
          <td width="20">&nbsp;</td>
        </tr>        				
        <tr> 
          <td width="20" valign="top"></td>
          <td valign="top"> &nbsp;<br>
	    <table width="100%" border="0" cellspacing="1" cellpadding="3">                 
	      <tr>
		<td width="100%" class="ftverdanapreto"> <%=trd.Traduz("FILTROS ESCOLHIDOS")%>: <span class="ftverdanacinza"> <%=filtros%> </span></td>
              </tr>
	    </table>
            <table width="100%" height="100%" border="0"> 
              <tr><td colspan="100%">&nbsp;</td></tr>
              <tr>
                <td align="center" width="75%">
                  <applet codebase="." code="com.gencode.util.applet.BarGraph.class" name="BarGraph" width=700 height=400></applet>
                </td>
                <td width="25%">
                  <table width="100%" border="0">
<%                for(int i=0;dados.size() > i;i++) {%>
                    <tr>
                    <td width="5%" bgcolor="<%=cor.elementAt(i)%>">&nbsp;&nbsp;&nbsp;</td>
                    <td width="95%" bgcolor="#FFFFFF" class="ftverdanacinza">&nbsp;<%=legenda.elementAt(i)%></td>
                    </tr>
<%                }%>
                  </table>
                </td>
              </tr>
            </table>
            <!--<input type="button" onClick="return imprimir();" Value="Imprimir">-->
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</center>
</body>
<%
/*for (int i=0; dados.size() > i; i++) {
    out.println(dados.elementAt(i) + "<br>");
    out.println(legenda.elementAt(i) + "<br>");
}*/

%>
<%
//************************************
//caso nao exista dados para o grAfico
} else {
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%>
<head>
<title>FirstOn - <%=trd.Traduz("ImpressOes")%> - <%=trd.Traduz("GrAficos")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<script language="JavaScript1.1">
function fecha() {
  history.go(-1);
}
</script>
<body  onunload='return fecha();' >
<center>
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
                <td class="trontrk" width="100%" align="center"><%=titulo%><br><%=eixoY%></td>                              
              </tr>
            </table>
          </td>
          <td width="20">&nbsp;</td>
        </tr>        				
        <tr> 
          <td width="20" valign="top"></td>
          <td valign="top"> &nbsp;<br>
	    <table width="100%" border="0" cellspacing="1" cellpadding="3">                 
	      <tr>
		<td width="100%" class="ftverdanapreto"> <%=trd.Traduz("FILTROS ESCOLHIDOS")%>: <span class="ftverdanacinza"> <%=filtros%> </span></td>
              </tr>
	    </table>
            <table width="100%" height="100%" border="0"> 
              <tr><td colspan="100%">&nbsp;</td></tr>
              <tr>
	        <td align="center" bgcolor="FFFFFF"> 
	          <img src="../art/em_peq.gif" border="0">
	          <br><br>
	          <font face="Verdana" size="1" color="000000"><%=trd.Traduz("NENHUM ITEM SELECIONADO")%></font>
	          <br><br><br><br>
	          <input type="button" class="botcin" value=<%=("\""+trd.Traduz("VOLTAR")+"\"")%> onclick="return fecha();">
	        </td>
              </tr>
            </table>
            <!--<input type="button" onClick="return imprimir();" Value="Imprimir">-->
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</center>
</body>
</html>
	
<%
}

if(rs_filtro!=null)  {
            rs_filtro.close(); 
            conexao.finalizaConexao(session.getId()+"RS_14");
          }

//} catch (Exception e) {
//  out.println(e);
//}
%>