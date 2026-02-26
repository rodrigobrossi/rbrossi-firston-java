
<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
%>
<%
	request.getSession();
	firston.eval.components.FOParametersBean prm = (firston.eval.components.FOParametersBean) session
			.getAttribute("Param");
%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.util.*"%>

<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
	request.getSession();
	String fun_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	String dequem = (((String) request.getParameter("op") == null) ? "N"
			: (String) request.getParameter("op"));

	boolean grupo_perguntas = false, perguntas = false, respostas = false, grupo_respostas = false, montar_quest = false, responder = false, per_func_aval = false;

	Vector per = (Vector) session.getAttribute("vetorPermissoes");

	/*Verifica permissoes*/
	if (per.contains("AVALIACAO - GRUPO PERGUNTAS")) {
		grupo_perguntas = true;
	} // Sub-Menu Grupo Perguntas
	if (per.contains("AVALIACAO - PERGUNTAS")) {
		perguntas = true;
	} // Sub-Menu Perguntas
	if (per.contains("AVALIACAO - RESPOSTAS")) {
		respostas = true;
	} // Sub-Menu Respostas
	if (per.contains("AVALIACAO - GRUPO RESPOSTAS")) {
		grupo_respostas = true;
	} // Sub-Menu Grupo Respostas
	if (per.contains("AVALIACAO - MONTAR QUESTIONARIO")) {
		montar_quest = true;
	} // Sub-Menu Montar QuestionArio
	if (per.contains("AVALIACAO - RESPONDER")) {
		responder = true;
	} // Sub-Menu Responder
	if (per.contains("AVALIACAO - FUNCIONARIO PARA AVALIACAO")) {
		per_func_aval = true;
	} // Sub-Menu Responder

	String func_aval = "";
	func_aval = prm.buscaparam("USE_FUNCAVAL");
