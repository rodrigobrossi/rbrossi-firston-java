<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
  response.setHeader("Cache-Control", "no-cache");
}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*, java.lang.*, java.util.*"%>

<%
//try{
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");

Integer usu_idi = (Integer)session.getAttribute("usu_idi");  

String tamanho = "", origem = "", cod = "", replicado = "", check = "";
String altera = "";
int i=0;

if(request.getParameter("replicado2") != null)
  replicado = request.getParameter("replicado2");
if(request.getParameter("check") != null)
  check = request.getParameter("check");
if(request.getParameter("cont") != null)
  tamanho = request.getParameter("cont");
if(request.getParameter("tipo") != null)
  origem = request.getParameter("tipo");
if(request.getParameter("cod") != null)
  cod = request.getParameter("cod");
if(!replicado.equals("") && origem.equals("U"))
  altera = "1";

Vector vet_comp = new Vector();

if(vet_comp.size()!=0)
  vet_comp.clear();
if((Vector)session.getAttribute("vet_compS") != null)
  vet_comp = (Vector)session.getAttribute("vet_compS");

String aux = "";
int tamanhoi = 0;

tamanhoi = Integer.parseInt((String)tamanho);

for(i=tamanhoi;i>=0;i--){
  if(request.getParameter("cb_"+i) != null){
    aux = request.getParameter("cb_"+i);    
    vet_comp.removeElement(aux);    
  }
}

//out.println(vet_desc.size());
request.getSession(true);

//out.println("**Replicado: "+replicado);
//out.println("Joga na sessAo: "+vet_comp);
session.setAttribute("vet_compS",vet_comp);

String ativo = request.getParameter("ativo5");
%>


<%@page import="firston.eval.components.FOLocalizationBean"%><html>
<body  onunload='return fecha();' >
 <form name="frm" action="inclusaodecurso.jsp" method="POST">
 <input type="hidden" name="sel_desenv"   value=<%=("\""+request.getParameter("sel_desenv")+"\"")%>>
 <input type="hidden" name="sel_entidade" value=<%=("\""+request.getParameter("sel_entidade")+"\"")%>>
 <input type="hidden" name="sel_titulo"   value=<%=("\""+request.getParameter("sel_titulo")+"\"")%>>
 <input type="hidden" name="sel_saratoga"   value=<%=("\""+request.getParameter("sel_saratoga")+"\"")%>>
 <input type="hidden" name="sel_tipo"     value=<%=("\""+request.getParameter("sel_tipo")+"\"")%>>
 <input type="hidden" name="ativo5"     value="<%=ativo%>">
 <input type="hidden" name="tf_nome"    value=<%=("\""+request.getParameter("tf_nome")+"\"")%>>
 <input type="hidden" name="tf_custo"     value=<%=("\""+request.getParameter("tf_custo")+"\"")%>>
 <input type="hidden" name="tf_custol"    value=<%=("\""+request.getParameter("tf_custol")+"\"")%>>
 <input type="hidden" name="tf_duracao"   value=<%=("\""+request.getParameter("tf_duracao")+"\"")%>>
 <input type="hidden" name="tf_duracao_min" value=<%=("\""+request.getParameter("tf_duracao_min")+"\"")%>>
 <input type="hidden" name="tf_versao"    value=<%=("\""+request.getParameter("tf_versao")+"\"")%>>
 <input type="hidden" name="sel_resp"     value=<%=("\""+request.getParameter("sel_resp")+"\"")%>>
 <input type="hidden" name="tf_maxpart"   value=<%=("\""+request.getParameter("tf_maxpart")+"\"")%>>
 <input type="hidden" name="tf_minpart"   value=<%=("\""+request.getParameter("tf_minpart")+"\"")%>>
 <input type="hidden" name="ta_resumo"    value=<%=("\""+request.getParameter("ta_resumo")+"\"")%>>
 <input type="hidden" name="ta_contprog"  value=<%=("\""+request.getParameter("ta_contprog")+"\"")%>>
 <input type="hidden" name="ta_comoaval"  value=<%=("\""+request.getParameter("ta_comoaval")+"\"")%>>
 <input type="hidden" name="ta_consger"   value=<%=("\""+request.getParameter("ta_consger")+"\"")%>>
 <input type="hidden" name="tipo"       value="<%=origem%>">
 <input type="hidden" name="cod"      value="<%=cod%>">
 <input type="hidden" name="reload2"    value="1">
 <input type="hidden" name="replicado2"   value="<%=replicado%>">
 <input type="hidden" name="check"      value="<%=check%>">
 <input type="hidden" name="altera2"    value="<%=altera%>">
 <input type="hidden" name="apagavetor"   value="N">
 </form>
</body>
</html>

<script language="JavaScript">
  alert(<%=("\""+trd.Traduz("EXCLUSAO EFETUADA COM SUCESSO")+"\"")%>);
  frm.submit();
</script>

<%
//}catch(Exception e){out.println("Erro: "+e);}
%>