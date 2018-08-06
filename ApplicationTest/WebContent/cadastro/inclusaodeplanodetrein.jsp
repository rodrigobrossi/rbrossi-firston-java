
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page
	import="java.sql.*,java.text.*,java.util.*"%>

<%
	//try{    
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	ResultSet rs = null, rsAlt = null, rs2 = null, rsA = null, rsQ = null, rsI = null;

	//Pega o tipo de cadastro (inclusAo ou alteraCAo) e o codigo do plano
	String tipo = "", cod = "1", tipoOperacao = "", query2 = "", ava_codigo = "";
	Vector vetAvaliacao = new Vector();
	Vector vetEnvio = new Vector();
	Vector vetVencimento = new Vector();
	Vector vetAmostra = new Vector();

	if (request.getParameter("apagavetor") == null) {
		session.setAttribute("vetor_avaliacao", vetAvaliacao);
		session.setAttribute("vetor_envio", vetEnvio);
		session.setAttribute("vetor_vencimento", vetVencimento);
		session.setAttribute("vetor_amostra", vetAmostra);
	} else {
		vetAvaliacao = (Vector) session.getAttribute("vetor_avaliacao");
		vetEnvio = (Vector) session.getAttribute("vetor_envio");
		vetVencimento = (Vector) session
				.getAttribute("vetor_vencimento");
		vetAmostra = (Vector) session.getAttribute("vetor_amostra");
	}

	if (!(request.getParameter("tipo") == null)) {
		tipo = request.getParameter("tipo");
	}
	if (!(request.getParameter("cod") == null)) {
		cod = request.getParameter("cod");
	}
	if (!(request.getParameter("sel_aval") == null)) {
		ava_codigo = request.getParameter("sel_aval");
	}

	String envio = "", vencimento = "", porcentagem = "", pla_codigo = "", que_codigo = "";

	//Se for alteracao faz a query 
	String query = "SELECT PLA_CODIGO, PLA_NOME, PLA_ANTERIOR, PER_CODIGO, PLA_ACESSO, PLA_NOVASOLICITACAO, "
			+ "PLA_ALTERACAO, PLA_EXCLUSAO, PLA_JUSTIFICATIVA, PLA_REGISTROTREINAMENTO, PLA_SOLICITACAOEXTRA, PLA_DATAINICIO, PLA_DATAFINAL "
			+ "FROM  PLANO " + "WHERE PLA_CODIGO = " + cod;

	rsAlt = conexao.executaConsulta(query, session.getId() + "RS1");

	if (rsAlt.next()) {
	}

	int cont_aval = 0;
	pla_codigo = rsAlt.getString(1);

	SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
	int index = 0;
	int qtde = 0;
	//qtde = Integer.parseInt(request.getParameter("c_avaliacao"));

	if (request.getParameter("tipo_op") != null) {
		tipoOperacao = request.getParameter("tipo_op");
		if (tipoOperacao.equals("IA")) {

			if (!vetAvaliacao.contains(request
					.getParameter("sel_quest"))) {
				vetAvaliacao.add(request.getParameter("sel_quest"));
			}
			qtde = Integer
					.parseInt(request.getParameter("c_avaliacao"));
		}
		if (tipoOperacao.equals("EA")) {
			qtde = Integer
					.parseInt(request.getParameter("c_avaliacao"));
			for (int ii = 0; ii <= qtde; ii++) {
				if (request.getParameter("chk_avaliacao" + ii) != null) {
					index = vetAvaliacao.indexOf((String) request
							.getParameter("chk_avaliacao" + ii));
					vetAvaliacao.removeElement((String) request
							.getParameter("chk_avaliacao" + ii));
					vetEnvio.remove(index);
					vetVencimento.remove(index);
					vetAmostra.remove(index);
				}
			}
		}
	}

	int i = 0;
%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Cadastro")%> - <%
	if (tipo.equals("I")) {
%> <%=trd.Traduz("INCLUSAO DE ANO DE REFERENCIA")%></title>
<%
	} else {
%>
<%=trd.Traduz("ALTERACAO DE ANO DE REFERENCIA")%></title>
<%
	}
%>
<script language="JavaScript" src="/js/scripts.js"></script>

