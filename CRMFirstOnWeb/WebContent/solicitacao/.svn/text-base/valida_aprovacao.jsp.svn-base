<%
    response.setHeader("Pragma", "no-cache");
    if (request.getProtocol().equals("HTTP/1.1"))
    {
      response.setHeader("Cache-Control", "no-cache");
    }
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.io.*"%>
<jsp:useBean id="email" 	scope="page" class="firston.eval.components.FOEmaiBeanl" />

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
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 
Integer usu_cod = (Integer)session.getAttribute("usu_cod"); 

ResultSet rsEmailRem = null, rsEmail = null, rsVerifica = null;
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("SolicitaCAo")%> - <%=trd.Traduz("APROVACAO DO PLANO")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<!--/*FUNCOES RESPONSAVEIS PELO ENVIO DE E-MAILS */-->
<%!
public String replaceString(String s, String busca, String troca){
	String nova = "";
	int ini = s.indexOf(busca);
	boolean ok = false;
	if (ini>0){
		ok = true;
	}
	else{
		nova = s;
	}
	while (ok) {
		int fim = busca.length();
		nova = s.substring(0,ini) + troca + s.substring(ini+fim,s.length());
		ini = nova.indexOf(busca);
		if (ini>0){
			s = nova;
		}
		else {
			ok = false;
		}
	}
	return nova;
}	

public String readFile(String path) throws IOException{
	FileInputStream arq = new FileInputStream(path);
	BufferedInputStream fil = new BufferedInputStream(arq);
	String arquivo = "";
	char ch;
	int c = -1;
	while((c = fil.read()) != -1){
		ch = (char)(c);
		arquivo += ch;
	} 
	fil.close();
	return arquivo;
}
%>

<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','solicitacao/../art/onenglish.gif','solicitacao/../art/onespanol.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="59" class="hcfundo"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
               <%
	      	   String ponto = (String)session.getAttribute("barra");
	      	   if(ponto.equals("..")){%>
               <jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="SO"/></jsp:include> 
               <%}else{%>
               <jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="SO"/></jsp:include> 
               <%}%>
              </tr>
            </table>
          </td>
        </tr>
        
        <tr> 
          <td class="mnfundo"><img src="../art/bit.gif" width="12" height="5"></td>
        </tr>
        
        <tr>
          <td height="25" class="mnfundo"> 
            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
		<%String menu = "", opMenu = "";
		
		if(ponto.equals("..")){
			if (request.getParameter("op") == null){
				menu = "../menu/menu.jsp?op=S";
			}
			else{
				menu = "../menu/menu.jsp?op=S";
			}
			if (request.getParameter("opt") == null){
				opMenu = "../menu/menu1.jsp?opt=AP&op=S";
			} 
			else{  
				opMenu = "../menu/menu1.jsp?opt=AP&op=S";
			}
		}
		else{
			if (request.getParameter("op") == null){
				menu = "/menu/menu.jsp?op=S";
			}
			else{
				menu = "/menu/menu.jsp?op=S";
			}
			if (request.getParameter("opt") == null){
				opMenu = "/menu/menu1.jsp?opt=AP&op=S";
			} 
			else{  
				opMenu = "/menu/menu1.jsp?opt=AP&op=S";
			}
		}		
		%>
		<jsp:include page="<%=menu%>" flush="true"></jsp:include>
              </tr>
            </table>
          </td>
        </tr>
	      <jsp:include page="<%=opMenu%>" flush="true"></jsp:include>
      </table>
     <form name="frm" method="POST"> 
      <table width="90%" border="0" cellspacing="0" cellpadding="0" align="center">
      		<tr> 
      			<td colspan="4"> 
      				<div align="center"><font class="trontrk"><%=trd.Traduz("APROVACAO DO PLANO")%></font></div>
      			</td>
      		</tr>
      		<tr> 
		          <td colspan="4"> 
		            <hr  >
		          </td>
        </tr>
      		<tr> 
      			<td colspan="4"> 
      				&nbsp;
      			</td>
      		</tr>
      		<tr> 
      			<td colspan="4"> 
      				&nbsp;
      			</td>
		</tr>
      
      
      <tr>
      <td colspan="4" align="center"> 
      <%
//try{

Integer fun_idi    = (Integer)session.getAttribute("fun_idi");

