<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1"))
    response.setHeader("Cache-Control", "no-cache");
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.util.*, java.sql.*"%>

<%
request.getSession();

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
String aplicacao = (String) session.getAttribute("aplicacao");
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 
Integer usu_codigo = (Integer)session.getAttribute("usu_cod");
String usu_plano = "";
usu_plano = usu_plano.valueOf(session.getAttribute("usu_plano")); 

//try
//{

String ponto = (String)session.getAttribute("barra");

FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
//Declaracao de Variaveis
String curso = "", query = "", queryp = "", querynp = "", cancela = "", deleta = "";
int contaplan = 0, contanplan = 0;
boolean existe  = false;
ResultSet rsgrid = null;

Vector vec_plan = new Vector();
Vector vec_nplan = new Vector();
Vector vec_registro = new Vector();

String[] str_plan = new String[3];
String[] str_nplan = new String[3];
String[] str_reg = new String[5];

//Pega os vetores da secao
if ((Vector)session.getAttribute("vec_plan") != null)
	vec_plan = (Vector)session.getAttribute("vec_plan");
else
	vec_plan.setSize(0);

if ((Vector)session.getAttribute("vec_nplan") != null)
	vec_nplan = (Vector)session.getAttribute("vec_nplan");
else
	vec_nplan.setSize(0);

//Para cancelar as inclusões
if (request.getParameter("cancela") != null){
   cancela = request.getParameter("cancela");
   if (cancela.equals("S")){ 
     
     vec_plan.removeAllElements();
     vec_plan.setSize(0);
     session.setAttribute("vec_plan", null);
     
     vec_nplan.removeAllElements();
     vec_nplan.setSize(0);
     session.setAttribute("vec_nplan", null);

     vec_registro.removeAllElements();
     vec_registro.setSize(0);
     session.setAttribute("vec_registro", null);
   }
}

if (request.getParameter("deleta") != null)
   deleta = request.getParameter("deleta");

//Curso planejado para registro
if (request.getParameter("curso") != null)
   curso = request.getParameter("curso");


//Contador planejado
if (request.getParameter("contaplan") != null){
    contaplan = Integer.parseInt(request.getParameter("contaplan"));

   if (vec_plan.size() == 0){
    for(int i=1;i<=contaplan;i++){
           if (request.getParameter("checkplan"+i) != null){
           str_plan = new String[3];         
           str_plan[0] = request.getParameter("checkplan"+i);  
           str_plan[1] = null; 
		   str_plan[2] = curso; 
           vec_plan.addElement(str_plan);
           }
    }
   }
   else
   {
    for(int i=1;i<=contaplan;i++)
    {  
		boolean achou = false;
		if (request.getParameter("checkplan"+i) != null)
	        {			
			for(int k=0;k<vec_plan.size();k++)
	                {
				String[] strp = (String[])vec_plan.elementAt(k);
                
				  if ( request.getParameter("checkplan"+i).equals(strp[0]) )
				  {		            
				    achou = true;
				  } 							   
			}
		   
                     if (achou == false){
		     str_plan = new String[3];         
                     str_plan[0] = request.getParameter("checkplan"+i);  
                     str_plan[1] = null; 
		     str_plan[2] = curso; 
                     vec_plan.addElement(str_plan);
		    }

		}
		
    }

   }
session.setAttribute("vec_plan", vec_plan);
}


//Contador nao planejado
if (request.getParameter("contanplan") != null){
    contanplan = Integer.parseInt(request.getParameter("contanplan"));

   if (vec_nplan.size() == 0){
    for(int i=1;i<=contanplan;i++)
    {
		if (request.getParameter("checknplan"+i) != null)
	    {
           str_nplan = new String[3];         
           str_nplan[0] = null;  
           str_nplan[1] = request.getParameter("checknplan"+i); 
		   str_nplan[2] = null; 
           vec_nplan.addElement(str_nplan);
		}
	}
   }
   else
   {
      for(int i=1;i<=contanplan;i++)
      {  
		boolean achou = false;
		if (request.getParameter("checknplan"+i) != null)
	        {			
			for(int k=0;k<vec_nplan.size();k++)
	                {
				  String[] strnp = (String[])vec_nplan.elementAt(k);
                
				  if ( request.getParameter("checknplan"+i).equals(strnp[1]) )
				  {		            
				    achou = true;
				  }
			}
		   
                     if (achou == false)
                     {
		         str_nplan = new String[3];         
                         str_nplan[0] = null;  
                         str_nplan[1] = request.getParameter("checknplan"+i); 
		         str_nplan[2] = null; 
                         vec_nplan.addElement(str_nplan);
		    }

		}
		
	}

   }
session.setAttribute("vec_nplan", vec_nplan);
}



