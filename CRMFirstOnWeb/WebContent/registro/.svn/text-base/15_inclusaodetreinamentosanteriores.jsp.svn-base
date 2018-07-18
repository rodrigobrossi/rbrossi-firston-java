<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1"))
    response.setHeader("Cache-Control", "no-cache");
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.lang.Math.*, java.util.*, java.text.*"%>

<%
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");

String usu_tipo		= (String) session.getAttribute("usu_tipo"); 
String usu_nome 	= (String) session.getAttribute("usu_nome"); 
String usu_login	= (String) session.getAttribute("usu_login"); 
Integer usu_fil		= (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi		= (Integer)session.getAttribute("usu_idi"); 

String nome			= (String) request.getParameter("fun_nome");

//recupera variaveis da pagina
String ass          = (request.getParameter("cboassunto")==null)?"":request.getParameter("cboassunto");
String pag_dtinic   = (request.getParameter("dtinicio")==null)?"":request.getParameter("dtinicio");
String pag_dtfim    = (request.getParameter("dtfim")==null)?"":request.getParameter("dtfim");
String pag_entidade = (request.getParameter("cboentidade")==null)?"":request.getParameter("cboentidade");
String pag_custo    = (request.getParameter("custo")==null)?"":request.getParameter("custo");
String pag_durh     = (request.getParameter("duracao")==null)?"":request.getParameter("duracao");
String pag_durm     = (request.getParameter("duracao2")==null)?"":request.getParameter("duracao2");
String pag_obs      = (request.getParameter("observacao")==null)?"":request.getParameter("observacao");

String pag_saratoga = "";
String moeda = prm.buscaparam("MOEDA");

//variaveis de banco
String query="", query_cur = "", query_tit = "", query_ass = "";
ResultSet rs = null;

//TESTE VETOR DADOS
//Busca e Insere dados no vetor de funcionArios selecionados
int pag = Integer.parseInt((String)session.getAttribute("pagina"));
String n = "";
Vector functemp = new Vector();
functemp = (Vector)session.getAttribute("funcs");

//insere os elementos no vetor
for(int k=1 ; k<=pag;k++) {
    if (!(request.getParameter("checkbox" + n.valueOf(k)) == null)) {
        //out.println(request.getParameter("checkbox" + n.valueOf(k)));
            if (!(functemp.contains(request.getParameter("checkbox" + n.valueOf(k)))))
                functemp.add(request.getParameter("checkbox" + n.valueOf(k)));
    }
}
session.setAttribute("funcs",functemp);

//try {

if (functemp.size() == 0) {%>
<script language="JavaScript">
  alert(<%=("\""+trd.Traduz("NENHUM ITEM SELECIONADO")+"\"")%>);
  window.open("14_lancamentosanteriores.jsp", "_parent");
</script>
<%}
%>

<script language="JavaScript">
function ok(){
	var data1 = document.frm.dtinicio.value; //data inicial da tela
	var data2 = document.frm.dtfim.value; //data final da tela
	i1=0; i2=0;
	while(i1<data1.length){
	    i1++;
	}
	while(i2<data2.length){
	    i2++;
	}
	if(data1.length==9)
	    data1 ="0"+data1;
	if(data2.length==9)
	    data2 ="0"+data2;
	var dia1 = data1.substring(0,2);
	var dia2 = data2.substring(0,2);
	var mes1 = data1.substring(3,5);
	var mes2 = data2.substring(3,5);
	var ano1 = data1.substring(6,10);
	var ano2 = data2.substring(6,10);

	if(frm.txt_curso.value == ""){
		alert(<%=("\""+trd.Traduz("O CAMPO CURSO DEVE SER PREENCHIDO")+"\"")%>); 
		return true; 
	}
	else if (frm.cboassunto.value == "") {
		alert(<%=("\""+trd.Traduz("SELECIONE UM ASSUNTO")+"\"")%>); 
		return true; 
	}
	else if (frm.dtinicio.value == "") {
		alert(<%=("\""+trd.Traduz("O CAMPO DATA INICIAL DEVE SER PREENCHIDO")+"\"")%>); 
		return true; 
	}
	else if (frm.dtfim.value == "") {
		alert(<%=("\""+trd.Traduz("O CAMPO DATA FINAL DEVE SER PREENCHIDO")+"\"")%>); 
		return true; 
	}
	else if (frm.duracao.value == "" || frm.duracao2.value == "") {
		alert(<%=("\""+trd.Traduz("O CAMPO DURACAO DEVE SER PREENCHIDO")+"\"")%>); 
		return true; 
	}
	else if (frm.cboentidade.value == "") {
		alert(<%=("\""+trd.Traduz("SELECIONE UMA ENTIDADE")+"\"")%>); 
		return true; 
	}
	else if (frm.sel_saratoga.value == "") {
		alert(<%=("\""+trd.Traduz("SELECIONE UMA SARATOGA")+"\"")%>); 
		return true; 
	}
	else if (frm.sel_tipo.value == "") {
		alert(<%=("\""+trd.Traduz("SELECIONE UM TIPO")+"\"")%>); 
		return true; 
	}
	else if (frm.custo.value == "") {
		alert(<%=("\""+trd.Traduz("O CAMPO CUSTO DEVE SER PREENCHIDO")+"\"")%>); 
		return true; 
	}
	else if(ano1>ano2) {
		alert(<%=("\""+trd.Traduz("A data final nAo pode ser menor que a data de inicial")+"\"")%>);
		document.frm.dtfim.value="";
		document.frm.dtfim.focus();
		return false;	
	}
	else if(ano1==ano2) {
		if (mes1>mes2) {
			alert(<%=("\""+trd.Traduz("A data final nAo pode ser menor que a data de inicial")+"\"")%>);
			document.frm.dtfim.value="";
			document.frm.dtfim.focus();
			return false;	
		}
		else if(mes1==mes2) { 
			if(dia1>dia2) {	
				alert(<%=("\""+trd.Traduz("A data final nAo pode ser menor que a data de inicial")+"\"")%>);
				document.frm.dtfim.value="";
				document.frm.dtfim.focus();
				return false;	
			}
		}
	}
	frm.action ="16_lancamentosanteriores_return.jsp";
	frm.submit();
	return false;	
}
    
function cancela()
        {
        frm.action ="14_lancamentosanteriores.jsp";
	frm.submit();
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
			} else {
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
	} else {
                alert(<%=("\""+trd.Traduz("INTERNET EXPLORER 4.0 OU SUPERIOR E NECESSARIO")+"\"")%>)
        }
}
function FormataCampo(campo, evento, direcao) {
    //alert(evento);
    aux = campo.value;
    aux = aux.length;
    aux = aux - 1;
    pal = campo.value;
	if (campo.value.length < 1000000){
		if(evento != 9 ){//tab
			if(evento != 8 && evento != 46 && evento != 16 && !(evento > 36 && evento < 41) && evento!=190 && evento!=110 && evento!=194){ //delete, backspace, shift nAo causam evento
				var tam = campo.value.length
				if ((evento >= 48 && evento <= 57) || (evento >= 96 && evento <= 105)){
					if (tam == 2 || tam == 5){
						campo.value = campo.value + "";
					}
				}
				else{
					if (direcao == "up"){
						if (campo.value.length == 0){
                                                        //campo.value = pal.substring(0, aux);
							campo.value = ""
						}
						else{
                                                        //campo.value = pal.substring(0, aux);
							campo.value = "";//campo.value.substring(0,campo.value.length-1)
						}
					}
				}
				campo.focus()
			}
			else if(evento == 16){
                //campo.value = pal.substring(0, aux);
				campo.value="";
			}

		} 
		else{
			if (direcao == "down"){
				var teste = campo.value.substring(0,1);
				if(campo.value<0){
					alert(<%=("\""+trd.Traduz("Este campo nAo aceita valores negativos !")+"\"")%>);
                                        //campo.value = pal.substring(0, aux);
					campo.value="";
					campo.focus();
					return false;
				}
				else if(teste=="-"||teste=="+"||teste=="~"||teste=="^"||
					teste=="\""||teste=="'"||teste=="!"||teste=="@"||
					teste=="#"||teste=="$"||teste=="%"||teste=="¨"||
					teste=="&"||teste=="*"||teste=="("||teste==")"||
					teste=="_"||teste=="="||teste=="~"||teste=="`"||
					teste=="´"||teste=="{"||teste=="["||teste=="}"||
					teste=="]"||teste=="<"||
					teste==">"||teste==":"||teste==";"||teste=="/"||
					teste=="?"||teste=="|"||teste=="\\"||teste=="^"){
					alert(<%=("\""+trd.Traduz("Este campo nAo aceita caracteres especiais !")+"\"")%>);
                    //campo.value = pal.substring(0, aux);
					campo.value="";
					campo.focus();
					return false;
				}
			}
		}
	}
	//formataReal(campo);
}

