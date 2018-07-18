<%
//Limpa cache
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")) {
  response.setHeader("Cache-Control", "no-cache");
}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*, java.util.*"%>

<%!
public String trataAspas(String conteudo){
	
	char troca[] = conteudo.toCharArray();
	int contador=0;
	while (contador<conteudo.length()){
		String alfa=""+troca[contador];
	 	if(alfa.equals("'")){troca[contador]='\"';}
	 	else if(alfa.equals("/")){troca[contador]='/';}
	 	contador=contador+1;
		}

	String retorna="";
	return retorna.copyValueOf(troca);
}
%>
<%
//recupera valores
request.getSession();
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");

String usu_codigo = "";
String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 
usu_codigo = usu_codigo.valueOf((Integer)session.getAttribute("fun_codigo"));
String usu_plano = "";
usu_plano = usu_plano.valueOf(session.getAttribute("usu_plano")); 
String ass = request.getParameter("selectass");
String tit = request.getParameter("selecttit");
String cur = request.getParameter("selectcur");
String tip = request.getParameter("selecttip");
String dtini = request.getParameter("textdatai");
String dtfim = request.getParameter("textdataf");
String cuscur = request.getParameter("textcustocur");
String cuslog = request.getParameter("textcustolog");
String pmin = request.getParameter("txtmin");
String pmax = request.getParameter("txtmax");
String duracao = request.getParameter("textdurh");
String duracao2 = request.getParameter("textdurm");
String entidade = request.getParameter("selectent");
String func = request.getParameter("selectfunc");
String obs = trataAspas(request.getParameter("txtobs"));
String tipo = request.getParameter("tipo");
String turma = request.getParameter("turma");

String query = "";

if (tipo.equals("I")){
 query = "INSERT INTO TREINAMENTO (EMP_CODIGO, FUN_CODIGO,  " + 
" PLA_CODIGO,  CUR_CODIGO, TEF_RESULTADOESPERADO, TTR_CODIGO) VALUES (" + entidade + ", " + func + ", " + usu_plano + ", " + cur + ", '" + obs + "', 3)";
}
else
{
 query = "UPDATE TREINAMENTO SET EMP_CODIGO = "  + entidade + ", FUN_CODIGO = " + func + ", CUR_CODIGO = " + cur + ", " + " TEF_RESULTADOESPERADO = '" + obs + "', TTR_CODIGO = 3 WHERE TEF_CODIGO = " + turma;
}
conexao.executaAlteracao(query);
conexao.finalizaConexao();

if (tipo.equals("I")){
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><script language="JavaScript">
alert(<%=("\""+trd.Traduz("CRIACAO DE TURMA REALIZADA COM SUCESSO!")+"\"")%>);
window.open("05_criarturmalongaduracao.jsp","_self");
</script>
<%}
else
{%>
<script language="JavaScript">
alert(<%=("\""+trd.Traduz("ALTERACAO REALIZADA COM SUCESSO!")+"\"")%>);
window.open("05_criarturmalongaduracao.jsp","_self");
</script>
<%}%>
