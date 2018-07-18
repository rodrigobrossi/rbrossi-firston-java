
<%
	response.setHeader("Pragma", "no-cache");

	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.util.*,java.text.*"%>

<%
	//try{

	Vector per = (Vector) session.getAttribute("vetorPermissoes");

	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	firston.eval.components.FOParametersBean prm = (firston.eval.components.FOParametersBean) session
			.getAttribute("Param");

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	ResultSet rs = null, rsG = null, rsX = null;

	boolean existe = false, mostraCheck = true;

	int num_func = 0;
	float car_hora = 0, valor = 0, car_min = 0, total_hora = 0;
	String cod_pla = "", mes = "", query = "", queryG = "", nome = "", filial = "";

	if (request.getParameter("codigo") != null)
		cod_pla = request.getParameter("codigo");
	if (request.getParameter("cod") != null)
		mes = request.getParameter("cod");
	if (request.getParameter("sel_filial") != null)
		filial = request.getParameter("sel_filial");

	queryG = "SELECT I.IFM_CODIGO, I.IFM_MES, I.IFM_NFUNCIONARIO, I.IFM_HORAS, I.IFM_VALOR, Q.QBR_NOME "
			+ "FROM INFOMES I, QUEBRA Q "
			+ "WHERE PLA_CODIGO = "
			+ cod_pla
			+ " "
			+ "AND IFM_MES = "
			+ mes
			+ " "
			+ "AND I.IFM_MES = Q.QBR_CODIGO "
			+ "AND I.FIL_CODIGO = "
			+ filial;
	//out.println(queryG);
	rsG = conexao.executaConsulta(queryG, session.getId() + "RS1");

	if (rsG.next()) {
		if (rsG.getString(3) != null)
			num_func = rsG.getInt(3);
		if (rsG.getString(4) != null)
			total_hora = rsG.getFloat(4);
		if (rsG.getString(5) != null)
			valor = rsG.getFloat(5);
		if (rsG.getString(6) != null)
			nome = rsG.getString(6);
	} else {

		//Insere valores nulos para a filial que nao possui os dados mensais
		String queryX = "SELECT QBR_CODIGO FROM QUEBRA WHERE PER_CODIGO = 3";//O cOdigo do perIodo estA fixo em mensal (3)
		rsX = conexao.executaConsulta(queryX, session.getId() + "RS2");
		if (rsX.next()) {
			do {
				query = "INSERT INTO INFOMES (PLA_CODIGO,IFM_MES,FIL_CODIGO) "
						+ "VALUES ("
						+ cod_pla
						+ ", "
						+ rsX.getInt(1)
						+ ", " + filial + ")";
				//out.println(query+"<br>");
				conexao.executaAlteracao(query);
			} while (rsX.next());
		}

		if (rsX != null) {
			rsX.close();
			conexao.finalizaConexao(session.getId() + "RS2");
		}

	}

	if (rsG != null) {
		rsG.close();
		conexao.finalizaConexao(session.getId() + "RS1");
	}

	String moeda = prm.buscaparam("MOEDA");
%>

<%!public String convHora(float minutos) {
		Float ft = new Float(minutos);
		int min = ft.intValue();
		String total = "";
		float result;
		int inteiro = 0, decimal = 0;
		result = min / 60;
		Float ft2 = new Float(result);
		inteiro = ft2.intValue();
		//decimal = min % 60;
		//if (decimal<10) 
		total = inteiro + "";
		//else
		//  total = inteiro + ":" + decimal;
		return total;
	}%>
<%!public String convMin(float minutos) {
		Float ft = new Float(minutos);
		int min = ft.intValue();
		String total = "";
		float result;
		int inteiro = 0, decimal = 0;
		result = min / 60;
		Float ft2 = new Float(result);
		inteiro = ft2.intValue();
		decimal = min % 60;
		if (decimal < 10)
			total = "0" + decimal;
		else
			total = "" + decimal;
		return total;
	}%>
<%!//funcao para formatacao
	public String formataValor(float valor) {
		DecimalFormat dcf = new DecimalFormat("0.00");
		dcf.setMaximumFractionDigits(2);
		String strReais = dcf.format(valor);
		return strReais;

	}%>



<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Cadastro")%> - <%=trd.Traduz("DADOS MENSAIS")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<script>

function altera(){
  if(frm.txt_min.value >= "60"){
    alert(<%=("\"" + trd.Traduz("VALOR INVALIDO PARA MINUTO") + "\"")%>);
    frm.txt_min.value = "";
    frm.txt_min.focus();
    return false;
  }
  else{
    if(frm.txt_num.value == "")
      frm.txt_num.value = "0";
    if(frm.txt_hora.value == "")
      frm.txt_hora.value = "0";
    if(frm.txt_min.value == "")
      frm.txt_min.value = "0";
    if(frm.txt_valor.value == "")
      frm.txt_valor.value = "0";

    document.frm.tipo.value = "DU";
    frm.action ="planotreinamentograva.jsp";
    frm.submit();
    return false; 
  }
}

function numero(campo,tipo){
  if(tipo == "K"){
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
  else if(tipo == "B"){
    aux = campo.value;
    tam = aux.length;
    k = 0;
    while(tam>0){
      aux2 = aux.substring(tam-1,tam);
      if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" && aux2 != "4" &&
         aux2 != "5" && aux2 != "6" && aux2 != "7" && aux2 != "8" && aux2 != "9"){
        k = k+1;
      }
      tam--;
    }
    if(k != 0){
      alert(<%=("\""
									+ trd
											.Traduz("ESTE CAMPO POSSUI CARACTER NAO PERMITIDO") + "\"")%>);
      campo.value = "";
      campo.focus();
    }
  }
}

