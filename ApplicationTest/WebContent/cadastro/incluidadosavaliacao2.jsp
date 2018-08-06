<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
  response.setHeader("Cache-Control", "no-cache");
}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*, java.text.*, java.util.*"%>

<%
//try{    
request.getSession();
String usu_tipo  = (String) session.getAttribute("usu_tipo"); 
String usu_nome  = (String) session.getAttribute("usu_nome"); 
String usu_login = (String) session.getAttribute("usu_login"); 
Integer usu_fil  = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi  = (Integer)session.getAttribute("usu_idi"); 

//Pega o tipo de cadastro (inclusão ou alteração) e o codigo do plano
Vector vetAvaliacao = new Vector();
Vector vetEnvio = new Vector();
Vector vetVencimento = new Vector();
Vector vetAmostra = new Vector();

vetAvaliacao  = (Vector)session.getAttribute("vetor_avaliacao");
vetEnvio      = (Vector)session.getAttribute("vetor_envio");
vetVencimento = (Vector)session.getAttribute("vetor_vencimento");
vetAmostra    = (Vector)session.getAttribute("vetor_amostra");

String envio = "", venc = "", amo = "";

if(request.getParameter("txt_env")!=null)
  envio = request.getParameter("txt_env");
if(request.getParameter("txt_ven")!=null)
  venc = request.getParameter("txt_ven");
if(request.getParameter("txt_amo")!=null)
  amo = request.getParameter("txt_amo");

vetEnvio.add(envio);
vetVencimento.add(venc);
vetAmostra.add(amo);

session.setAttribute("vetor_avaliacao", vetAvaliacao);
session.setAttribute("vetor_envio", vetEnvio);
session.setAttribute("vetor_vencimento", vetVencimento);
session.setAttribute("vetor_amostra", vetAmostra);
%>
<script>
window.close();
</script>
<%
//}catch(Exception e){out.println("Erro: "+e);}
%>