request.getSession();
String 	fun_codigo 		= (((String)request.getParameter("func")==null)?"":(String)request.getParameter("func"));
String 	meu 			= (((String)request.getParameter("meu")==null)?"N":(String)request.getParameter("meu"));
String 	flag_aprovado	= "";
String 	justificativa	= "";
Integer	plan_cod 		= new Integer(0);

if(meu.equals("N")){
	flag_aprovado = (((String)request.getParameter("aprovado")==null)?"":(String)request.getParameter("aprovado"));
	plan_cod 		= (Integer)session.getAttribute("usu_plano");

	if(flag_aprovado.equals("N")){
		justificativa = (((String)request.getParameter("textarea")==null)?"":(String)request.getParameter("textarea"));
	}
}	

/*ENVIA E-MAIL AO SOLICITANTE*/
String smtp 	= prm.buscaparam("MAI_SMTP"	);
String rem 		= prm.buscaparam("MAI_END"	);
String cc 		= prm.buscaparam("MAI_CC"		);
String user 	= prm.buscaparam("MAI_USER"	);
String senha 	= prm.buscaparam("MAI_SENHA"	);
String dest		= "";
String assunto	= "";
if(meu.equals("N")){
	assunto = assunto = trd.Traduz("APROVACAO DO PLANO DE TREINAMENTO");
}
else{
	assunto = trd.Traduz("SOLICITACAO DE APROVACAO DO PLANO");
}	

String a 		= "";
String msg_tip	= "text/html";
/*
out.println("<p>SMTP: "+smtp);
out.println("<p>REM: "+rem);
out.println("<p>CC: "+cc);
out.println("<p>USER: "+user);
out.println("<p>SENHA: "+senha);
*/

/*SELECIONA REMETENTE*/      
String queryEmailRem = "SELECT F.FUN_EMAIL,F.FUN_NOME,C.CAR_NOME FROM FUNCIONARIO F,CARGO C WHERE F.FUN_CODIGO="+usu_cod+" AND F.CAR_CODIGO=C.CAR_CODIGO";
rsEmailRem = conexao.executaConsulta(queryEmailRem,session.getId()+"RS1");
String nomeRem="";
String cargo="";
if(rsEmailRem.next()){
		do{
		rem= rsEmailRem.getString(1);
		nomeRem=rsEmailRem.getString(2);
		cargo=rsEmailRem.getString(3);
		}while(rsEmailRem.next());
}


if(rsEmailRem != null){
   rsEmailRem.close();
   conexao.finalizaConexao(session.getId()+"RS1");
}

//out.println("SMTP: "+smtp+" REM: "+rem+" USER: "+user+" SENHA: "+senha+" CC: "+cc);
email.pegaConf(smtp.trim(), rem.trim(), user.trim(),senha.trim(),cc.trim());/*Recupera configuraCAo de e-mail do Bean*/

//out.println("<br><br>Deu?"+email.envio());

/*SELECIONA DESTINATARIO*/
String queryEmail = "SELECT FUN_EMAIL,FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO="+fun_codigo;
rsEmail = conexao.executaConsulta(queryEmail,session.getId()+"RS2");
boolean verificaEmailExist= true;
String nomeDest="";
      
if(rsEmail.next()){
	do{
		dest= rsEmail.getString(1);
		nomeDest=rsEmail.getString(2);
	}while(rsEmail.next());
}
else{
/*TRATA POSSIVEL FALTA DE E-MAIL NO BANCO DE DADOS*/
verificaEmailExist= false;
}

if(rsEmail != null){
   rsEmail.close();
   conexao.finalizaConexao(session.getId()+"RS2");
}

      
try{
	if(meu.equals("N")){
		a = readFile(""+request.getRealPath("/")+"emails\\email1.html");
	}
	else{
		a = readFile(""+request.getRealPath("/")+"emails\\email.html");
	}
}
catch(java.io.FileNotFoundException rf){
	out.println("<tt class=\"ctfontc\">Arquivo de Email estA faltando :</tt><p>"+rf+" <p><tt class=\"ctfontb\">Verifique se o arquivo encontra-se no local correto!<p></tt><hr>");
}
      	
