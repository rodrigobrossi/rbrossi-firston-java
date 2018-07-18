<%
//Limpa cache
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")) {
  response.setHeader("Cache-Control", "no-cache");
}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*, java.util.*"%>

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
String turma =request.getParameter("checkbox");

     if (turma == null)  
	 {%>
	  
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><script language="JavaScript">
      alert(<%=("\""+trd.Traduz("E necessArio selecionar uma turma.")+"\"")%>);
      window.open("05_criarturmalongaduracao.jsp","_self");
      </script>
	 <%}

                            ResultSet Rsv = null;
							String query = "SELECT COUNT(*) FROM LANCAMENTO WHERE TEF_CODIGO = " + turma;
							Rsv = conexao.executaConsulta(query);
                            int Cont;
							Cont = 0;
							if (Rsv.next()) 
							{
							  Cont = Rsv.getInt(1);
							}

     if (Cont == 0){
      query = "DELETE FROM TREINAMENTO WHERE TEF_CODIGO = " + turma;
      conexao.executaAlteracao(query);
     }
	 else
	 {%>
	  <script language="JavaScript">
      alert(<%=("\""+trd.Traduz("EXISTEM LANCAMENTOS NA TURMA, EXCELUSAO NAO REALIZADA!")+"\"")%>);
      window.open("05_criarturmalongaduracao.jsp","_self");
      </script>
	 <%}
if(Rsv != null) Rsv.close();
conexao.finalizaConexao();
%>
<script language="JavaScript">
alert(<%=("\""+trd.Traduz("EXCELUSAO REALIZADA COM SUCESSO!")+"\"")%>);
window.open("05_criarturmalongaduracao.jsp","_self");
</script>