<script language="JavaScript">
function cancela() {
  window.open("planodetreinamento.jsp","_self");
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
    if (isNaN(bis))
      erro = 1
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
    alert(<%=("\""
									+ trd
											.Traduz("INTERNET EXPLORER 4.0 OU SUPERIOR E NECESSARIO") + "\"")%>)
}






function validaData(){
  var data1 = document.frm.text_datainicio.value;
  var data2 = document.frm.text_datafinal.value;
  i1=0;
  i2=0;
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
  
  if(ano1>ano2){
    alert(<%=("\""
									+ trd
											.Traduz("A DATA DE TERMINO NAO PODE SER MENOR QUE A DATA DE INICIO") + "\"")%>);
    document.frm.text_datafinal.value="";
    document.frm.text_datafinal.focus();
    return false; 
  }
  else if(ano1<ano2 || ano1==ano2){
    if (mes1>mes2){
      alert(<%=("\""
									+ trd
											.Traduz("A DATA DE TERMINO NAO PODE SER MENOR QUE A DATA DE INICIO") + "\"")%>);
      document.frm.text_datafinal.value="";
      document.frm.text_datafinal.focus();
      return false; 
    }
    else if(mes1==mes2){
      if(dia1>dia2){  
        alert(<%=("\""
									+ trd
											.Traduz("A DATA DE TERMINO NAO PODE SER MENOR QUE A DATA DE INICIO") + "\"")%>);
        document.frm.text_datafinal.value="";
        document.frm.text_datafinal.focus();
        return false; 
      }
      else{
        return true; 
      }
    }
    else{
      return true; 
    }   
  }   
} 

function envia(){
  var erro;
  erro = 0;
  if(document.frm.text_nome.value==""){
    alert(<%=("\"" + trd.Traduz("Digite o ANO DE REFERENCIA!") + "\"")%>);
    return false;
    erro++;
  }
  if(document.frm.text_datainicio.value==""){
    alert(<%=("\""
									+ trd
											.Traduz("Digite a data de inIcio do treinamento!") + "\"")%>);
    return false;
    erro++;
  }
  if(document.frm.text_datafinal.value==""){
    alert(<%=("\""
									+ trd
											.Traduz("Digite a data de fim do treinamento!") + "\"")%>);
    return false;
    erro++;
  }
  
  else{
    var data1 = document.frm.text_datainicio.value;
    var data2 = document.frm.text_datafinal.value;
    i1=0;
    i2=0;
    while(i1<data1.length)
      i1++;
    
    while(i2<data2.length)
      i2++;
    
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
    
    if(ano1>ano2){
      alert(<%=("\""
									+ trd
											.Traduz("A DATA DE TERMINO NAO PODE SER MENOR QUE A DATA DE INICIO") + "\"")%>);
      document.frm.text_datafinal.value="";
      document.frm.text_datafinal.focus();
      return false;
      erro++;
    }
    else if(ano1<ano2 || ano1==ano2){
      if (mes1>mes2){
        alert(<%=("\""
									+ trd
											.Traduz("A DATA DE TERMINO NAO PODE SER MENOR QUE A DATA DE INICIO") + "\"")%>);
        document.frm.text_datafinal.value="";
        document.frm.text_datafinal.focus();
        return false;
        erro++;
      }
      else if(mes1==mes2){
        if(dia1>dia2){  
          alert(<%=("\""
									+ trd
											.Traduz("A DATA DE TERMINO NAO PODE SER MENOR QUE A DATA DE INICIO") + "\"")%>);
          document.frm.text_datafinal.value="";
          document.frm.text_datafinal.focus();
          return false;
          erro++;
        }
      }
    }   
  }

  if (erro == 0){
    frm.submit();
    return false;
  }
}
///terminar/////
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
  k = 0;
  while(tam>0){
    aux2 = aux.substring(tam-1,tam);
    if(aux2 == "\"" || aux2 == "\'")
      k = k+1;
    tam--;
  }
  if(k != 0){
    alert(<%=("\""
									+ trd
											.Traduz("NAO E PERMITIDO DIGITAR ASPA SIMPLES OU DUPLA") + "\"")%>);
    campo.value = "";
    campo.focus();
  }
}


function quest(){
    frm.action = "inclusaodeplanodetrein.jsp";
    frm.reload.value="1";
    //frm.tipo_op.value = "IA";
    frm.submit();
    return true;
}

