
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.util.*"%>

<jsp:useBean id="cmb" scope="page" class="firston.eval.components.FODynamicComboBean" />
<jsp:useBean id="pos" scope="page" class="firston.eval.components.FOUserPositionBean" />

<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	firston.eval.components.FOParametersBean prm = (firston.eval.components.FOParametersBean) session
			.getAttribute("Param");

	//try{

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	String aplicacao = (String) session.getAttribute("aplicacao");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	Integer usu_codigo = (Integer) session.getAttribute("usu_cod");
	String usu_plano = "";
	usu_plano = usu_plano.valueOf(session.getAttribute("usu_plano"));

	ResultSet rsgrid = null, rs = null;

	//VariAveis para as Queryes
	String query = "", query_gridNP = "", lotacao = "", unidade = "", diretoria = "", celula = "", time = "", opt_filtro = "", opt_loc = "", campo = "", filtro_q = "", filtro_nome = "";
	int sel = -1;
	boolean existe = false;

	//Filtros lotacao
	Vector querys = new Vector();
	if (request.getParameter("op_uni") != null)
		unidade = request.getParameter("op_uni");
	else
		unidade = "" + usu_fil;
	if (request.getParameter("op_dir") != null)
		diretoria = request.getParameter("op_dir");
	if (request.getParameter("op_cel") != null)
		celula = request.getParameter("op_cel");
	if (request.getParameter("op_tim") != null)
		time = request.getParameter("op_tim");
	lotacao = prm.buscaparam("LOTACAO");

	//Filtro do Nome
	if (request.getParameter("textnome") != null) {
		opt_loc = (String) request.getParameter("textnome");
	} else {
		opt_loc = "";
	}

	//Pegar parametros
	if (request.getParameter("select2") != null) {
		opt_filtro = (String) request.getParameter("select2");

		query = cmb.montaCombo(opt_filtro, "null", "null", aplicacao);

		//CARGO
		if (opt_filtro.equals("Cargo")) {
			if (lotacao.equals("S")) {
		querys = pos.montaCombo(opt_filtro, "null", "null",
				aplicacao, unidade, diretoria, celula, time);
			}

			else {
		query = cmb.montaCombo(opt_filtro, "null", "null",
				aplicacao);
			}
		}
	} else {
		//Filtro Padrao
		opt_filtro = "Tabela2";

		if (opt_filtro.equals("Cargo")) {
			if (lotacao.equals("S")) {
		querys = pos.montaCombo(opt_filtro, "null", "null",
				aplicacao, unidade, diretoria, celula, time);
			}
		} else {
			query = cmb.montaCombo(opt_filtro, "null", "null",
			aplicacao);
		}
	}

	//Filtro selecionado
	if (!(query.equals("")))
		if (opt_filtro.equals("Solicitante"))
			campo = query.substring(36, 48) + " = ";
		else
			campo = query.substring(7, 17) + " = ";

	if (!(request.getParameter("select") == null)) {
		if (!(request.getParameter("select").equals("Todos"))) {
			sel = Integer.parseInt(request.getParameter("select"));
			filtro_q = " FUNCIONARIO." + campo
			+ request.getParameter("select") + " ";
		} else {
			filtro_q = " 0=0 ";
		}
	} else {
		filtro_q = " 0=0 ";
	}

	if (!(opt_loc.equals(""))) {
		filtro_nome = " AND FUNCIONARIO.FUN_NOME >= '" + opt_loc + "%'";
	}

	query_gridNP = "SELECT FUNCIONARIO.FUN_CODIGO, FUNCIONARIO.FUN_CHAPA, FUNCIONARIO.FUN_NOME, "
			+ "CARGO.CAR_NOME, DEPTO.DEP_NOME, TABELA3.TB3_DESCRICAO, TABELA2.TB2_NOME, "
			+ "FILIAL.FIL_NOME, SOLICITANTE.FUN_NOME, funcionario.fun_demitido, funcionario.fun_terceiro  "
			+ "FROM FUNCIONARIO, FUNCIONARIO SOLICITANTE, CARGO, DEPTO, TABELA3, TABELA2, FILIAL "
			+ "WHERE FUNCIONARIO.FUN_CODSOLIC *= SOLICITANTE.FUN_CODIGO AND "
			+ "CARGO.CAR_CODIGO = FUNCIONARIO.CAR_CODIGO AND "
			+ "DEPTO.DEP_CODIGO = FUNCIONARIO.DEP_CODIGO AND "
			+ "TABELA3.TB3_CODIGO =* FUNCIONARIO.TB3_CODIGO AND "
			+ "TABELA2.TB2_CODIGO =* FUNCIONARIO.TB2_CODIGO AND "
			+ "FILIAL.FIL_CODIGO =* FUNCIONARIO.FIL_CODIGO "
			+ "AND FUNCIONARIO.FUN_DEMITIDO = 'N' AND "
			+ filtro_q
			+ " " + filtro_nome + " ORDER BY FUNCIONARIO.FUN_NOME";

	//out.println("query_gridNP = " + query_gridNP);
