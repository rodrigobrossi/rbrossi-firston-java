<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")) {
  response.setHeader("Cache-Control", "no-cache");
}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*" %>


<%
try{

//Recupera dados da sessao
request.getSession();
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");


String usu_tipo 	= (((String)session.getAttribute("usu_tipo")==null)?"":(String)session.getAttribute("usu_tipo"));
String usu_nome 	= (((String)session.getAttribute("usu_nome")==null)?"":(String)session.getAttribute("usu_nome"));
String usu_login 	= (((String)session.getAttribute("usu_login")==null)?"":(String)session.getAttribute("usu_login"));
Integer usu_fil 	= (((Integer)session.getAttribute("usu_fil")==null)?new Integer(0):(Integer)session.getAttribute("usu_fil"));
Integer usu_idi 	= (((Integer)session.getAttribute("usu_idi")==null)?new Integer(0):(Integer)session.getAttribute("usu_idi"));
Integer usu_plano 	= (((Integer)session.getAttribute("usu_plano")==null)?new Integer(0):(Integer)session.getAttribute("usu_plano"));

//***********************
//Declaracao de variaveis
//***********************
//Valores mensais dos Titulos
float janQ=0, janHV=0, fevQ=0, fevHV=0, marQ=0, marHV=0, abrQ=0, abrHV=0, maiQ=0, maiHV=0, junQ=0, junHV=0;
float julQ=0, julHV=0, agoQ=0, agoHV=0, setQ=0, setHV=0, outQ=0, outHV=0, novQ=0, novHV=0, dezQ=0, dezHV=0;
float TAjanQ=0, TAjanHV=0, TAfevQ=0, TAfevHV=0, TAmarQ=0, TAmarHV=0, TAabrQ=0, TAabrHV=0, TAmaiQ=0, TAmaiHV=0, TAjunQ=0, TAjunHV=0;
float TAjulQ=0, TAjulHV=0, TAagoQ=0, TAagoHV=0, TAsetQ=0, TAsetHV=0, TAoutQ=0, TAoutHV=0, TAnovQ=0, TAnovHV=0, TAdezQ=0, TAdezHV=0;
//Total de Treinamento
float TTjanQ=0, TTjanHV=0, TTfevQ=0, TTfevHV=0, TTmarQ=0, TTmarHV=0, TTabrQ=0, TTabrHV=0, TTmaiQ=0, TTmaiHV=0, TTjunQ=0, TTjunHV=0;
float TTjulQ=0, TTjulHV=0, TTagoQ=0, TTagoHV=0, TTsetQ=0, TTsetHV=0, TToutQ=0, TToutHV=0, TTnovQ=0, TTnovHV=0, TTdezQ=0, TTdezHV=0;
//Total Trabalho
float janTTrabV=0, janTTrabH=0, fevTTrabV=0, fevTTrabH=0, marTTrabV=0, marTTrabH=0, abrTTrabV=0, abrTTrabH=0;
float maiTTrabV=0, maiTTrabH=0, junTTrabV=0, junTTrabH=0, julTTrabV=0, julTTrabH=0, agoTTrabV=0, agoTTrabH=0;
float setTTrabV=0, setTTrabH=0, outTTrabV=0, outTTrabH=0, novTTrabV=0, novTTrabH=0, dezTTrabV=0, dezTTrabH=0;
float janTTrabF=0, fevTTrabF=0, marTTrabF=0, abrTTrabF=0, maiTTrabF=0, junTTrabF=0, julTTrabF=0, agoTTrabF=0, setTTrabF=0, outTTrabF=0, novTTrabF=0, dezTTrabF=0;

//Totais e sub totais
float totTTrabHV=0, totTTrabV=0, totTTrabF=0, TTTotalQ=0, TTTotalHV=0, totTTrabH=0, totTTrabHF=0;
float totalC=0, totalH=0, totalHmin=0, totalHhora=0, TAtotalC=0, TAtotalHV=0;

//Variavel auxiliar de conversao
Float aux_conv_F = new Float(0f);
float aux_conv_f=0;

String moeda = prm.buscaparam("MOEDA");

//Variaveis gerais
String query="", query_filtro="", assunto="", titulo="", filtro="", cor="celcinrela", tit_valor="";
boolean print_titulo=false, tipo_valor=false;
ResultSet rs = null, rs_plano = null,rs2=null;
DecimalFormat dec_qtde = new DecimalFormat("0");
dec_qtde.setMaximumFractionDigits(0);
DecimalFormat dec_qtde2 = new DecimalFormat("0");
dec_qtde2.setMaximumFractionDigits(1);

//Distincao de valores (1: Hora & 2:Valor)
String teste1 = (((String)request.getParameter("rdo_tipo")==null)?"":(String)request.getParameter("rdo_tipo"));
if(teste1.equals("1")) { //Hora
  query = "SELECT A.ASS_NOME, T.TIT_NOME, MONTH(TU.TUR_DATAINICIO) AS MES, COUNT(TR.TTR_CODIGO) AS QTDE, SUM(TR.TEF_DURACAO) AS CUSTO ";
  tipo_valor = false;
  tit_valor = trd.Traduz("Horas");
} else { //Valor
  query = "SELECT A.ASS_NOME, T.TIT_NOME, MONTH(TU.TUR_DATAINICIO) AS MES, COUNT(TR.TTR_CODIGO) AS QTDE, SUM(TR.TEF_CUSTO) AS CUSTO ";
  tipo_valor = true;
  tit_valor = trd.Traduz("Valor");
}

//Consulta dos dados
query = query + "FROM ASSUNTO A, TITULO T, CURSO C, TREINAMENTO TR, TURMA TU, FUNCIONARIO F, FILIAL FI "+
                "WHERE T.ASS_CODIGO = A.ASS_CODIGO "+
                "AND T.TIT_CODIGO = C.TIT_CODIGO "+
                "AND C.CUR_CODIGO = TR.CUR_CODIGO "+
                "AND TR.TUR_CODIGO_REAL = TU.TUR_CODIGO "+
                "AND TR.FUN_CODIGO = F.FUN_CODIGO "+
                "AND F.FIL_CODIGO = FI.FIL_CODIGO "+
                "AND TR.PLA_CODIGO = "+usu_plano+" ";

// ******************* FILTROS ******************

String teste2 = (((String)request.getParameter("cbo_assunto")==null)?"T":(String)request.getParameter("cbo_assunto"));
if(!teste2.equals("T")) {
  query = query + "AND A.ASS_CODIGO = " + request.getParameter("cbo_assunto") + " ";
  query_filtro = "SELECT ASS_NOME FROM ASSUNTO WHERE ASS_CODIGO = " +request.getParameter("cbo_assunto");
  rs = conexao.executaConsulta(query_filtro,session.getId());
  if (rs.next())
    filtro = filtro + "<BR>" + trd.Traduz("ASSUNTO") + ": " + rs.getString(1) + "; ";
}
if(rs!=null){
rs.close();
conexao.finalizaConexao(session.getId());
}
String teste3 = (((String)request.getParameter("cbo_filial")==null)?"T":(String)request.getParameter("cbo_filial"));
if(!teste3.equals("T")) {
  query = query + "AND F.FIL_CODIGO = " + request.getParameter("cbo_filial") + " ";
  query_filtro = "SELECT FIL_NOME FROM FILIAL WHERE FIL_CODIGO = " +request.getParameter("cbo_filial");
  rs = conexao.executaConsulta(query_filtro,session.getId());
  if (rs.next())
    filtro = filtro + "<BR>" + trd.Traduz("FILIAL") + ": " + rs.getString(1) + "; ";
}
if(rs!=null){
rs.close();
conexao.finalizaConexao(session.getId());
}

String teste4 = (((String)request.getParameter("cbo_solicitante")==null)?"T":(String)request.getParameter("cbo_solicitante"));
if(!teste4 .equals("T")) {
  query = query + "AND F.FUN_CODSOLIC = " + request.getParameter("cbo_solicitante") + " ";
  query_filtro = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = " +request.getParameter("cbo_solicitante");
  rs = conexao.executaConsulta(query_filtro,session.getId());
  if (rs.next())
    filtro = filtro + "<BR>" + trd.Traduz("SOLICITANTE") + ": " + rs.getString(1) + "; ";
}
if(rs!=null){
rs.close();
conexao.finalizaConexao(session.getId());
}

String teste5 = (((String)request.getParameter("cbo_departamento")==null)?"T":(String)request.getParameter("cbo_departamento"));
if(!teste5.equals("T")) {
  query = query + "AND F.DEP_CODIGO = " + request.getParameter("cbo_departamento") + " ";
  query_filtro = "SELECT DEP_NOME FROM DEPTO WHERE DEP_CODIGO = " +request.getParameter("cbo_departamento");
  rs = conexao.executaConsulta(query_filtro,session.getId());
  if (rs.next())
    filtro = filtro + "<BR>" + trd.Traduz("DEPARTAMENTO") + ": " + rs.getString(1) + "; ";
}
if(rs!=null){
rs.close();
conexao.finalizaConexao(session.getId());
}

String teste6 = (((String)request.getParameter("cbo_tipo")==null)?"T":(String)request.getParameter("cbo_tipo"));
if(!teste6.equals("T")) {
  query = query + "AND TR.TTR_CODIGO = " + request.getParameter("cbo_tipo") + " ";
  query_filtro = "SELECT TTR_NOME FROM TIPOTREINAMENTO WHERE TTR_CODIGO = " +request.getParameter("cbo_tipo");
  rs = conexao.executaConsulta(query_filtro,session.getId());
  if (rs.next())
    filtro = filtro + "<BR>" + trd.Traduz("TIPO") + ": " + rs.getString(1) + "; ";
}
if(rs!=null){
rs.close();
conexao.finalizaConexao(session.getId());
}


String teste7 = (((String)request.getParameter("cbo_cargo")==null)?"T":(String)request.getParameter("cbo_cargo"));
if(!teste7.equals("T")) {
  query = query + "AND F.CAR_CODIGO = " + request.getParameter("cbo_cargo") + " ";
  query_filtro = "SELECT CAR_NOME FROM CARGO WHERE CAR_CODIGO = " +request.getParameter("cbo_cargo");
  rs = conexao.executaConsulta(query_filtro,session.getId());
  if (rs.next())
    filtro = filtro + "<BR>" + trd.Traduz("CARGO") + ": " + rs.getString(1) + "; ";
}
if(rs!=null){
rs.close();
conexao.finalizaConexao(session.getId());
}


String teste8 = (((String)request.getParameter("cbo_tabela_1")==null)?"T":(String)request.getParameter("cbo_tabela_1"));
if(!teste8.equals("T")) {
  query = query + "AND F.TB1_CODIGO = " + request.getParameter("cbo_tabela_1") + " ";
  query_filtro = "SELECT TB1_NOME FROM TABELA1 WHERE TB1_CODIGO = " +request.getParameter("cbo_tabela_1");
  rs = conexao.executaConsulta(query_filtro,session.getId());
  if (rs.next())
    filtro = filtro + "<BR>" + trd.Traduz("TABELA1") + ": " + rs.getString(1) + "; ";
}
if(rs!=null){
rs.close();
conexao.finalizaConexao(session.getId());
}

String teste9 = (((String)request.getParameter("cbo_tabela_2")==null)?"T":(String)request.getParameter("cbo_tabela_2"));
if(!teste9.equals("T")) {
  query = query + "AND F.TB2_CODIGO = " + request.getParameter("cbo_tabela_2") + " ";
  query_filtro = "SELECT TB2_NOME FROM TABELA2 WHERE TB2_CODIGO = " +request.getParameter("cbo_tabela_2");
  rs = conexao.executaConsulta(query_filtro,session.getId());
  if (rs.next())
    filtro = filtro + "<BR>" + trd.Traduz("TABELA2") + ": " + rs.getString(1) + "; ";
}
if(rs!=null){
rs.close();
conexao.finalizaConexao(session.getId());
}

String teste10 = (((String)request.getParameter("cbo_tabela_3")==null)?"T":(String)request.getParameter("cbo_tabela_3"));
if(!teste10.equals("T")) {
  query = query + "AND F.TB3_CODIGO = " + request.getParameter("cbo_tabela_3") + " ";
  query_filtro = "SELECT TB3_DESCRICAO FROM TABELA3 WHERE TB3_CODIGO = " +request.getParameter("cbo_tabela_3");
  rs = conexao.executaConsulta(query_filtro,session.getId());
  if (rs.next())
    filtro = filtro + "<BR>" + trd.Traduz("TABELA3") + ": " + rs.getString(1) + "; ";
}
if(rs!=null){
rs.close();
conexao.finalizaConexao(session.getId());
}

String teste11 = (((String)request.getParameter("cbo_tabela_4")==null)?"T":(String)request.getParameter("cbo_tabela_4"));
if(!teste11.equals("T")) {
  query = query + "AND F.TB4_CODIGO = " + request.getParameter("cbo_tabela_4") + " ";
  query_filtro = "SELECT TB4_DESCRICAO FROM TABELA4 WHERE TB4_CODIGO = " +request.getParameter("cbo_tabela_4");
  rs = conexao.executaConsulta(query_filtro,session.getId());
  if (rs.next())
    filtro = filtro + "<BR>" + trd.Traduz("TABELA4") + ": " + rs.getString(1) + "; ";
}
if(rs!=null){
rs.close();
conexao.finalizaConexao(session.getId());
}

/*String teste12 = (((String)request.getParameter("cbo_tabela_5")==null)?"T":(String)request.getParameter("cbo_tabela_5"));
if(!teste12.equals("T")) {
  query = query + "AND F.TB5_CODIGO = " + request.getParameter("cbo_tabela_5") + " ";
  query_filtro = "SELECT TB5_DESCRICAO FROM TABELA5 WHERE TB5_CODIGO = " +request.getParameter("cbo_tabela_5");
  rs = conexao.executaConsulta(query_filtro);
  if (rs.next())
    filtro = filtro + "<BR>" + trd.Traduz("TABELA5") + ": " + rs.getString(1) + "; ";
}
String teste13 = (((String)request.getParameter("cbo_tabela_6")==null)?"T":(String)request.getParameter("cbo_tabela_6"));
if(!teste13.equals("T")) {
  query = query + "AND F.TB6_CODIGO = " + request.getParameter("cbo_tabela_6") + " ";
  query_filtro = "SELECT TB6_DESCRICAO FROM TABELA6 WHERE TB6_CODIGO = " +request.getParameter("cbo_tabela_6");
  rs = conexao.executaConsulta(query_filtro);
  if (rs.next())
    filtro = filtro + "<BR>" + trd.Traduz("TABELA6") + ": " + rs.getString(1) + "; ";
}
String teste14 = (((String)request.getParameter("cbo_tabela_7")==null)?"T":(String)request.getParameter("cbo_tabela_7"));
if(!teste14.equals("T")) {
  query = query + "AND F.TB7_CODIGO = " + request.getParameter("cbo_tabela_7") + " ";
  query_filtro = "SELECT TB7_DESCRICAO FROM TABELA7 WHERE TB7_CODIGO = " +request.getParameter("cbo_tabela_7");
  rs = conexao.executaConsulta(query_filtro);
  if (rs.next())
    filtro = filtro + "<BR>" + trd.Traduz("TABELA7") + ": " + rs.getString(1) + "; ";
}
String teste15 = (((String)request.getParameter("cbo_tabela_8")==null)?"T":(String)request.getParameter("cbo_tabela_8"));
if(!teste15.equals("T")) {
  query = query + "AND F.TB8_CODIGO = " + request.getParameter("cbo_tabela_8") + " ";
  query_filtro = "SELECT TB8_DESCRICAO FROM TABELA8 WHERE TB8_CODIGO = " +request.getParameter("cbo_tabela_8");
  rs = conexao.executaConsulta(query_filtro);
  if (rs.next())
    filtro = filtro + "<BR>" + trd.Traduz("TABELA8") + ": " + rs.getString(1) + "; ";
}*/

if (filtro.equals(""))
  filtro = trd.Traduz("NENHUM");

//Agrupamento e ordenacao
query = query + "GROUP BY A.ASS_NOME, T.TIT_NOME, MONTH(TU.TUR_DATAINICIO) "+
                "ORDER BY A.ASS_NOME, T.TIT_NOME, MES";
rs = conexao.executaConsulta(query,session.getId());
%>

<%!//funcao para formatacao
public String formataValor(float valor, boolean tipo_valor, String moeda){
  //se valor
  if (tipo_valor) {
    DecimalFormat dcf = new DecimalFormat("0.00");
    dcf.setMaximumFractionDigits(2);
    String strReais = dcf.format(valor);
    return moeda + strReais;
  //se horas
  } else {
    String hora="";
    hora = convHora(valor);
    return hora;
  }
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
        if (decimal<10) 
	  total = inteiro + ":0" + decimal;
        else
          total = inteiro + ":" + decimal;

	return total;
}
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("ImpressOes")%> - <%=trd.Traduz("RELATORIO DE MATRIZ DE TREINAMENTOS")%></title>
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
              <tr><td>&nbsp;</td></tr>
              <tr> 
<%      	String query_plano = "SELECT PLA_NOME FROM PLANO WHERE PLA_CODIGO = "+usu_plano;
		rs_plano = conexao.executaConsulta(query_plano,session.getId()+"RS_plano");
		if(rs_plano.next())%>
                <td class="trontrk" width="100%" align="center"><%=trd.Traduz("RELATORIO DE MATRIZ DE TREINAMENTOS")%> / <%=rs_plano.getString(1)%></td>                              
              </tr>
              <tr><td>&nbsp;</td></tr>
              <tr valign="top"> 
                <td width="100%" class="ftverdanacinza" align="center">
                  <img src="../art/white.gif" width="17" height="17"> = <%=tit_valor%>
                  &nbsp;&nbsp;&nbsp;&nbsp;
                  <img src="../art/gray.gif" width="17" height="17"> = <%=trd.Traduz("PARTICIPACOES")%> 
                </td>
              </tr>
              <tr><td>&nbsp;</td></tr>
              <tr valign="top"> 
		<td width="100%" class="ftverdanapreto11" align="left"> <%=trd.Traduz("FILTROS ESCOLHIDOS")%>: <span class="ftverdanacinza"><%=filtro%></span></td>
              </tr>
            </table><p>
<%            //Teste se existe assunto cadastrado
                if(rs_plano!=null){
                    rs_plano.close();
                    conexao.finalizaConexao(session.getId()+"RS_plano");
                }
              if (rs.next()) {
                assunto = rs.getString(1);
                titulo = rs.getString(2);
        

             %>
                <table width="100%" border="1" cellspacing="0" cellpadding="2" bordercolor="#CCCCCC">
                  <tr class="ftverdanapreto11"> 
                    <td width="22%"><%=trd.Traduz("Assunto")%></td>
                    <td width="6%" align="center"><%=trd.Traduz("Jan")%></td>
                    <td width="6%" align="center"><%=trd.Traduz("Fev")%></td>
                    <td width="6%" align="center"><%=trd.Traduz("Mar")%></td>
                    <td width="6%" align="center"><%=trd.Traduz("Abr")%></td>
                    <td width="6%" align="center"><%=trd.Traduz("Mai")%></td>
                    <td width="6%" align="center"><%=trd.Traduz("Jun")%></td>
                    <td width="6%" align="center"><%=trd.Traduz("Jul")%></td>
                    <td width="6%" align="center"><%=trd.Traduz("Ago")%></td>
                    <td width="6%" align="center"><%=trd.Traduz("Set")%></td>
                    <td width="6%" align="center"><%=trd.Traduz("Out")%></td>
                    <td width="6%" align="center"><%=trd.Traduz("Nov")%></td>
                    <td width="6%" align="center"><%=trd.Traduz("Dez")%></td>
                    <td width="6%" align="center"><%=trd.Traduz("Total")%></td>
                  </tr>
                  <tr class="ftverdanapreto11"> 
                    <td colspan="14"><%=assunto%></td>
                  </tr>
                  <tr> 
<%                do {
                    if(!assunto.equals(rs.getString(1))){%>
                      <!--escreve os dados anteriores-->
                      <td rowspan="2" class="celbrarela"><%=titulo%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(janQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(fevQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(marQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(abrQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(maiQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(junQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(julQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(agoQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(setQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(outQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(novQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(dezQ)%></td>
<%                    totalC = janQ+fevQ+marQ+abrQ+maiQ+junQ+julQ+agoQ+setQ+outQ+novQ+dezQ;%>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(totalC)%></td>
                    </tr>
                    <tr> 
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(janHV,tipo_valor,moeda)%></td>
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(fevHV,tipo_valor,moeda)%></td>
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(marHV,tipo_valor,moeda)%></td>
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(abrHV,tipo_valor,moeda)%></td>
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(maiHV,tipo_valor,moeda)%></td>
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(junHV,tipo_valor,moeda)%></td>
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(julHV,tipo_valor,moeda)%></td>
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(agoHV,tipo_valor,moeda)%></td>
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(setHV,tipo_valor,moeda)%></td>
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(outHV,tipo_valor,moeda)%></td>
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(novHV,tipo_valor,moeda)%></td>
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(dezHV,tipo_valor,moeda)%></td>
<%                    if (tipo_valor) {//valor
                        totalH = janHV+fevHV+marHV+abrHV+maiHV+junHV+julHV+agoHV+setHV+outHV+novHV+dezHV;
                      } else {//hora
                        totalH = 0;
                        totalH = somaHoras(janHV, totalH);
                        totalH = somaHoras(fevHV, totalH);
                        totalH = somaHoras(marHV, totalH);
                        totalH = somaHoras(abrHV, totalH);
                        totalH = somaHoras(maiHV, totalH);
                        totalH = somaHoras(junHV, totalH);
                        totalH = somaHoras(julHV, totalH);
                        totalH = somaHoras(agoHV, totalH);
                        totalH = somaHoras(setHV, totalH);
                        totalH = somaHoras(outHV, totalH);
                        totalH = somaHoras(novHV, totalH);
                        totalH = somaHoras(dezHV, totalH);
                      }%>
                     <td width="6%" class="celbrarela" align="right"><%=formataValor(totalH,tipo_valor,moeda)%></td>
                    </tr>
<%                  //Total de treinamento (qtde treinamentos)
                    TTjanQ=TTjanQ+janQ; TTfevQ=TTfevQ+fevQ; TTmarQ=TTmarQ+marQ; TTabrQ=TTabrQ+abrQ;
                    TTmaiQ=TTmaiQ+maiQ; TTjunQ=TTjunQ+junQ; TTjulQ=TTjulQ+julQ; TTagoQ=TTagoQ+agoQ;
                    TTsetQ=TTsetQ+setQ; TToutQ=TToutQ+outQ; TTnovQ=TTnovQ+novQ; TTdezQ=TTdezQ+dezQ;
                    //Total de treinamento (qtde hora/valor)
                    if (tipo_valor) {//valor
                      TTjanHV=TTjanHV+janHV; TTfevHV=TTfevHV+fevHV; TTmarHV=TTmarHV+marHV; TTabrHV=TTabrHV+abrHV;
                      TTmaiHV=TTmaiHV+maiHV; TTjunHV=TTjunHV+junHV; TTjulHV=TTjulHV+julHV; TTagoHV=TTagoHV+agoHV;
                      TTsetHV=TTsetHV+setHV; TToutHV=TToutHV+outHV; TTnovHV=TTnovHV+novHV; TTdezHV=TTdezHV+dezHV;
                    } else {
                      TTjanHV=somaHoras(TTjanHV,janHV); 
                      TTfevHV=somaHoras(TTfevHV,fevHV); 
                      TTmarHV=somaHoras(TTmarHV,marHV); 
                      TTabrHV=somaHoras(TTabrHV,abrHV); 
                      TTmaiHV=somaHoras(TTmaiHV,maiHV); 
                      TTjunHV=somaHoras(TTjunHV,junHV); 
                      TTmarHV=somaHoras(TTjulHV,julHV); 
                      TTagoHV=somaHoras(TTagoHV,agoHV); 
                      TTsetHV=somaHoras(TTsetHV,setHV); 
                      TToutHV=somaHoras(TToutHV,outHV); 
                      TTnovHV=somaHoras(TTnovHV,novHV); 
                      TTdezHV=somaHoras(TTdezHV,dezHV);
                    }%>
                    <tr> 
                      <td rowspan="2" class="ftverdanapreto11"><%=trd.Traduz("Total")%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAjanQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAfevQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAmarQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAabrQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAmaiQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAjunQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAjulQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAagoQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAsetQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAoutQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAnovQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAdezQ)%></td>
<%                    TAtotalC = TAjanQ+TAfevQ+TAmarQ+TAabrQ+TAmaiQ+TAjunQ+TAjulQ+TAagoQ+TAsetQ+TAoutQ+TAnovQ+TAdezQ;%>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAtotalC)%></td>
                    </tr>
                    <tr> 
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(TAjanHV,tipo_valor,moeda)%></td>
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(TAfevHV,tipo_valor,moeda)%></td>
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(TAmarHV,tipo_valor,moeda)%></td>
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(TAabrHV,tipo_valor,moeda)%></td>
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(TAmaiHV,tipo_valor,moeda)%></td>
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(TAjunHV,tipo_valor,moeda)%></td>
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(TAjulHV,tipo_valor,moeda)%></td>
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(TAagoHV,tipo_valor,moeda)%></td>
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(TAsetHV,tipo_valor,moeda)%></td>
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(TAoutHV,tipo_valor,moeda)%></td>
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(TAnovHV,tipo_valor,moeda)%></td>
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(TAdezHV,tipo_valor,moeda)%></td>
<%                    if (tipo_valor) {//valor
                        TAtotalHV = TAjanHV+TAfevHV+TAmarHV+TAabrHV+TAmaiHV+TAjunHV+TAjulHV+TAagoHV+TAsetHV+TAoutHV+TAnovHV+TAdezHV;
                      } else {
                        TAtotalHV = 0;
                        TAtotalHV = somaHoras(TAjanHV, TAtotalHV);
                        TAtotalHV = somaHoras(TAfevHV, TAtotalHV);
                        TAtotalHV = somaHoras(TAmarHV, TAtotalHV);
                        TAtotalHV = somaHoras(TAabrHV, TAtotalHV);
                        TAtotalHV = somaHoras(TAmaiHV, TAtotalHV);
                        TAtotalHV = somaHoras(TAjunHV, TAtotalHV);
                        TAtotalHV = somaHoras(TAjulHV, TAtotalHV);
                        TAtotalHV = somaHoras(TAagoHV, TAtotalHV);
                        TAtotalHV = somaHoras(TAsetHV, TAtotalHV);
                        TAtotalHV = somaHoras(TAoutHV, TAtotalHV);
                        TAtotalHV = somaHoras(TAnovHV, TAtotalHV);
                        TAtotalHV = somaHoras(TAdezHV, TAtotalHV);
                      }%>
                      <td width="6%" class="celbrarela" align="right"><%=formataValor(TAtotalHV,tipo_valor,moeda)%></td>
                    </tr>
<%                  assunto = rs.getString(1);
                    titulo = rs.getString(2);
                    print_titulo = true;
                    janQ=0; janHV=0; fevQ=0; fevHV=0; marQ=0; marHV=0; abrQ=0; abrHV=0; 
                    maiQ=0; maiHV=0; junQ=0; junHV=0; julQ=0; julHV=0; agoQ=0; agoHV=0;
                    setQ=0; setHV=0; outQ=0; outHV=0; novQ=0; novHV=0; dezQ=0; dezHV=0;
                    TAjanQ=0; TAjanHV=0; TAfevQ=0; TAfevHV=0; TAmarQ=0; TAmarHV=0; TAabrQ=0; TAabrHV=0; TAmaiQ=0; TAmaiHV=0; TAjunQ=0; TAjunHV=0;
                    TAjulQ=0; TAjulHV=0; TAagoQ=0; TAagoHV=0; TAsetQ=0; TAsetHV=0; TAoutQ=0; TAoutHV=0; TAnovQ=0; TAnovHV=0; TAdezQ=0; TAdezHV=0;%>
                    <tr> 
                      <td colspan="14" class="celbra">&nbsp;</td>
                    </tr>
                    <tr class="ftverdanapreto11"> 
                      <td colspan="14"><%=assunto%></td>
                    </tr>
<%                } else {
                      if (!titulo.equals(rs.getString(2))){//testar <> titulo/ <> novo assunto
                        //if (print_titulo) {%>
                          <tr> 
                            <td rowspan="2" class="celbrarela"><%=titulo%></td>
<%                      //}%>
                          <!--escreve os dados anteriores-->
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(janQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(fevQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(marQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(abrQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(maiQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(junQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(julQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(agoQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(setQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(outQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(novQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(dezQ)%></td>
<%                    totalC = janQ+fevQ+marQ+abrQ+maiQ+junQ+julQ+agoQ+setQ+outQ+novQ+dezQ;%>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(totalC)%></td>
                    </tr>
                        <tr> 
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(janHV,tipo_valor,moeda)%></td>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(fevHV,tipo_valor,moeda)%></td>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(marHV,tipo_valor,moeda)%></td>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(abrHV,tipo_valor,moeda)%></td>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(maiHV,tipo_valor,moeda)%></td>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(junHV,tipo_valor,moeda)%></td>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(julHV,tipo_valor,moeda)%></td>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(agoHV,tipo_valor,moeda)%></td>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(setHV,tipo_valor,moeda)%></td>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(outHV,tipo_valor,moeda)%></td>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(novHV,tipo_valor,moeda)%></td>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(dezHV,tipo_valor,moeda)%></td>
<%                        if (tipo_valor) {
                            totalH = janHV+fevHV+marHV+abrHV+maiHV+junHV+julHV+agoHV+setHV+outHV+novHV+dezHV;
                          } else {
                            totalH = 0;
                            totalH = somaHoras(janHV, totalH);
                            totalH = somaHoras(fevHV, totalH);
                            totalH = somaHoras(marHV, totalH);
                            totalH = somaHoras(abrHV, totalH);
                            totalH = somaHoras(maiHV, totalH);
                            totalH = somaHoras(junHV, totalH);
                            totalH = somaHoras(julHV, totalH);
                            totalH = somaHoras(agoHV, totalH);
                            totalH = somaHoras(setHV, totalH);
                            totalH = somaHoras(outHV, totalH);
                            totalH = somaHoras(novHV, totalH);
                            totalH = somaHoras(dezHV, totalH);
                         }%>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(totalH,tipo_valor,moeda)%></td>
                        </tr>
                        <tr> 
<%                        //Total de treinamento (qtde treinamentos)
                          TTjanQ=TTjanQ+janQ; TTfevQ=TTfevQ+fevQ; TTmarQ=TTmarQ+marQ; TTabrQ=TTabrQ+abrQ;
                          TTmaiQ=TTmaiQ+maiQ; TTjunQ=TTjunQ+junQ; TTjulQ=TTjulQ+julQ; TTagoQ=TTagoQ+agoQ;
                          TTsetQ=TTsetQ+setQ; TToutQ=TToutQ+outQ; TTnovQ=TTnovQ+novQ; TTdezQ=TTdezQ+dezQ;
                          //Total de treinamento (qtde hora/valor)
                          if (tipo_valor) {//valor
                            TTjanHV=TTjanHV+janHV; TTfevHV=TTfevHV+fevHV; TTmarHV=TTmarHV+marHV; TTabrHV=TTabrHV+abrHV;
                            TTmaiHV=TTmaiHV+maiHV; TTjunHV=TTjunHV+junHV; TTjulHV=TTjulHV+julHV; TTagoHV=TTagoHV+agoHV;
                            TTsetHV=TTsetHV+setHV; TToutHV=TToutHV+outHV; TTnovHV=TTnovHV+novHV; TTdezHV=TTdezHV+dezHV;
                          } else {//hora
                            TTjanHV=somaHoras(TTjanHV,janHV); 
                            TTfevHV=somaHoras(TTfevHV,fevHV); 
                            TTmarHV=somaHoras(TTmarHV,marHV); 
                            TTabrHV=somaHoras(TTabrHV,abrHV); 
                            TTmaiHV=somaHoras(TTmaiHV,maiHV); 
                            TTjunHV=somaHoras(TTjunHV,junHV); 
                            TTmarHV=somaHoras(TTjulHV,julHV); 
                            TTagoHV=somaHoras(TTagoHV,agoHV); 
                            TTsetHV=somaHoras(TTsetHV,setHV); 
                            TToutHV=somaHoras(TToutHV,outHV); 
                            TTnovHV=somaHoras(TTnovHV,novHV); 
                            TTdezHV=somaHoras(TTdezHV,dezHV);
                          }
 			  print_titulo = false;
                          titulo = rs.getString(2);
                          %>
                          
<%                      janQ=0; janHV=0; fevQ=0; fevHV=0; marQ=0; marHV=0; abrQ=0; abrHV=0; 
                        maiQ=0; maiHV=0; junQ=0; junHV=0; julQ=0; julHV=0; agoQ=0; agoHV=0;
                        setQ=0; setHV=0; outQ=0; outHV=0; novQ=0; novHV=0; dezQ=0; dezHV=0;
                      }
                    }
                        if (rs.getInt(3) == 1){
                          janQ = rs.getFloat(4);
                          TAjanQ = TAjanQ + rs.getFloat(4);
                          if (tipo_valor) {//valor
                            janHV = rs.getFloat(5);
                            TAjanHV = TAjanHV + rs.getFloat(5);
                          } else {//hora
                            TAjanHV = somaHoras(TAjanHV, rs.getFloat(5));
                            janHV = somaHoras(rs.getFloat(5), 0);
                          }
                        }
                        if (rs.getInt(3) == 2){
                          fevQ = rs.getFloat(4);
                          TAfevQ = TAfevQ + rs.getFloat(4);
                          if (tipo_valor) {//valor
                            fevHV = rs.getFloat(5);
                            TAfevHV = TAfevHV + rs.getFloat(5);
                          } else {//hora
                            TAfevHV = somaHoras(TAfevHV, rs.getFloat(5)); 
                            fevHV = somaHoras(rs.getFloat(5), 0);
                          }
                        }
                        if (rs.getInt(3) == 3){
                          marQ = rs.getFloat(4);
                          TAmarQ = TAmarQ + rs.getFloat(4);
                          if (tipo_valor) {//valor
                            marHV = rs.getFloat(5);
                            TAmarHV = TAmarHV + rs.getFloat(5);
                          } else {//hora
                            marHV = somaHoras(rs.getFloat(5), 0);
                            TAmarHV = somaHoras(TAmarHV, rs.getFloat(5)); 
                          }
                        }
                        if (rs.getInt(3) == 4){
                          abrQ = rs.getFloat(4);
                          TAabrQ = TAabrQ + rs.getFloat(4);
                          if (tipo_valor) {//valor
                            abrHV = rs.getFloat(5);
                            TAabrHV = TAabrHV + rs.getFloat(5);
                          } else {//hora
                            abrHV = somaHoras(rs.getFloat(5), 0);
                            TAabrHV = somaHoras(TAabrHV, rs.getFloat(5)); 
                          }
                        }
                        if (rs.getInt(3) == 5){
                          maiQ = rs.getFloat(4);
                          TAmaiQ = TAmaiQ + rs.getFloat(4);
                          if (tipo_valor) {//valor
                            maiHV = rs.getFloat(5);
                            TAmaiHV = TAmaiHV + rs.getFloat(5);
                          } else {//hora
                            maiHV = somaHoras(rs.getFloat(5), 0 );
                            TAmaiHV = somaHoras(TAmaiHV, rs.getFloat(5)); 
                          }
                        }
                        if (rs.getInt(3) == 6){
                          junQ = rs.getFloat(4);
                          TAjunQ = TAjunQ + rs.getFloat(4);
                          if (tipo_valor) {//valor
                            junHV = rs.getFloat(5);
                            TAjunHV = TAjunHV + rs.getFloat(5);
                          } else {//hora
                            junHV = somaHoras(rs.getFloat(5), 0);
                            TAjunHV = somaHoras(TAjunHV, rs.getFloat(5)); 
                          }
                        }
                        if (rs.getInt(3) == 7){
                          julQ = rs.getFloat(4);
                          TAjulQ = TAjulQ + rs.getFloat(4);
                          if (tipo_valor) {//valor
                            julHV = rs.getFloat(5);
                            TAjulHV = TAjulHV + rs.getFloat(5);
                          } else {//hora
                            julHV = somaHoras(rs.getFloat(5), 0);
                            TAjulHV = somaHoras(TAjulHV, rs.getFloat(5)); 
                          }
                        }
                        if (rs.getInt(3) == 8){
                          agoQ = rs.getFloat(4);
                          TAagoQ = TAagoQ + rs.getFloat(4);
                          if (tipo_valor) {//valor
                            agoHV = rs.getFloat(5);
                            TAagoHV = TAagoHV + rs.getFloat(5);
                          } else {//hora
                            agoHV = somaHoras(rs.getFloat(5), 0);
                            TAagoHV = somaHoras(TAagoHV, rs.getFloat(5)); 
                          }
                        }
                        if (rs.getInt(3) == 9){
                          setQ = rs.getFloat(4);
                          TAsetQ = TAsetQ + rs.getFloat(4);
                          if (tipo_valor) {//valor
                            setHV = rs.getFloat(5);
                            TAsetHV = TAsetHV + rs.getFloat(5);
                          } else {//hora
                            setHV = somaHoras(rs.getFloat(5), 0);
                            TAsetHV = somaHoras(TAsetHV, rs.getFloat(5)); 
                          }
                        }
                        if (rs.getInt(3) == 10){
                          outQ = rs.getFloat(4);
                          TAoutQ = TAoutQ + rs.getFloat(4);
                          if (tipo_valor) {//valor
                            outHV = rs.getFloat(5);
                            TAoutHV = TAoutHV + rs.getFloat(5);
                          } else {//hora
                            outHV = somaHoras(rs.getFloat(5), 0);
                            TAoutHV = somaHoras(TAoutHV, rs.getFloat(5)); 
                          }
                        }
                        if (rs.getInt(3) == 11){
                          novQ = rs.getFloat(4);
                          TAnovQ = TAnovQ + rs.getFloat(4);
                          if (tipo_valor) {//valor
                            novHV = rs.getFloat(5);
                            TAnovHV = TAnovHV + rs.getFloat(5);
                          } else {//hora
                            novHV = somaHoras(rs.getFloat(5), 0);
                            TAnovHV = somaHoras(TAnovHV, rs.getFloat(5)); 
                          }
                        }
                        if (rs.getInt(3) == 12){
                          dezQ = rs.getFloat(4);
                          TAdezQ = TAdezQ + rs.getFloat(4);
                          if (tipo_valor) {//valor
                            dezHV = rs.getFloat(5);
                            TAdezHV = TAdezHV + rs.getFloat(5);
                          } else {//hora
                            dezHV = somaHoras(rs.getFloat(5), 0);
                            TAdezHV = somaHoras(TAdezHV, rs.getFloat(5)); 
                          }
                        }

                } while (rs.next());%>

                  <tr> 
                    <td rowspan="2" class="celbrarela"><%=titulo%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(janQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(fevQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(marQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(abrQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(maiQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(junQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(julQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(agoQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(setQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(outQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(novQ)%></td>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(dezQ)%></td>
<%                    totalC = janQ+fevQ+marQ+abrQ+maiQ+junQ+julQ+agoQ+setQ+outQ+novQ+dezQ;%>
                      <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(totalC)%></td>
                    </tr>
                  <tr> 
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(janHV,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(fevHV,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(marHV,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(abrHV,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(maiHV,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(junHV,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(julHV,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(agoHV,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(setHV,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(outHV,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(novHV,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(dezHV,tipo_valor,moeda)%></td>
<%                  if (tipo_valor){//valor
                      totalH = janHV+fevHV+marHV+abrHV+maiHV+junHV+julHV+agoHV+setHV+outHV+novHV+dezHV;
                    } else {
                      totalH = 0;
                      totalH = somaHoras(janHV, totalH);
                      totalH = somaHoras(fevHV, totalH);
                      totalH = somaHoras(marHV, totalH);
                      totalH = somaHoras(abrHV, totalH);
                      totalH = somaHoras(maiHV, totalH);
                      totalH = somaHoras(junHV, totalH);
                      totalH = somaHoras(julHV, totalH);
                      totalH = somaHoras(agoHV, totalH);
                      totalH = somaHoras(setHV, totalH);
                      totalH = somaHoras(outHV, totalH);
                      totalH = somaHoras(novHV, totalH);
                      totalH = somaHoras(dezHV, totalH);
                    }%>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(totalH,tipo_valor,moeda)%></td>
                  </tr>
<%                      //Total de treinamento (qtde treinhamentos)
                        TTjanQ=TTjanQ+janQ; TTfevQ=TTfevQ+fevQ; TTmarQ=TTmarQ+marQ; TTabrQ=TTabrQ+abrQ;
                        TTmaiQ=TTmaiQ+maiQ; TTjunQ=TTjunQ+junQ; TTjulQ=TTjulQ+julQ; TTagoQ=TTagoQ+agoQ;
                        TTsetQ=TTsetQ+setQ; TToutQ=TToutQ+outQ; TTnovQ=TTnovQ+novQ; TTdezQ=TTdezQ+dezQ;
                        //Total de treinamento (qtde hora/valor)
                        if (tipo_valor) {//valor
                          TTjanHV=TTjanHV+janHV; TTfevHV=TTfevHV+fevHV; TTmarHV=TTmarHV+marHV; TTabrHV=TTabrHV+abrHV;
                          TTmaiHV=TTmaiHV+maiHV; TTjunHV=TTjunHV+junHV; TTjulHV=TTjulHV+julHV; TTagoHV=TTagoHV+agoHV;
                          TTsetHV=TTsetHV+setHV; TToutHV=TToutHV+outHV; TTnovHV=TTnovHV+novHV; TTdezHV=TTdezHV+dezHV;
                        } else {//hora
                          TTjanHV=somaHoras(TTjanHV,janHV); 
                          TTfevHV=somaHoras(TTfevHV,fevHV); 
                          TTmarHV=somaHoras(TTmarHV,marHV); 
                          TTabrHV=somaHoras(TTabrHV,abrHV); 
                          TTmaiHV=somaHoras(TTmaiHV,maiHV); 
                          TTjunHV=somaHoras(TTjunHV,junHV); 
                          TTmarHV=somaHoras(TTjulHV,julHV); 
                          TTagoHV=somaHoras(TTagoHV,agoHV); 
                          TTsetHV=somaHoras(TTsetHV,setHV); 
                          TToutHV=somaHoras(TToutHV,outHV); 
                          TTnovHV=somaHoras(TTnovHV,novHV); 
                          TTdezHV=somaHoras(TTdezHV,dezHV);
                        }%>
                        <tr> 
                          <td rowspan="2" class="ftverdanapreto11"><%=trd.Traduz("Total")%></td>
                          <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAjanQ)%></td>
                          <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAfevQ)%></td>
                          <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAmarQ)%></td>
                          <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAabrQ)%></td>
                          <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAmaiQ)%></td>
                          <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAjunQ)%></td>
                          <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAjulQ)%></td>
                          <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAagoQ)%></td>
                          <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAsetQ)%></td>
                          <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAoutQ)%></td>
                          <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAnovQ)%></td>
                          <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAdezQ)%></td>
<%                        TAtotalC = TAjanQ+TAfevQ+TAmarQ+TAabrQ+TAmaiQ+TAjunQ+TAjulQ+TAagoQ+TAsetQ+TAoutQ+TAnovQ+TAdezQ;%>
                          <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TAtotalC)%></td>
                        </tr>
                        <tr> 
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(TAjanHV,tipo_valor,moeda)%></td>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(TAfevHV,tipo_valor,moeda)%></td>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(TAmarHV,tipo_valor,moeda)%></td>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(TAabrHV,tipo_valor,moeda)%></td>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(TAmaiHV,tipo_valor,moeda)%></td>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(TAjunHV,tipo_valor,moeda)%></td>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(TAjulHV,tipo_valor,moeda)%></td>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(TAagoHV,tipo_valor,moeda)%></td>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(TAsetHV,tipo_valor,moeda)%></td>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(TAoutHV,tipo_valor,moeda)%></td>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(TAnovHV,tipo_valor,moeda)%></td>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(TAdezHV,tipo_valor,moeda)%></td>
<%                        if (tipo_valor) {//valor
                            TAtotalHV = TAjanHV+TAfevHV+TAmarHV+TAabrHV+TAmaiHV+TAjunHV+TAjulHV+TAagoHV+TAsetHV+TAoutHV+TAnovHV+TAdezHV;
                          } else {//hora
                            TAtotalHV = 0;
                            TAtotalHV = somaHoras(TAjanHV, TAtotalHV);
                            TAtotalHV = somaHoras(TAfevHV, TAtotalHV);
                            TAtotalHV = somaHoras(TAmarHV, TAtotalHV);
                            TAtotalHV = somaHoras(TAabrHV, TAtotalHV);
                            TAtotalHV = somaHoras(TAmaiHV, TAtotalHV);
                            TAtotalHV = somaHoras(TAjunHV, TAtotalHV);
                            TAtotalHV = somaHoras(TAjulHV, TAtotalHV);
                            TAtotalHV = somaHoras(TAagoHV, TAtotalHV);
                            TAtotalHV = somaHoras(TAsetHV, TAtotalHV);
                            TAtotalHV = somaHoras(TAoutHV, TAtotalHV);
                            TAtotalHV = somaHoras(TAnovHV, TAtotalHV);
                            TAtotalHV = somaHoras(TAdezHV, TAtotalHV);
                          }%>
                          <td width="6%" class="celbrarela" align="right"><%=formataValor(TAtotalHV,tipo_valor,moeda)%></td>
                        </tr>

                  <tr> 
                    <td colspan="14" class="celbra">&nbsp;</td>
                  </tr>
                  <tr> 
                    <td rowspan="2" class="ftverdanapreto11"><%=trd.Traduz("Total de Treinamento")%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TTjanQ)%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TTfevQ)%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TTmarQ)%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TTabrQ)%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TTmaiQ)%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TTjunQ)%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TTjulQ)%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TTagoQ)%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TTsetQ)%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TToutQ)%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TTnovQ)%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TTdezQ)%></td>
<%                  TTTotalQ=TTjanQ+TTfevQ+TTmarQ+TTabrQ+TTmaiQ+TTjunQ+TTjulQ+TTagoQ+TTsetQ+TToutQ+TTnovQ+TTdezQ;%>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(TTTotalQ)%></td>
                  </tr>
                  <tr> 
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(TTjanHV,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(TTfevHV,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(TTmarHV,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(TTabrHV,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(TTmaiHV,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(TTjunHV,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(TTjulHV,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(TTagoHV,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(TTsetHV,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(TToutHV,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(TTnovHV,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(TTdezHV,tipo_valor,moeda)%></td>
<%                  if (tipo_valor) {//valor
                      TTTotalHV = TTjanHV+TTfevHV+TTmarHV+TTabrHV+TTmaiHV+TTjunHV+TTjulHV+TTagoHV+TTsetHV+TToutHV+TTnovHV+TTdezHV;
                    } else {//valor
                      TTTotalHV = somaHoras(TTTotalHV, TTjanHV);
                      TTTotalHV = somaHoras(TTTotalHV, TTfevHV);
                      TTTotalHV = somaHoras(TTTotalHV, TTmarHV);
                      TTTotalHV = somaHoras(TTTotalHV, TTabrHV);
                      TTTotalHV = somaHoras(TTTotalHV, TTmaiHV);
                      TTTotalHV = somaHoras(TTTotalHV, TTjunHV);
                      TTTotalHV = somaHoras(TTTotalHV, TTjulHV);
                      TTTotalHV = somaHoras(TTTotalHV, TTagoHV);
                      TTTotalHV = somaHoras(TTTotalHV, TTsetHV);
                      TTTotalHV = somaHoras(TTTotalHV, TToutHV);
                      TTTotalHV = somaHoras(TTTotalHV, TTnovHV);
                      TTTotalHV = somaHoras(TTTotalHV, TTdezHV);
                    }%>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(TTTotalHV,tipo_valor,moeda)%></td>
                  </tr>
<%                String filial_sql = " ";
                  //filtro se houver filial, senao soma-se todas
                  if(!teste3.equals("T")) filial_sql = "AND FIL_CODIGO = " +teste3+ " ";
                  query = "SELECT SUM(IFM_VALOR) AS IFM_VALOR, SUM(IFM_HORAS) AS IFM_HORAS, IFM_MES, SUM(IFM_NFUNCIONARIO) AS IFM_NFUNCIONARIO "+
                          "FROM INFOMES "+
                          "WHERE PLA_CODIGO = " +usu_plano+ " " +filial_sql+ 
                          "GROUP BY IFM_VALOR, IFM_HORAS, IFM_NFUNCIONARIO, IFM_MES "+
                          "ORDER BY IFM_MES";
                  //out.println(query);
                  rs2 = conexao.executaConsulta(query,session.getId()+"RS_5");
                  float janTTrabHF=0; float fevTTrabHF=0; float marTTrabHF=0; float abrTTrabHF=0; float maiTTrabHF=0; float junTTrabHF=0;
                  float julTTrabHF=0; float agoTTrabHF=0; float setTTrabHF=0; float outTTrabHF=0; float novTTrabHF=0; float dezTTrabHF=0;
                  if (rs2.next()) {
                    do {
                        if (rs2.getInt(3) == 1){
                          janTTrabV = janTTrabV + rs2.getFloat(1);
                          janTTrabH = somaHoras(janTTrabH, rs2.getFloat(2));
                          janTTrabF = (rs2.getString(4)==null)?0:rs2.getFloat(4);
                          janTTrabHF = (rs2.getString(4)==null)?0:rs2.getFloat(4);
                        }
                        if (rs2.getInt(3) == 2){
                          fevTTrabV = fevTTrabV + rs2.getFloat(1);
                          fevTTrabH = somaHoras(fevTTrabH, rs2.getFloat(2));
                          fevTTrabF = (rs2.getString(4)==null)?0:rs2.getFloat(4);
                        }
                        if (rs2.getInt(3) == 3){
                          marTTrabV = marTTrabV + rs2.getFloat(1);
                          marTTrabH = somaHoras(marTTrabH, rs2.getFloat(2));
                          marTTrabF = (rs2.getString(4)==null)?0:rs2.getFloat(4);
                        }
                        if (rs2.getInt(3) == 4){
                          abrTTrabV = abrTTrabV + rs2.getFloat(1);
                          abrTTrabH = somaHoras(abrTTrabH, rs2.getFloat(2));
                          abrTTrabF = (rs2.getString(4)==null)?0:rs2.getFloat(4);
                        }
                        if (rs2.getInt(3) == 5){
                          maiTTrabV = maiTTrabV + rs2.getFloat(1);
                          maiTTrabH = somaHoras(maiTTrabH, rs2.getFloat(2));
                          maiTTrabF = (rs2.getString(4)==null)?0:rs2.getFloat(4);
                        }
                        if (rs2.getInt(3) == 6){
                          junTTrabV = junTTrabV + rs2.getFloat(1);
                          junTTrabH = somaHoras(junTTrabH, rs2.getFloat(2));
                          junTTrabF = (rs2.getString(4)==null)?0:rs2.getFloat(4);
                        }
                        if (rs2.getInt(3) == 7){
                          julTTrabV = julTTrabV + rs2.getFloat(1);
                          julTTrabH = somaHoras(julTTrabH, rs2.getFloat(2));
                          julTTrabF = (rs2.getString(4)==null)?0:rs2.getFloat(4);
                        }
                        if (rs2.getInt(3) == 8){
                          agoTTrabV = agoTTrabV + rs2.getFloat(1);
                          agoTTrabH = somaHoras(agoTTrabH, rs2.getFloat(2));
                          agoTTrabF = (rs2.getString(4)==null)?0:rs2.getFloat(4);
                        }
                        if (rs2.getInt(3) == 9){
                          setTTrabV = setTTrabV + rs2.getFloat(1);
                          setTTrabH = somaHoras(setTTrabH, rs2.getFloat(2));
                          setTTrabF = (rs2.getString(4)==null)?0:rs2.getFloat(4);
                        }
                        if (rs2.getInt(3) == 10){
                          outTTrabV = outTTrabV + rs2.getFloat(1);
                          outTTrabH = somaHoras(outTTrabH, rs2.getFloat(2));
                          outTTrabF = (rs2.getString(4)==null)?0:rs2.getFloat(4);
                        }
                        if (rs2.getInt(3) == 11){
                          novTTrabV = novTTrabV + rs2.getFloat(1);
                          novTTrabH = somaHoras(novTTrabH, rs2.getFloat(2));
                          novTTrabF = (rs2.getString(4)==null)?0:rs2.getFloat(4);
                        }
                        if (rs2.getInt(3) == 12){
                          dezTTrabV = dezTTrabV + rs2.getFloat(1);
                          dezTTrabH = somaHoras(dezTTrabH, rs2.getFloat(2));
                          dezTTrabF = (rs2.getString(4)==null)?0:rs2.getFloat(4);
                        }
                    } while (rs2.next());
                    totTTrabF = janTTrabF+fevTTrabF+marTTrabF+abrTTrabF+maiTTrabF+junTTrabF+
                                julTTrabF+agoTTrabF+setTTrabF+outTTrabF+novTTrabF+dezTTrabF;
                  }
                if(rs2!=null){
                    rs2.close();
                    conexao.finalizaConexao(session.getId()+"RS_5");
                    }

%>
                  <tr> 
                    <td rowspan="2" class="ftverdanapreto11"><%=trd.Traduz("Total de Trabalho")%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(janTTrabF)%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(fevTTrabF)%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(marTTrabF)%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(abrTTrabF)%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(maiTTrabF)%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(junTTrabF)%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(julTTrabF)%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(agoTTrabF)%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(setTTrabF)%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(outTTrabF)%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(novTTrabF)%></td>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(dezTTrabF)%></td>
<%                  totTTrabF = janTTrabF+fevTTrabF+marTTrabF+abrTTrabF+maiTTrabF+junTTrabF+
                                julTTrabF+agoTTrabF+setTTrabF+outTTrabF+novTTrabF+dezTTrabF;%>
                    <td width="6%" class="celcinrela" align="right"><%=dec_qtde.format(totTTrabF)%></td>
                  </tr>
                  <tr> 
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(janTTrabH,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(fevTTrabH,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(marTTrabH,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(abrTTrabH,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(maiTTrabH,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(junTTrabH,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(julTTrabH,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(agoTTrabH,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(setTTrabH,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(outTTrabH,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(novTTrabH,tipo_valor,moeda)%></td>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(dezTTrabH,tipo_valor,moeda)%></td>
<%                  totTTrabH = janTTrabH+fevTTrabH+marTTrabH+abrTTrabH+maiTTrabH+junTTrabH+
                                julTTrabH+agoTTrabH+setTTrabH+outTTrabH+novTTrabH+dezTTrabH;%>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(totTTrabH,tipo_valor,moeda)%></td>
                  </tr>
<%                if (!tipo_valor) {%>
                  <tr> 
                    <td class="ftverdanapreto11"><%=trd.Traduz("% hs Trab. dedicadas a Trein.")%></td>
<%                  if (janTTrabH == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=dec_qtde2.format((100*TTjanHV)/janTTrabH)%>%</td>
<%                  }
                    if (fevTTrabH == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=dec_qtde2.format((100*TTfevHV)/fevTTrabH)%>%</td>
<%                  }
                    if (marTTrabH == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=dec_qtde2.format((100*TTmarHV)/marTTrabH)%>%</td>
<%                  }
                    if (abrTTrabH == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=dec_qtde2.format((100*TTabrHV)/abrTTrabH)%>%</td>
<%                  }
                    if (maiTTrabH == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=dec_qtde2.format((100*TTmaiHV)/maiTTrabH)%>%</td>
<%                  }
                    if (junTTrabH == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=dec_qtde2.format((100*TTjunHV)/junTTrabH)%>%</td>
<%                  }
                    if (julTTrabH == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=dec_qtde2.format((100*TTjulHV)/julTTrabH)%>%</td>
<%                  }
                    if (agoTTrabH == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=dec_qtde2.format((100*TTagoHV)/agoTTrabH)%>%</td>
<%                  }
                    if (setTTrabH == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=dec_qtde2.format((100*TTsetHV)/setTTrabH)%>%</td>
<%                  }
                    if (outTTrabH == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=dec_qtde2.format((100*TToutHV)/outTTrabH)%>%</td>
<%                  }
                    if (novTTrabH == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=dec_qtde2.format((100*TTnovHV)/novTTrabH)%>%</td>
<%                  }
                    if (dezTTrabH == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=dec_qtde2.format((100*TTdezHV)/dezTTrabH)%>%</td>
<%                  }
                    if (totTTrabH == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=dec_qtde2.format((100*TTTotalHV)/totTTrabH)%>%</td>
<%                  }%>
                  </tr>
                  <tr> 
                    <td class="ftverdanapreto11"><%=trd.Traduz("Hs de treinamento por func.")%></td>
<%                  if (TTjanHV == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(janTTrabF/TTjanHV, tipo_valor,moeda)%></td>
<%                  }
                    if (TTfevHV == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(fevTTrabF/TTfevHV, tipo_valor,moeda)%></td>
<%                  }
                    if (TTmarHV == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(marTTrabF/TTmarHV, tipo_valor,moeda)%></td>
<%                  }
                    if (TTabrHV == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(abrTTrabF/TTabrHV, tipo_valor,moeda)%></td>
<%                  }
                    if (TTmaiHV == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(maiTTrabF/TTmaiHV, tipo_valor,moeda)%></td>
<%                  }
                    if (TTjunHV == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(junTTrabF/TTjunHV, tipo_valor,moeda)%></td>
<%                  }
                    if (TTjulHV == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(julTTrabF/TTjulHV, tipo_valor,moeda)%></td>
<%                  }
                    if (TTagoHV == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(agoTTrabF/TTagoHV, tipo_valor,moeda)%></td>
<%                  }
                    if (TTsetHV == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(setTTrabF/TTsetHV, tipo_valor,moeda)%></td>
<%                  }
                    if (TToutHV == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(outTTrabF/TToutHV, tipo_valor,moeda)%></td>
<%                  }
                    if (TTnovHV == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(novTTrabF/TTnovHV, tipo_valor,moeda)%></td>
<%                  }
                    if (TTdezHV == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(dezTTrabF/TTdezHV, tipo_valor,moeda)%></td>
<%                  }
                    if (TTTotalHV == 0){%>
                    <td width="6%" class="celbrarela" align="center"> - </td>
<%                  } else {%>
                    <td width="6%" class="celbrarela" align="right"><%=formataValor(totTTrabF/TTTotalHV, tipo_valor,moeda)%></td>
<%                  }%>
                  </tr>
<%                }%>
                </table><p>&nbsp;
<%            } else {%>
                <p>&nbsp;
                <table width="100%" border="0" cellspacing="1" cellpadding="2">
                  <tr> 
                    <td align="center" class="celbrarela"><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO!")%></td>
                  </tr>
                  <tr> 
                    <td align="center" class="celbrarela"><a class="lnk" href="01_matrizdetreinamentos.jsp"><%=trd.Traduz("Voltar")%></a></td>
                  </tr>
                </table>
<%            }
        if(rs!=null){
            rs.close();
            conexao.finalizaConexao(session.getId());
        }


%>
              </center>
          </td>
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

} catch(Exception ne){
out.println("Erro"+ne);
}
%>
