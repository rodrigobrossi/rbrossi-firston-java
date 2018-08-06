<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")) {
  response.setHeader("Cache-Control", "no-cache");
}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*, java.lang.*, java.util.*"%>

<%
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");

String tamanho = "";
int i=0;

String origem = "";
if(request.getParameter("origem") != null)
	origem = request.getParameter("origem");

if(request.getParameter("contador") != null)
	tamanho = request.getParameter("contador");

Vector vet_desc = new Vector();
Vector vet_cust = new Vector();

if(vet_desc.size()!=0)
	vet_desc.clear();
if(vet_cust.size()!=0)
	vet_cust.clear();
if((Vector)session.getAttribute("vet_descS") != null)
	vet_desc = (Vector)session.getAttribute("vet_descS");
if((Vector)session.getAttribute("vet_custS") != null)
	vet_cust = (Vector)session.getAttribute("vet_custS");

String aux = "";
int tamanhoi = 0;
tamanhoi = Integer.parseInt((String)tamanho);
for(i=tamanhoi;i>=0;i--)
{
	if(request.getParameter("vet"+i) != null)
	{	
		aux = request.getParameter("vet"+i);
		int novo = Integer.parseInt((String)aux);
		vet_desc.remove(novo);
		vet_cust.remove(novo);
		//out.println(request.getParameter("vet"+i));
	}
}

out.println(vet_desc);
out.println(vet_cust);
out.println(origem);
//vet_desc.clear();
//vet_cust.clear();

//out.println(vet_desc.size());
request.getSession(true);
session.setAttribute("vet_descS",vet_desc);
session.setAttribute("vet_custS",vet_cust);

if(origem.equals("1"))
	response.sendRedirect("02_registrarlistadepresenca.jsp");
else if(origem.equals("2"))
	response.sendRedirect("04_registrorapido.jsp");//nao utiliza mais essa página para a exclusao!!!
else if(origem.equals("3"))
	response.sendRedirect("10_criacaoturmaantecipada.jsp?selectcur1=Selecione&tipo=I");
	
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<body  onunload='return fecha();' >

</body>
</html>