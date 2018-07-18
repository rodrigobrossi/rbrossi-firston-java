<!--
Nome do arquivo: erro/ExceptionPage.jsp
Nome da funcionalidade: Pagina de tratamento de erros
Função: Captar o erro gerado, verificar seu tipo e encaminhar para a pagina de erro correta
Variáveis necessárias/ Requisitos: 
- sessao: 
- parametro: parametros da classe Exception
Regras de negócio (pagina):
- captura o erro
- verifica o tipo
- encaminha para a devida página de erro
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Histórico
Data de atualizacao: 17/03/2003 - Desenvolvedor: Marcelo Marques
Atividade: desenvolvimento da rotina
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-->

<!--***DIRETRIZES DA PAGINA***-->
<%@page isErrorPage="true" import="java.io.*, javax.servlet.*, java.util.Vector"%>

<%
//recupera variaveis do erro gerado
String str_expTypeFullName = exception.getClass().getName();
String str_expTypeName = str_expTypeFullName.substring(str_expTypeFullName.lastIndexOf(".")+1);
String str_fullFile = (String) request.getAttribute("javax.servlet.error.request_uri");
String str_file = str_fullFile.substring(str_fullFile.lastIndexOf("/")+1);

String origem = str_fullFile.substring(0,str_fullFile.lastIndexOf("/")+1);

//log do erro
application.log("***************************DIDAXIS EM ERROR LOG***************************");
application.log("Excessao:"+str_expTypeName+" - Arquivo:"+str_fullFile);

//vetor com os erros genericos
Vector vec_errosGenericos = new Vector ();
vec_errosGenericos.addElement("ArithmeticException");
vec_errosGenericos.addElement("NullPointerException");
vec_errosGenericos.addElement("SQLException");

//coloca na sessão a pagina geradora do erro
session.setAttribute("erro_origem", str_file);

String ponto = "";
if(origem.equals("/FirstOnEM/")){
  ponto = "/FirstOnEM/erro";
} 
else {
  ponto = "../erro";
}

//direcionamento da pagina de erro
if (session.getAttribute("usu_cod") == null) {//termino da sessao
  response.sendRedirect(ponto+"/msg_erros.jsp?tipo=S");
} else if (vec_errosGenericos.contains(str_expTypeName)) {//erros genericos (ver vetor)
  response.sendRedirect(ponto+"/msg_erros.jsp?tipo=G");
}
%>