if (!(deleta.equals("S"))){

 //Monta a query de Planejados
 if ((Vector)session.getAttribute("vec_plan") != null){
    String filtrop = "", cod_curso = "";
    for(int k=0;k<vec_plan.size();k++)
	{
		String[] strv = (String[])vec_plan.elementAt(k);

		if (vec_plan.size() == 1){
          filtrop = filtrop + strv[0];
		}
		else if (k == (vec_plan.size()-1)){
          filtrop = filtrop + strv[0];
		}
		else
		{
          filtrop = filtrop + strv[0] + ",";
		}

		cod_curso = strv[2];
	}

 queryp = "SELECT T.TEF_CODIGO, F.FUN_CODIGO, F.FUN_NOME, C.CUR_NOME, T.CUR_CODIGO from TREINAMENTO T, FUNCIONARIO F, CURSO C WHERE " + " T.FUN_CODIGO = F.FUN_CODIGO AND T.CUR_CODIGO = C.CUR_CODIGO AND T.CUR_CODIGO = " + cod_curso + " AND T.PLA_CODIGO = " + usu_plano + " AND T.TEF_CODIGO IN (" + filtrop + ")";

 }

 //Monta a query de Não Planejados
 if ((Vector)session.getAttribute("vec_nplan") != null){
    String filtronp = "";
	
    for(int j=0;j<vec_nplan.size();j++)
	{
		String[] strnv = (String[])vec_nplan.elementAt(j);

		if (vec_nplan.size() == 1){
          filtronp = filtronp + strnv[1];
		}
		else if (j == (vec_nplan.size()-1)){
          filtronp = filtronp + strnv[1];
		}
		else
		{
          filtronp = filtronp + strnv[1] + ",";
		}
	}

 querynp = "SELECT F.FUN_CODIGO, F.FUN_CODIGO, F.FUN_NOME, '', -1 from FUNCIONARIO F WHERE " + 
 " F.FUN_CODIGO IN (" + filtronp + ")";

 }


 if ( ((Vector)session.getAttribute("vec_plan") != null) && ((Vector)session.getAttribute("vec_nplan") != null) ){
    query = queryp + " UNION ALL " + querynp + " ORDER BY FUN_NOME";
	existe = true;
 }
 else
 {

      if (((Vector)session.getAttribute("vec_plan") != null)){
          query = queryp + " ORDER BY FUN_NOME";
	  existe = true;
     }
	
     if (((Vector)session.getAttribute("vec_nplan") != null)){
        query = querynp + " ORDER BY FUN_NOME";
	existe = true;
    }

 }

           //out.println("query = " + query);

                           //Preenche o Vetor principal dos funcionários selecionados                                   
                           if (existe){
                               rsgrid = conexao.executaConsulta(query,session.getId());
                               if (rsgrid.next()) {
                                   do {

                                       str_reg = new String[5];         
                                       str_reg[0] = rsgrid.getString(1);
                                       str_reg[1] = rsgrid.getString(2);
		                       str_reg[2] = rsgrid.getString(3);
                                       str_reg[3] = rsgrid.getString(4);
		                       str_reg[4] = rsgrid.getString(5);
                                       vec_registro.addElement(str_reg);                                       
                                }
                                  while (rsgrid.next());
		               }
                           session.setAttribute("vec_registro", vec_registro);
                           }
                           if(rsgrid!=null){    
                               rsgrid.close();
                               conexao.finalizaConexao(session.getId());
                           }
           
                            

}

                               //Para Excluir os elementos do vetor
                               if (deleta.equals("S")){
                                 if ((Vector)session.getAttribute("vec_registro") != null){
	                             vec_registro = (Vector)session.getAttribute("vec_registro");
                                     
                                     for(int k=0;k<vec_registro.size();k++)
	                             {
                                         //out.println("request.getParameter(checkreg+k) = " + request.getParameter("checkreg"+k));
                                         if ( request.getParameter("checkreg"+k) != null) {
                                             
 
                                             String[] strreg = (String[])vec_registro.elementAt(k);
                                             if (!(strreg[4].equals("-1"))){

                                                  for(int j=0;j<vec_plan.size();j++)
	                                          { 
				                     String[] strp = (String[])vec_plan.elementAt(j);
                
				                     if ( strreg[0].equals(strp[0]) )
				                     {		            
				                         vec_plan.remove(j);
				                     } 							   
			                          }
                                              session.setAttribute("vec_plan", vec_plan);
                                             }
                                             else
                                             {
                                                 for(int j=0;j<vec_nplan.size();j++)
	                                          { 
				                     String[] strnp = (String[])vec_nplan.elementAt(j);
                
				                     if ( strreg[1].equals(strnp[1]) )
				                     {		            
				                         vec_nplan.remove(j);
				                     } 							   
			                          }
                                              session.setAttribute("vec_nplan", vec_nplan);
                                             }

                                          vec_registro.removeElementAt(Integer.parseInt(request.getParameter("checkreg"+k)));  

                                         }
                                     }
                                 session.setAttribute("vec_registro", vec_registro);                                                                  
                                 
                                 
                                 }                             
                                 if (vec_registro.size() > 0){
                                   existe = true;
                                 }
                               }


