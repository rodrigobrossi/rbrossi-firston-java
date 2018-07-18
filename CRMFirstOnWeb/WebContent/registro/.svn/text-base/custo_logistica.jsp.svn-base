<%
    response.setHeader("Pragma", "no-cache");
    if (request.getProtocol().equals("HTTP/1.1"))
    {
      response.setHeader("Cache-Control", "no-cache");
    }
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*, java.lang.*, java.util.*"%>

<%
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");

Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 

Vector vet_desc = new Vector();
Vector vet_cust = new Vector();

if(vet_desc.size()!=0){
	vet_desc.clear();
}
if(vet_cust.size()!=0){	
	vet_cust.clear();
}

String moeda = prm.buscaparam("MOEDA");

String descricao = "", custo = "", aux="", teste="";
float total = 0;
int i = 0, a = 0;

if((Vector)session.getAttribute("vet_descS") != null)
{
	vet_desc = (Vector)session.getAttribute("vet_descS");
}
if((Vector)session.getAttribute("vet_custS") != null)
{
	vet_cust = (Vector)session.getAttribute("vet_custS");
}
if(request.getParameter("txt_desc") != null)
{
	if(!(vet_desc.contains(request.getParameter("txt_desc"))))
	{
		vet_desc.addElement(request.getParameter("txt_desc"));
		if(request.getParameter("txt_cust") != null)
		{
			vet_cust.addElement(request.getParameter("txt_cust"));
		}
	}
	else
	{
		%>
		<script language="JavaScript">
		alert(<%=("\""+trd.Traduz("Este custo jA existe")+"\"")%>);
		</script>
		<%
	}
}


int tamanho = 0;
tamanho = vet_desc.size();

String origem = "";
if(request.getParameter("origem") != null)
	origem = request.getParameter("origem");

//vet_desc.clear();
//vet_cust.clear();

//out.println(vet_desc.size());
request.getSession(true);
session.setAttribute("vet_descS",vet_desc);
session.setAttribute("vet_custS",vet_cust);
%>
<script language="JavaScript">
function deleta(origem)
{
	var cont=0;
	for(i=0;i<frm.contador.value;i++)
	{
		if(eval("frm.vet"+i+".checked")==true)
		{
			cont = cont + 1;
		}
	}
	
	if(cont==0)
	{
		alert(<%=("\""+trd.Traduz("NENHUM ITEM SELECIONADO")+"\"")%>);
		return false;
	}
	else
	{
		if(confirm(<%=("\""+trd.Traduz("DESEJA EXCLUIR O ITEM SELECIONADO?")+"\"")%>))
		{
			frm.action="deleta_custo.jsp";
			frm.submit();
			return true;
		}
		else
			return false;
	}
}
</script>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOnEM</title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<%!
public String ReaistoStr(float valor, String moeda){
	DecimalFormat dcf = new DecimalFormat("0.00");
	dcf.setMaximumFractionDigits(2);
	String strReais = dcf.format(valor);
	return moeda + strReais;
}
%>


<script language="JavaScript">
function insere()
{
	if(frm.txt_desc.value == "")
	{
		alert(<%=("\""+trd.Traduz("DIGITE A DESCRICAO")+"\"")%>)
		frm.txt_desc.focus();
		return false;
	}
	else if(frm.txt_cust.value == "")
	{
		alert(<%=("\""+trd.Traduz("DIGITE O CUSTO")+"\"")%>);
		frm.txt_cust.focus();
		return false;
	}
	else
	{
		frm.action="custo_logistica.jsp";
		frm.submit();
		return true;
	}

}


function finaliza(total)
{
	if(frm.origem.value == "1")
		window.open("02_registrarlistadepresenca.jsp?total="+total,"_self");
	else if(frm.origem.value == "2")
		window.open("04_registrorapido.jsp?total="+total,"_self");	
	else if(frm.origem.value == "3")
		window.open("10_criacaoturmaantecipada.jsp?total="+total,"_self");
	
	
	
	//window.close();
}
</script>
<body  onunload='return fecha();' >
  <form name="frm" method="post">