function duracao01(campo){
	aux = campo.value;
	tam = aux.length
	aux2 = aux.substring(tam-1,tam);
	if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" && aux2 != "4" &&
	   aux2 != "5" && aux2 != "6" && aux2 != "7" && aux2 != "8" && aux2 != "9"){
		aux = campo.value;
		aux = aux.length;
		aux = aux - 1;
		pal = campo.value;
		campo.value = pal.substring(0, aux);
	}

}
function duracao02(campo){
	aux = campo.value;
	tam = aux.length;
	i = 0;
	nova = "";
	while(i != tam){
		aux2 = aux.substring(i,i+1);
		if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" && aux2 != "4" &&
	   		aux2 != "5" && aux2 != "6" && aux2 != "7" && aux2 != "8" && aux2 != "9"){
			nova = nova;
		}
		else{
			nova = nova + aux2;
		}
		i++;
		
	}
	campo.value = nova;
}

function numero(campo){
	aux = campo.value;
	tam = aux.length
	aux2 = aux.substring(tam-1,tam);
	if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" && aux2 != "4" && aux2 != "," &&
	   aux2 != "5" && aux2 != "6" && aux2 != "7" && aux2 != "8" && aux2 != "9"){
		aux = campo.value;
		aux = aux.length;
		aux = aux - 1;
		pal = campo.value;
		campo.value = pal.substring(0, aux);
	}
}