/*out.println("vec_nplan = " + vec_nplan);
out.println("vec_plan = " + vec_plan);
out.println("vec_registro = " + vec_registro);*/



%>
<script language="JavaScript">
function Cancela()
{    
    frm.cancela.value = "S";
    frm.action = "frame_listafuncionarios.jsp";
    frm.submit();
    return false; 
}

function Deleta()
{    

var tem = false;
 
  for(k=0;k<frm.contareg.value;k++)
  {
    if(eval("frm.checkreg"+k+".checked")==true)
    {
	  tem = true;	 
    }
  }

if (tem)
  {
    frm.deleta.value = "S";
    frm.action = "frame_listafuncionarios.jsp";
    frm.submit();
    return false; 
  }
  else
  {
    alert(<%=("\""+trd.Traduz("NENHUM FUNCIONARIO SELECIONADO")+"\"")%>);   
    return false;
  }
    
}

function Registra()
{
  if (frm.selecionados.value == "S")
  {
      window.open("02_registrarlistadepresenca.jsp","_parent");
  }
  else
  {
      alert(<%=("\""+trd.Traduz("NENHUM FUNCIONARIO INCLUIDO")+"\"")%>);   
  }
}
</script>
<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Registro")%> - <%=trd.Traduz("Lista de PresenCa")%></title>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body  onunload='return fecha();'  marginheight="0" leftmargin="0" topmargin="0">
<form name="frm">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr>
    <td><table width="100%" border="0" cellspacing="3" cellpadding="0">
        <tr> 
          <td colspan="2" class="ctfontc" bgcolor="#000000"><img src="art/bit.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td width="46%" class="ctfontc">&nbsp;</td>
          <td width="54%">&nbsp;</td>
        </tr>
      </table>
      <table border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="25"> <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
              <tr> 
                <td width="127" height="22" align=center class="botver" onMouseOver="this.className='ctonlnk2';" onClick="return Registra();"><a href="#" class="txbotver"><%=trd.Traduz("REGISTRAR")%></a></td>
              </tr>
            </table></td>
          <td>&nbsp;&nbsp;</td>
          <td> <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
              <tr> 
                <td width="127" height="22" align=center class="botver" onMouseOver="this.className='ctonlnk2';" onClick="return Deleta();"><a href="#" class="txbotver"><%=trd.Traduz("EXCLUIR")%></a></td>
              </tr>
            </table>
          <td>&nbsp;&nbsp;</td>
          <td> <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
              <tr> 
                <td width="127" height="22" align=center class="botver" onMouseOver="this.className='ctonlnk2';" onClick="return Cancela();"><a href="#" class="txbotver"><%=trd.Traduz("CANCELAR")%></a></td>
              </tr>
            </table></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="3" cellpadding="0">
        <tr> 
          <td>&nbsp;</td>
        </tr>
      </table>
      <table width="90%" border="0" align="center" cellpadding="0" cellspacing="1">
        <tr> 
          <td class="celtittab"><div align="center"></div></td>
          <td class="celtittab"><div align="center"><%=trd.Traduz("FUNCIONARIO")%></div></td>
          <td class="celtittab"><div align="center"><%=trd.Traduz("CURSO")%></div></td>
        </tr>
                           <%
	                   if (existe){
                               
                               for(int k=0;k<vec_registro.size();k++)
	                       {
				String[] strreg = (String[])vec_registro.elementAt(k);       
			        %>
	                              <tr> 
                                      <td width="2%" class="celnortab"><input type="checkbox" name="checkreg<%=k%>" value="<%=k%>"></td>
                                      <td width="53%" class="celnortab"><%=strreg[2]%></td>
                                      <td width="45%" class="celnortab"><%=strreg[3]%></td>
                                    </tr>
                                <%
		               }
                               %>
                                <INPUT type="hidden" name="selecionados" value="S">
                               <%
                           }
                           else
                           {
                           %>
                              <td colspan="90%" class="celtittab" align="center"><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...</td>
                              <INPUT type="hidden" name="selecionados" value="N">
                           <%
                           }
                           %>

      </table>
      <table width="100%" border="0" cellspacing="3" cellpadding="0">
        <tr> 
          <td>&nbsp;</td>
        </tr>
      </table></td>
  </tr>
  <INPUT type="hidden" name="cancela" value="N">
  <INPUT type="hidden" name="deleta" value="N">
  <INPUT type="hidden" name="contareg" value="<%=vec_registro.size()%>">


<tr> 
    <td align="right" height="30" class="difundo">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr bgcolor="#FFFFFF">
			<td>&nbsp;  </td>
		</tr>
        <tr> 
          <td> 
<%           if(ponto.equals("..")){%>
             <jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include>
	     <%}else{%>
	     <jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>
	     <%}%>
          </td>
        </tr>
      </table>
    </td>
  </tr>


</table>
  </form>
</body>
</html>
<%
//if(rsgrid != null) rsgrid.close();

//conexaod.finalizaConexao();
///conexaod.finalizaBD();


/*} catch(Exception e){
  out.println("Erro:"+e);
}*/
%>