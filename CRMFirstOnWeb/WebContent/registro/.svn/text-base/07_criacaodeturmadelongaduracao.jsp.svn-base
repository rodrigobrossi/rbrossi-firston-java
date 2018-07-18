<%
    response.setHeader("Pragma", "no-cache");
    if (request.getProtocol().equals("HTTP/1.1"))
    {
      response.setHeader("Cache-Control", "no-cache");
    }
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.lang.Math.*, java.util.*, java.text.*"%>

<%
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
FODBConnectionBean conexaoe = new FODBConnectionBean();
conexaoe.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"), (String)session.getAttribute("s_driverbanco")); 


String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 
String ent = "*"; 
String fun = "*"; 
String inst = "*";
String op = request.getParameter("tipo");
String turma =request.getParameter("checkbox");

ResultSet rs = null, rse = null;

//try {

   if (!(op.equals("I")))
   {
     if (request.getParameter("checkbox") == null)  
	 {%>
	  <script language="JavaScript">
      alert(<%=("\""+trd.Traduz("E necessArio selecionar uma turma.")+"\"")%>);
      window.open("05_criarturmalongaduracao.jsp","_self");
      </script>	
	  <%}
   }

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

if(request.getParameter("txt_desc") != null)
{
	if(!(request.getParameter("txt_desc").equals("")))
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
}

request.getSession(true);
session.setAttribute("vet_descS",vet_desc);
session.setAttribute("vet_custS",vet_cust);
String descricao = "", custo = "", aux="", teste="";

float total = 0;
if(request.getParameter("total2") != null)
{	
	String m = request.getParameter("total2");
	total = Float.parseFloat(m);
}

String origem = "";
if(request.getParameter("origem") != null)
	origem = request.getParameter("origem");

int a = 0;

String ass = "-1";
if (request.getParameter("selectass") != null)
    ass = request.getParameter("selectass"); //auxiliar combo Asunto
String tit = "-1";
if (request.getParameter("selecttit") != null)
    tit = request.getParameter("selecttit"); //auxiliar combo Titulo
String cur = "-1";
if (request.getParameter("selectcur") != null)
    cur =  request.getParameter("selectcur"); //auxiliar combo Curso

String dtini = "";
String tip = "";
String dtfim = "";
String cuscur = "";
String cuslog = "";
String pmin = "";
String pmax = "";

float duracao = 0;
float duracao2 = 0;

String entidade = "";
String instrutor = "";
String obs = "";

String query = "";
if (op.equals("A")){
 if (cur.equals("-1")){
  query = "SELECT CURSO.CUR_CODIGO, TITULO.TIT_CODIGO, TITULO.ASS_CODIGO FROM CURSO, TITULO " +
                               " WHERE  CURSO.TIT_CODIGO = TITULO.TIT_CODIGO AND  " + 
                               " CURSO.CUR_CODIGO IN (SELECT CUR_CODIGO FROM TREINAMENTO WHERE TEF_CODIGO = " + turma + ")";
  rs = conexao.executaConsulta(query);
                       if (rs.next()) {    
					     cur = rs.getString(1);
						 tit = rs.getString(2);
						 ass = rs.getString(3);
					   }
 }
 query = "SELECT CUR_CODIGO, TEF_RESULTADOESPERADO, EMP_CODIGO FROM TREINAMENTO WHERE TEF_CODIGO = " + turma;

  rs = conexao.executaConsulta(query);
  if (rs.next()) { 

    entidade = rs.getString(3);
    obs = rs.getString(2);
  }
}
%>
<script language="JavaScript">
function enviar() {

          if (frm.selectent.value == "") {
              alert(<%=("\""+trd.Traduz("Favor escolher a entidade")+"\"")%>); 
              frm.selectent.focus();
            } else 
		{        
	       if (frm.selectfunc.value == "Selecione") 
		   {
                alert(<%=("\""+trd.Traduz("Favor escolher o funcionario!")+"\"")%>); 
                frm.selectfunc.focus();
	        } else {
                frm.action = "07_criacaodeturmadelongaduracao_grava.jsp";
                frm.submit();
                return false; 
	        }
        } 

}

