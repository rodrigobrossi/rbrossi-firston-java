<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*, java.util.*"%>
<jsp:useBean id="trd" scope="page" class="firston.eval.components.FOLocalizationBean" />

<%
//try{

//*******************************//
//   DECLARACAO DAS VARIAVEIS    //
//*******************************//
Vector funcvet 	= new Vector();
String query = "";
ResultSet rs;
int index = 0;

java.text.SimpleDateFormat sdf_hora = new java.text.SimpleDateFormat("hh:mm");
java.text.SimpleDateFormat sdf_data = new java.text.SimpleDateFormat("dd/MM/yyyy");
java.util.Date dte_hoje = new java.util.Date();
String hoje = sdf_data.format(dte_hoje);

//*******************************//
//   RECUPERA DADOS DA SESSAO    //
//*******************************//
request.getSession(true);
funcvet	= (Vector) session.getAttribute("funcvet");

request.getSession(true);

FODBConnectionBean conexao = new FODBConnectionBean(); 
conexao.getConection();

%>

<%@page import="firston.eval.connection.FODBConnectionBean"%>
<html>
<head>
<title>FirstOn</title>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<body  onunload='return fecha();' >
<table border="0" width="100%" height="100%" cellspacing="1">
 <tr class="trontrk">
  <td height="10%" align="center">
   <b>HISTORICO DE ENTRADAS (<%=hoje%>)</b>
  </td>
 </tr>
 <tr class="trontrk">
  <td>
   <hr>
  </td>
 </tr>
 
 <tr>
  <td align="center">
   <table border="1" cellspacing="1">
	<tr class="celtittab">
	 <td>
	 &nbsp;
	 </td>
	 <td>
	  &nbsp;NOME DO FUNCIONARIO&nbsp;
	 </td>
	 <td align="center">
	  &nbsp;HORA DO ACESSO&nbsp;
	 </td>
	</tr>
	<%
	
	
		query = "SELECT A.FUN_CODIGO, F.FUN_NOME ,A.ACE_DATA, A.ACE_HORA, A.ACE_OPERACAO, A.ACE_SESSION, F.FUN_LOGIN "+
				"FROM FUNCIONARIO F, ACESSO A "+
				"WHERE A.FUN_CODIGO = F.FUN_CODIGO "+
				"AND A.ACE_DATA >= DATEFMT("+hoje+") "+
				"ORDER BY A.ACE_HORA DESC";
		
		rs = conexao.executaConsulta(query,session.getId()+"RS1");
		
		if(rs.next()){
			do{
				if(rs.getInt(5) == 0){
					index = index + 1;
					%>
					<tr class="celnortab">
					 <td align="center">
					  <%=index%>
					 </td>
					 <td>
					  &nbsp;<%=rs.getString(2)%>&nbsp;
					 </td>
					 <td align="center">
					  <%=sdf_hora.format(rs.getTime(4))%>
					 </td>
					</tr>
					<%
				}
			}while(rs.next());
		}

                                if(rs != null){
                                    rs.close();
                                    conexao.finalizaConexao(session.getId() + "RS1");
                                }
	
 	%>
    </table>
   </td>
  </tr>
 <tr class="trontrk">
  <td>
   &nbsp;
  </td>
 </tr>
  
  <tr class="ftverdanacinza">
   <td align="center" class="ftverdanacinza" height="10%">
    <input type="button" class="botcin" value="     FECHAR     " name="botao" onClick="JavaScript:window.close();">
   </td>
  </tr>
 </table>
</body>
</html>

<%
//} catch(Exception e){
//  out.println("ERRO:"+e);
//}
%>