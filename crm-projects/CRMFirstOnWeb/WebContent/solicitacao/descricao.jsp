
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
	firston.eval.components.FOParametersBean prm = (firston.eval.components.FOParametersBean) session
			.getAttribute("Param");

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	String moeda = prm.buscaparam("MOEDA");

	ResultSet rs = null, rsC = null;

	Integer cur_codigo = new Integer(0);

	if (request.getParameter("cur_codigo") != null)
		cur_codigo = new Integer(request.getParameter("cur_codigo"));

	String query = "", queryC = "";

	query = "SELECT C.CUR_NOME, E.EMP_NOME, E.EMP_CONTATO, E.EMP_FONE1, E.EMP_EMAIL, "
			+ "C.CUR_CUSTO, C.CUR_DURACAO, C.CUR_MAXPART, C.CUR_MINPART, C.CUR_VERSAOATUAL, "
			+ "C.CUR_OBJETIVO, C.CUR_PROGRAMA, F.FUN_NOME, C.CUR_PUBLALVO, C.CUR_COMOAVALIAR, "
			+ "TC.TCU_NOME, C.CUR_CUSTO2 "
			+ "FROM CURSO C, EMPRESA E, FUNCIONARIO F, TIPOCURSO TC "
			+ "WHERE C.CUR_CODIGO = "
			+ cur_codigo
			+ " "
			+ "AND C.FUN_CODIGO_RESP = F.FUN_CODIGO "
			+ "AND TC.TCU_CODIGO = C.TCU_CODIGO "
			+ "AND E.EMP_CODIGO = C.EMP_CODIGO";

	rs = conexao.executaConsulta(query, session.getId() + "RS1");
%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn EM</title>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<%!public String ReaistoStr(float valor, String moeda) {
		DecimalFormat dcf = new DecimalFormat("0.00");
		dcf.setMaximumFractionDigits(2);
		String strReais = dcf.format(valor);
		return moeda + strReais;
	}%>

<%!public String convHora(float minutos) {
		Float ft = new Float(minutos);
		int min = ft.intValue();

		String total = "";
		float result;
		int inteiro = 0, decimal = 0;

		result = min / 60;

		Float ft2 = new Float(result);
		inteiro = ft2.intValue();

		decimal = min % 60;

		total = inteiro + ":" + decimal;

		return total;
	}%>