function insere(){
  if (frm.sel_quest.value == ""){
    alert(<%=("\""
									+ trd
											.Traduz("FAVOR SELECIONAR UM QUESTIONARIO") + "\"")%>);
    return false;
    }
    else{
      var ret = showModalDialog("incluidadosavaliacao.jsp","","center=yes;status=no;scroll=no;dialogWidth=300px;dialogHeight=270px");
      if(ret == 2){
        frm.tipo_op.value = "IA";
        frm.reload.value="1";
        frm.action = "inclusaodeplanodetrein.jsp";
        frm.submit();
        return true;
      }
      else{
        return false;
      }
    }
}

function exclui(){
  var teste = 0;
  for(i=1;i<=frm.c_avaliacao.value;i++){
    if(eval("frm.chk_avaliacao"+i+".checked")==true){
      teste = teste+1;
    }
  }
  if(teste == 0){
    alert(<%=("\"" + trd.Traduz("NENHUM ITEM SELECIONADO") + "\"")%>);
    return false;
  }
  else{
    if(confirm("DESEJA EXCLUIR O ITEM SELECIONADO?")){
      frm.tipo_op.value = "EA";
      frm.reload.value="1";
      frm.action = "inclusaodeplanodetrein.jsp";
      frm.submit();
      return true;
    }
    else
      return false;
  }
}

function numero2(campo){
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
  if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" && aux2 != "4" &&
     aux2 != "5" && aux2 != "6" && aux2 != "7" && aux2 != "8" && aux2 != "9"){
    aux = campo.value;
    aux = aux.length;
    aux = aux - 1;
    pal = campo.value;
    campo.value = pal.substring(0, aux);
  }
}

</script>