%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><tr>
	<td class="snfundo">
	<table border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="2" cellpadding="0">
				<tr>

					<%
						if (grupo_perguntas) {
							if (dequem.equals("GP")) {
					%>
					<td onClick="location='grupopergunta.jsp?opt=AV&op=GP';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="imagens/bit.gif" width="10" height="5"><a
						href="grupopergunta.jsp?opt=AV&op=GP" class="snofitm"><label
						title=""><%=trd.Traduz("GRUPO PERGUNTAS")%></label></a><img
						src="imagens/bit.gif" width="10" height="5"></td>
					<%
						} else {
					%>
					<td onClick="location='grupopergunta.jsp?opt=AV&op=GP';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img
						src="imagens/bit.gif" width="10" height="5"><a
						href="grupopergunta.jsp?opt=AV&op=GP" class="snofitm"><label
						title="questionario.jsp"><%=trd.Traduz("GRUPO PERGUNTAS")%></label></a><img
						src="imagens/bit.gif" width="10" height="5"></td>
					<%
						}
						}

						if (perguntas) {
							if (dequem.equals("P")) {
					%>
					<td width="1" class="snhdiv"><img src="imagens/bit.gif"
						width="1" height="1"></td>
					<td onClick="location='questoes.jsp?opt=AV&op=P';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="imagens/bit.gif" width="10" height="5"><a
						href="questoes.jsp?opt=AV&op=P" class="snofitm"><label
						title=""><%=trd.Traduz("PERGUNTAS")%></label></a><img
						src="imagens/bit.gif" width="10" height="5"></td>
					<%
						} else {
					%>
					<td width="1" class="snhdiv"><img src="imagens/bit.gif"
						width="1" height="1"></td>
					<td onClick="location='questoes.jsp?opt=AV&op=P';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img
						src="imagens/bit.gif" width="10" height="5"><a
						href="questoes.jsp?opt=AV&op=P" class="snofitm"><label
						title=""><%=trd.Traduz("PERGUNTAS")%></label></a><img
						src="imagens/bit.gif" width="10" height="5"></td>
					<%
						}
						}

						if (respostas) {
							if (dequem.equals("R")) {
					%>
					<td width="1" class="snhdiv"><img src="imagens/bit.gif"
						width="1" height="1"></td>
					<td onClick="location='resposta.jsp?opt=AV&op=R';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="imagens/bit.gif" width="10" height="5"><a
						href="resposta.jsp?opt=AV&op=R" class="snofitm"><label
						title=""><%=trd.Traduz("RESPOSTAS")%></label><img
						src="imagens/bit.gif" width="10" height="5"></td>
					<%
						} else {
					%>
					<td width="1" class="snhdiv"><img src="imagens/bit.gif"
						width="1" height="1"></td>
					<td onClick="location='resposta.jsp?opt=AV&op=R';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img
						src="imagens/bit.gif" width="10" height="5"><a
						href="resposta.jsp?opt=AV&op=R" class="snofitm"><label
						title=""><%=trd.Traduz("RESPOSTAS")%></label><img
						src="imagens/bit.gif" width="10" height="5"></td>
					<%
						}
						}

						if (grupo_respostas) {
							if (dequem.equals("GR")) {
					%>
					<td width="1" class="snhdiv"><img src="imagens/bit.gif"
						width="1" height="1"></td>
					<td onClick="location='gruporesposta.jsp?opt=AV&op=GR';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="imagens/bit.gif" width="10" height="5"><a
						href="gruporesposta.jsp?opt=AV&op=GR" class="snofitm"><label
						title=""><%=trd.Traduz("GRUPO RESPOSTAS")%></label><img
						src="imagens/bit.gif" width="10" height="5"></td>
					<%
						} else {
					%>
					<td width="1" class="snhdiv"><img src="imagens/bit.gif"
						width="1" height="1"></td>
					<td onClick="location='gruporesposta.jsp?opt=AV&op=GR';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img
						src="imagens/bit.gif" width="10" height="5"><a
						href="gruporesposta.jsp?opt=AV&op=GR" class="snofitm"><label
						title=""><%=trd.Traduz("GRUPO RESPOSTAS")%></label><img
						src="imagens/bit.gif" width="10" height="5"></td>
					<%
						}
						}

						if (montar_quest) {
							if (dequem.equals("MQ")) {
					%>
					<td width="1" class="snhdiv"><img src="imagens/bit.gif"
						width="1" height="1"></td>
					<td onClick="location='questionario.jsp?opt=AV&op=MQ';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="imagens/bit.gif" width="10" height="5"><a
						href="questionario.jsp?opt=AV&op=MQ" class="snofitm"><label
						title=""><%=trd.Traduz("MONTAR QUESTIONARIO")%></label><img
						src="imagens/bit.gif" width="10" height="5"></td>
					<%
						} else {
					%>
					<td width="1" class="snhdiv"><img src="imagens/bit.gif"
						width="1" height="1"></td>
					<td onClick="location='questionario.jsp?opt=AV&op=MQ';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img
						src="imagens/bit.gif" width="10" height="5"><a
						href="questionario.jsp?opt=AV&op=MQ" class="snofitm"><label
						title=""><%=trd.Traduz("MONTAR QUESTIONARIO")%></label><img
						src="imagens/bit.gif" width="10" height="5"></td>
					<%
						}
						}

						if (per_func_aval) {
							if (func_aval.equals("S")) {
								if (dequem.equals("FA")) {
					%>
					<td width="1" class="snhdiv"><img src="imagens/bit.gif"
						width="1" height="1"></td>
					<td onClick="location='funcionarioavaliacao.jsp?opt=AV&op=FA';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="imagens/bit.gif" width="10" height="5"><a
						href="funcionarioavaliacao.jsp?opt=AV&op=FA" class="snofitm"><label
						title=""><%=trd
												.Traduz("FUNCIONARIO PARA AVALIACAO")%></label><img
						src="imagens/bit.gif" width="10" height="5"></td>
					<%
						} else {
					%>
					<td width="1" class="snhdiv"><img src="imagens/bit.gif"
						width="1" height="1"></td>
					<td onClick="location='funcionarioavaliacao.jsp?opt=AV&op=FA';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img
						src="imagens/bit.gif" width="10" height="5"><a
						href="funcionarioavaliacao.jsp?opt=AV&op=FA" class="snofitm"><label
						title=""><%=trd
												.Traduz("FUNCIONARIO PARA AVALIACAO")%></label><img
						src="imagens/bit.gif" width="10" height="5"></td>
					<%
						}
							}
						}

						if (responder) {
							if (dequem.equals("RE")) {
					%>
					<td width="1" class="snhdiv"><img src="imagens/bit.gif"
						width="1" height="1"></td>
					<td onClick="location='responder.jsp?opt=AV&op=R';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="imagens/bit.gif" width="10" height="5"><a
						href="responder.jsp?opt=AV&op=R" class="snofitm"><label
						title=""><%=trd.Traduz("RESPONDER")%></label><img
						src="imagens/bit.gif" width="10" height="5"></td>
					<%
						} else {
					%>
					<td width="1" class="snhdiv"><img src="imagens/bit.gif"
						width="1" height="1"></td>
					<td onClick="location='responder.jsp?opt=AV&op=R';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img
						src="imagens/bit.gif" width="10" height="5"><a
						href="responder.jsp?opt=AV&op=R" class="snofitm"><label
						title=""><%=trd.Traduz("RESPONDER")%></label><img
						src="imagens/bit.gif" width="10" height="5"></td>
					<%
						}
						}
					%>
					<td nowrap width="100%">&nbsp;</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	</td>
</tr>