function numero2(campo){
	aux = campo.value;
	tam = aux.length;
	k = 0;
	v = 0;
	if(tam == 1){
		aux2 = aux.substring(tam-1,tam);
		if(aux2 == ","){
			campo.value = "";
		}
	}
	while(tam>0){
		aux2 = aux.substring(tam-1,tam);
		if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" && aux2 != "4" && aux2 != "," &&
		   aux2 != "5" && aux2 != "6" && aux2 != "7" && aux2 != "8" && aux2 != "9"){
			k = k+1;
		}
		if(aux2 == ","){
			v = v + 1;
		}
		tam--;
	}
	if(k != 0 || v > 1){
		alert(<%=("\""+trd.Traduz("FORMATO INVALIDO")+"\"")%>);
		campo.value = "";
		campo.focus();
	}
	soma();
}

function soma() {
    if(frm.custo.value != ""){
    	aux = frm.custo.value;
	    tam = aux.length;
	    var nova = "";
	    for(i=0;i<tam;i++){
	    	aux2 = aux.charAt(i);
	    	if(aux2 == ","){
	    		aux2 = ".";
	    		nova = nova + aux2;
	    	}
	    	else if(aux2 == "."){
	    		nova = nova;
	    	}
	    	else{
	    		nova = nova + aux2;
	    	}
	    }
		var c1 = nova;
    }
    else{
    	var c1 = 0;
    }
	if(frm.custo_log.value != ""){
		aux = frm.custo_log.value;
    	tam = aux.length;
    	var nova = "";
    	for(i=0;i<tam;i++){
    		aux2 = aux.charAt(i);
    		if(aux2 == ","){
    			aux2 = ".";
    			nova = nova + aux2;
    		}
    		else if(aux2 == "."){
    			nova = nova;
    		}
    		else{
    			nova = nova + aux2;
    		}
    	}
		var c2 = nova;	
	}
	else{
		var c2 = 0;
	}
	
    var total = eval(c1+"+"+c2);
    
    frm.custo_tot.value = total;
    aux = frm.custo_tot.value;
    tam = aux.length;
    var nova = "";
    for(i=0;i<tam;i++){
    	aux2 = aux.charAt(i);
    	if(aux2 == "."){
	   		aux2 = ",";
    		nova = nova + aux2 + aux.charAt(i+1) + aux.charAt(i+2);
    		i = tam;
    	}
    	else{
    		nova = nova + aux2;
    	}
    }
    frm.custo_tot.value = nova;
}

function aspa(campo){
	aux = campo.value;
	tam = aux.length
	aux2 = aux.substring(tam-1,tam);
	if(aux2 == "\"" || aux2 == "\'"){
		aux = campo.value;
		aux = aux.length;
		aux = aux - 1;
		pal = campo.value;
		campo.value = pal.substring(0, aux);
	}
}

