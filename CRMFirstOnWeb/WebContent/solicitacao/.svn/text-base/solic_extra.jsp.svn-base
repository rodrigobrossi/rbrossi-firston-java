<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1"))
{
  response.setHeader("Cache-Control", "no-cache");
} 
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*, java.util.*"%>

<%
//CASO A CHAMADA DESTA JSP NAO PASSAR POR PARAMEETRO SESSION O VECTOR "FUNCVET", UTILIZAR O COMANDO:
//Vector funcvet = new Vector();
//session.setAttribute("funcs", funcvet);

//Declaracoes iniciais

request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");

//Declaracoes de variaveis e recuperacao de parametros
String contador  = (String)request.getParameter("contador"); //contador do numero de funcionarios possiveis
String operacao  = (String)request.getParameter("operacao"); //tipo da operacao (I = insert, U = update)
String origem    = (String)request.getParameter("origem"); //nome da pagina de origem
String usu_tipo  = (String) session.getAttribute("usu_tipo"); //tipo do usuario
String usu_nome  = (String) session.getAttribute("usu_nome"); //nome do usuario
String usu_login = (String) session.getAttribute("usu_login"); //login do usuario
Integer usu_fil  = (Integer)session.getAttribute("usu_fil"); //
Integer usu_idi  = (Integer)session.getAttribute("usu_idi"); //

int pag = Integer.parseInt((String)session.getAttribute("pagina")); //numero de quebras de pagina

String moeda = prm.buscaparam("MOEDA");
ResultSet rs = null, rsq = null, rsRes = null, rsP = null;

//try {

String usu_plano = "", str_func = "", query_cur = "", query_tit = "", query_ass = "", query_comp = "";
usu_plano = usu_plano.valueOf(session.getAttribute("usu_plano")); //

String extra = ""; //Parametro para Solicitacao Extra (OBRIGATORIO)
if ((request.getParameter("extra") != null))
	extra = request.getParameter("extra");

String fun_codigo = ""; //Parametro quando funcionario for UNICO!!!
if ((request.getParameter("fun_codigo") != null))
	fun_codigo = request.getParameter("fun_codigo");

String ass = "-1";
if (request.getParameter("selectass") != null)
	ass = request.getParameter("selectass"); //auxiliar combo Asunto

String tit = "-1";
if (request.getParameter("selecttit") != null)
	tit = request.getParameter("selecttit"); //auxiliar combo Titulo

String cur = "-1";
if (request.getParameter("selectcur") != null)
	cur =  request.getParameter("selectcur"); //auxiliar combo Curso

String compt = "-1";
if (request.getParameter("compt") != null)
	compt =  request.getParameter("compt"); //auxiliar da Competencia escolhida

String query = ""; //variavel auxiliar de construcao de querys

//Busca e Insere dados no vetor de funcionArios
//Obs: o nome dos parametros dos codigos do registro deverao usar o formato: "checkbox" + numero sequencial (Ex: checkbox1, checkbox2)
//TESTE VETOR DADOS
//Busca e Insere dados no vetor de funcionArios selecionados
String n = "";
Vector funcvet = new Vector();
funcvet = (Vector)session.getAttribute("funcs");

//Insere os elementos (Funcionarios) no vetor, mesmo se for unico
if (!(fun_codigo.equals(""))) {
  funcvet.clear();
  funcvet.add(0, fun_codigo);  
} else {


  if(!(funcvet.equals(session.getAttribute("funcs"))))	{
    //funcvet.clear();		
    funcvet = (Vector)session.getAttribute("funcs"); //Busca o vetor de funcionarios na sessao
  }

  if (request.getParameter("reloaded") == null)	{
    //insere os elementos no vetor
    for(int k=1 ; k<=pag;k++) {
      if (!(request.getParameter("checkbox" + n.valueOf(k)) == null)) {
        if (!(funcvet.contains(request.getParameter("checkbox" + n.valueOf(k)))))
          funcvet.add(request.getParameter("checkbox" + n.valueOf(k)));
      }
    }
  session.setAttribute("funcs",funcvet);
  }
}