<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','art/onenglish.gif','art/onespanol.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	height="100%">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="59" class="hcfundo">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<%
							String ponto = (String) session.getAttribute("barra");
							if (ponto.equals("..")) {
						%>
						<jsp:include page="../menu/banner.jsp" flush="true"><jsp:param
								value="opt" name="CA" /></jsp:include>
						<%
							} else {
						%>
						<jsp:include page="/menu/banner.jsp" flush="true"><jsp:param
								value="opt" name="CA" /></jsp:include>
						<%
							}
						%>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="mnfundo"><img src="../art/bit.gif" width="12"
					height="5"></td>
			</tr>
			<tr>
				<td height="25" class="mnfundo">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<%
							String oi = "", oia = "";
							if (ponto.equals("..")) {
								if (request.getParameter("op") == null) {
									oi = "../menu/menu.jsp?op=" + "C";
								} else {
									oi = "../menu/menu.jsp?op=" + request.getParameter("op");
								}
								if (request.getParameter("opt") == null) {
									oia = "../menu/menu1.jsp?opt=" + "PT";
								} else {
									oia = "../menu/menu1.jsp?opt="
											+ request.getParameter("opt");
								}

							} else {
								if (request.getParameter("op") == null) {
									oi = "/menu/menu.jsp?op=" + "C";
								} else {
									oi = "/menu/menu.jsp?op=" + request.getParameter("op");
								}
								if (request.getParameter("opt") == null) {
									oia = "/menu/menu1.jsp?opt=" + "PT";
								} else {
									oia = "/menu/menu1.jsp?opt=" + request.getParameter("opt");
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
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="20">&nbsp;</td>
				<td width="963" align="center">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="13"><img src="../art/bit.gif" width="13"
							height="15"></td>
						<td class="trontrk" align="center">
						<%
							if (tipo.equals("I")) {
						%> <%=trd.Traduz("INCLUSAO DE ANO DE REFERENCIA")%> <%
 	} else {
 %> <%=trd.Traduz("ALTERACAO DE ANO DE REFERENCIA")%> <%
 	}
 %>
						</td>
						<td width="18"><img src="../art/bit.gif" width="13"
							height="15"></td>
					</tr>
				</table>
				</td>
				<td width="10">&nbsp;</td>
			</tr>
			<tr>
				<td width="20" height="1"><img src="../art/bit.gif" width="1"
					height="1"></td>
				<td valign="top" class="ctvdiv" width="963"><img
					src="../art/bit.gif" width="1" height="1"></td>
				<td width="10"><img src="../art/bit.gif" width="1" height="1"></td>
			</tr>
			<tr>
				<td width="20" valign="top"></td>
				<FORM name="frm" action="planotreinamentograva.jsp" method="POST">
				<td valign="top" width="963"><img src="../art/bit.gif"
					width="159" height="1">&nbsp;<br>
				<center>
				<table border="0" cellspacing="2" cellpadding="3" width="100%">
					<tr class="celnortab">
						<td width="33%" colspan="3"><%=trd.Traduz("ANO DE REFERENCIA")%><br>
						<%
							String text_nome = (((String) request.getParameter("text_nome") == null) ? ""
									: (String) request.getParameter("text_nome"));
							if (tipo.equals("I")) {
						%> <input type="text" name="text_nome" maxlength="5"
							value="<%=text_nome%>" onKeyUp="aspa(this);"
							onBlur="aspa2(this);"> <%
 	} else {
 %> <input type="text" name="text_nome" maxlength="5"
							value="<%=rsAlt.getString(2)%>" onKeyUp="aspa(this);"
							onBlur="aspa2(this);"> <%
 	}
 %>
						</td>
						<td width="33%" colspan="3"><%=trd.Traduz("PLANO ANTERIOR")%><br>
						<br>
						<select name="sel_planoanterior">
							<%
								query = "SELECT PLA_CODIGO, PLA_NOME FROM PLANO ";
								rs = conexao.executaConsulta(query, session.getId() + "RS2");
								if (rs.next()) {
									do {
										if (tipo.equals("I")) {
											String sel_planoanterior = (((String) request
													.getParameter("sel_planoanterior") == null) ? ""
													: (String) request
															.getParameter("sel_planoanterior"));
											if (sel_planoanterior.equals("" + rs.getInt(1))) {
							%>
							<option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
							<%
								} else {
							%>
							<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
							<%
								}
										} else {
											if (rs.getInt(1) == (rsAlt.getInt(3))) {
							%>
							<option selected value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
							<%
								} else {
							%>
							<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
							<%
								}
										}
									} while (rs.next());
								}
							%>
						</select></td>

					</tr>
					<tr class="celnortab">

						<td width="33%" colspan="3"><%=trd.Traduz("DATA INICIAL")%><br>
						<%
							if (tipo.equals("I")) {
								String text_datainicio = (((String) request
										.getParameter("text_datainicio") == null) ? ""
										: (String) request.getParameter("text_datainicio"));
						%> <input type="text" name="text_datainicio" size="9"
							value="<%=text_datainicio%>" onChange="ChecaData(this)"
							onKeyDown="FormataData(this, window.event.keyCode,'down')"
							onKeyUp="FormataData(this, window.event.keyCode,'up')">
						&nbsp;<img onclick="DoCal(text_datainicio)" style="cursor: hand"
							src="../art/icon_cal.gif" title="CalendArio" WIDTH="17"
							HEIGHT="16"> <%
 	} else {
 		String str_ini = formato.format(rsAlt.getDate(12));
 %> <input type="text" name="text_datainicio"
							value="<%=str_ini%>" size="9" onChange="ChecaData(this)"
							onKeyDown="FormataData(this, window.event.keyCode,'down')"
							onKeyUp="FormataData(this, window.event.keyCode,'up')">
						&nbsp;<img onclick="DoCal(text_datainicio)" style="cursor: hand"
							src="../art/icon_cal.gif" title="CalendArio" WIDTH="17"
							HEIGHT="16"> <%
 	}
 %>
						</td>
						<td width="33%" colspan="3"><%=trd.Traduz("DATA FINAL")%><br>
						<%
							if (tipo.equals("I")) {
								String text_datafinal = (((String) request
										.getParameter("text_datafinal") == null) ? ""
										: (String) request.getParameter("text_datafinal"));
						%> <input type="text" name="text_datafinal"
							value="<%=text_datafinal%>" size="9" onChange="ChecaData(this)"
							onKeyDown="FormataData(this, window.event.keyCode,'down')"
							onKeyUp="FormataData(this, window.event.keyCode,'up')">
						&nbsp;<img onclick="DoCal(text_datafinal)" style="cursor: hand"
							src="../art/icon_cal.gif" title="CalendArio" WIDTH="17"
							HEIGHT="16"> <%
 	} else {
 		String str_fim = formato.format(rsAlt.getDate(13));
 %> <input type="text" name="text_datafinal"
							value="<%=str_fim%>" size="9" onChange="ChecaData(this)"
							onKeyDown="FormataData(this, window.event.keyCode,'down')"
							onKeyUp="FormataData(this, window.event.keyCode,'up')">
						&nbsp;<img onclick="DoCal(text_datafinal)" style="cursor: hand"
							src="../art/icon_cal.gif" title="CalendArio" WIDTH="17"
							HEIGHT="16"> <%
 	}
 %>
						</td>

					</tr>
					<tr class="celnortab">
						<td width="33%" colspan="3"><%=trd.Traduz("PERIODO")%><br>
						<br>
						<select name="sel_periodo">
							<%
								if (rs != null) {
									rs.close();
									conexao.finalizaConexao(session.getId() + "RS2");
								}

								query = "SELECT PER_CODIGO, PER_NOME FROM PERIODO ";
								rs = conexao.executaConsulta(query, session.getId() + "RS3");

								if (rs.next()) {
									do {
										if (tipo.equals("I")) {
											String sel_periodo = (((String) request
													.getParameter("sel_periodo") == null) ? ""
													: (String) request.getParameter("sel_periodo"));
											if (sel_periodo.equals("" + rs.getInt(1))) {
							%><option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
							<%
								} else {
							%><option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
							<%
								}
										} else {
											if (rs.getInt(1) == (rsAlt.getInt(4))) {
							%><option selected value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
							<%
								} else {
							%><option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
							<%
								}
										}
									} while (rs.next());
								}

								if (rs != null) {
									rs.close();
									conexao.finalizaConexao(session.getId() + "RS3");
								}
							%>
						</select></td>
						<td width="33%" colspan="3">
						<%
							if (tipo.equals("I")) {
								String chk_Acesso = (((String) request
										.getParameter("chk_Acesso") == null) ? ""
										: (String) request.getParameter("chk_Acesso"));
								if (chk_Acesso.equals("")) {
						%> <input type="checkbox" name="chk_Acesso"> <%=trd.Traduz("PERMITIR ACESSO")%>&nbsp;
						<%
							} else {
						%> <input type="checkbox" name="chk_Acesso" checked> <%=trd.Traduz("PERMITIR ACESSO")%>&nbsp;
						<%
							}
							} else {
								if (rsAlt.getString(5).equals("S")) {
						%> <input type="checkbox" checked name="chk_Acesso"><%=trd.Traduz("PERMITIR ACESSO")%>&nbsp;
						<%
							} else {
						%> <input type="checkbox" name="chk_Acesso"><%=trd.Traduz("PERMITIR ACESSO")%>&nbsp;
						<%
							}
							}
						%>
						</td>
					</tr>
					<tr class="celnortab">
						<td colspan="6">
						<hr>
						</td>
					</tr>
					<tr class="celnortab">
						<td width="33%" colspan="3">
						<%
							if (tipo.equals("I")) {
								String chk_novasolicitacao = (((String) request
										.getParameter("chk_novasolicitacao") == null) ? ""
										: (String) request.getParameter("chk_novasolicitacao"));
								if (chk_novasolicitacao.equals("")) {
						%> <input type="checkbox" name="chk_novasolicitacao"><%=trd.Traduz("PERMITIR NOVA SOLICITACAO")%>&nbsp;
						<%
							} else {
						%> <input type="checkbox" name="chk_novasolicitacao" checked><%=trd.Traduz("PERMITIR NOVA SOLICITACAO")%>&nbsp;
						<%
							}
							} else {
								if (rsAlt.getString(6).equals("S")) {
						%> <input type="checkbox" checked name="chk_novasolicitacao"><%=trd.Traduz("PERMITIR SOLICITACAO")%>&nbsp;
						<%
							} else {
						%> <input type="checkbox" name="chk_novasolicitacao"><%=trd.Traduz("PERMITIR SOLICITACAO")%>&nbsp;
						<%
							}
							}
						%>
						</td>
						<td width="33%" colspan="3">
						<%
							if (tipo.equals("I")) {
								String chk_justificativa = (((String) request
										.getParameter("chk_justificativa") == null) ? ""
										: (String) request.getParameter("chk_justificativa"));
								if (chk_justificativa.equals("")) {
						%> <input type="checkbox" name="chk_justificativa"> <%=trd.Traduz("PERMITIR JUSTIFICATIVA")%>&nbsp;
						<%
							} else {
						%> <input type="checkbox"
							name="chk_justificativa" checked> <%=trd.Traduz("PERMITIR JUSTIFICATIVA")%>&nbsp;
						<%
							}
							} else {
								if (rsAlt.getString(9).equals("S")) {
						%> <input type="checkbox" checked name="chk_justificativa"><%=trd.Traduz("PERMITIR JUSTIFICATIVA")%>&nbsp;
						<%
							} else {
						%> <input type="checkbox" name="chk_justificativa"> <%=trd.Traduz("PERMITIR JUSTIFICATIVA")%>&nbsp;
						<%
							}
							}
						%>
						</td>
					</tr>
					<tr class="celnortab">
						<td width="33%" colspan="3">
						<%
							if (tipo.equals("I")) {
								String chk_alteracao = (((String) request
										.getParameter("chk_alteracao") == null) ? ""
										: (String) request.getParameter("chk_alteracao"));
								if (chk_alteracao.equals("")) {
						%> <input type="checkbox" name="chk_alteracao"><%=trd.Traduz("PERMITIR ALTERACAO")%>&nbsp;
						<%
							} else {
						%> <input type="checkbox" name="chk_alteracao" checked><%=trd.Traduz("PERMITIR ALTERACAO")%>&nbsp;
						<%
							}
							} else {
								if (rsAlt.getString(7).equals("S")) {
						%> <input type="checkbox" checked name="chk_alteracao"><%=trd.Traduz("PERMITIR ALTERACAO")%>&nbsp;
						<%
							} else {
						%> <input type="checkbox" name="chk_alteracao"><%=trd.Traduz("PERMITIR ALTERACAO")%>&nbsp;
						<%
							}
							}
						%>
						</td>
						<td width="33%" colspan="3">
						<%
							if (tipo.equals("I")) {
								String chk_registro = (((String) request
										.getParameter("chk_registro") == null) ? ""
										: (String) request.getParameter("chk_registro"));
								if (chk_registro.equals("")) {
						%> <input type="checkbox" name="chk_registro"><%=trd.Traduz("PERMITIR REGISTRO")%>&nbsp;
						<%
							} else {
						%> <input type="checkbox" name="chk_registro" checked><%=trd.Traduz("PERMITIR REGISTRO")%>&nbsp;
						<%
							}
							} else {
								if (rsAlt.getString(10).equals("S")) {
						%> <input type="checkbox" checked name="chk_registro"><%=trd.Traduz("PERMITIR REGISTRO")%>&nbsp;
						<%
							} else {
						%> <input type="checkbox" name="chk_registro"><%=trd.Traduz("PERMITIR REGISTRO")%>&nbsp;
						<%
							}
							}
						%>
						</td>
					</tr>
					<tr class="celnortab">
						<td width="33%" colspan="3">
						<%
							if (tipo.equals("I")) {
								String chk_exclusao = (((String) request
										.getParameter("chk_exclusao") == null) ? ""
										: (String) request.getParameter("chk_exclusao"));
								if (chk_exclusao.equals("")) {
						%> <input type="checkbox" name="chk_exclusao"><%=trd.Traduz("PERMITIR EXCLUSAO")%>&nbsp;
						<%
							} else {
						%> <input type="checkbox" name="chk_exclusao" checked><%=trd.Traduz("PERMITIR EXCLUSAO")%>&nbsp;
						<%
							}
							} else {
								if (rsAlt.getString(8).equals("S")) {
						%> <input type="checkbox" checked name="chk_exclusao"><%=trd.Traduz("PERMITIR EXCLUSAO")%>&nbsp;
						<%
							} else {
						%> <input type="checkbox" name="chk_exclusao"><%=trd.Traduz("PERMITIR EXCLUSAO")%>&nbsp;
						<%
							}
							}
						%>
						</td>
						<td width="33%" colspan="3">
						<%
							if (tipo.equals("I")) {
								String chk_solicextra = (((String) request
										.getParameter("chk_solicextra") == null) ? ""
										: (String) request.getParameter("chk_solicextra"));
								if (chk_solicextra.equals("")) {
						%> <input type="checkbox" name="chk_solicextra"><%=trd.Traduz("PERMITIR SOLICITACAO EXTRA")%>&nbsp;
						<%
							} else {
						%> <input type="checkbox" name="chk_solicextra" checked><%=trd.Traduz("PERMITIR SOLICITACAO EXTRA")%>&nbsp;
						<%
							}
							} else {
								if (rsAlt.getString(11) != null) {
									if (rsAlt.getString(11).equals("S")) {
						%> <input type="checkbox" checked name="chk_solicextra"><%=trd
												.Traduz("PERMITIR SOLICITACAO EXTRA")%>&nbsp;
						<%
							} else {
						%> <input type="checkbox" name="chk_solicextra"><%=trd
												.Traduz("PERMITIR SOLICITACAO EXTRA")%>&nbsp;
						<%
							}
								} else {
						%> <input type="checkbox" name="chk_solicextra"><%=trd.Traduz("PERMITIR SOLICITACAO EXTRA")%>&nbsp;
						<%
							}
							}
						%>
						</td>
					</tr>
					<tr class="celnortab">
						<td colspan="6">
						<hr>
						</td>
					</tr>

					<tr class="celnortab">
						<td colspan="3"><%=trd.Traduz("AVALIACAO")%>: <br>
						<select name="sel_aval" onChange="return quest();">
							<option value=""><%=trd.Traduz("SELECIONE")%></option>
							<%
								String queryA = "SELECT AVA_CODIGO, AVA_DESCRICAO FROM AVALIACAO";
								rsA = conexao.executaConsulta(queryA, session.getId() + "RS4");
								if (rsA.next()) {
									do {
										//if(!vetAvaliacao.contains(rsA.getString(1))){
										if (ava_codigo.equals(rsA.getString(1))) {
							%>
							<option selected value="<%=rsA.getString(1)%>"><%=rsA.getString(2)%></option>
							<%
								} else {
							%>
							<option value="<%=rsA.getString(1)%>"><%=rsA.getString(2)%></option>
							<%
								}
										//}
									} while (rsA.next());
								}

								if (rsA != null) {
									rsA.close();
									conexao.finalizaConexao(session.getId() + "RS4");
								}
							%>
						</select></td>
						<td colspan="3"><%=trd.Traduz("QUESTIONARIO")%>:<br>
						<select name="sel_quest">
							<option value="">SELECIONE</option>
							<%
								if (!ava_codigo.equals("")) {
									String queryQ = "SELECT QUE_CODIGO, QUE_NOME "
											+ "FROM QUESTIONARIO " + "WHERE AVA_CODIGO = "
											+ ava_codigo + " " + "ORDER BY QUE_NOME";

									rsQ = conexao.executaConsulta(queryQ, session.getId() + "RS5");
									if (rsQ.next()) {
										do {
											if (!vetAvaliacao.contains(rsQ.getString(1))) {
							%>
							<option value=<%=rsQ.getInt(1)%>><%=rsQ.getString(2)%></option>
							<%
								}
										} while (rsQ.next());

										if (rsQ != null) {
											rsQ.close();
											conexao.finalizaConexao(session.getId() + "RS5");
										}

									}
								}
							%>
						</select> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="button"
							value=<%=("\"" + trd.Traduz("INSERIR") + "\"")%> class="botcin"
							onClick="return insere();">&nbsp;&nbsp;&nbsp; <input
							type="button" value=<%=("\"" + trd.Traduz("EXCLUIR") + "\"")%>
							class="botcin" onClick="return exclui();"></td>
					</tr>

					<%
						String reload = "";
						if (request.getParameter("reload") != null) {
							reload = request.getParameter("reload");
						}

						if (tipo.equals("U") && !reload.equals("1")) {
							if (vetAvaliacao.isEmpty()) {
								query2 = "SELECT QUE_CODIGO FROM PLANO_AVALIA WHERE PLA_CODIGO = "
										+ pla_codigo;
								rs2 = conexao.executaConsulta(query2, session.getId()
										+ "RS6");
								if (rs2.next()) {
									do {
										que_codigo = rs2.getString(1);
										vetAvaliacao.add(que_codigo);
									} while (rs2.next());
								}

								if (rs2 != null) {
									rs2.close();
									conexao.finalizaConexao(session.getId() + "RS6");
								}

							}

						}

						if (!vetAvaliacao.isEmpty()) {
							i = 0;
							cont_aval = 0;
							do {
								query2 = "SELECT Q.QUE_CODIGO, Q.QUE_NOME, A.AVA_DESCRICAO "
										+ "FROM QUESTIONARIO Q, AVALIACAO A "
										+ "WHERE Q.AVA_CODIGO = A.AVA_CODIGO "
										+ "AND QUE_CODIGO = " + vetAvaliacao.elementAt(i);

								cont_aval++;
								rs2 = conexao.executaConsulta(query2, session.getId()
										+ "RS7");
								if (rs2.next()) {
									que_codigo = rs2.getString(1);

									if (tipo.equals("U") && !reload.equals("1")) {
										String queryI = "SELECT PLV_DIASENVIO,PLV_DIASVENC,PLV_PORCENTAGEM, QUE_CODIGO FROM PLANO_AVALIA WHERE PLA_CODIGO = "
												+ pla_codigo
												+ " AND QUE_CODIGO = "
												+ que_codigo;
										rsI = conexao.executaConsulta(queryI, session
												.getId()
												+ "RS8");
										rsI.next();
										vetEnvio.addElement(rsI.getString(1));
										vetVencimento.addElement(rsI.getString(2));
										vetAmostra.addElement(rsI.getString(3));

										if (rsI != null) {
											rsI.close();
											conexao
													.finalizaConexao(session.getId()
															+ "RS8");
										}

									}

									if (!vetEnvio.isEmpty())
										envio = (String) vetEnvio.elementAt(i);
									if (!vetVencimento.isEmpty())
										vencimento = (String) vetVencimento.elementAt(i);
									if (!vetAmostra.isEmpty())
										porcentagem = (String) vetAmostra.elementAt(i);
					%>
					<tr class="celnortab">
						<td><input type="checkbox" name="chk_avaliacao<%=cont_aval%>"
							value="<%=rs2.getInt(1)%>"></td>
						<td><b> <%=rs2.getString(3)%> </b></td>
						<td><%=trd.Traduz("QUESTIONARIO")%>: &nbsp; <b> <%=rs2.getString(2)%>
						</b></td>
						<td><%=trd.Traduz("DIAS PARA ENVIO")%>: &nbsp; <b> <%=envio%>
						</b></td>
						<td><%=trd.Traduz("DIAS PARA VENCIMENTO")%>: &nbsp; <b> <%=vencimento%>
						</b></td>
						<td>
						<%
							if (porcentagem.equals("") || porcentagem.equals("100")) {
						%>
						<%=trd.Traduz("TOTAL")%>: &nbsp; <b> 100% </b> <%
 	} else {
 %> <%=trd.Traduz("AMOSTRAGEM")%>: &nbsp; <b>
						<%=porcentagem%>% </b> <%
 	}
 %>
						</td>
					</tr>
					<%
						i++;
								}
							} while (i < vetAvaliacao.size());

							if (rs2 != null) {
								rs2.close();
								conexao.finalizaConexao(session.getId() + "RS7");
							}

						} else {
					%>
					<tr class="celnortab">
						<td colspan="100%"><%=trd.Traduz("NENHUM ITEM ADICIONADO")%>...</td>
					</tr>
					<%
						}
					%>
					<input type="hidden" name="tipo_op">
					<input type="hidden" name="c_avaliacao" value="<%=cont_aval%>">
					<input type="hidden" name="apagavetor" value="N">
					<input type="hidden" name="tipo" value="<%=tipo%>">
					<input type="hidden" name="cod" value="<%=cod%>">
					<input type="hidden" name="reload" value="1">
					<tr>
						<td align="center" colspan="6">&nbsp;<br>
						<input type="button" onClick="return envia();"
							value="        <%=trd.Traduz("OK")%>        " class="botcin"
							name="buttonok"> &nbsp; <input type="button"
]							onClick="cancela()"
							value=<%=("\"" + trd.Traduz("CANCELAR") + "\"")%> class="botcin"
							name="buttoncancel"></td>
					</tr>
				</table>
				<p>&nbsp;
				</center>
				</td>
				</FORM>

				<!--Fim cOdigo fonte-->

				<td width="10" valign="top"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td align="right" height="30" class="difundo">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<%
					if (ponto.equals("..")) {
				%><jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include></td>
				<%
					} else {
				%><jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include></td>
				<%
					}
				%>
			</tr>
		</table>
		</td>
	</tr>
</table>
</body>
</html>
<%
	if (rsAlt != null) {
		rsAlt.close();
		conexao.finalizaConexao(session.getId() + "RS1");
	}

	//}catch(Exception e){out.println(""+e);}
%>