function aspa2(campo){
	aux = campo.value;
	tam = aux.length;
	i = 0;
	nova = "";
	while(i != tam){
		aux2 = aux.substring(i,i+1);
		if(aux2 == "\"" || aux2 == "\'")
			nova = nova;
		else
			nova = nova + aux2;
		i++;
		
	}
	campo.value = nova;
}

</script>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Registro")%> - <%=trd.Traduz("InclusAo de Treinamentos Anteriores")%></title>
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
<%    	      String ponto = (String)session.getAttribute("barra");
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
                  oia = "../menu/menu1.jsp?opt="+"LA";
				} 
				else
				{  
                  oia = "../menu/menu1.jsp?opt="+request.getParameter("opt");
				}
		} else {
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
		                  oia = "/menu/menu1.jsp?opt="+"LA";
						} 
						else
						{  
		                  oia = "/menu/menu1.jsp?opt="+request.getParameter("opt");
				}
		}%>
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
                <td class="trontrk" align="center"><%=trd.Traduz("INCLUSAO DE TREINAMENTOS ANTERIORES")%></td>
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
	  <FORM name="frm" method="post">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1">&nbsp;<br><center>
                <table border="0" cellspacing="2" cellpadding="2" width="100%">
                  <tr> 
                    <td class="ftverdanacinza" align="right" height="30"><%=trd.Traduz("CURSO")%>:</td>
                    <td class="ftverdanacinza">
                    <input type="text" name="txt_curso" size="65" onKeyUp="aspa(this)" onBlur="aspa2(this)">
                    </td>
                  </tr>
                  <tr> 
                    <td class="ftverdanacinza" align="right" height="30"><%=trd.Traduz("ASSUNTO")%>:</td>
                    <td class="ftverdanacinza"> 
                      <select name="cboassunto">
                        <option value="" selected><%=trd.Traduz("Selecione")%></option>
             <%

                        query = "SELECT DISTINCT A.ASS_CODIGO, A.ASS_NOME FROM ASSUNTO A, TITULO T " +
                                "WHERE A.ASS_ATIVO = 'S' AND A.ASS_CODIGO = T.ASS_CODIGO ORDER BY ASS_NOME";


                   		rs = conexao.executaConsulta(query,session.getId()+"RS1");
                   
                   		if (rs.next()) {
                            do {
                                if (rs.getString(1).equals(ass)) {%>
                                 <option value = "<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
<%                              } else {%>
                                 <option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                              }
                            } while (rs.next());
                        }
                        if(rs != null){
                           rs.close();
                           conexao.finalizaConexao(session.getId()+"RS1");
                        }                        
%>
                    </select>
                    </td>
                  </tr>
                  <tr>
                     <td class="ftverdanacinza" align="right" height="30"><%=trd.Traduz("Data Inicial")%>:</td>
                    <td class="ftverdanacinza"> 
                      <input type="text" name="dtinicio" value="<%=pag_dtinic%>" size="9" onChange="ChecaData(this)" onKeyDown="FormataData(this, window.event.keyCode,'down')" onKeyUp="FormataData(this, window.event.keyCode,'up')">
                      &nbsp;<img onclick="DoCal(dtinicio)" style="cursor:hand" src="../art/icon_cal.gif" title="CalendArio" WIDTH="17" HEIGHT="16"> 
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <%=trd.Traduz("Data Final")%>:
                      <input type="text" name="dtfim" size="9" value="<%=pag_dtfim%>" onChange="ChecaData(this)" onKeyDown="FormataData(this, window.event.keyCode,'down')" onKeyUp="FormataData(this, window.event.keyCode,'up')">
                      &nbsp;<img onclick="DoCal(dtfim)" style="cursor:hand" src="../art/icon_cal.gif" title="CalendArio" WIDTH="17" HEIGHT="16"> 
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  	<%=trd.Traduz("DURACAO")%>:
                      <input type="text" name="duracao" size="2" maxlength="3" value="<%=pag_durh%>" onBlur="duracao02(this)" onKeyUp="duracao01(this)">:
                      <input type="text" name="duracao2" size="2" maxlength="2" value="<%=pag_durm%>" onBlur="duracao02(this)" onKeyUp="duracao01(this)"> hh:mm
                    </td>
                    
                    
                  </tr>
                  <tr> 
                    <td class="ftverdanacinza" align="right" height="30"><%=trd.Traduz("ENTIDADE")%>:</td>
                    <td class="ftverdanacinza"> 
                      <select name="cboentidade">
                        <option value="" selected><%=trd.Traduz("Selecione")%></option>