//Consiste dados de funcionarios
//out.println("tam vetor = " + funcvet.size());
int tamv = funcvet.size();//Tamanho do vetor de funcionarios
if(tamv == 0){
%>
<script language="JavaScript">
alert(<%=("\""+trd.Traduz("E NECESSARIO SELECIONAR UM FUNCIONARIO")+"\"")%>);
history.go(-1);
</script>
<%}

//Consiste se os cursos checados sao iguais

//Encontra Curso / Titulo / Assunto para "reprogramacao"
if ((origem.equals("reprogramacao")) /*|| (origem.equals("result_solics"))*/) {
  query = "SELECT C.CUR_CODIGO, T.TIT_CODIGO, A.ASS_CODIGO " + 
          "FROM CURSO C, TITULO T, ASSUNTO A " +
          "WHERE C.TIT_CODIGO = T.TIT_CODIGO AND T.ASS_CODIGO = A.ASS_CODIGO ";

  if (!(cur.equals("-1")))
    query = query + "AND C.CUR_CODIGO = " + cur;
 

  rs = conexao.executaConsulta(query,session.getId()+"RS1");
  if (rs.next()) {
    if (rs.getString(1) != null)
      cur = rs.getString(1);
    if (rs.getString(2) != null)
      tit = rs.getString(2);
    if (rs.getString(3) != null)
      ass = rs.getString(3);
  }

  if(rs != null){
    rs.close();
    conexao.finalizaConexao(session.getId()+"RS1");
  } 

  ResultSet rsrep = null;
  String queryrep = "SELECT FUN_CODIGO FROM TREINAMENTO WHERE TEF_CODIGO = " + fun_codigo;
  rsrep = conexao.executaConsulta(queryrep,session.getId()+"RS15");
  if (rsrep.next()){
      str_func = rsrep.getString(1);
  }
  
  if(rsrep != null){
    rsrep.close();
    conexao.finalizaConexao(session.getId()+"RS15");
  } 
  

}



//aloca o vetor de funcionarios na sessao
session.setAttribute("funcs", funcvet);
//funcvet.clear();

%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("SolicitaCAo")%> -
<%
if (origem.equals("prerequisitos")){%>
<%=trd.Traduz("PRE-REQUISITOS")%><%
}
if (origem.equals("result_solics")){%>
<%=trd.Traduz("ALTERACAO DA SOLICITACAO")%><%
}
if (origem.equals("porcompetencias")){%>
<%=trd.Traduz("POR COMPETENCIAS")%><%
}
if (origem.equals("reprogramacao")){%>
<%=trd.Traduz("REPROGRAMACAO")%><%
}
if (origem.equals("result_filtro")){%>
<%=trd.Traduz("SOLICITACAO EXTRA")%><%
}%>
</title>
<script language="JavaScript" src="scripts.js"></script>
<script language="JavaScript">
function envia()
{
	if ((frm.selectass.value == "Selecione") && (frm.selectass.enabled))
	{
    		alert(<%=("\""+trd.Traduz("E necessArio selecionar um Assunto!")+"\"")%>);			
	}
	else if ((frm.selecttit.value == "Selecione") && (frm.selecttit.enabled))
	{
    		alert(<%=("\""+trd.Traduz("E necessArio selecionar um Titulo!")+"\"")%>);			
	}
	else if (frm.selectcur.value == "Selecione")
	{
    		alert(<%=("\""+trd.Traduz("E necessArio selecionar um Curso!")+"\"")%>);			
	}
	else if (frm.selectprev.value == "Selecione")
	{
    		alert(<%=("\""+trd.Traduz("E necessArio selecionar uma PrevisAo!")+"\"")%>);			
	}
	/*else if(document.frm.tf_result.value == "")
	{
		alert(<%=("\""+trd.Traduz("E necessArio preencher o campo resultados esperados!")+"\"")%>);
		return false;
	}*/
	else
	{
                frm.fun_codigo.value = "";
		frm.action ="solic_extra_grava.jsp";
	   	frm.submit();
        	return false;	
	}
}

function assunto()
	{
	frm.selectass.disabled = false;
	frm.selecttit.disabled = false;
	frm.selecttit.value = null;
	frm.selectcur.value = null;
	frm.action ="solic_extra.jsp";
	frm.submit();
	return false;	
	}
