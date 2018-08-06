
<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
%>
<%
	request.getSession();
	firston.eval.components.FOParametersBean prm = (firston.eval.components.FOParametersBean) session
			.getAttribute("Param");
%>
<%
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.lang.Math.*,java.util.*,java.text.*"%>
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
	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_plano = "";
	usu_plano = usu_plano.valueOf(session.getAttribute("usu_plano"));
	String query = "";

	Vector per = (Vector) session.getAttribute("vetorPermissoes");

	//try{

	/*VARIAVEIS DE PESQUISA - SUBMENU CADASTRO*/
	boolean assunto = false, competencia = false, compTitulo = false, cursos = false, entidades = false, instrutores = false, idiomas = false, justificativas = false, saratoga = false, auxiliares = false, alterDesen = false, local = false, titulos = false, plano = false, prerequisitos = false, funcionarios = false, avaliacoes = false, plano2 = false, assunto2 = false, titulos2 = false, alterDesen2 = false, entidades2 = false, instrutores2 = false, saratoga2 = false, local2 = false, cursos2 = false, prerequisitos2 = false, justificativas2 = false;

	/*VARIAVEIS DE PESQUISA - SUBMENU IMPRESSOES*/
	boolean impPlano = false, treinoEfetuado = false, gestaoTreino = false, matrizTreino = false, matrizComp = false, impGrafico = false, planejTurma = false, impAval = false, tabulaAval = false, apuraAval = false;

	/*VARIAVEIS DE PESQUISA - SUBMENU REGISTRO*/
	boolean listaPre = false, rapido = false, /*longaDu   = false,  */
	antecipado = false, anterior = false;

	/*VARIAVEIS DE PESQUISA - SUBMENU JUSTIFICATIVA*/
	boolean criaJust = false, just = false, extra = false, aprovaplano = false;

	if (per.contains("CADASTRO ASSUNTO - CONSULTA")
			&& per.contains("CADASTRO ASSUNTO - MANUTENCAO")) {
		assunto = true;
	} // Sub-Menu Assunto
	if (per.contains("CADASTRO COMPETENCIA - CONSULTA")) {
		competencia = true;
	} // Sub-Competencia
	if (per.contains("CADASTRO COMP.TITULO - CONSULTA")
			&& per.contains("CADASTRO COMP.TITULO - MANUTENCAO")) {
		compTitulo = true;
	} // Sub-CompTitulo
	if (per.contains("CADASTRO CURSO - CONSULTA")
			&& per.contains("CADASTRO CURSO - MANUTENCAO")) {
		cursos = true;
	} // Sub-Cursos
	if (per.contains("CADASTRO ENTIDADE - CONSULTA")
			&& per.contains("CADASTRO ENTIDADE - MANUTENCAO")) {
		entidades = true;
	} // Sub-Entidades
	if (per.contains("CADASTRO INSTRUTOR - CONSULTA")
			&& per.contains("CADASTRO INSTRUTOR - MANUTENCAO")) {
		instrutores = true;
	} // Sub-Instrutore
	if (per.contains("CADASTRO IDIOMA - CONSULTA")
			&& per.contains("CADASTRO IDIOMA - MANUTENCAO")) {
		idiomas = true;
	} // Sub-Idiomas
	if (per.contains("CADASTRO JUSTIFICATIVA - CONSULTA")
			&& per.contains("CADASTRO JUSTIFICATIVA - MANUTENCAO")) {
		justificativas = true;
	} // Sub-Justificativas
	if (per.contains("CADASTRO SARATOGA - CONSULTA")
			&& per.contains("CADASTRO SARATOGA - MANUTENCAO")) {
		saratoga = true;
	} // Sub-Saratoga
	if (per.contains("CADASTRO - AUXILIAR")) {
		auxiliares = true;
	} // Sub-Auxiliares
	if (per.contains("CADASTRO ALTER.DESENV. - CONSULTA")
			&& per.contains("CADASTRO ALTER.DESENV. - MANUTENCAO")) {
		alterDesen = true;
	} // Sub-Alternativa de Desenvolvimento
	if (per.contains("CADASTRO TIPO - CONSULTA")
			&& per.contains("CADASTRO TIPO - MANUTENCAO")) {
		local = true;
	} // Sub-Local
	if (per.contains("CADASTRO TITULO - CONSULTA")
			&& per.contains("CADASTRO TITULO - MANUTENCAO")) {
		titulos = true;
	} // Sub-TItulos
	if (per.contains("CADASTRO PLANO - CONSULTA")
			&& per.contains("CADASTRO PLANO - MANUTENCAO")) {
		plano = true;
	} // Sub-Plano de Treinamento
	if (per.contains("CADASTRO PRE-REQ. - CONSULTA")
			&& per.contains("CADASTRO PRE-REQ. - MANUTENCAO")) {
		prerequisitos = true;
	} // Sub-Pre-Requisitos
	if (per.contains("CADASTRO FUNCIONARIO - CONSULTA")
			&& per.contains("CADASTRO FUNCIONARIO - MANUTENCAO")) {
		funcionarios = true;
	} // Sub-Funcionarios
	if (per.contains("CADASTRO AVALIACOES - CONSULTA")
			|| per.contains("CADASTRO AVALIACOES - MANUTENCAO")) {
		avaliacoes = true;
	} // Sub-AvaliaCOes
	if (per.contains("CADASTRO PLANO - CONSULTA")) {
		plano2 = true;
	} // Sub-Plano de Treinamento Consulta
	if (per.contains("CADASTRO ASSUNTO - CONSULTA")) {
		assunto2 = true;
	} // Sub-Menu Assunto Consulta
	if (per.contains("CADASTRO TITULO - CONSULTA")) {
		titulos2 = true;
	} // Sub-TItulos Consulta
	if (per.contains("CADASTRO ALTER.DESENV. - CONSULTA")) {
		alterDesen2 = true;
	} // Sub-Alternativa de Desenvolvimento Consulta
	if (per.contains("CADASTRO ENTIDADE - CONSULTA")) {
		entidades2 = true;
	} // Sub-Entidades Consulta
	if (per.contains("CADASTRO INSTRUTOR - CONSULTA")) {
		instrutores2 = true;
	} // Sub-Instrutore Consulta
	if (per.contains("CADASTRO SARATOGA - CONSULTA")) {
		saratoga2 = true;
	} // Sub-Saratoga Consulta
	if (per.contains("CADASTRO TIPO - CONSULTA")) {
		local2 = true;
	} // Sub-Local Consulta
	if (per.contains("CADASTRO CURSO - CONSULTA")) {
		cursos2 = true;
	} // Sub-Cursos Consulta
	if (per.contains("CADASTRO PRE-REQ. - CONSULTA")) {
		prerequisitos2 = true;
	} // Sub-Pre-Requisitos Consulta
	if (per.contains("CADASTRO JUSTIFICATIVA - CONSULTA")) {
		justificativas2 = true;
	} // Sub-Justificativas Consulta
	/*FIM DA PESQUISA DE PERMISSOES DE ACESSO PARA O SUBMENU - CADASTRO*/

	if (per.contains("IMPRESSOES - PLANO DE TREINAMENTO")) {
		impPlano = true;
	} // Sub-ImpressOes Plano de Treinamento
	if (per.contains("IMPRESSOES - TREINAMENTOS EFETUADOS")) {
		treinoEfetuado = true;
	} // Sub-ImpressOes Treinamentos Efetuados
	if (per.contains("IMPRESSOES - GESTAO DE TREINAMENTOS")) {
		gestaoTreino = true;
	} // Sub-ImpressOes GestAo de Treinamentos
	if (per.contains("IMPRESSOES - MATRIZ DE TREINAMENTO")) {
		matrizTreino = true;
	} // Sub-ImpressOes Matriz de Treinamentos 
	if (per.contains("IMPRESSOES - MATRIZ DE COMPETENCIAS")) {
		matrizComp = true;
	} // Sub-ImpressOes Matriz de CompetEncias
	if (per.contains("IMPRESSOES - GRAFICOS")) {
		impGrafico = true;
	} // Sub-ImpressOes de GrAficos
	if (per.contains("IMPRESSOES - PLANEJAMENTO DE TURMA")) {
		planejTurma = true;
	} // Sub-ImpressOes de Planejamento de Turma
	if (per.contains("IMPRESSOES - IMPRESSOES DAS AVALIACOES")) {
		impAval = true;
	} // Sub-ImpressOes das AvaliaCOes
	if (per.contains("IMPRESSOES - TABULACAO DAS AVALIACOES")) {
		tabulaAval = true;
	} // Sub-ImpressOes de TabulaCAo das AvaliaCOes
	if (per.contains("IMPRESSOES - APURACAO DAS AVALIACOES")) {
		apuraAval = true;
	} // Sub-ImpressOes de ApuraCAo das AvaliaCOes
	/*FIM DA PESQUISA DE PERMISSOES DE ACESSO PARA O SUBMENU - IMPRESSOES*/

	if (per.contains("REGISTRO - LISTA PRESENCA - CONSULTA")
			&& per.contains("REGISTRO - LISTA PRESENCA - MANUTENCAO")) {
		listaPre = true;
	} // Sub-Lista de presenCa
	if (per.contains("REGISTRO - RAPIDO - CONSULTA")
			&& per.contains("REGISTRO - RAPIDO - MANUTENCAO")) {
		rapido = true;
	} // Sub-Registro RApido
	//if(per.contains("REGISTRO - LONGA - CONSULTA")&&per.contains("REGISTRO - LONGA - MANUTENCAO"))                {longaDu  = true;}  // Sub-Longa DuraCAo
	if (per.contains("REGISTRO - PLANEJAMENTO DE TURMA - CONSULTA")
			&& per
					.contains("REGISTRO - PLANEJAMENTO DE TURMA - MANUTENCAO")) {
		antecipado = true;
	} // Sub-Antecipadas
	if (per.contains("REGISTRO - LANCAMENTO ANTERIOR - CONSULTA")
			&& per
					.contains("REGISTRO - LANCAMENTO ANTERIOR - MANUTENCAO")) {
		anterior = true;
	} // Sub-Anteriores
	/*FIM DA PESQUISA DE PERMISSOES DE ACESSO PARA O SUBMENU - REGISTRO*/

	/*PESQUISA DE PERMISSOES DE ACESSO - SUBMENU - JUSTIFICATIVAS*/
	if (per.contains("SOLICITACAO - SOLICITACAO EXTRA")
			|| per.contains("SOLICITACAO - REPROGRAMACAO")
			|| per.contains("SOLICITACAO - PRE REQUISITOS - CONSULTA")
			|| per
					.contains("SOLICITACAO - PRE REQUISITOS - MANUTENCAO")
			|| per
					.contains("SOLICITACAO - POR COMPETENCIAS - MANUTENCAO")
			|| per
					.contains("SOLICITACAO - POR COMPETENCIAS - CONSULTA")
			|| per.contains("SOLICITACAO - PLANO SUCESSORIO")) {
		criaJust = true;
	} // Sub-Cria SolicitaCAo
	if (per.contains("SOLICITACAO - JUSTIFICATIVA")) {
		just = true;
	} // Sub-Justificativas
	if (per.contains("SOLICITACAO - SOLICITACAO EXTRA")) {
		extra = true;
	} // Sub-SolicitaCAo Extra
	if (per.contains("SOLICITACAO - APROVACAO DO PLANO")) {
		aprovaplano = true;
	} // Sub-Aprova Plano

	String aprova_plano = prm.buscaparam("APROVA_PLANO");
	/*FIM DA PESQUISA DE PERMISSOES DE ACESSO PARA O SUBMENU - JUSTIFICATIVAS*/

	String ops = "", m = "";

	if (request.getParameter("opt") == null) {
		ops = "X";
	} else {
		ops = request.getParameter("opt");
	}
	if (request.getParameter("main") == null) {
		m = "N";
	} else {
		m = "S";
	}

	// conexao.finalizaConexao();
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
						if (!(request.getParameter("main") == null)) {
					%>
					<td width="12"><img src="art/bit.gif" width="12" height="15"></td>
					<%
						} else {
					%>
					<td width="12"><img src="../art/bit.gif" width="12"
						height="15"></td>
					<%
						}
						if (ops.equals("S")) {
							if (criaJust) {
					%>
					<td align="center" valign="middle"
						onClick="location='index.jsp?opt=S&op=S';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("CriaCAo de solicitaCAo de cursos para funcionArios") + "\"")%>><%=trd.Traduz("Criar SolicitaCAo")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							if (extra) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='index.jsp?opt=E&op=S';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("SolicitaCAo Extra de cursos para funcionArios") + "\"")%>><%=trd.Traduz("SolicitaCAo Extra")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							if (aprovaplano) {
								if (aprova_plano.equals("S")) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='aprovacao1.jsp?opt=AP&op=S';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("AprovaCAo do Plano de treinamento") + "\"")%>><%=trd.Traduz("AprovaCAo do Plano")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							}
							if (just) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='justificativa.jsp?opt=J&op=S';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("Justificativa para cursos nAo realizados") + "\"")%>><%=trd.Traduz("Justificativa")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
						} else if (ops.equals("J")) {
							if (criaJust) {
					%>
					<td align="center" valign="middle"
						onClick="location='index.jsp?opt=S&op=S';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("CriaCAo de solicitaCAo de cursos para funcionArios") + "\"")%>><%=trd.Traduz("Criar SolicitaCAo")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							if (extra) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='index.jsp?opt=E&op=S';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("SolicitaCAo Extra de cursos para funcionArios") + "\"")%>><%=trd.Traduz("SolicitaCAo Extra")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							if (aprovaplano) {
								if (aprova_plano.equals("S")) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='aprovacao1.jsp?opt=AP&op=S';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("AprovaCAo do Plano de treinamento") + "\"")%>><%=trd.Traduz("AprovaCAo do Plano")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							}
							if (just) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='justificativa.jsp?opt=J&op=S';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("Justificativa para cursos nAo realizados") + "\"")%>><%=trd.Traduz("Justificativa")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
						} else if (ops.equals("AP")) {
							if (criaJust) {
					%>
					<td align="center" valign="middle"
						onClick="location='index.jsp?opt=S&op=S';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("CriaCAo de solicitaCAo de cursos para funcionArios") + "\"")%>><%=trd.Traduz("Criar SolicitaCAo")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							if (extra) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='index.jsp?opt=E&op=S';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("SolicitaCAo Extra de cursos para funcionArios") + "\"")%>><%=trd.Traduz("SolicitaCAo Extra")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							if (aprovaplano) {
								if (aprova_plano.equals("S")) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='aprovacao1.jsp?opt=AP&op=S';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("AprovaCAo do Plano de treinamento") + "\"")%>><%=trd.Traduz("AprovaCAo do Plano")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							}
							if (just) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='justificativa.jsp?opt=J&op=S';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("Justificativa para cursos nAo realizados") + "\"")%>><%=trd.Traduz("Justificativa")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
						} else if (ops.equals("E")) {
							if (criaJust) {
					%>
					<td align="center" valign="middle"
						onClick="location='index.jsp?opt=S&op=S';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("CriaCAo de solicitaCAo de cursos para funcionArios") + "\"")%>><%=trd.Traduz("Criar SolicitaCAo")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							if (extra) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='index.jsp?opt=E&op=S';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("SolicitaCAo Extra de cursos para funcionArios") + "\"")%>><%=trd.Traduz("SolicitaCAo Extra")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							if (aprova_plano.equals("S")) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='aprovacao1.jsp?opt=AP&op=S';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("AprovaCAo do Plano de treinamento") + "\"")%>><%=trd.Traduz("AprovaCAo do Plano")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							if (just) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='justificativa.jsp?opt=J&op=S';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("Justificativa para cursos nAo realizados") + "\"")%>><%=trd.Traduz("Justificativa")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
						} else if (ops.equals("SA")) {
							if (m.equals("S")) {
								if (criaJust) {
					%>
					<td align="center" valign="middle"
						onClick="location='solicitacao/index.jsp?opt=S&op=S';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CriaCAo de solicitaCAo de cursos para funcionArios") + "\"")%>><%=trd.Traduz("Criar SolicitaCAo")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
								if (extra) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='solicitacao/index.jsp?opt=E&op=S';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("SolicitaCAo Extra de cursos para funcionArios") + "\"")%>><%=trd.Traduz("SolicitaCAo Extra")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
								if (aprovaplano) {
									if (aprova_plano.equals("S")) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='aprovacao1.jsp?opt=AP&op=S';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
													+ trd
															.Traduz("AprovaCAo do Plano de treinamento") + "\"")%>><%=trd.Traduz("AprovaCAo do Plano")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
								}
								if (just) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='solicitacao/justificativa.jsp?op=S&opt=J';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Justificativa para cursos nAo realizados") + "\"")%>><%=trd.Traduz("Justificativa")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							} else {
								if (criaJust) {
					%>
					<td align="center" valign="middle"
						onClick="location='../solicitacao/index.jsp?op=S&opt=S';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CriaCAo de solicitaCAo de cursos para funcionArios") + "\"")%>><%=trd.Traduz("Criar SolicitaCAo")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
								if (extra) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='../solicitacao/index.jsp?opt=E&op=S';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("SolicitaCAo Extra de cursos para funcionArios") + "\"")%>><%=trd.Traduz("SolicitaCAo Extra")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
								if (aprovaplano) {
									if (aprova_plano.equals("S")) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='aprovacao1.jsp?opt=AP&op=S';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
													+ trd
															.Traduz("AprovaCAo do Plano de treinamento") + "\"")%>><%=trd.Traduz("AprovaCAo do Plano")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
								}
								if (just) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='../solicitacao/justificativa.jsp?op=S&opt=J';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Justificativa para cursos nAo realizados") + "\"")%>><%=trd.Traduz("Justificativa")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							}
						} else if (ops.equals("X")) {
						}/*INICIO SUBMENU IMPRESSAO*/
						else if (ops.equals("IA")) {
							if (m.equals("S")) {
					%>
					<%
						if (impPlano) {
					%>
					<td align="center" valign="middle"
						onClick="location='impressoes/01_planodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("ImpressAo do relatOrio do plano anual de treinamento dos funcionArios") + "\"")%>><%=trd.Traduz("Plano Anual")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (treinoEfetuado) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='impressoes/01_treinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("ImpressAo do relatOrio de treinamentos efetuados dos funcionArios") + "\"")%>><%=trd.Traduz("Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (gestaoTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='impressoes/01_gestaodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("ImpressAo do relatOrio de gestAo treinamento dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("GestAo de Treinamento")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizComp) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='impressoes/01_matrizdecompetencias.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("ImpressAo do relatOrio de matriz por competEncias dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de CompetEncias")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='impressoes/01_matrizdetreinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("ImpressAo do relatOrio de matriz de treinamentos dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>


					<!--Quebra de Linha-->
				</tr>
				<tr width="0" height="0">
					<td class="snombck"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td colspan="100%" class="snhdiv"><img src="art/bit.gif"
						width="1" height="1"></td>
				</tr>
				<tr>
					<td class="snombck"><img src="art/bit.gif" width="0"
						height="0"></td>

					<%
						if (impGrafico) {
					%>
					<td align="center" valign="middle"
						onClick="location='impressoes/graficos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("ImpressAo dos grAficos dos funcionArios") + "\"")%>><%=trd.Traduz("GrAficos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (planejTurma) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='impressoes/01_planejamentodeturma.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("PLANEJAMENTO DE TURMA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (impAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='impressoes/01_impressaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("IMPRESSOES DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (tabulaAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='impressoes/01_tabulacaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("TABULACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (apuraAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='impressoes/01_apuracaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("APURACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>

					<%
						}
					%>
					<%
						} else {
					%>
					<%
						if (impPlano) {
					%>
					<td align="center" valign="middle"
						onClick="location='../impressoes/01_planodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("ImpressAo do relatOrio do plano anual de treinamento dos funcionArios") + "\"")%>><%=trd.Traduz("Plano Anual")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (treinoEfetuado) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='../impressoes/01_treinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("ImpressAo do relatOrio de treinamentos efetuados dos funcionArios") + "\"")%>><%=trd.Traduz("Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (gestaoTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='../impressoes/01_gestaodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("ImpressAo do relatOrio de gestAo treinamento dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("GestAo de Treinamento")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizComp) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='../impressoes/01_matrizdecompetencias.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("ImpressAo do relatOrio de matriz por competEncias dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de CompetEncias")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='../impressoes/01_matrizdetreinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("ImpressAo do relatOrio de matriz de treinamentos dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<!--Quebra de Linha-->
				</tr>
				<tr width="0" height="0">
					<td class="snombck"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td colspan="100%" class="snhdiv"><img src="art/bit.gif"
						width="1" height="1"></td>
				</tr>

				<tr>
					<td class="snombck"><img src="art/bit.gif" width="0"
						height="0"></td>

					<%
						if (impGrafico) {
					%>
					<td align="center" valign="middle"
						onClick="location='../impressoes/graficos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("ImpressAo dos grAficos dos funcionArios") + "\"")%>><%=trd.Traduz("GrAficos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (planejTurma) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='../impressoes/01_planejamentodeturma.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("PLANEJAMENTO DE TURMA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (impAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='../impressoes/01_impressaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("IMPRESSOES DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (tabulaAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='../impressoes/01_tabulacaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("TABULACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (apuraAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='../impressoes/01_apuracaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("APURACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						}
						} else if (ops.equals("P")) {
					%>
					<%
						if (impPlano) {
					%>
					<td align="center" valign="middle"
						onClick="location='01_planodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio do plano anual de treinamento dos funcionArios") + "\"")%>><%=trd.Traduz("Plano Anual")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (treinoEfetuado) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_treinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de treinamentos efetuados dos funcionArios") + "\"")%>><%=trd.Traduz("Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (gestaoTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_gestaodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de gestAo treinamento dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("GestAo de Treinamento")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizComp) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_matrizdecompetencias.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de matriz por competEncias dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de CompetEncias")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_matrizdetreinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de matriz de treinamentos dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<!--Quebra de Linha-->
				</tr>
				<tr width="0" height="0">
					<td class="snombck"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td colspan="100%" class="snhdiv"><img src="art/bit.gif"
						width="1" height="1"></td>
				</tr>

				<tr>
					<td class="snombck"><img src="art/bit.gif" width="0"
						height="0"></td>

					<%
						if (impGrafico) {
					%>
					<td align="center" valign="middle"
						onClick="location='graficos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo dos grAficos dos funcionArios") + "\"")%>><%=trd.Traduz("GrAficos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (planejTurma) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_planejamentodeturma.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("PLANEJAMENTO DE TURMA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (impAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_impressaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("IMPRESSOES DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (tabulaAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_tabulacaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("TABULACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (apuraAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_apuracaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("APURACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						} else if (ops.equals("T")) {
					%>
					<%
						if (impPlano) {
					%>
					<td align="center" valign="middle"
						onClick="location='01_planodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio do plano anual de treinamento dos funcionArios") + "\"")%>><%=trd.Traduz("Plano Anual")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (treinoEfetuado) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_treinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de treinamentos efetuados dos funcionArios") + "\"")%>><%=trd.Traduz("Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (gestaoTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_gestaodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de gestAo treinamento dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("GestAo de Treinamento")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizComp) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_matrizdecompetencias.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de matriz por competEncias dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de CompetEncias")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_matrizdetreinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de matriz de treinamentos dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<!--Quebra de Linha-->
				</tr>
				<tr width="0" height="0">
					<td class="snombck"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td colspan="100%" class="snhdiv"><img src="art/bit.gif"
						width="1" height="1"></td>
				</tr>

				<tr>
					<td class="snombck"><img src="art/bit.gif" width="0"
						height="0"></td>

					<%
						if (impGrafico) {
					%>
					<td align="center" valign="middle"
						onClick="location='graficos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo dos grAficos dos funcionArios") + "\"")%>><%=trd.Traduz("GrAficos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (planejTurma) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_planejamentodeturma.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("PLANEJAMENTO DE TURMA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (impAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_impressaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("IMPRESSOES DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (tabulaAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_tabulacaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("TABULACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (apuraAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_apuracaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("APURACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						} else if (ops.equals("G")) {
					%>
					<%
						if (impPlano) {
					%>
					<td align="center" valign="middle"
						onClick="location='01_planodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio do plano anual de treinamento dos funcionArios") + "\"")%>><%=trd.Traduz("Plano Anual")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (treinoEfetuado) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_treinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de treinamentos efetuados dos funcionArios") + "\"")%>><%=trd.Traduz("Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (gestaoTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_gestaodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de gestAo treinamento dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("GestAo de Treinamento")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizComp) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_matrizdecompetencias.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de matriz por competEncias dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de CompetEncias")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_matrizdetreinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de matriz de treinamentos dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<!--Quebra de Linha-->
				</tr>
				<tr width="0" height="0">
					<td class="snombck"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td colspan="100%" class="snhdiv"><img src="art/bit.gif"
						width="1" height="1"></td>
				</tr>

				<tr>
					<td class="snombck"><img src="art/bit.gif" width="0"
						height="0"></td>

					<%
						if (impGrafico) {
					%>
					<td align="center" valign="middle"
						onClick="location='graficos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo dos grAficos dos funcionArios") + "\"")%>><%=trd.Traduz("GrAficos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (planejTurma) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_planejamentodeturma.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("PLANEJAMENTO DE TURMA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (impAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_impressaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("IMPRESSOES DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (tabulaAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_tabulacaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("TABULACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (apuraAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_apuracaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("APURACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						} else if (ops.equals("MC")) {
					%>
					<%
						if (impPlano) {
					%>
					<td align="center" valign="middle"
						onClick="location='01_planodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio do plano anual de treinamento dos funcionArios") + "\"")%>><%=trd.Traduz("Plano Anual")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (treinoEfetuado) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_treinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de treinamentos efetuados dos funcionArios") + "\"")%>><%=trd.Traduz("Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (gestaoTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_gestaodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de gestAo treinamento dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("GestAo de Treinamento")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizComp) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_matrizdecompetencias.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de matriz por competEncias dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de CompetEncias")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_matrizdetreinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de matriz de treinamentos dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<!--Quebra de Linha-->
				</tr>
				<tr width="0" height="0">
					<td class="snombck"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td colspan="100%" class="snhdiv"><img src="art/bit.gif"
						width="1" height="1"></td>
				</tr>

				<tr>
					<td class="snombck"><img src="art/bit.gif" width="0"
						height="0"></td>

					<%
						if (impGrafico) {
					%>
					<td align="center" valign="middle"
						onClick="location='graficos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo dos grAficos dos funcionArios") + "\"")%>><%=trd.Traduz("GrAficos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (planejTurma) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_planejamentodeturma.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("PLANEJAMENTO DE TURMA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (impAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_impressaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("IMPRESSOES DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (tabulaAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_tabulacaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("TABULACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (apuraAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_apuracaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("APURACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						} else if (ops.equals("M")) {
					%>
					<%
						if (impPlano) {
					%>
					<td align="center" valign="middle"
						onClick="location='01_planodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio do plano anual de treinamento dos funcionArios") + "\"")%>><%=trd.Traduz("Plano Anual")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (treinoEfetuado) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_treinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de treinamentos efetuados dos funcionArios") + "\"")%>><%=trd.Traduz("Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (gestaoTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_gestaodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de gestAo treinamento dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("GestAo de Treinamento")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizComp) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_matrizdecompetencias.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de matriz por competEncias dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de CompetEncias")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_matrizdetreinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de matriz de treinamentos dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<!--Quebra de Linha-->
				</tr>
				<tr width="0" height="0">
					<td class="snombck"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td colspan="100%" class="snhdiv"><img src="art/bit.gif"
						width="1" height="1"></td>
				</tr>

				<tr>
					<td class="snombck"><img src="art/bit.gif" width="0"
						height="0"></td>

					<%
						if (impGrafico) {
					%>
					<td align="center" valign="middle"
						onClick="location='graficos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo dos grAficos dos funcionArios") + "\"")%>><%=trd.Traduz("GrAficos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (planejTurma) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_planejamentodeturma.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("PLANEJAMENTO DE TURMA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (impAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_impressaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("IMPRESSOES DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (tabulaAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_tabulacaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("TABULACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (apuraAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_apuracaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("APURACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						} else if (ops.equals("GF")) {
					%>
					<%
						if (impPlano) {
					%>
					<td align="center" valign="middle"
						onClick="location='01_planodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio do plano anual de treinamento dos funcionArios") + "\"")%>><%=trd.Traduz("Plano Anual")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (treinoEfetuado) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_treinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de treinamentos efetuados dos funcionArios") + "\"")%>><%=trd.Traduz("Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (gestaoTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_gestaodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de gestAo treinamento dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("GestAo de Treinamento")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizComp) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_matrizdecompetencias.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de matriz por competEncias dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de CompetEncias")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_matrizdetreinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de matriz de treinamentos dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<!--Quebra de Linha-->
				</tr>
				<tr width="0" height="0">
					<td class="snombck"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td colspan="100%" class="snhdiv"><img src="art/bit.gif"
						width="1" height="1"></td>
				</tr>

				<tr>
					<td class="snombck"><img src="art/bit.gif" width="0"
						height="0"></td>

					<%
						if (impGrafico) {
					%>
					<td align="center" valign="middle"
						onClick="location='graficos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo dos grAficos dos funcionArios") + "\"")%>><%=trd.Traduz("GrAficos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (planejTurma) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_planejamentodeturma.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("PLANEJAMENTO DE TURMA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (impAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_impressaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("IMPRESSOES DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (tabulaAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_tabulacaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("TABULACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (apuraAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_apuracaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("APURACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						}

						else if (ops.equals("PDT")) {
					%>
					<%
						if (impPlano) {
					%>
					<td align="center" valign="middle"
						onClick="location='01_planodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio do plano anual de treinamento dos funcionArios") + "\"")%>><%=trd.Traduz("Plano Anual")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (treinoEfetuado) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_treinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de treinamentos efetuados dos funcionArios") + "\"")%>><%=trd.Traduz("Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (gestaoTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_gestaodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de gestAo treinamento dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("GestAo de Treinamento")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizComp) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_matrizdecompetencias.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de matriz por competEncias dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de CompetEncias")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_matrizdetreinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de matriz de treinamentos dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<!--Quebra de Linha-->
				</tr>
				<tr width="0" height="0">
					<td class="snombck"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td colspan="100%" class="snhdiv"><img src="art/bit.gif"
						width="1" height="1"></td>
				</tr>

				<tr>
					<td class="snombck"><img src="art/bit.gif" width="0"
						height="0"></td>

					<%
						if (impGrafico) {
					%>
					<td align="center" valign="middle"
						onClick="location='graficos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo dos grAficos dos funcionArios") + "\"")%>><%=trd.Traduz("GrAficos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (planejTurma) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_planejamentodeturma.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label title=""><%=trd.Traduz("PLANEJAMENTO DE TURMA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (impAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_impressaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("IMPRESSOES DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (tabulaAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_tabulacaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("TABULACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (apuraAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_apuracaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("APURACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						}

						else if (ops.equals("IDA")) {
					%>
					<%
						if (impPlano) {
					%>
					<td align="center" valign="middle"
						onClick="location='01_planodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio do plano anual de treinamento dos funcionArios") + "\"")%>><%=trd.Traduz("Plano Anual")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (treinoEfetuado) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_treinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de treinamentos efetuados dos funcionArios") + "\"")%>><%=trd.Traduz("Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (gestaoTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_gestaodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de gestAo treinamento dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("GestAo de Treinamento")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizComp) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_matrizdecompetencias.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de matriz por competEncias dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de CompetEncias")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_matrizdetreinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de matriz de treinamentos dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<!--Quebra de Linha-->
				</tr>
				<tr width="0" height="0">
					<td class="snombck"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td colspan="100%" class="snhdiv"><img src="art/bit.gif"
						width="1" height="1"></td>
				</tr>

				<tr>
					<td class="snombck"><img src="art/bit.gif" width="0"
						height="0"></td>

					<%
						if (impGrafico) {
					%>
					<td align="center" valign="middle"
						onClick="location='graficos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo dos grAficos dos funcionArios") + "\"")%>><%=trd.Traduz("GrAficos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (planejTurma) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_planejamentodeturma.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("PLANEJAMENTO DE TURMA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (impAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_impressaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label title=""><%=trd.Traduz("IMPRESSOES DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (tabulaAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_tabulacaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("TABULACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (apuraAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_apuracaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("APURACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						}

						else if (ops.equals("TDA")) {
					%>
					<%
						if (impPlano) {
					%>
					<td align="center" valign="middle"
						onClick="location='01_planodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio do plano anual de treinamento dos funcionArios") + "\"")%>><%=trd.Traduz("Plano Anual")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (treinoEfetuado) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_treinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de treinamentos efetuados dos funcionArios") + "\"")%>><%=trd.Traduz("Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (gestaoTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_gestaodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de gestAo treinamento dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("GestAo de Treinamento")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizComp) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_matrizdecompetencias.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de matriz por competEncias dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de CompetEncias")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_matrizdetreinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de matriz de treinamentos dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<!--Quebra de Linha-->
				</tr>
				<tr width="0" height="0">
					<td class="snombck"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td colspan="100%" class="snhdiv"><img src="art/bit.gif"
						width="1" height="1"></td>
				</tr>

				<tr>
					<td class="snombck"><img src="art/bit.gif" width="0"
						height="0"></td>

					<%
						if (impGrafico) {
					%>
					<td align="center" valign="middle"
						onClick="location='graficos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo dos grAficos dos funcionArios") + "\"")%>><%=trd.Traduz("GrAficos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (planejTurma) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_planejamentodeturma.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("PLANEJAMENTO DE TURMA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (impAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_impressaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("IMPRESSOES DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (tabulaAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_tabulacaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label title=""><%=trd.Traduz("TABULACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (apuraAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_apuracaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("APURACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						}

						else if (ops.equals("ADA")) {
					%>
					<%
						if (impPlano) {
					%>
					<td align="center" valign="middle"
						onClick="location='01_planodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio do plano anual de treinamento dos funcionArios") + "\"")%>><%=trd.Traduz("Plano Anual")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (treinoEfetuado) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_treinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de treinamentos efetuados dos funcionArios") + "\"")%>><%=trd.Traduz("Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (gestaoTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_gestaodetreinamento.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de gestAo treinamento dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("GestAo de Treinamento")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizComp) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_matrizdecompetencias.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de matriz por competEncias dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de CompetEncias")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (matrizTreino) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_matrizdetreinamentos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo do relatOrio de matriz de treinamentos dos funcionArios em forma de matriz") + "\"")%>><%=trd.Traduz("Matriz de Treinamentos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<!--Quebra de Linha-->
				</tr>
				<tr width="0" height="0">
					<td class="snombck"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td colspan="100%" class="snhdiv"><img src="art/bit.gif"
						width="1" height="1"></td>
				</tr>

				<tr>
					<td class="snombck"><img src="art/bit.gif" width="0"
						height="0"></td>

					<%
						if (impGrafico) {
					%>
					<td align="center" valign="middle"
						onClick="location='graficos.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("ImpressAo dos grAficos dos funcionArios") + "\"")%>><%=trd.Traduz("GrAficos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (planejTurma) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_planejamentodeturma.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("PLANEJAMENTO DE TURMA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (impAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_impressaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("IMPRESSOES DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (tabulaAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_tabulacaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("TABULACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (apuraAval) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="location='01_apuracaoavaliacao.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label title=""><%=trd.Traduz("APURACAO DAS AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						}

						//************************SUBMENU*REGISTRO************************//
						else if (ops.equals("RA")) {
							if (m.equals("S")) {
					%>
					<%
						if (antecipado) {
					%>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('registro/06_criarturmaantecipada.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CRIAR PLANEJAMENTO DE TURMA") + "\"")%>><%=trd.Traduz("CRIAR PLANEJAMENTO DE TURMA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (listaPre) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('registro/frame_principal.jsp?limpa=S','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Registro eletronico de cursos do tipo Lista de PresenCa") + "\"")%>><%=trd
												.Traduz("Registro Lista de PresenCa")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (rapido) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('registro/02_registrorapido.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Registro eletronico de cursos do tipo RApido") + "\"")%>><%=trd.Traduz("Registro RApido")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (anterior) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('registro/14_lancamentosanteriores.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("LanCamentos anteriores") + "\"")%>><%=trd.Traduz("LanCamentos Anteriores")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							} else {
					%>
					<%
						if (antecipado) {
					%>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('../registro/06_criarturmaantecipada.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CRIAR PLANEJAMENTO DE TURMA") + "\"")%>><%=trd.Traduz("CRIAR PLANEJAMENTO DE TURMA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (listaPre) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('../registro/frame_principal.jsp?limpa=S','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Registro eletronico de cursos do tipo Lista de PresenCa") + "\"")%>><%=trd
												.Traduz("Registro Lista de PresenCa")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (rapido) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('../registro/02_registrorapido.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Registro eletronico de cursos do tipo RApido") + "\"")%>><%=trd.Traduz("Registro RApido")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (anterior) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('../registro/14_lancamentosanteriores.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("LanCamentos anteriores") + "\"")%>><%=trd.Traduz("LanCamentos Anteriores")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							}
						} else if (ops.equals("RL")) {
					%>
					<%
						if (antecipado) {
					%>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('06_criarturmaantecipada.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("CRIAR PLANEJAMENTO DE TURMA") + "\"")%>><%=trd.Traduz("CRIAR PLANEJAMENTO DE TURMA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (listaPre) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('frame_principal.jsp?limpa=S','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("Registro eletronico de cursos do tipo Lista de PresenCa") + "\"")%>><%=trd.Traduz("Registro Lista de PresenCa")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (rapido) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('02_registrorapido.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("Registro eletronico de cursos do tipo RApido") + "\"")%>><%=trd.Traduz("Registro RApido")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (anterior) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('14_lancamentosanteriores.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("LanCamentos anteriores") + "\"")%>><%=trd.Traduz("LanCamentos Anteriores")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
						} else if (ops.equals("RR")) {
					%>
					<%
						if (antecipado) {
					%>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('06_criarturmaantecipada.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("CRIAR PLANEJAMENTO DE TURMA") + "\"")%>><%=trd.Traduz("CRIAR PLANEJAMENTO DE TURMA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (listaPre) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('frame_principal.jsp?limpa=S','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("Registro eletronico de cursos do tipo Lista de PresenCa") + "\"")%>><%=trd.Traduz("Registro Lista de PresenCa")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (rapido) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('02_registrorapido.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("Registro eletronico de cursos do tipo RApido") + "\"")%>><%=trd.Traduz("Registro RApido")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (anterior) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('14_lancamentosanteriores.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("LanCamentos anteriores") + "\"")%>><%=trd.Traduz("LanCamentos Anteriores")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
						} else if (ops.equals("LTL")) {
					%>
					<%
						if (antecipado) {
					%>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('06_criarturmaantecipada.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("CRIAR PLANEJAMENTO DE TURMA") + "\"")%>><%=trd.Traduz("CRIAR PLANEJAMENTO DE TURMA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (listaPre) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('frame_principal.jsp?limpa=S','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("Registro eletronico de cursos do tipo Lista de PresenCa") + "\"")%>><%=trd.Traduz("Registro Lista de PresenCa")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (rapido) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('02_registrorapido.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("Registro eletronico de cursos do tipo RApido") + "\"")%>><%=trd.Traduz("Registro RApido")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (anterior) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('14_lancamentosanteriores.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("LanCamentos anteriores") + "\"")%>><%=trd.Traduz("LanCamentos Anteriores")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
						} else if (ops.equals("CTA")) {
					%>
					<%
						if (antecipado) {
					%>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('06_criarturmaantecipada.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("CRIAR PLANEJAMENTO DE TURMA") + "\"")%>><%=trd.Traduz("CRIAR PLANEJAMENTO DE TURMA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (listaPre) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('frame_principal.jsp?limpa=S','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("Registro eletronico de cursos do tipo Lista de PresenCa") + "\"")%>><%=trd.Traduz("Registro Lista de PresenCa")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (rapido) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('02_registrorapido.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("Registro eletronico de cursos do tipo RApido") + "\"")%>><%=trd.Traduz("Registro RApido")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (anterior) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('14_lancamentosanteriores.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("LanCamentos anteriores") + "\"")%>><%=trd.Traduz("LanCamentos Anteriores")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
						} else if (ops.equals("LTA")) {
					%>
					<%
						if (antecipado) {
					%>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('06_criarturmaantecipada.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("CRIAR PLANEJAMENTO DE TURMA") + "\"")%>><%=trd.Traduz("CRIAR PLANEJAMENTO DE TURMA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (listaPre) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('frame_principal.jsp?limpa=S','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("Registro eletronico de cursos do tipo Lista de PresenCa") + "\"")%>><%=trd.Traduz("Registro Lista de PresenCa")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (rapido) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('02_registrorapido.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("Registro eletronico de cursos do tipo RApido") + "\"")%>><%=trd.Traduz("Registro RApido")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (anterior) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('14_lancamentosanteriores.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("LanCamentos anteriores") + "\"")%>><%=trd.Traduz("LanCamentos Anteriores")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
						} else if (ops.equals("LA")) {
					%>
					<%
						if (antecipado) {
					%>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('06_criarturmaantecipada.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("CRIAR PLANEJAMENTO DE TURMA") + "\"")%>><%=trd.Traduz("CRIAR PLANEJAMENTO DE TURMA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (listaPre) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('frame_principal.jsp?limpa=S','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("Registro eletronico de cursos do tipo Lista de PresenCa") + "\"")%>><%=trd.Traduz("Registro Lista de PresenCa")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (rapido) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('02_registrorapido.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("Registro eletronico de cursos do tipo RApido") + "\"")%>><%=trd.Traduz("Registro RApido")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (anterior) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('14_lancamentosanteriores.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
											+ trd
													.Traduz("LanCamentos anteriores") + "\"")%>><%=trd.Traduz("LanCamentos Anteriores")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
						}

						//**********************SUBMENU*CADASTRO**********************//
						else if (ops.equals("CA")) {
							if (m.equals("S")) {
					%>
					<%
						if ((plano) || (plano2)) {
					%>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('cadastro/planodetreinamento.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE ANO DE REFERENCIA") + "\"")%>><%=trd.Traduz("ANO DE REFERENCIA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if ((assunto) || (assunto2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('cadastro/assuntos.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE ASSUNTO") + "\"")%>><%=trd.Traduz("Assuntos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if ((titulos) || (titulos2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('cadastro/titulos.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE TITULOS") + "\"")%>><%=trd.Traduz("TItulos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (competencia) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('cadastro/competencias.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de competEncias") + "\"")%>><%=trd.Traduz("CompetEncias")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if ((alterDesen) || (alterDesen2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('cadastro/tipodedesenv.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE ALTERNATIVAS DE DESENVOLVIMENTO") + "\"")%>><%=trd.Traduz("Alternativa de Desenvolvimento")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if ((entidades) || (entidades2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('cadastro/entidades.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de entidades") + "\"")%>><%=trd.Traduz("Entidades")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if ((instrutores) || (instrutores2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('cadastro/instrutor.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de instrutores") + "\"")%>><%=trd.Traduz("Instrutores")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if ((saratoga) || (saratoga2)) {
					%>
					<%
						if (prm.buscaparam("USE_SARATOGA").equals("S")) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('cadastro/saratoga.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
													+ trd
															.Traduz("Cadastro de Saratoga") + "\"")%>><%=trd.Traduz("Saratoga")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
								}
					%>

					<!--Quebra de Linha-->
				</tr>
				<!--</table>
                <table border="0" cellspacing="0" cellpadding="0">-->

				<tr width="0" height="0">
					<td class="snombck"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td colspan="100%" class="snhdiv"><img src="art/bit.gif"
						width="1" height="1"></td>
				</tr>

				<tr>
					<td class="snombck"><img src="art/bit.gif" width="0"
						height="0"></td>

					<!--<td width="1" class="snhdiv"><img src="art/bit.gif" width="1" height="1"></td>-->

					<%
						if ((local) || (local2)) {
					%>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('cadastro/tipos.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE LOCAL") + "\"")%>><%=trd.Traduz("Local")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (compTitulo) {
					%>
					<%
						if (prm.buscaparam("COMPTITULO").equals("S")) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('cadastro/competencia_titulo.jsp';"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
													+ trd
															.Traduz("Cadastro de competEncias por tItulo") + "\"")%>><%=trd.Traduz("CompetEncias por Titulo")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
								}
					%>
					<%
						if ((cursos) || (cursos2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('cadastro/cursos.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de aCOes de desenvolvimento") + "\"")%>><%=trd.Traduz("Cursos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if ((prerequisitos) || (prerequisitos2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('cadastro/prerequisitos.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE PRE-REQUISITOS") + "\"")%>><%=trd.Traduz("PrE-Requisitos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (funcionarios) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('cadastro/funcionarios.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE FUNCIONARIOS") + "\"")%>><%=trd.Traduz("FuncionArios")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if ((justificativas) || (justificativas2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('cadastro/justificativas.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de justificativas") + "\"")%>><%=trd.Traduz("Justificativas")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (auxiliares) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('cadastro/auxiliares.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CONSULTA DE TABELAS AUXILIARES") + "\"")%>><%=trd.Traduz("AUXILIARES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (idiomas) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('cadastro/idioma.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de idiomas") + "\"")%>><%=trd.Traduz("Idiomas")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>


					<%
						if (avaliacoes) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('cadastro/avaliacoes.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							} else {
					%>
					<%
						if ((plano) || (plano2)) {
					%>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('../cadastro/planodetreinamento.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE ANO DE REFERENCIA") + "\"")%>><%=trd.Traduz("ANO DE REFERENCIA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if ((assunto) || (assunto2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('../cadastro/assuntos.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE ASSUNTO") + "\"")%>><%=trd.Traduz("Assuntos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if ((titulos) || (titulos2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('../cadastro/titulos.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE TITULOS") + "\"")%>><%=trd.Traduz("TItulos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (competencia) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('../cadastro/competencias.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de competEncias") + "\"")%>><%=trd.Traduz("CompetEncias")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if ((alterDesen) || (alterDesen2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('../cadastro/tipodedesenv.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE ALTERNATIVAS DE DESENVOLVIMENTO") + "\"")%>><%=trd.Traduz("Alternativa de Desenvolvimento")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if ((entidades) || (entidades2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('../cadastro/entidades.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de entidades") + "\"")%>><%=trd.Traduz("Entidades")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if ((instrutores) || (instrutores2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('../cadastro/instrutor.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de instrutores") + "\"")%>><%=trd.Traduz("Instrutores")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if ((saratoga) || (saratoga2)) {
					%>
					<%
						if (prm.buscaparam("USE_SARATOGA").equals("S")) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('../cadastro/saratoga.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
													+ trd
															.Traduz("Cadastro de Saratoga") + "\"")%>><%=trd.Traduz("Saratoga")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
								}
					%>
					<!--Quebra de Linha-->
				</tr>
				<!--</table>
              <table border="0" cellspacing="0" cellpadding="0">-->

				<tr width="0" height="0">
					<td class="snombck"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td colspan="100%" class="snhdiv"><img src="art/bit.gif"
						width="1" height="1"></td>
				</tr>
				<tr>
					<td class="snombck"><img src="art/bit.gif" width="0"
						height="0"></td>
					<!--<td width="1" class="snhdiv"><img src="art/bit.gif" width="1" height="1"></td>-->

					<%
						if ((local) || (local2)) {
					%>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('../cadastro/tipos.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE LOCAL") + "\"")%>><%=trd.Traduz("Local")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (compTitulo) {
					%>
					<%
						if (prm.buscaparam("COMPTITULO").equals("S")) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('../cadastro/competencia_titulo.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
													+ trd
															.Traduz("Cadastro de competEncias por tItulo") + "\"")%>><%=trd.Traduz("CompetEncias por Titulo")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
								}
					%>
					<%
						if ((cursos) || (cursos2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('../cadastro/cursos.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de aCOes de desenvolvimento") + "\"")%>><%=trd.Traduz("Cursos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if ((prerequisitos) || (prerequisitos2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('../cadastro/prerequisitos.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE PRE-REQUISITOS") + "\"")%>><%=trd.Traduz("PrE-Requisitos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (funcionarios) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('../cadastro/funcionarios.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE FUNCIONARIOS") + "\"")%>><%=trd.Traduz("FuncionArios")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if ((justificativas) || (justificativas2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('../cadastro/justificativas.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de justificativas") + "\"")%>><%=trd.Traduz("Justificativas")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (auxiliares) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('../cadastro/auxiliares.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CONSULTA DE TABELAS AUXILIARES") + "\"")%>><%=trd.Traduz("AUXILIARES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						if (idiomas) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('../cadastro/idioma.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de idiomas") + "\"")%>><%=trd.Traduz("Idiomas")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>

					<%
						if (avaliacoes) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('../cadastro/avaliacoes.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}

							}
						} else {
							if (ops.equals("PT")) {
					%>
					<%
						if ((plano) || (plano2)) {
					%>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('planodetreinamento.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE ANO DE REFERENCIA") + "\"")%>><%=trd.Traduz("ANO DE REFERENCIA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							} else {
					%>
					<%
						if ((plano) || (plano2)) {
					%>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('planodetreinamento.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE ANO DE REFERENCIA") + "\"")%>><%=trd.Traduz("ANO DE REFERENCIA")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							}

							if (ops.equals("AS")) {
					%>
					<%
						if ((assunto) || (assunto2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('assuntos.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE ASSUNTO") + "\"")%>><%=trd.Traduz("Assuntos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						} else {
					%>
					<%
						if ((assunto) || (assunto2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('assuntos.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE ASSUNTO") + "\"")%>><%=trd.Traduz("Assuntos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						}
							if (ops.equals("TI")) {
					%>
					<%
						if ((titulos) || (titulos2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('titulos.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE TITULOS") + "\"")%>><%=trd.Traduz("TItulos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							} else {
					%>
					<%
						if ((titulos) || (titulos2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('titulos.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE TITULOS") + "\"")%>><%=trd.Traduz("TItulos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							}
							if (ops.equals("CO")) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<%
						if (competencia) {
					%>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('competencias.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de competEncias") + "\"")%>><%=trd.Traduz("CompetEncias")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						} else {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<%
						if (competencia) {
					%>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('competencias.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de competEncias") + "\"")%>><%=trd.Traduz("CompetEncias")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
					%>
					<%
						}
							if (ops.equals("TD")) {
					%>
					<%
						if ((alterDesen) || (alterDesen2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('tipodedesenv.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE ALTERNATIVAS DE DESENVOLVIMENTO") + "\"")%>><%=trd.Traduz("Alternativa de Desenvolvimento")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							} else {
					%>
					<%
						if ((alterDesen) || (alterDesen2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('tipodedesenv.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE ALTERNATIVAS DE DESENVOLVIMENTO") + "\"")%>><%=trd.Traduz("Alternativa de Desenvolvimento")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							}
							if (ops.equals("ET")) {
					%>
					<%
						if ((entidades) || (entidades2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('entidades.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de entidades") + "\"")%>><%=trd.Traduz("Entidades")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							} else {
					%>
					<%
						if ((entidades) || (entidades2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('entidades.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de entidades") + "\"")%>><%=trd.Traduz("Entidades")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							}
							if (ops.equals("IS")) {
					%>
					<%
						if ((instrutores) || (instrutores2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('instrutor.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de instrutores") + "\"")%>><%=trd.Traduz("Instrutores")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							} else {
					%>
					<%
						if ((instrutores) || (instrutores2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('instrutor.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de instrutores") + "\"")%>><%=trd.Traduz("Instrutores")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							}
							if (ops.equals("ST")) {
					%>
					<%
						if ((saratoga) || (saratoga2)) {
					%>
					<%
						if (prm.buscaparam("USE_SARATOGA").equals("S")) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('saratoga.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
													+ trd
															.Traduz("Cadastro de Saratoga") + "\"")%>><%=trd.Traduz("Saratoga")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
								}
							} else {
					%>
					<%
						if ((saratoga) || (saratoga2)) {
					%>
					<%
						if (prm.buscaparam("USE_SARATOGA").equals("S")) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('saratoga.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
													+ trd
															.Traduz("Cadastro de Saratoga") + "\"")%>><%=trd.Traduz("Saratoga")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
								}
							}
					%>
					<!--Quebra de Linha-->
				</tr>
				<!--</table>
              <table border="0" cellspacing="0" cellpadding="0">-->

				<tr width="0" height="0">
					<td class="snombck"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td colspan="100%" class="snhdiv"><img src="art/bit.gif"
						width="1" height="1"></td>
				</tr>

				<tr>

					<%
						if (ops.equals("TP")) {
					%>
					<%
						if ((local) || (local2)) {
					%>
					<td class="snombck"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('tipos.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE LOCAL") + "\"")%>><%=trd.Traduz("Local")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							} else {
					%>
					<%
						if ((local) || (local2)) {
					%>
					<td class="snombck"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('tipos.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE LOCAL") + "\"")%>><%=trd.Traduz("Local")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							}

							if (ops.equals("CT")) {
					%>
					<%
						if (compTitulo) {
					%>
					<%
						if (prm.buscaparam("COMPTITULO").equals("S")) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('competencia_titulo.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
													+ trd
															.Traduz("Cadastro de competEncias por tItulo") + "\"")%>><%=trd.Traduz("CompetEncias por Titulo")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>

					<%
						}
								}
							} else {
					%>
					<%
						if (compTitulo) {
					%>
					<%
						if (prm.buscaparam("COMPTITULO").equals("S")) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('competencia_titulo.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
													+ trd
															.Traduz("Cadastro de competEncias por tItulo") + "\"")%>><%=trd.Traduz("CompetEncias por Titulo")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
								}
							}
							if (ops.equals("CU")) {
					%>
					<%
						if ((cursos) || (cursos2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('cursos.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de aCOes de desenvolvimento") + "\"")%>><%=trd.Traduz("Cursos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							} else {
					%>
					<%
						if ((cursos) || (cursos2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('cursos.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de aCOes de desenvolvimento") + "\"")%>><%=trd.Traduz("Cursos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							}
							if (ops.equals("PR")) {
					%>
					<%
						if ((prerequisitos) || (prerequisitos2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('prerequisitos.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE PRE-REQUISITOS") + "\"")%>><%=trd.Traduz("PrE-Requisitos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							} else {
					%>
					<%
						if ((prerequisitos) || (prerequisitos2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('prerequisitos.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE PRE-REQUISITOS") + "\"")%>><%=trd.Traduz("PrE-Requisitos")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							}

							if (ops.equals("FU")) {
					%>
					<%
						if (funcionarios) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('funcionarios.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE FUNCIONARIOS") + "\"")%>><%=trd.Traduz("FuncionArios")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							} else {
					%>
					<%
						if (funcionarios) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('funcionarios.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CADASTRO DE FUNCIONARIOS") + "\"")%>><%=trd.Traduz("FuncionArios")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							}
							if (ops.equals("JU")) {
					%>
					<%
						if ((justificativas) || (justificativas2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('justificativas.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de justificativas") + "\"")%>><%=trd.Traduz("Justificativas")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							} else {
					%>
					<%
						if ((justificativas) || (justificativas2)) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('justificativas.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de justificativas") + "\"")%>><%=trd.Traduz("Justificativas")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							}
							if (ops.equals("AX")) {
					%>
					<%
						if (auxiliares) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('auxiliares.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CONSULTA DE TABELAS AUXILIARES") + "\"")%>><%=trd.Traduz("AUXILIARES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							} else {
					%>
					<%
						if (auxiliares) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('auxiliares.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("CONSULTA DE TABELAS AUXILIARES") + "\"")%>><%=trd.Traduz("AUXILIARES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							}

							if (ops.equals("ID")) {
					%>
					<%
						if (idiomas) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('idioma.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de idiomas") + "\"")%>><%=trd.Traduz("Idiomas")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							} else {
					%>
					<%
						if (idiomas) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('idioma.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=<%=("\""
												+ trd
														.Traduz("Cadastro de idiomas") + "\"")%>><%=trd.Traduz("Idiomas")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							}
							if (ops.equals("AV")) {
								if (avaliacoes) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('avaliacoes.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='snobck';" nowrap class="snobck"><img
						src="art/bit.gif" width="2" height="1"><a href=""
						class="snofitm"><label title=""><%=trd.Traduz("AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							} else {
								if (avaliacoes) {
					%>
					<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
						height="1"></td>
					<td align="center" valign="middle"
						onClick="JavaScript:window.open('avaliacoes.jsp','_parent');"
						onMouseOver="this.className='snobck';"
						onMouseOut="this.className='';" nowrap><img src="art/bit.gif"
						width="2" height="1"><a href="" class="snofitm"><label
						title=""><%=trd.Traduz("AVALIACOES")%></label></a><img
						src="art/bit.gif" width="2" height="1"></td>
					<%
						}
							}
						}
					%>
				</tr>
			</table>
	</table>
	</td>
</tr>
<%
	//}catch(Exception e){out.println("ERRO:"+e);}
%>