function assunto() { 
	frm.selectass.disabled = false;
	frm.selecttit.disabled = false;
	frm.selecttit.value = null;
	frm.selectcur.value = null;
	frm.action ="07_criacaodeturmadelongaduracao.jsp";
	frm.submit();
	return false;	
}

function titulo() {
	frm.selectass.disabled = false;
	frm.selecttit.disabled = false;
	frm.selectcur.value = null;
	frm.action ="07_criacaodeturmadelongaduracao.jsp";
	frm.submit();
	return false;	
}

function curso() {
	frm.selectass.disabled = false;
	frm.selecttit.disabled = false;
	frm.action ="07_criacaodeturmadelongaduracao.jsp";
	frm.submit();
	return false;	
}
	
function insere() {
  if(frm.txt_desc.value == "") {
    alert(<%=("\""+trd.Traduz("DIGITE A DESCRICAO")+"\"")%>)
    frm.txt_desc.focus();
    return false;
  }
  else if(frm.txt_cust.value == "") 
  {
    alert(<%=("\""+trd.Traduz("DIGITE O CUSTO")+"\"")%>);
    frm.txt_cust.focus();
    return false;
  } else {
    frm.action="10_criacaoturmaantecipada.jsp";
    frm.submit();
    return true;
  }
}

function deleta() {
  var cont=0;
  for(i=0;i<frm.contador.value;i++) {
    if(eval("frm.vet"+i+".checked")==true) {
      cont = cont + 1;
    }
  }
  if(cont==0) {
    alert(<%=("\""+trd.Traduz("NENHUM ITEM SELECIONADO")+"\"")%>);
    return false;
  } else {
    if(confirm(<%=("\""+trd.Traduz("DESEJA EXCLUIR O ITEM SELECIONADO?")+"\"")%>)) {
      frm.action="deleta_custo.jsp";
      frm.submit();
      return true;
    } else {
      return false;
    }
  }
}
function soma(){
var v1=0;
var v2=0;
v1=frm.textcustocur.value;
v2=frm.textcustolog.value;
var total=0;
total=eval(v1+"+"+v2);
frm.textcustoreal.value = 0;
frm.textcustoreal.value = total;
return false;
}	
function FormataData(campo, evento, direcao){
	if (campo.value.length < 10000){
		if (evento != 9 ){//tab
			if(evento != 8 && evento != 46 && evento != 16 && !(evento > 36 && evento < 41)){ //delete, backspace, shift nAo causam evento
				var tam = campo.value.length
				if ((evento >= 48 && evento <= 57) || (evento >= 96 && evento <= 105)) {
					if (tam == 2 || tam == 5){
						campo.value = campo.value + "/";
						}
					} 
				else{
					if (direcao == "up"){
						if (campo.value.length == 0){
							campo.value = ""
							}
						else{
							campo.value = campo.value.substring(0,campo.value.length-1)
							}
						}
					}
				campo.focus()
				}
			} 
		else{
			if (direcao == "down"){
				ChecaData(campo)
				}
			}
		}
	}
	
function ChecaData(THISDATE){
	var erro = 0
	var data = THISDATE.value
	if (data.length != 10) 
		erro=1
	var dia = data.substring(0, 2)// dia
	var barra1 = data.substring(2, 3)// '/'
	var mes = data.substring(3, 5)// mes
	var barra2 = data.substring(5, 6)// '/'
	var ano = data.substring(6, 10)// ano
		
	if (mes < 1 || mes > 12) 
		erro = 1
	if (dia < 1 || dia > 31) 
		erro = 1
	if (ano < 1990) 
		erro = 1
	if (mes == 4 || mes == 6 || mes == 9 || mes == 11){
		if (dia == 31) 
			erro = 1
			}
	if (mes == 2){
		var bis = parseInt(ano/4)
		if (isNaN(bis)){
			erro = 1
			}
		if (dia > 29) 
			erro = 1
		if (dia == 29 && ((ano/4) != parseInt(ano/4))) 
			erro = 1
		}
	if ((erro == 1) && (THISDATE.value != "")) {
		alert(THISDATE.value + ' <%=trd.Traduz("E uma data invAlida!")%>');
		THISDATE.value = "";
		}
	}