function titulo()
	{
	frm.selectass.disabled = false;
	frm.selecttit.disabled = false;
	frm.selectcur.value = null;
	frm.action ="solic_extra.jsp";
	frm.submit();
	return false;	
	}
function curso()
	{
	frm.selectass.disabled = false;
	frm.selecttit.disabled = false;
	frm.action ="solic_extra.jsp";
	frm.submit();
	return false;	
	}

function cancela()
{
    if (frm.origem.value == "result_filtro"){
      window.open("result_filtro.jsp","_self");	
    }

    if (frm.origem.value == "prerequisitos"){
      window.open("prerequisitos.jsp?fun_codigo="+frm.func_codigo.value,"_self");	
    }   
    
    if (frm.origem.value == "porcompetencias"){
      window.open("porcompetencias.jsp?fun_codigo="+frm.func_codigo.value,"_self");	
    }
     
    if (frm.origem.value == "planosussessorio"){
      window.open("planosussessorio.jsp?fun_codigo="+frm.func_codigo.value,"_self");	
    }

    if (frm.origem.value == "reprogramacao"){ 
      window.open("reprogramacao.jsp?fun_codigo="+frm.fun_codigotef.value,"_self");
    }

}	

function descricao()
{
  if (!(frm.selectcur.value == "Selecione")){
     showModalDialog("descricao.jsp?cur_codigo="+frm.selectcur.value,"","center=yes;status=no;scroll=yes;dialogWidth=650px;dialogHeight=580px");
  }
}
	
	
</script>
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

<%! public String convHora(float minutos)
{	
	Float aux = new Float(minutos);
	int hora_aux = aux.intValue();
	String total = "";
	int hora = hora_aux / 60;
	int min  = hora_aux % 60;
	if(min < 10)
		total = hora + ":0" + min;
	else
		total = hora + ":" + min;
	return total;
}
%>