<%                        query = "SELECT EMP_CODIGO, EMP_NOME FROM EMPRESA where emp_tipo <> 2 ORDER BY EMP_NOME";
                          rs = conexao.executaConsulta(query, session.getId()+"RS2");
                          if (rs.next()) {
                              do {
                                if(pag_entidade.equals(rs.getString(1))){%>
                                   <option value = "<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
<%                              } else {%>
                                   <option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                              }
                              } while (rs.next());
                          }
                          if(rs != null){
                              rs.close();
                              conexao.finalizaConexao(session.getId()+"RS2");
                          }                        %>
                      </select>
                    </td>
                  </tr>
                  <tr>
					<%
					String use_saratoga = prm.buscaparam("USE_SARATOGA");
					if(use_saratoga.equals("S")) {
						%>

						   <td class="ftverdanacinza" align="right" height="30"><%=trd.Traduz("CLASSIFICACAO SARATOGA")%>:</td>                     
						   <td class="ftverdanacinza">
                       	<select name="sel_saratoga">
                       	<option value = ""><%=trd.Traduz("SELECIONE")%></option>
						<%
						query = "SELECT SAR_CODIGO, SAR_DESCRICAO FROM SARATOGA ORDER BY SAR_DESCRICAO";
                       	rs = conexao.executaConsulta(query,session.getId()+"RS3");
                       	if (rs.next()){
                            do{
                                if(pag_saratoga.equals(rs.getString(1))){
                                	%> 
                                    <option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option> 
									<%
								}
								else {
									%>
                                    <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option> 
									<%
								}
							}while(rs.next());
                        }
                        if(rs != null){
                              rs.close();
                              conexao.finalizaConexao(session.getId()+"RS3");
                        }
                        %>
                        </select>
                        &nbsp;<!--<input type="button" class="botcin" value=<%=("\""+trd.Traduz("DESCRICAO")+"\"")%> onClick="">-->
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;
						<%
					}
					%>
					<%=trd.Traduz("TIPO")%>
                    <select name="sel_tipo">
					  <option value=""><%=trd.Traduz("Selecione")%></option>
					 	<%
					 	query = "SELECT TCU_CODIGO, TCU_NOME FROM TIPOCURSO ORDER BY TCU_NOME";
						rs = conexao.executaConsulta(query,session.getId()+"RS4");
						if (rs.next()) {
							do {
								%>
                                <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
								<%
			    			} while(rs.next());
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
                    <td class="ftverdanacinza" align="right" height="30"><%=trd.Traduz("CUSTO")%>:<%=moeda%></td>
                    <td class="ftverdanacinza"> 
                      <input type="text" name="custo" size="10" maxlength="9" onBlur="numero2(this)" onKeyUp="numero(this)">
                      (9999,99) + <%=trd.Traduz("CUSTO LOGISTICA")%>:<%=moeda%>
                      <input type="text" name="custo_log" size="10" maxlength="9" onBlur="numero2(this)" onKeyUp="numero(this)">
                      (9999,99) = <%=trd.Traduz("CUSTO TOTAL")%>:<%=moeda%>
                      <input type="text" name="custo_tot" disabled size="10" maxlength="9">
                    </td>
                  </tr>
                  <tr> 
                    <td class="ftverdanacinza" align="right"><%=trd.Traduz("OBSERVACAO")%>:</td>
                    <td class="ftverdanacinza"> 
                      <textarea name="observacao" rows="4" cols="50" onKeyUp="aspa(this)" onBlur="aspa2(this)"><%=pag_obs%></textarea>
                    </td>
                  </tr>
                  <tr> 
                    <td class="ftverdanacinza" align="center" colspan="100%">&nbsp;<br>
                      <input type="button" onClick="return ok();" value="       <%=trd.Traduz("OK")%>       " class="botcin" name="button">
                      &nbsp; <input type="button" onClick="return cancela();" value=<%=("\""+trd.Traduz("Cancelar")+"\"")%> class="botcin" name="button">
                  </tr>
                </table>
              </center>
            </td>
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
<%        if(ponto.equals("..")){%>
	    <jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include>
	    <%}else{%>	  
	    <jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>
<%        }%>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
<%

//} catch (Exception e) {
//  out.println(e);
//}
%>