function DoCal(elTarget){
	if (showModalDialog){
		var sRtn;
		sRtn = showModalDialog("calendar.htm","","center=yes;status=no;dialogWidth=306px;dialogHeight=220px");
		if (sRtn!="")
			elTarget.value = sRtn;
		} 
	else
		alert(<%=("\""+trd.Traduz("INTERNET EXPLORER 4.0 OU SUPERIOR E NECESSARIO")+"\"")%>)
}
	
</script>
<%! public String convHora(float minutos)
{	
	Float ft = new Float(minutos);
	int min = ft.intValue();
	
	String total = "";
	float result;
	int inteiro = 0, decimal = 0;

	result = min / 60;

	Float ft2 = new Float(result);
	inteiro = ft2.intValue();

	decimal = min % 60;

	total = total.valueOf(inteiro);

	return total;
}
%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Registro")%> - 
<%if (op.equals("I")){%>
  <%=trd.Traduz("CriaCAo Turma Longa DuraCAo")%>
<%}else{%>
  <%=trd.Traduz("AlteraCAo de Longa DuraCAo")%>
<%}%>
</title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','art/onenglish.gif','art/onespanol.gif')">
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
               <jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="RG"/></jsp:include> 
               <%}else{%>
               <jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="RG"/></jsp:include> 
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
                                <%String oi = "", oia = "";
if(ponto.equals("..")){
				if (request.getParameter("op") == null)
				{
                  oi = "../menu/menu.jsp?op="+"R";
				}
				else
				{
                  oi = "../menu/menu.jsp?op="+request.getParameter("op");
				}
				if (request.getParameter("opt") == null)
				{
                  oia = "../menu/menu1.jsp?opt="+"CTL";
				} 
				else
				{  
                  oia = "../menu/menu1.jsp?opt="+request.getParameter("opt");
				}
		}else {
		
		if (request.getParameter("op") == null)
						{
		                  oi = "/menu/menu.jsp?op="+"R";
						}
						else
						{
		                  oi = "/menu/menu.jsp?op="+request.getParameter("op");
						}
						if (request.getParameter("opt") == null)
						{
		                  oia = "/menu/menu1.jsp?opt="+"CTL";
						} 
						else
						{  
		                  oia = "/menu/menu1.jsp?opt="+request.getParameter("opt");
				}
		
		
		
		
		}		
				%>
                <jsp:include page="<%=oi%>" flush="true"></jsp:include>
				</tr>
            </table>
          </td>
        </tr>
		<jsp:include page="<%=oia%>" flush="true"></jsp:include>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="20">&nbsp;</td>
          <td width="100%" align="center"> 
            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
                <td class="trontrk" align="center">
				<%if (op.equals("I")){%>
				  <%=trd.Traduz("CriaCAo Turma Longa DuraCAo")%></td>
				<%}else{%>
				  <%=trd.Traduz("AlteraCAo de Longa DuraCAo")%></td>
				<%}%>
                <td width="29"><img src="../art/bit.gif" width="13" height="15"></td>
              </tr>
            </table>
          </td>
          <td width="20">&nbsp;</td>
        </tr>
        <tr> 
          <td width="20" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
          <td valign="top" class="ctvdiv"><img src="../art/bit.gif" width="1" height="1"></td>
          <td width="20"><img src="../art/bit.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td width="20" valign="top"></td>
		  <FORM name = "frm">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1">&nbsp;<br><center>
                <table border="0" cellspacing="2" cellpadding="2" width="82%">
                  <tr> 
                    <td class="ftverdanacinza" align="right" height="30" width="3%"><%=trd.Traduz("Assunto")%>:</td>
                    <td class="ftverdanacinza" colspan="4"> 
                      <select name="selectass" class="form" onChange="return assunto();">
<%                      query = "SELECT ASS_CODIGO, ASS_NOME FROM ASSUNTO " +
                                "WHERE ASS_ATIVO = 'S' ORDER BY ASS_NOME";
                        rs = conexao.executaConsulta(query);
                        if (rs.next()) {    
                            if (request.getParameter("selectass") != null) {
                            ass = request.getParameter("selectass");
                        }%>
                        <option value = "Selecione" selected><%=trd.Traduz("Selecione")%></option>
<%                      do {
                           if (ass.equals(rs.getString(1))) {%>
                              <option value = "<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
<%                         } else {%>
                              <option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                         }
                        } while (rs.next());
		        }%>
                      </select>
                    </td>
                  </tr>
                  <tr> 
                    <td class="ftverdanacinza" align="right" height="30" width="3%"><%=trd.Traduz("TItulo")%>:</td>
                    <td class="ftverdanacinza" colspan="4"> 
                      <select name="selecttit" class="form" onChange="return titulo();">
<%                      if (!(ass.equals("Selecione"))){
                            query = "SELECT TIT_CODIGO, TIT_NOME FROM TITULO " + 
                                    "WHERE TIT_ATIVO = 'S' AND ASS_CODIGO = " + ass + " " + 
                                    "ORDER BY TIT_NOME";
                        } else {
                            query = "SELECT TIT_CODIGO, TIT_NOME FROM TITULO " + 
                                    "WHERE TIT_ATIVO = 'S' AND ASS_CODIGO = -1 ORDER BY TIT_NOME";
                        }%>
                        <option value = "Selecione" selected><%=trd.Traduz("Selecione")%></option>
<%                      rs = conexao.executaConsulta(query); 
                        if (rs.next()) {
                            if (request.getParameter("selecttit") != null) {
                                if (!(request.getParameter("selecttit").equals("Selecione"))) {
                                    tit = request.getParameter("selecttit");
				} else {
                                    tit = rs.getString(1); 
				}
                            } else {
                           //if (!(tit.equals("-1")))
                                tit = rs.getString(1); 
			    }
                            do { 
                                if (tit.equals(rs.getString(1))) {%>
                                    <option value = "<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
<%                              } else {%>
                                    <option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                              }
                            } while (rs.next());
		        }%>
                      </select>
                    </td>
                  </tr>
                  <tr> 
                    <td class="ftverdanacinza" align="right" height="30" width="3%"><%=trd.Traduz("Curso")%>:</td>
                    <td class="ftverdanacinza" colspan="4"> 
                      <select name="selectcur" class="form" onChange="return curso();">
                        <%				   
   					   if (!(tit.equals("Selecione"))){
                       query = "SELECT CUR_CODIGO, CUR_NOME FROM CURSO " +
                               "WHERE CUR_ATIVO = 'S' AND TIT_CODIGO = " + tit + " " + 
                               " AND CUR_SIMPLES = 'N' ORDER BY CUR_NOME";
			           }
			           else
					   {
                       query = "SELECT CUR_CODIGO, CUR_NOME FROM CURSO " +
                               "WHERE CUR_ATIVO = 'S' AND TIT_CODIGO = -1 AND CUR_SIMPLES = 'N' ORDER BY CUR_NOME";
					   }

                           %>
                        <option value = "Selecione" selected><%=trd.Traduz("Selecione")%></option>
                        <%

                       rs = conexao.executaConsulta(query);
                       if (rs.next()) {
                         do {
			   if (request.getParameter("selectcur") != null) {
				   		     if (!(request.getParameter("selectcur").equals("Selecione")))
							 {
                                  cur = request.getParameter("selectcur");
							 }
							   else
							 {
								  cur = rs.getString(1); 
							 }
                           } else {
                             if (op.equals("I")){
                   			       cur = rs.getString(1);
							 }                                 

		                   }
			   if (cur.equals(rs.getString(1))) {%>
                        <option value = "<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
                        <%} else {%>
                        <option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
                        <%}
                          }
                          while (rs.next());
		        }%>
                      </select>
                    </td>
                  </tr>
                  <tr> 

                  <tr> 
                    <td class="ftverdanacinza" align="right" height="30" width="3%"><%=trd.Traduz("Entidade")%>:</td>
                    <td class="ftverdanacinza" colspan="4"> 
                      <select name="selectent">
                        <option value = "Selecione" selected><%=trd.Traduz("Selecione")%></option>
                        <%query = "SELECT EMP_CODIGO, EMP_NOME FROM EMPRESA ORDER BY EMP_NOME";
                       rse = conexaoe.executaConsulta(query);
                       if (rse.next()) {
                         if ((request.getParameter("selectent") != null)){
                           ent = request.getParameter("selectent");
                         } else {
                           if (ent.equals("*"))
		             ent = rse.getString(1); 
                         }
                         do {
							  if (op.equals("A"))
							 {
							    if (rse.getString(1).equals(entidade))
								{%>
                                      <option value = "<%=rse.getInt(1)%>" selected><%=rse.getString(2)%></option>
                              <%}
								else
								{%>
							          <option value = "<%=rse.getInt(1)%>"><%=rse.getString(2)%></option>
						      <%}
						     }
						     else
						     {%>
                             <option value = "<%=rse.getInt(1)%>"><%=rse.getString(2)%></option>
                           <%}
							 }
                         while (rse.next());
		       } %>
                      </select>
                    </td>
                  </tr>
                  <tr> 

                  </tr>
                  <tr> 
                    <td class="ftverdanacinza" align="right" width="3%"><%=trd.Traduz("HISTORICO")%>:</td>
                    <td class="ftverdanacinza" colspan="4"> 
					<%if (op.equals("I")){%>
                      <textarea name="txtobs" rows="4" cols="50"></textarea>
                    <%}else{%>
                      <textarea name="txtobs" rows="4" cols="50"><%=obs%></textarea>
					<%}%>
                    </td>
                  </tr>
                  <tr> 
                    <td class="ftverdanacinza" align="right" height="30" width="3%"><%=trd.Traduz("FuncionArio")%>:</td>
                    <td class="ftverdanacinza" colspan="4"> 
                      <select name="selectfunc">
                        <option value = "Selecione" selected><%=trd.Traduz("Selecione")%></option>
                        <%query = "SELECT FUN_CODIGO, FUN_NOME FROM FUNCIONARIO ORDER BY FUN_NOME";
                       rse = conexaoe.executaConsulta(query);
                       if (rse.next()) {
                         if ((request.getParameter("selectfunc") != null)){
                           ent = request.getParameter("selectfunc");
                         } else {
                           if (fun.equals("*"))
		             fun = rse.getString(1); 
                         }
                         do {
							  if (op.equals("A"))
							 {
							    if (rse.getString(1).equals(fun))
								{%>
                                      <option value = "<%=rse.getInt(1)%>" selected><%=rse.getString(2)%></option>
                              <%}
								else
								{%>
							          <option value = "<%=rse.getInt(1)%>"><%=rse.getString(2)%></option>
						      <%}
						     }
						     else
						     {%>
                             <option value = "<%=rse.getInt(1)%>"><%=rse.getString(2)%></option>
                           <%}
							 }
                         while (rse.next());
		       } %>
                      </select>
                    </td>
                  </tr>
                  <tr> 
                    <td class="ftverdanacinza" align="center" colspan="5">&nbsp;<br>
                      <input type="button" onClick="return enviar();" value=<%=("\""+trd.Traduz("Confirmar")+"\"")%> class="botcin" name="button">
                  </tr>                                                                      
                </table>
              </center>
          </td>
  		  <input type="hidden" name="tipo" value="<%=op%>">
          <input type="hidden" name="turma" value="<%=turma%>">
		  </FORM>
          <td width="20" valign="top"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td align="right" height="30" class="difundo"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td> <%if(ponto.equals("..")){%>
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
</body>
</html>
<%
if(rs != null) rs.close();
conexao.finalizaConexao();

conexaoe.finalizaConexao();	
//conexaoe.finalizaBD();

//} catch (Exception r) {
//  out.println(r);	
//}
%>