<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
  <tr align="center" valign="middle">
    <td>
      <table border="1" cellspacing="0" cellpadding="0" width="90%" height="100%">
        
        <tr height="5%" class="celtittab">
          <td valign="middle" class="trontrk" align="center"><%=trd.Traduz("CADASTRO DE CUSTO LOGISTICA")%>
          </td>
        </tr>
      
        <tr>
          <td valign="top">
          <br><br>&nbsp;&nbsp;&nbsp;
          <font class="ftverdanacinza"><%=trd.Traduz("DESCRICAO")%>:</font>
          <br>&nbsp;&nbsp;&nbsp;
	  <input type="text" name="txt_desc" size="50">
          <br><br>&nbsp;&nbsp;&nbsp;
          <font class="ftverdanacinza"><%=trd.Traduz("CUSTO LOGISTICA")%>:</font><br>
	  &nbsp;&nbsp;&nbsp;
	  <input type="text" name="txt_cust" size="50"><br>

	  <br>
	  <center>
	  <input class="botcin" type="button" value=<%=("\""+trd.Traduz("INCLUIR")+"\"")%> OnClick="return insere();">
	  <input class="botcin" type="button" value=<%=("\""+trd.Traduz("EXCLUIR")+"\"")%> OnClick="return deleta(<%=origem%>);">
	  </center>
	  
	  <BR>&nbsp;&nbsp;&nbsp;


	  <center>
	  <table border="0" cellspacing="1" cellpadding="0" width="80%">
	  <tr>
	    <td>&nbsp;</td>
	    <td class="celtittab" width="80%">&nbsp;<%=trd.Traduz("DESCRICAO")%></td>
	    <td class="celtittab" align="center" width="20%"><%=trd.Traduz("CUSTO")%></td>
	  </tr>
	    <%
	    //out.println(""+vet_cust);
	    //out.println(""+vet_desc);
	    try{
	    while(a<vet_cust.size())
	    {
	    		aux = (String)vet_cust.elementAt(a);
	    		float novo = Float.parseFloat(aux);
	    		%>
			<tr>
			<td class="celnortab" align="center">
			<input name="vet<%=a%>" type="checkbox" value="<%=a%>">
			</td>
	    		<td class="celnortab">&nbsp;<%=vet_desc.elementAt(a)%></td>
			<td class="celnortab" align="center"><%=ReaistoStr(novo,moeda)%></td>
	    		</tr>
	    		<%
	    	a=a+1;	
	    }
	    %>
	  <tr>
	  <td colspan="3" valign="top" class="ctvdiv"><img src="../art/bit.gif" width="1" height="1"></td>
	  </tr>
	  <tr>
	  <td class="celnortab">&nbsp;</td>
	  <td align="right" class="celnortab"><B><%=trd.Traduz("VALOR TOTAL")%>:&nbsp;<B></td>
	  <%
  
	  //out.println(vet_desc);
	  //out.println(vet_desc.size());
	  
	  while(i<vet_cust.size())
	  {
		aux = (String)vet_cust.elementAt(i); 
		float nova = Float.parseFloat(aux);
		total = total + nova;
		i=i+1;
	  }
	  %>
	  <td align="center" class="celnortab"><%=ReaistoStr(total,moeda)%></td>
	  </tr>	
	  <%
	    
	    }
	    catch(Exception e){
	    out.println(""+e);
	    
	    }
	    %>
	  </table>
	  </center>
	

	  <br>
	  <center>
	  <input class="botcin" type="button" value=<%=("\""+trd.Traduz("FINALIZAR")+"\"")%> OnClick="return finaliza(<%=total%>);">
	  </center>
	  <br>
          </td>
        </tr>
        <input type="hidden" name="contador" value="<%=a%>">
        <input type="hidden" name="origem" value="<%=origem%>">
       
      </table>

    </td>
  </tr>
</table>
       </form>
</body>
<script language="JavaScript1.1" >
document.frm.txt_desc.focus();
</script>

</html>