if(meu.equals("S")){
    a = replaceString(a,":NOME:",nomeDest);
    a = replaceString(a,":REM:",nomeRem);
    a = replaceString(a,":CARGO:",cargo);
}
else{
	a = replaceString(a,":NOME:",nomeDest);
	a = replaceString(a,":REM:",nomeRem);
	a = replaceString(a,":CARGO:",cargo);
	if(flag_aprovado.equals("N")){
		justificativa="JUSTIFICATIVA : <P>"+justificativa;
	}
	a = replaceString(a,":JUSTIFICATIVA:",justificativa);
      	
	String sit="";
	if(flag_aprovado.equals("S")){
		sit =trd.Traduz("FOI");
	}
	else{
		sit =trd.Traduz("NAO FOI");
	}
	a = replaceString(a,":SIT:",sit);
}      
      
      
if(verificaEmailExist){
	try {
		//out.println("<br><br>1:"+dest+" 2:"+assunto+" 3:"+msg_tip+" 4:"+a+"<P>");
		email.sendMail(dest, assunto, a, "text/html");/*Manda o E-mail depois de configurado*/
		
	}
	catch(Exception ex1 ){
		out.println("<tt class=\"ctfontc\"> Erro no envio do E-mail :</tt><p>"+ex1+" <p><tt class=\"ctfontb\">Verifique todos os parametros na tabela PARAM do sistema.<p>Ou Contate o fabricante!</tt><hr>");
	}      
	//out.println(email.envio());
	if(email.envio() == true){
		%>
		<tt class="ctfontc"><%=trd.Traduz("Remetente")%></tt>: <tt class="ctfontb"><%=nomeRem%> - <%=rem%></tt><br>
		<tt class="ctfontc"><%=trd.Traduz("DestinatArio")%></tt>: <tt class="ctfontb"><%=nomeDest%> - <%=dest%> </tt><br>
		<tt class="ctfontc"><%=trd.Traduz("Assunto")%></tt> : <tt class="ctfontb"><%=assunto%></tt><br><br>
		<BR><BR><tt class="ctfontb"><%=trd.Traduz("E-MAIL enviado com sucesso! ")%>
		<%
	}
	else{
		%>
		<br><tt class="ctfontb"><%=trd.Traduz("NAo foi possIvel enviar o e-mail para o destinatArio")%></tt>.
		<%
	}
}
else{
	%>
	<br><tt class="ctfontb"><%=trd.Traduz("O destinatArio nAo possui um e-mail!")%></tt>.
	<%
}

/*FIM DO PROCESSO DE ENVIO DE E-MAIL*/
      
      
      /*GRAVA APROVACAO*/


if(meu.equals("N")){     		
	String queryVerifica="SELECT * FROM solic_plano WHERE Fun_codigo="+fun_codigo+" AND pla_codigo="+plan_cod+"";
	rsVerifica = conexao.executaConsulta(queryVerifica,session.getId()+"RS3");
	String query="";
	if(rsVerifica.next()){
		query ="UPDATE  solic_plano SET fun_codigo="+fun_codigo+",pla_codigo="+plan_cod+",sop_aprovado='"+flag_aprovado.toUpperCase()+"',sop_justificativa='"+trataAspas(justificativa)+"' WHERE Fun_codigo="+fun_codigo+" AND pla_codigo="+plan_cod+"";
	}
	else{
		query ="INSERT INTO solic_plano (fun_codigo,pla_codigo,sop_aprovado,sop_justificativa) VALUES("+fun_codigo+","+plan_cod+",'"+flag_aprovado.toUpperCase()+"','"+trataAspas(justificativa)+"')";
	}	
	conexao.executaAlteracao(query);

        if(rsVerifica != null){
            rsVerifica.close();
            conexao.finalizaConexao(session.getId()+"RS3");
        }

}

//} catch(Exception ex){out.println("<tt class=\"ctfontc\"> Contate o Fabricante :<p></tt>"+ex+"<p><tt class=\"ctfontb\">Erro generico! Verifique se todos os dados estAo preenchidos na Tabela PARAM</tt><hr>");}

%>
      
   		</td>   
	</tr>
	<tr>
		<td colspan="4">&nbsp; </td>
	</tr>
	<tr> 
		<td colspan="4"><hr></td>
    </tr>
    <tr>
		<td colspan="4"> 
			<div align="center">
				<input type="button" class="botcin" onClick="location='aprovacao1.jsp';" name="final" value=<%=("\""+trd.Traduz("concluir")+"\"")%>>
			</div>
		</td>
	</tr> 
	<tr>
		<td colspan="4">&nbsp; </td>
	</tr> 
</table>
</form>
    </td>
  </tr>
  <tr> 
    <td align="right" height="30" class="difundo"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td> 
          
          <%if(ponto.equals("..")){%>
              <!--<jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include>-->
              <%}else{%>
              <!--<jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>-->
              <%}%>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<%

%>

</body>
</html>