function valor(campo,tipo){
  if(tipo == "K"){
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
  else if(tipo == "B"){
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
      alert(<%=("\"" + trd.Traduz("FORMATO INVALIDO") + "\"")%>);
      campo.value = "0,00";
      campo.focus();
    }
  }
}

</script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../solicitacao/art/onenglish.gif','../solicitacao/art/onespanol.gif')">
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
						<jsp:include page="../menu/banner.jsp" flush="true">
							<jsp:param value="opt" name="CA" />
						</jsp:include>
						<%
							} else {
						%>
						<jsp:include page="/menu/banner.jsp" flush="true">
							<jsp:param value="opt" name="CA" />
						</jsp:include>
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
								if (request.getParameter("op") == null)
									oi = "../menu/menu.jsp?op=" + "C";
								else
									oi = "../menu/menu.jsp?op=" + request.getParameter("op");
								if (request.getParameter("opt") == null)
									oia = "../menu/menu1.jsp?opt=" + "PT";
								else
									oia = "../menu/menu1.jsp?opt="
											+ request.getParameter("opt");
							} else {
								if (request.getParameter("op") == null)
									oi = "/menu/menu.jsp?op=" + "C";
								else
									oi = "/menu/menu.jsp?op=" + request.getParameter("op");
								if (request.getParameter("opt") == null)
									oia = "/menu/menu1.jsp?opt=" + "PT";
								else
									oia = "/menu/menu1.jsp?opt=" + request.getParameter("opt");
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
						<td width="13"><img src="../art/bit.gif" width="13"
							height="15"></td>
						<td class="trontrk" width="297" align="center"><%=trd.Traduz("DADOS MENSAIS")%></td>
						<td width="29"><img src="../art/bit.gif" width="13"
							height="15"></td>
					</tr>
				</table>
				</td>
				<!--<td width="20">&nbsp;</td>-->
			</tr>
			<tr>
				<td width="20" height="1"><img src="../art/bit.gif" width="1"
					height="1"></td>
				<td valign="top" class="ctvdiv"><img src="../art/bit.gif"
					width="1" height="1"></td>
				<td width="20"><img src="../art/bit.gif" width="1" height="1"></td>
			</tr>
			<tr>
				<td width="20" valign="top"></td>
				<FORM name="frm" method="post">
				<td valign="top"><img src="../art/bit.gif" width="159"
					height="1"><br>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="center"><br>
						<%
							query = "SELECT QBR_CODIGO, PER_CODIGO, QBR_ORDEM, QBR_NOME FROM QUEBRA WHERE QBR_CODIGO = "
									+ mes;
							rs = conexao.executaConsulta(query, session.getId() + "RS3");
							if (rs.next())
								existe = true;/*Atribuie valor para existe*/

							if (rs != null) {
								rs.close();
								conexao.finalizaConexao(session.getId() + "RS3");
							}
						%>
						<p>
						<table border="0" cellspacing="1" cellpadding="2" width="60%">
							<tr class="celtittab" align="center">
								<td colspan="100%">&nbsp; <%=trd.Traduz("DADOS PARA")%> <%=nome%>
								</td>
							</tr>

							<tr class="celnortab">
								<td width="40%" colspan="2">&nbsp; <%=trd.Traduz("NUMERO DE FUNCIONARIOS")%>
								</td>
								<td width="60%"><input type="text" name="txt_num"
									value="<%=num_func%>" maxlength="9" onBlur="numero(this,'B')"
									onKeyUp="numero(this,'K')"></td>
							</tr>

							<tr class="celnortab">
								<td width="40%" colspan="2">&nbsp; <%=trd.Traduz("CARGA HORARIA")%>
								</td>
								<td width="60%"><input type="text" name="txt_hora"
									value="<%=convHora(total_hora)%>" size="3" maxlength="5"
									onBlur="numero(this,'B')" onKeyUp="numero(this,'K')">:
								<input type="text" name="txt_min"
									value="<%=convMin(total_hora)%>" size="3" maxlength="2"
									onBlur="numero(this,'B')" onKeyUp="numero(this,'K')"></td>
							</tr>
							<tr class="celnortab">
								<td width="40%">&nbsp; <%=trd.Traduz("VALOR")%></td>
								<td><%=moeda%></td>
								<td width="60%"><input type="text" name="txt_valor"
									value="<%=formataValor(valor)%>" maxlength="8"
									onBlur="valor(this,'B')" onKeyUp="valor(this,'K')">(99999,99)
								</td>
							</tr>
						</table>
						<br>
						&nbsp;</td>
					</tr>
					<tr align="center">
						<td><input type="button"
							value=<%=("\"" + trd.Traduz("ALTERAR") + "\"")%>
							onClick="return altera();" class="botcin">&nbsp; <input
							type="button" value=<%=("\"" + trd.Traduz("CANCELAR") + "\"")%>
							onClick="JavaScript:history.go(-1)" class="botcin"></td>
					</tr>

				</table>
				</td>
				<input type="hidden" name="tipo">
				<input type="hidden" name="cod_mes" value="<%=mes%>">
				<input type="hidden" name="codigo" value="<%=cod_pla%>">
				<input type="hidden" name="sel_filial" value="<%=filial%>">
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
				<%
					if (ponto.equals("..")) {
				%> <jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include>
				<%
					} else {
				%> <jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>
				<%
					}
				%>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</body>
</html>
<%
	//}catch(Exception e){
	//  out.println("Erro: "+e);
	//}
%>