<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../art/onenglish.gif','../art/onespanol.gif')">
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
	      	      if(ponto.equals("..")){
              %>
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
                <%
                String oi = "", oia = "", sigla = "";
				//parametro para o submenu ficar selecionado//
				if (origem.equals("result_filtro"))
					sigla = "E";
				else
					sigla = "S";
				/////////////////////////////////////////////
                if(ponto.equals("..")){
					if (request.getParameter("op") == null)
						oi = "../menu/menu.jsp?op="+"S";
					else
						oi = "../menu/menu.jsp?op="+request.getParameter("op");
					if (request.getParameter("opt") == null)
						oia = "../menu/menu1.jsp?opt="+sigla+"&op=S";
					else
						oia = "../menu/menu1.jsp?opt="+request.getParameter("opt")+"&op=S";
				}
				else{
					if (request.getParameter("op") == null)
						oi = "/menu/menu.jsp?op="+"S";
					else
						oi = "/menu/menu.jsp?op="+request.getParameter("op");
					if (request.getParameter("opt") == null)
						oia = "/menu/menu1.jsp?opt="+sigla+"&op=S";
					else
						oia = "/menu/menu1.jsp?opt="+request.getParameter("opt")+"&op=S";
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
				<%
				  String Msg = "";
				  if (origem.equals("prerequisitos")){
                    Msg = "PRE-REQUISITOS";
                  }

                  if (origem.equals("result_solics")){
                    Msg = "ALTERACAO DA SOLICITACAO";
                  }

                  if (origem.equals("porcompetencias")){
                    Msg = "POR COMPETENCIAS";
                  } 
      
                  if (origem.equals("reprogramacao")){
                    Msg = "REPROGRAMACAO";
                  }

                  if (origem.equals("result_filtro")){
                    Msg = "SOLICITACAO EXTRA";
                  }
				%>
                <td class="trontrk" width="297" align="center"><%=trd.Traduz(Msg)%></td>
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
		  <FORM name = "frm" method="POST">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                  <td height="20" class="ftverdanacinza" align="center"> 
                    <table border="0" cellspacing="2" cellpadding="2" width="80%">
                      <tr> 
                        <td width="16%" class="ftverdanacinza" align="right" ><%=trd.Traduz("ASSUNTO")%>:</td>
                        <td colspan=3> 
						<%if (origem.equals("prerequisitos")){%>
                          <select name="selectass" disabled class="form" onChange="return assunto();">
                                                <%}
                                                else if (origem.equals("porcompetencias")){%>
                          <select name="selectass" disabled class="form" onChange="return assunto();">
						<%}else{%>
                          <select name="selectass" class="form" onChange="return assunto();">
						<%}%>
                       <%  
		       query = "SELECT ASS_CODIGO, ASS_NOME FROM ASSUNTO WHERE ASS_ATIVO = 'S' ";
				
		       if ((origem.equals("porcompetencias")) || (origem.equals("planosussessorio"))){
                           query_comp = " AND ASS_CODIGO IN (SELECT ASS_CODIGO FROM TITULO WHERE TIT_CODIGO IN (SELECT DISTINCT TIT_CODIGO FROM CURSO WHERE CUR_CODIGO IN (SELECT DISTINCT CUR_CODIGO FROM CURSOCOMP WHERE CMP_CODIGO = " + compt +  ")))";
                       }
                       else
                       {
                           query_comp = "";
		       }
                       query = query + query_comp + " ORDER BY ASS_NOME";
                        
                           if ((!(cur.equals("-1"))) && (!(cur.equals("Selecione")))){
                           query_tit = "SELECT ASS_CODIGO FROM TITULO " + 
                               "WHERE TIT_CODIGO IN (SELECT TIT_CODIGO FROM CURSO WHERE CUR_CODIGO = " + cur + ") ";                              

                              rs = conexao.executaConsulta(query_tit, session.getId()+"RS2"); 
                              if (rs.next()){
                                  ass = rs.getString(1);
			      }
                               
                              if(rs != null){
                                  rs.close();
                                  conexao.finalizaConexao(session.getId()+"RS2");
                              }

                           }

                           if ((!(tit.equals("-1"))) && (!(tit.equals("Selecione")))){
                           query_ass = "SELECT ASS_CODIGO FROM TITULO " + "WHERE TIT_CODIGO = " + tit + " ";

                              rs = conexao.executaConsulta(query_ass,session.getId()+"RS3");
                              if (rs.next()){
                                  ass = rs.getString(1);
	                      }
                               
                              if(rs != null){
                                  rs.close();
                                  conexao.finalizaConexao(session.getId()+"RS3");
                              }
                               
                           }

                           rs = conexao.executaConsulta(query, session.getId()+"RS4");
                           if (rs.next()) {
                               if (request.getParameter("selectass") != null) {
			           if (((cur.equals("-1")) && (cur.equals("Selecione"))) || ((tit.equals("-1")) && (tit.equals("Selecione")))){
                                       ass = request.getParameter("selectass");
				   }
                               }                                
                           %>
                             <option value = "Selecione" selected><%=trd.Traduz("Selecione")%></option>  
                           <%

                               do{
                                   if (ass.equals(rs.getString(1))) {%>
                                       <option value = "<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>  
                                   <%
				   } 
                                   else 
                                   {%>
                                       <option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>  
                                 <%}
                                 }
                               while (rs.next());
		           }

                           if(rs != null){
                               rs.close();
                               conexao.finalizaConexao(session.getId()+"RS4");
                           }

			   %>
                          </select>
                        </td>
                      </tr>
                      <tr>  
                        <td width="16%" class="ftverdanacinza" align="right"><%=trd.Traduz("TITULO")%>:</td>
                        <td colspan=3> 
						<%if (origem.equals("prerequisitos")){%>
                          <select name="selecttit" disabled class="form" onChange="return titulo();">
                                                <%}
                                                else if (origem.equals("porcompetencias")){%>
                          <select name="selecttit" disabled class="form" onChange="return titulo();">
						<%}else{%>
                          <select name="selecttit" class="form" onChange="return titulo();">
						<%}%>
                       <%
					  if ((!(ass.equals("-1"))) && (!(ass.equals("Selecione")))){
                       query = "SELECT TIT_CODIGO, TIT_NOME FROM TITULO " + 
                               "WHERE TIT_ATIVO = 'S' AND ASS_CODIGO = " + ass + " ";


				          if ((origem.equals("porcompetencias")) || (origem.equals("planosussessorio"))){
                             query_comp = " AND TIT_CODIGO IN (SELECT DISTINCT TIT_CODIGO FROM CURSO WHERE CUR_CODIGO IN (SELECT DISTINCT CUR_CODIGO FROM CURSOCOMP WHERE CMP_CODIGO = " + compt +  "))";
					        }
							else
				            {
                              query_comp = "";
				            }

					   query = query + query_comp + " ORDER BY TIT_NOME";


			           }
					   else
					   {

						query = "SELECT TIT_CODIGO, TIT_NOME FROM TITULO " + 
                               "WHERE TIT_ATIVO = 'S' ";
						
					        if ((origem.equals("porcompetencias")) || (origem.equals("planosussessorio"))){
                             query_comp = " AND TIT_CODIGO IN (SELECT DISTINCT TIT_CODIGO FROM CURSO WHERE CUR_CODIGO IN (SELECT DISTINCT CUR_CODIGO FROM CURSOCOMP WHERE CMP_CODIGO = " + compt + "))";
					        }
							else
				            {
                              query_comp = "";
				            }

					   query = query + query_comp + " ORDER BY TIT_NOME";
						
					   }

                       
                           if ((!(cur.equals("-1"))) && (!(cur.equals("Selecione")))){
                              query_cur = "SELECT TIT_CODIGO FROM CURSO " + 
                              "WHERE CUR_CODIGO = " + cur + " ";
                               

                              rs = conexao.executaConsulta(query_cur, session.getId()+"RS5");
                              if (rs.next()){
                                  tit = rs.getString(1);
			      }

                              if(rs != null){
                                 rs.close();
                                 conexao.finalizaConexao(session.getId()+"RS5");
                              }

		           }

                           %>
                             <option value = "Selecione" selected><%=trd.Traduz("Selecione")%></option>  
                           <%

                       rs = conexao.executaConsulta(query, session.getId()+"RS6"); 
                       if (rs.next()){
                             if (request.getParameter("selecttit") != null){
		                     if (!(request.getParameter("selecttit").equals("Selecione"))){
                                         tit = request.getParameter("selecttit");
				     }
				     else
				     {
                                         if ((cur.equals("-1")) && (cur.equals("Selecione"))){
					     tit = "-1";//rs.getString(1); 
					 }
				     }
                             } 
			     else 
			     {
                                 if ((cur.equals("-1")) && (cur.equals("Selecione"))){
			                 tit = "-1";//rs.getString(1); 
				 }
	                     } 
                         
			     do{
                                 if (tit.equals(rs.getString(1))){%>
					         <option value = "<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option> 
                               <%}
                                 else
                                 {%>					  
                                                 <option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>  
                               <%}


		             }while (rs.next());
		       }

                       if(rs != null){
                          rs.close();
                          conexao.finalizaConexao(session.getId()+"RS6");
                       }

                          %>
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td width="16%" class="ftverdanacinza" align="right"><%=trd.Traduz("CURSO")%>:</td>
                        <td colspan=3> 
                          <select name="selectcur" class="form" onChange="return curso();">
                       <%							      
                       if ((!(tit.equals("-1"))) && (!(tit.equals("Selecione")))){
					        if ((origem.equals("porcompetencias")) || (origem.equals("planosussessorio"))){
                                                                query = "SELECT CUR_CODIGO, CUR_NOME FROM CURSO WHERE CUR_ATIVO = 'S' AND CUR_SIMPLES = 'N' ";
								query_comp = " AND CUR_CODIGO IN (SELECT DISTINCT CUR_CODIGO FROM CURSOCOMP WHERE CMP_CODIGO = " + compt +") ";

					        }
						else
				                {               query = "SELECT CUR_CODIGO, CUR_NOME FROM CURSO " +
                                                                " WHERE CUR_ATIVO = 'S' AND TIT_CODIGO = " + tit + " " + 
                                                                " AND CUR_SIMPLES = 'N' ";
                                                                query_comp = "";
				                }

					   query = query + query_comp + " ORDER BY CUR_NOME";

			           }
			           else
				   {

						   if ((!(ass.equals("-1"))) && (!(ass.equals("Selecione")))){                                                       
							   
                                                        if ((origem.equals("porcompetencias")) || (origem.equals("planosussessorio"))){
                                                                query = "SELECT CUR_CODIGO, CUR_NOME FROM CURSO " +
                                                                "WHERE CUR_ATIVO = 'S' AND CUR_SIMPLES = 'N' ";
								query_comp = " AND CUR_CODIGO IN (SELECT DISTINCT CUR_CODIGO FROM CURSOCOMP WHERE CMP_CODIGO = " + compt +") ";

					                }
						        else
				                        {
                                                                query = "SELECT CUR_CODIGO, CUR_NOME FROM CURSO " + 
                                                                "WHERE CUR_ATIVO = 'S' AND CUR_SIMPLES = 'N' AND TIT_CODIGO IN (SELECT TIT_CODIGO FROM TITULO WHERE ASS_CODIGO = " + ass + ") ";
                                                                query_comp = "";
				                        }

					                query = query + query_comp + " ORDER BY CUR_NOME";

						   }
						   else
						   {
	
                                                         query = "SELECT CUR_CODIGO, CUR_NOME FROM CURSO " +
                                                         "WHERE CUR_ATIVO = 'S' AND CUR_SIMPLES = 'N' ";
							   
							 if ((origem.equals("porcompetencias")) || (origem.equals("planosussessorio"))){
								query_comp = " AND CUR_CODIGO IN (SELECT DISTINCT CUR_CODIGO FROM CURSOCOMP WHERE CMP_CODIGO = " + compt +") ";

					                 }
							 else
				                         {
                                                                query_comp = "";
				                         }
							   
                                                         query = query + query_comp + " ORDER BY CUR_NOME";
						   }
				   }

                           %>
                             <option value = "Selecione" selected><%=trd.Traduz("Selecione")%></option>  
                           <%                      
                       
                       rs = conexao.executaConsulta(query, session.getId()+"RS7");
                       if (rs.next()) {
                         do {
			   if (request.getParameter("selectcur") != null) {
				   		     if (!(request.getParameter("selectcur").equals("Selecione")))
							 {
                                  cur = request.getParameter("selectcur");
							 }
							   else
							 {
								  cur = "-1";//rs.getString(1); 
							 }
                           } else {
                             //if (cur == "-1")
        			       cur = "-1";//rs.getString(1);
		                   }
			   if (cur.equals(rs.getString(1))) {%>				
                             <option value = "<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option> 
	                   <%} else {%>
                              <option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>  
                           <%}
                          }
                          while (rs.next()); }
                          
                          if(rs != null){
                              rs.close();
                              conexao.finalizaConexao(session.getId()+"RS7");
                          }                          
                          %>
                          </select>
                          &nbsp;<input class="botcin" type="button" OnClick="return descricao();" value=<%=("\""+trd.Traduz("VISUALIZAR DESCRICAO")+"\"")%> />
                        </td>
                      </tr>
                      <tr> 
                           <%
                             query = "SELECT  TUR_CODIGO, TUR_DATAINICIO, TUR_DATAFINAL " +
                                     "FROM TURMA WHERE TUR_PLANEJADA = 'S' " + " " + 
		                     "AND (TUR_REGISTRADA = 'N' OR TUR_REGISTRADA = NULL) " + 
                                     "AND CUR_CODIGO = " + cur + " ORDER BY TUR_DATAINICIO";

                    rs = conexao.executaConsulta(query,session.getId()+"RS8");
                    if (rs.next()){%>
                        <td width="16%" class="ftverdanacinza" align="right"><%=trd.Traduz("TURMAS")%>:</td>
                        <td colspan=3> 
                          <select name="selecttur">
                                <option value="-1"><%=trd.Traduz("Selecione")%></option>
			     <%do {%>
                                  <option value="<%=rs.getInt(1)%>"><%=rs.getDate(2)%>&nbsp;|&nbsp;<%=rs.getDate(3)%></option>
                             <%} 					   
                               while (rs.next());
					%>     </select> <%
                    }
                    if(rs != null){
                         rs.close();
                         conexao.finalizaConexao(session.getId()+"RS8");
                    }
                    %>
                     
                        </td>
                      </tr>
                      <tr> 
                        <td width="16%" class="ftverdanacinza" align="right">&nbsp;</td>
                        <td colspan="2">&nbsp;<br>
                          <span class="ftverdanapreto"> <%=trd.Traduz("RESULTADOS ESPERADOS")%>:</span><br>
                          <%                                              
						  if (operacao.equals("U"))
						  {
							  String queryRes = "SELECT TEF_RESULTADOESPERADO FROM TREINAMENTO WHERE TEF_CODIGO = " + funcvet.elementAt(0);

                            rsRes = conexao.executaConsulta(queryRes,session.getId()+"RS9");
                            if(rsRes.next())
                            {
                          	%>
                          <textarea name="tf_result" rows="8" cols="45"><%=rsRes.getString(1)%></textarea>
                          <%}
						     else
							 {%>
                             <textarea name="tf_result" rows="8" cols="45"></textarea>
						   <%}
						  }
						  else
	                      {
						  %>
                          <textarea name="tf_result" rows="8" cols="45"></textarea>
						<%}
                             if(rs != null){
                                 rs.close();
                                 conexao.finalizaConexao(session.getId()+"RS9");
                             }
                             %>
                        </td>
                        <td width="30%"> 
                          <table cellpadding="3" width="280" cellspacing="0">
                            <tr> 
                      <td class="celtittabcin"> <%=trd.Traduz("COMPETENCIAS BUSCADAS")%>: 
                      <p> 
                      <% query = "SELECT COMPETENCIA.CMP_CODIGO, COMPETENCIA.CMP_DESCRICAO " +
                                 "FROM CURSOCOMP, COMPETENCIA " +
                                 "WHERE CURSOCOMP.CMP_CODIGO = COMPETENCIA.CMP_CODIGO AND " +
                                 "CURSOCOMP.CUR_CODIGO = " + cur + " " +
                                 "ORDER BY COMPETENCIA.CMP_DESCRICAO";
						 String comp = "";
                         rs = conexao.executaConsulta(query, session.getId()+"RS10");

                         int j = 1;
                         if (rs.next()) {
                           do {
                             comp = rs.getString(1);%>
                             <input type="checkbox" name="checkbox<%=j%>"  value="<%=rs.getInt(1)%>" checked>
                             <%=rs.getString(2)%><br>
                             <%j++;}
                           while (rs.next());
			 }
                         if(rs != null){
                              rs.close();
                              conexao.finalizaConexao(session.getId()+"RS10");
                         }
                         %>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 

                      <%
                      query = "SELECT CUR_CODIGO, CUR_CUSTO, CUR_CUSTO2, CUR_DURACAO " +
                              "FROM CURSO WHERE CUR_CODIGO = " + cur + " ";
                      rs = conexao.executaConsulta(query, session.getId()+"RS11");
                      %>
                        <td width="16%" class="ftverdanacinza" align="right"><%=trd.Traduz("CUSTO CURSO")%>:</td>
                        <td width="27%" class="cttit"> 

                       <% String Dur = "";
			  String Cus1 = "", Cus2 = "";
			  float  Cust = 0;

			  if (rs.next()) {
                            Dur=rs.getString(4);
                            Cus1=rs.getString(2);
			    Cus2=rs.getString(3);
			    Cust = (rs.getFloat(2) + rs.getFloat(3));                            
							%>				   

                            <%=ReaistoStr(rs.getFloat(2),moeda)%>
			    <input type="hidden" name="cus1" value = "<%=Cus1%>">
			    <input type="hidden" name="cus2" value = "<%=Cus2%>">
			    <input type="hidden" name="dur" value = "<%=Dur%>">
                            <input type="hidden" name="extra" value = "<%=extra%>">
			    <input type="hidden" name="fun_codigo" value = "<%=fun_codigo%>">
                            </td>
                            <%
                        String qbra = "-1";
					if (operacao.equals("U"))
					{
                        String queryP = 	"SELECT QBR_CODIGO "+
						"FROM TREINAMENTO "+
						"WHERE TEF_CODIGO = " + funcvet.elementAt(0) ;
                         rsP = conexao.executaConsulta(queryP, session.getId()+"RS12");
                         if (rsP.next()){
							qbra = rsP.getString(1); 
			 }
                         if(rsP != null){
                              rsP.close();
                              conexao.finalizaConexao(session.getId()+"RS12");
                         }
                          
					}

                              query = "SELECT QBR_CODIGO, QBR_NOME FROM QUEBRA " +
                                      "WHERE PER_CODIGO IN " +
                                      "(SELECT PER_CODIGO FROM PLANO WHERE PLA_CODIGO = " + usu_plano + ") " +
                                      "ORDER BY QBR_ORDEM";
                              rsq = conexao.executaConsulta(query, session.getId()+"RS13");
				%>
                        <td width="27%" class="ftverdanacinza" align="right"><%=trd.Traduz("PREVISAO")%>:</td>
                        <td width="30%"> 
                          <select name="selectprev">

                             <option value = "Selecione" selected><%=trd.Traduz("Selecione")%></option>  
						   
                           <%if (rsq.next()) {
                           do 
						   {
							   if (qbra.equals(rsq.getString(1)))
							   {%>
								<option value="<%=rsq.getString(1)%>" selected><%=rsq.getString(2)%></option>
							   <%}
							   else
							   {
							   %>
                                <option value="<%=rsq.getString(1)%>"><%=rsq.getString(2)%></option>
							  <%}
                           }
                           while (rsq.next());
			 }
                         if(rsq != null){
                              rsq.close();
                              conexao.finalizaConexao(session.getId()+"RS13");
                         }
                         %>

                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td width="16%" class="ftverdanacinza" align="right"><%=trd.Traduz("CUSTO LOGISTICA")%>:</td>
                        <td width="27%" class="cttit"> 
                          <%=ReaistoStr(rs.getFloat(3),moeda)%>
                          </td>
                        <td width="27%" class="ftverdanacinza" align="right"><%=trd.Traduz("DURACAO")%>:</td>
                        <td width="30%" class="cttit"> 
                          <%=convHora(rs.getFloat(4))%>
                        </td>
                      </tr>
                      <tr> 
                        <td width="16%" class="ftverdanacinza" align="right"><%=trd.Traduz("CUSTO TOTAL")%>:</td>
                        <td width="27%" class="cttit"> 
                          <%=ReaistoStr((rs.getFloat(2) + rs.getFloat(3)),moeda)%>
                        </td>
			<%}

                        if(rs != null){
                              rs.close();
                              conexao.finalizaConexao(session.getId()+"RS11");
                         }

			if (origem.equals("result_filtro")){
				if (tamv == 1)
				{%>
                          <td colspan="2" class="ftverdanacinza" align="right"> 
                          <input type="checkbox" name="checkboxcargo" value="checkbox"> <%=trd.Traduz("SOLICITAR A TODOS DO MESMO CARGO")%> &nbsp; &nbsp;&nbsp;</td>
			<%  }
			}			
			%>
                      </tr>
                      <tr> 
                        <td colspan="4" class="ftverdanacinza" align="center">&nbsp;<br>
			<input type="button" onClick="return envia();" value=<%=("\""+trd.Traduz("CONFIRMAR")+"\"")%> class="botcin" name="button">&nbsp;
                        <input type="button" onClick="return cancela();" value=<%=("\""+trd.Traduz("CANCELAR")+"\"")%> class="botcin" name="buttoncancel"></td>
                      </tr>
                    </table>
                  </td>
              </tr>
              <tr> 
                  <td height="15"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                  <td>&nbsp;</td>
              </tr>
            </table>
          </td>
            <input type="hidden" name="extra" value="<%=extra%>">
            <input type="hidden" name="origem" value="<%=origem%>">
            <input type="hidden" name="operacao" value="<%=operacao%>">
            <input type="hidden" name="func_codigo" value="<%=fun_codigo%>">
            <input type="hidden" name="fun_codigo" value="<%=fun_codigo%>">
            <input type="hidden" name="fun_codigotef" value="<%=str_func%>">
            <input type="hidden" name="contador" value="<%=contador%>">
            <input type="hidden" name="compt" value="<%=compt%>">
            <input type="hidden" name="reloaded" value="ok">
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
          <td> 
          <%    if(ponto.equals("..")){%>
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
<!--<script language="JavaScript1.2" src="HM_Loader.js" type='text/JavaScript'></script>-->
</body>
</html>
<%
session.setAttribute("funcs", funcvet);	

//out.println("fun_codigo = " + fun_codigo);

//out.println("query_curso = " + query_curso);

//} catch (Exception r) {
//  out.println(r);  
//}
%>