<body onunload='return fecha();' bgcolor="#FFFFFF" text="#000000">
<form name="frm" method="post" action="">
<table width="100%" heigth="100%">
	<tr>

		<td align="center" valign="middle" align="center">
		<center>
		<table width="528" border="0" cellspacing="1" cellpadding="0">
			<tr>
				<!--<td class="celnortab" width="169"> 
              <div align="center"><%//=trd.Traduz("NOME DO CURSO")%>:</div>
            </td>-->
				<td class="celtittab" colspan="4" align="center">
				<%
					String nome_curso = "";
					if (rs.next()) {
						if (rs.getString(1) != null) {
							nome_curso = rs.getString(1);
						}
				%> <%=nome_curso%></td>
			</tr>
			<tr>
				<td align="center" class="celnortab"><b><%=trd.Traduz("ENTIDADE")%>:</b></td>
				<td class="celnortab" colspan="3">
				<%
						String entidade_curso = "";
						if (rs.getString(2) != null)
							entidade_curso = rs.getString(2);
				%> <%=entidade_curso%></td>
			</tr>
			<tr>
				<td class="celnortab" width="169">
				<div align="center"><b><%=trd.Traduz("TIPO")%>:</b></div>
				</td>
				<td class="celnortab" colspan="3">
				<%
						String tipo_curso = "";
						if (rs.getString(16) != null)
							tipo_curso = rs.getString(16);
				%> <%=tipo_curso%></td>
			</tr>
			<tr>
				<td class="celnortab" width="169">
				<div align="center"><b><%=trd.Traduz("RESPONSAVEL")%>:</b></div>
				</td>
				<td class="celnortab" colspan="3">
				<%
						String resp_curso = "";
						if (rs.getString(13) != null)
							resp_curso = rs.getString(13);
				%> <%=resp_curso%></td>
			</tr>
			<tr>
				<td class="celnortab" width="169">
				<div align="center"><b><%=trd.Traduz("E-MAIL")%>:</b></div>
				</td>
				<td class="celnortab" colspan="3">
				<%
						String mail_curso = "";
						if (rs.getString(5) != null)
							mail_curso = rs.getString(5);
				%> <%=mail_curso%></td>
			</tr>
			<tr>
				<td class="celnortab" width="169">
				<div align="center"><b><%=trd.Traduz("TELEFONE")%>:</b></div>
				</td>
				<td class="celnortab" width="110">
				<%
						String tel_curso = "";
						if (rs.getString(4) != null)
							tel_curso = rs.getString(4);
				%> <%=tel_curso%></td>
				<td class="celnortab" width="87">
				<div align="center"><b><%=trd.Traduz("CONTATO")%>:</b></div>
				</td>
				<td class="celnortab" width="117">
				<%
						String cont_curso = "";
						if (rs.getString(3) != null)
							cont_curso = rs.getString(3);
				%> <%=cont_curso%></td>
			</tr>
			<tr>
				<td class="celnortab" width="169">
				<div align="center"><b><%=trd.Traduz("CUSTO")%>:</b></div>
				</td>
				<td class="celnortab" width="110">
				<%
						float custo_curso = 0;
						if (rs.getString(6) != null)
							custo_curso = rs.getFloat(6);
				%> <%=ReaistoStr(custo_curso, moeda)%>
				</td>
				<td class="celnortab" width="87">
				<div align="center">
				<div align="center"><b><%=trd.Traduz("CUSTO LOGISTICA")%>:</b></div>
				</div>
				</td>
				<td class="celnortab" width="117">
				<%
						float custol_curso = 0;
						if (rs.getString(17) != null)
							custol_curso = rs.getFloat(17);
				%> <%=ReaistoStr(custol_curso, moeda)%>
				</td>
			</tr>
			<tr>
				<td class="celnortab" width="169">
				<div align="center"><b><%=trd.Traduz("VERSAO ATUAL")%>:</b></div>
				</td>
				<td class="celnortab" width="110">
				<%
						String ver_curso = "";
						if (rs.getString(10) != null)
							ver_curso = rs.getString(10);
				%> <%=ver_curso%></td>
				<td class="celnortab" width="87">
				<div align="center">
				<div align="center"><b><%=trd.Traduz("DURACAO")%>:</b></div>
				</div>
				</td>
				<td class="celnortab" width="117">
				<%
						float dur_curso = 0;
						if (rs.getString(7) != null)
							dur_curso = rs.getFloat(7);
				%> <%=convHora(rs.getFloat(7))%>
				</td>
			</tr>
			<tr>
				<td class="celnortab" width="169">
				<div align="center"><b><%=trd.Traduz("NUMERO MAXIMO")%>:</b></div>
				</td>
				<td class="celnortab" width="110">
				<%
						String nmax_curso = "";
						if (rs.getString(8) != null)
							nmax_curso = rs.getString(8);
				%> <%=nmax_curso%></td>
				<td align="center" class="celnortab" width="87"><b><%=trd.Traduz("NUMERO MINIMO")%>:</b></td>
				<td class="celnortab" width="117">
				<%
						String nmin_curso = "";
						if (rs.getString(9) != null)
							nmin_curso = rs.getString(9);
				%> <%=nmin_curso%></td>
			</tr>
		</table>
		</center>
		<center>
		<table width="530" border="0" cellspacing="1" cellpadding="0">
			<tr>
				<td class="celtittab">
				<div align="center"><%=trd.Traduz("OBJETIVO")%>:</div>
				</td>
			</tr>
			<tr class="ftverdanacinza">
				<%
						String obj_curso = "";
						if (rs.getString(11) != null)
							obj_curso = rs.getString(11);
				%>

				<td align="center" height="15"><%=obj_curso%></td>
			</tr>
			<tr>
				<td align="center" class="celtittab"><%=trd.Traduz("CONTEUDO PROGRAMATICO")%>:
				</td>
			</tr>
			<tr>
				<%
						String conteudo_curso = "";
						if (rs.getString(12) != null)
							conteudo_curso = rs.getString(12);
				%>
				<td align="center" class="ftverdanacinza" height="15"><%=conteudo_curso%></td>
			</tr>
			<tr>
				<td class="celtittab">
				<div align="center"><%=trd.Traduz("COMO AVALIAR")%>:</div>
				</td>
			</tr>
			<tr>
				<%
						String aval_curso = "";
						if (rs.getString(14) != null)
							aval_curso = rs.getString(14);
				%>
				<td align="center" class="ftverdanacinza" height="15"><%=aval_curso%></td>
			</tr>
			<tr>
				<td class="celtittab">
				<div align="center"><%=trd.Traduz("CONSIDERACOES GERAIS")%>:</div>
				</td>
			</tr>
			<tr>
				<%
						String cons_curso = "";
						if (rs.getString(15) != null)
							cons_curso = rs.getString(15);
				%>
				<td align="center" class="ftverdanacinza" height="15"><%=cons_curso%></td>
			</tr>
		</table>

		<table width="530" border="0" cellspacing="1" cellpadding="0">
			<tr>
				<td class="celtittab" colspan="2">
				<div align="center"><%=trd.Traduz("COMPETENCIAS BUSCADAS")%>:</div>
				</td>
			</tr>
			<%
					queryC = "SELECT C.CMP_DESCRICAO "
					+ "FROM COMPETENCIA C, CURSOCOMP CC "
					+ "WHERE CC.CUR_CODIGO = " + cur_codigo + " "
					+ "AND C.CMP_CODIGO = CC.CMP_CODIGO "
					+ "ORDER BY C.CMP_DESCRICAO ";
					rsC = conexao.executaConsulta(queryC, session.getId() + "RS2");

					if (rsC.next()) {
						do {
			%>
			<tr>
				<td colspan="2" class="ftverdanacinza" width="605">
				<li><%=rsC.getString(1)%>
				</td>
			</tr>
			<%
					} while (rsC.next());
					} else {
			%>
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
			<td>
			<%
					}

					if (rsC != null) {
						rsC.close();
						conexao.finalizaConexao(session.getId() + "RS2");
					}

				} else {
			%>
			<%=trd.Traduz("VERIFIQUE OS DADOS DESTE CURSO")%>...

			<%
			}
			%>
			</td>
			</tr>
		</table>
		</td>
	</tr>
	
	<tr>
		<td>&nbsp;</td>
	</tr>

	<tr>
		<td align="center"><input class="botcin" type="button"
			value="     <%=trd.Traduz("fechar")%>     " OnClick="window.close();">
		</td>
	</tr>
</table>
</form>

<%
		if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId() + "RS1");
	}
%>

</body>
</html>
<%
	//} catch(Exception e){
	//  out.println("ERRO:"+e);
	//}
%>