%>
<script language="JavaScript">
function Opcao()
{
	frm.select.value = "";
    frm.action = "frame_naoplanejados.jsp";
    frm.submit();
    return false; 
}

function Filtro()
{
    frm.action = "frame_naoplanejados.jsp";
    frm.submit();
    return false; 
}

function Incluir(){

var paramnplan = "";
var tem = false;
 
  for(k=1;k<frm.contador.value;k++)
  {
    if(eval("frm.checknplan"+k+".checked")==true)
    {
	  tem = true;
	  paramnplan = paramnplan + "checknplan"+k+"="+ eval("frm.checknplan"+k+".value") + "&";
    }
  }

if (tem)
  {
	paramnplan = paramnplan + "contanplan=" + (frm.contador.value - 1);
    window.open("frame_listafuncionarios.jsp?" + paramnplan,target="bottomFrame", "_parent"); 	 
  }
  else
  {
    alert(<%=("\""+trd.Traduz("NENHUM FUNCIONARIO SELECIONADO")+"\"")%>);   
    return false;
  }
}

</script>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Registro")%> - <%=trd.Traduz("Lista de PresenCa")%></title>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body onunload='return fecha();' marginheight="0" leftmargin="14"
	topmargin="0">
<form name="frm">
<table width="90%" border="0" cellspacing="3" cellpadding="0">
	<tr>
		<td width="43%" class="ctfontc">
		<div align="left"><%=trd.Traduz("LOCALIZAR POR FUNCIONARIO")%>:</div>
		</td>
		<td width="23%"><input type="text" name="textnome"
			value="<%=opt_loc%>"></td>
		<td width="13%" class="ctfontc">
		<div align="left"><%=trd.Traduz("OPCOES")%>:</div>
		</td>
		<td width="21%"><select name="select2"
			onChange="return Opcao();">
			<option value="<%=opt_filtro%>"><%=trd.Traduz(opt_filtro)%></option>
			<%
			if (prm.buscaparam("USE_CARGO").equals("S")) {
			%>
			<%
			if (!(opt_filtro.equals("Cargo"))) {
			%>
			<option value="Cargo"><%=trd.Traduz("CARGO")%></option>
			<%
				}
				}
			%>
			<%
			if (prm.buscaparam("USE_DEPARTAMENTO").equals("S")) {
			%>
			<%
			if (!(opt_filtro.equals("Departamento"))) {
			%>
			<option value="Departamento"><%=trd.Traduz("DEPARTAMENTO")%></option>
			<%
				}
				}
			%>
			<%
			if (prm.buscaparam("USE_FILIAL").equals("S")) {
			%>
			<%
			if (!(opt_filtro.equals("Filial"))) {
			%>
			<option value="Filial"><%=trd.Traduz("FILIAL")%></option>
			<%
				}
				}
			%>
			<%
			if (prm.buscaparam("USE_TB1").equals("S")) {
			%>
			<%
			if (!(opt_filtro.equals("Tabela1"))) {
			%>
			<option value="Tabela1"><%=trd.Traduz("TABELA1")%></option>
			<%
				}
				}
			%>
			<%
			if (prm.buscaparam("USE_TB2").equals("S")) {
			%>
			<%
			if (!(opt_filtro.equals("Tabela2"))) {
			%>
			<option value="Tabela2"><%=trd.Traduz("TABELA2")%></option>
			<%
				}
				}
			%>
			<%
			if (prm.buscaparam("USE_TB3").equals("S")) {
			%>
			<%
			if (!(opt_filtro.equals("Tabela3"))) {
			%>
			<option value="Tabela3"><%=trd.Traduz("TABELA3")%></option>
			<%
				}
				}
			%>
			<%
			if (prm.buscaparam("USE_TB4").equals("S")) {
			%>
			<%
			if (!(opt_filtro.equals("Tabela4"))) {
			%>
			<option value="Tabela4"><%=trd.Traduz("TABELA4")%></option>
			<%
				}
				}
			%>
			<%
			if (prm.buscaparam("USE_TB5").equals("S")) {
			%>
			<%
			if (!(opt_filtro.equals("Tabela5"))) {
			%>
			<option value="Tabela5"><%=trd.Traduz("TABELA5")%></option>
			<%
				}
				}
			%>
			<%
			if (prm.buscaparam("USE_TB6").equals("S")) {
			%>
			<%
			if (!(opt_filtro.equals("Tabela6"))) {
			%>
			<option value="Tabela6"><%=trd.Traduz("TABELA6")%></option>
			<%
				}
				}
			%>
			<%
			if (prm.buscaparam("USE_TB7").equals("S")) {
			%>
			<%
			if (!(opt_filtro.equals("Tabela7"))) {
			%>
			<option value="Tabela7"><%=trd.Traduz("TABELA7")%></option>
			<%
				}
				}
			%>
			<%
			if (prm.buscaparam("USE_TB8").equals("S")) {
			%>
			<%
			if (!(opt_filtro.equals("Tabela8"))) {
			%>
			<option value="Tabela8"><%=trd.Traduz("TABELA8")%></option>
			<%
				}
				}
			%>
			<%
			if (!(opt_filtro.equals("Solicitante"))) {
			%>
			<option value="Solicitante"><%=trd.Traduz("SOLICITANTE")%></option>
			<%
			}
			%>
		</select></td>
	</tr>
	<tr>
		<td class="ctfontc"><%=trd.Traduz("FILTRO")%>:</td>
		<td colspan="3"><select name="select">
			<option value="Todos"><%=trd.Traduz("Todos")%></option>
			<%
					if (opt_filtro.equals("Cargo")) {
					if (lotacao.equals("S"))
						rs = conexao.executaConsulta((String) querys.elementAt(0),
						session.getId() + "RS_1");
					else
						rs = conexao.executaConsulta(query, session.getId()
						+ "RS_1");
				} else
					rs = conexao.executaConsulta(query, session.getId() + "RS_1");
				if (rs.next()) {
					do {
						if (sel == rs.getInt(1)) {
			%>
			<option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
			<%
			} else {
			%>
			<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
			<%
					}
					} while (rs.next());
				}
				if (rs != null) {
					rs.close();
					conexao.finalizaConexao(session.getId() + "RS_1");

				}
			%>
		</select></td>
	</tr>
	<tr>
		<td><input type="button" name="button"
			value=<%=("\""+trd.Traduz("FILTRAR")+"\"")%> class="botcin"
			onClick="return Filtro();"></td>
		<td colspan="3">&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td colspan="3">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="1" cellpadding="0">
	<tr>
		<td colspan="100%" class="celtittab">
		<div align="center"><%=trd.Traduz("TREINAMENTOS NAO PLANEJADOS")%></div>
		</td>
	</tr>
	<tr class="celtittab">

		<%
			//contador para os checks
			int i = 1;

			if (sel != -1) {
				rsgrid = conexao.executaConsulta(query_gridNP, session.getId()
				+ "RS_2");
				if (rsgrid.next()) {
					existe = true;
				}
			}

			if (existe) {
		%>
		<td width="3%" align="center">&nbsp;</td>
		<td width="32%"><%=trd.Traduz("CHAPA")%>&nbsp;</td>
		<td width="60%"><%=trd.Traduz("NOME")%></td>
		<%
		do {
		%>
	
	<tr>
		<td width="3%" class="celnortab"><input type="checkbox"
			name="checknplan<%=i%>" value="<%=rsgrid.getString(1)%>"></td>
		<td width="32%" class="celnortab" align="center"><%=rsgrid.getString(2)%></td>
		<td width="60%" class="celnortab"><%=rsgrid.getString(3)%></td>
	</tr>
	<%
			i++;
			} while (rsgrid.next());
		} else {
	%>
	<tr>
		<td colspan="100%" class="celtittab" align="center"><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...</td>
	</tr>
	<%
	}
	%>

</table>
<table width="100%" border="0" cellspacing="3" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<div align="center"><input type="button" name="button1"
			value=<%=("\""+trd.Traduz("INCLUIR")+"\"")%> class="botcin"
			onClick="return Incluir();"></div>
		</td>
	</tr>
	<INPUT type="hidden" name="contador" value="<%=i%>">
</table>
</form>
</body>
</html>
<%
		if (rs != null)
		rs.close();
	if (rsgrid != null) {
		rsgrid.close();
		conexao.finalizaConexao(session.getId() + "RS_2");
	}
	/*}
	 catch (Exception e)
	 {
	 out.println(e);
	 }*/
%>