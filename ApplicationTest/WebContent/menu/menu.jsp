
<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.lang.Math.*,java.util.*,java.text.*"%>
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
	request.getSession();
	Vector per = (Vector) session.getAttribute("vetorPermissoes");

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	String dequem = "";
	if (request.getParameter("op") == null) {
		dequem = "A";
	} else {
		dequem = request.getParameter("op");
	}

	String oi = request.getRequestURI();

	//Para suprimir o texto "/FirstOnEM/"
	if (!(request.getParameter("main") == null)) {
		oi = oi.substring(11, oi.length());
	} else {
		if (oi.substring(11, 23).equals("solicitacao/")) {
			oi = oi.substring(23, oi.length());
		}
	}
	if (!(request.getParameter("main") == null)) {
%>

<%@page import="firston.eval.components.FOLocalizationBean"%><td width="12"><img src="art/bit.gif" width="12" height="15"></td>
<%
	} else {
%>
<td width="12"><img src="../art/bit.gif" width="12" height="15"></td>
<%
	}

	if (dequem.equals("A")) {
		if (!(request.getParameter("main") == null))
			oi = "";
		else
			oi = "../";

		if (per.contains("MENU - CADASTRO")) {
%>
<td onClick="location='<%=oi%>cadastro/cadastro.jsp?op=C&opt=CA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>cadastro/cadastro.jsp?op=C&opt=CA" class="snmenu"><label
	title="Cadastro de informaCOes necessArias para utilizaCAo do sistema"><%=trd.Traduz("CADASTRO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - SOLICITACAO")) {
%>
<td onClick="location='<%=oi%>solicitacao/solicitacao.jsp?op=S&opt=SA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>solicitacao/solicitacao.jsp?op=S&opt=SA" class="snmenu"><label
	title="SolicitaCAo de cursos para funcionArios da empresa"><%=trd.Traduz("SOLICITACAO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - REGISTRO")) {
%>
<td onClick="location='<%=oi%>registro/registro.jsp?op=R&opt=RA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>registro/registro.jsp?op=R&opt=RA" class="snmenu"><label
	title="Registro eletronico dos cursos solicitados"><%=trd.Traduz("REGISTRO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - IMPRESS0ES")) {
%>
<td onClick="location='<%=oi%>impressoes/impressoes.jsp?op=I&opt=IA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="../art/bit.gif" width="10" height="5"><a
	href="<%=oi%>impressoes/impressoes.jsp?op=I&opt=IA" class="snmenu"><label
	title="ImpressAo dos relatOrios e grAficos"><%=trd.Traduz("IMPRESSOES")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - SOLICITANTE")) {
%>
<td
	onClick="location='<%=oi%>solicitante/solicitante.jsp?op=SO&opt=CA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>solicitante/solicitante.jsp?op=SO&opt=CA" class="snmenu"><label
	title="Cadastro dos Solicitantes do sistema"><%=trd.Traduz("USUARIO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - FERRAMENTAS")) {
%>
<td
	onClick="location='<%=oi%>ferramentas/ferramentas.jsp?op=F&opt=PA?op=F&opt=PA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="<%=oi%>ferramentas/ferramentas.jsp?op=F&opt=PA" class="snmenu"><label
	title="Ferramentas de ConfiguraCAo"><%=trd.Traduz("FERRAMENTAS")%></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - AVALIACAO")) {
%>
<td onClick="location='<%=oi%>avaliacao/avaliacao.jsp?op=AV&opt=PA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="<%=oi%>avaliacao/avaliacao.jsp?op=AV&opt=PA" class="snmenu"><label
	title=""><%=trd.Traduz("AVALIACAO")%></a><img src="imagens/bit.gif"
	width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}

		if (per.contains("MENU - SAIR")) {
%>
<td onClick="location='<%=oi%>sair.jsp';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="<%=oi%>sair.jsp" class="snmenu"><%=trd.Traduz("SAIR")%></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	}
	}

	else if (dequem.equals("S")) {//Menu
		if (!(request.getParameter("main") == null))
			oi = "";
		else
			oi = "../";

		if (per.contains("MENU - CADASTRO")) {
%>
<td onClick="location='<%=oi%>cadastro/cadastro.jsp?op=C&opt=CA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>cadastro/cadastro.jsp?op=C&opt=CA" class="snmenu"><label
	title="Cadastro de informaCOes necessArias para utilizaCAo do sistema"><%=trd.Traduz("CADASTRO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - SOLICITACAO")) {
%>
<td onClick="location='<%=oi%>solicitacao/solicitacao.jsp?op=S&opt=SA';"
	onMouseOver="this.className='snonitm';"
	onMouseOut="this.className='snonitm';" nowrap class="snonitm"><img
	src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>solicitacao/solicitacao.jsp?op=S&opt=SA" class="snmenu"><label
	title="SolicitaCAo de cursos para funcionArios da empresa"><%=trd.Traduz("SOLICITACAO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - REGISTRO")) {
%>
<td onClick="location='<%=oi%>registro/registro.jsp?op=R&opt=RA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>registro/registro.jsp?op=R&opt=RA" class="snmenu"><label
	title="Registro eletronico dos cursos solicitados"><%=trd.Traduz("REGISTRO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - IMPRESS0ES")) {
%>
<td onClick="location='<%=oi%>impressoes/impressoes.jsp?op=I&opt=IA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>impressoes/impressoes.jsp?op=I&opt=IA" class="snmenu"><label
	title="ImpressAo dos relatOrios e grAficos"><%=trd.Traduz("IMPRESSOES")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - SOLICITANTE")) {
%>
<td
	onClick="location='<%=oi%>solicitante/solicitante.jsp?op=SO&opt=CA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>solicitante/solicitante.jsp?op=SO&opt=CA" class="snmenu"><label
	title="Cadastro dos Solicitantes do sistema"><%=trd.Traduz("USUARIO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - FERRAMENTAS")) {
%>
<td onClick="location='<%=oi%>ferramentas/ferramentas.jsp?op=F&opt=PA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="<%=oi%>ferramentas/ferramentas.jsp?op=F&opt=PA" class="snmenu"><label
	title="Ferramentas de ConfiguraCAo"><%=trd.Traduz("FERRAMENTAS")%></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - AVALIACAO")) {
%>
<td onClick="location='<%=oi%>avaliacao/avaliacao.jsp?op=AV&opt=PA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="<%=oi%>avaliacao/avaliacao.jsp?op=AV&opt=PA" class="snmenu"><label
	title=""><%=trd.Traduz("AVALIACAO")%></a><img src="imagens/bit.gif"
	width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - SAIR")) {
%>
<td onClick="location='<%=oi%>sair.jsp';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="<%=oi%>sair.jsp" class="snmenu"><%=trd.Traduz("SAIR")%></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	}
	}

	else if (dequem.equals("R")) {
		if (!(request.getParameter("main") == null))
			oi = "";
		else
			oi = "../";

		if (per.contains("MENU - CADASTRO")) {
%>
<td
	onClick="JavaScript:window.open('<%=oi%>cadastro/cadastro.jsp?op=C&opt=CA','_parent');"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>cadastro/cadastro.jsp?op=C&opt=CA" class="snmenu"><label
	title="Cadastro de informaCOes necessArias para utilizaCAo do sistema"><%=trd.Traduz("CADASTRO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - SOLICITACAO")) {
%>
<td
	onClick="JavaScript:window.open('<%=oi%>solicitacao/solicitacao.jsp?op=S&opt=SA','_parent');"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>solicitacao/solicitacao.jsp?op=S&opt=SA" class="snmenu"><label
	title="SolicitaCAo de cursos para funcionArios da empresa"><%=trd.Traduz("SOLICITACAO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - REGISTRO")) {
%>
<td
	onClick="JavaScript:window.open('<%=oi%>registro/registro.jsp?op=R&opt=RA','_parent');"
	onMouseOver="this.className='snonitm';"
	onMouseOut="this.className='snonitm';" nowrap class="snonitm"><img
	src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>registro/registro.jsp?op=R&opt=RA" class="snmenu"><label
	title="Registro eletronico dos cursos solicitados"><%=trd.Traduz("REGISTRO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - IMPRESS0ES")) {
%>
<td
	onClick="JavaScript:window.open('<%=oi%>impressoes/impressoes.jsp?op=I&opt=IA','_parent');"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="../art/bit.gif" width="10" height="5"><a
	href="<%=oi%>impressoes/impressoes.jsp?op=I&opt=IA" class="snmenu"><label
	title="ImpressAo dos relatOrios e grAficos"><%=trd.Traduz("IMPRESSOES")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - SOLICITANTE")) {
%>
<td
	onClick="JavaScript:window.open('<%=oi%>solicitante/solicitante.jsp?op=SO&opt=CA','_parent');"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>solicitante/solicitante.jsp?op=SO&opt=CA" class="snmenu"><label
	title="Cadastro dos Solicitantes do sistema"><%=trd.Traduz("USUARIO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - FERRAMENTAS")) {
%>
<td
	onClick="JavaScript:window.open('<%=oi%>ferramentas/ferramentas.jsp?op=F&opt=PA','_parent');"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="<%=oi%>ferramentas/ferramentas.jsp?op=F&opt=PA" class="snmenu"><label
	title="Ferramentas de ConfiguraCAo"><%=trd.Traduz("FERRAMENTAS")%></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - AVALIACAO")) {
%>
<td
	onClick="JavaScript:window.open('<%=oi%>avaliacao/avaliacao.jsp?op=AV&opt=PA','_parent');"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="<%=oi%>avaliacao/avaliacao.jsp?op=AV&opt=PA" class="snmenu"><label
	title=""><%=trd.Traduz("AVALIACAO")%></a><img src="imagens/bit.gif"
	width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - SAIR")) {
%>
<td onClick="JavaScript:window.open('<%=oi%>sair.jsp','_parent');"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="<%=oi%>sair.jsp" class="snmenu"><%=trd.Traduz("SAIR")%></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	}
	} else if (dequem.equals("I")) {
		if (!(request.getParameter("main") == null))
			oi = "";
		else
			oi = "../";

		if (per.contains("MENU - CADASTRO")) {
%>
<td onClick="location='<%=oi%>cadastro/cadastro.jsp?op=C&opt=CA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>cadastro/cadastro.jsp?op=C&opt=CA" class="snmenu"><label
	title="Cadastro de informaCOes necessArias para utilizaCAo do sistema"><%=trd.Traduz("CADASTRO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - SOLICITACAO")) {
%>
<td onClick="location='<%=oi%>solicitacao/solicitacao.jsp?op=S&opt=SA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>solicitacao/solicitacao.jsp?op=S&opt=SA" class="snmenu"><label
	title="SolicitaCAo de cursos para funcionArios da empresa"><%=trd.Traduz("SOLICITACAO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - REGISTRO")) {
%>
<td onClick="location='<%=oi%>registro/registro.jsp?op=R&opt=RA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>registro/registro.jsp?op=R&opt=RA" class="snmenu"><label
	title="Registro eletronico dos cursos solicitados"><%=trd.Traduz("REGISTRO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - IMPRESS0ES")) {
%>
<td onClick="location='<%=oi%>impressoes/impressoes.jsp?op=I&opt=IA';"
	onMouseOver="this.className='snonitm';"
	onMouseOut="this.className='snonitm';" nowrap class="snonitm"><img
	src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>impressoes/impressoes.jsp?op=I&opt=IA" class="snmenu"><label
	title="ImpressAo dos relatOrios e grAficos"><%=trd.Traduz("IMPRESSOES")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - SOLICITANTE")) {
%>
<td
	onClick="location='<%=oi%>solicitante/solicitante.jsp?op=SO&opt=CA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>solicitante/solicitante.jsp?op=SO&opt=CA" class="snmenu"><label
	title="Cadastro dos Solicitantes do sistema"><%=trd.Traduz("USUARIO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - FERRAMENTAS")) {
%>
<td onClick="location='<%=oi%>ferramentas/ferramentas.jsp?op=F&opt=PA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="<%=oi%>ferramentas/ferramentas.jsp?op=F&opt=PA" class="snmenu"><label
	title="Ferramentas de ConfiguraCAo"><%=trd.Traduz("FERRAMENTAS")%></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - AVALIACAO")) {
%>
<td onClick="location='<%=oi%>avaliacao/avaliacao.jsp?op=AV&opt=PA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="<%=oi%>avaliacao/avaliacao.jsp?op=AV&opt=PA" class="snmenu"><label
	title=""><%=trd.Traduz("AVALIACAO")%></a><img src="imagens/bit.gif"
	width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - SAIR")) {
%>
<td onClick="location='<%=oi%>sair.jsp';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="<%=oi%>sair.jsp" class="snmenu"><%=trd.Traduz("SAIR")%></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	}
	} else if (dequem.equals("C")) {
		if (!(request.getParameter("main") == null))
			oi = "";
		else
			oi = "../";

		if (per.contains("MENU - CADASTRO")) {
%>
<td
	onClick="JavaScript:window.open('<%=oi%>cadastro/cadastro.jsp?op=C&opt=CA','_parent');"
	onMouseOver="this.className='snonitm';"
	onMouseOut="this.className='snonitm';" nowrap class="snonitm"><img
	src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>cadastro/cadastro.jsp?op=C&opt=CA" class="snmenu"><label
	title="Cadastro de informaCOes necessArias para utilizaCAo do sistema"><%=trd.Traduz("CADASTRO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - SOLICITACAO")) {
%>
<td
	onClick="JavaScript:window.open('<%=oi%>solicitacao/solicitacao.jsp?op=S&opt=SA','_parent');"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>solicitacao/solicitacao.jsp?op=S&opt=SA" class="snmenu"><label
	title="SolicitaCAo de cursos para funcionArios da empresa"><%=trd.Traduz("SOLICITACAO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - REGISTRO")) {
%>
<td
	onClick="JavaScript:window.open('<%=oi%>registro/registro.jsp?op=R&opt=RA','_parent');"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="../art/bit.gif" width="10" height="5"><a
	href="<%=oi%>registro/registro.jsp?op=R&opt=RA" class="snmenu"><label
	title="Registro eletronico dos cursos solicitados"><%=trd.Traduz("REGISTRO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - IMPRESS0ES")) {
%>
<td
	onClick="JavaScript:window.open('<%=oi%>impressoes/impressoes.jsp?op=I&opt=IA','_parent');"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>impressoes/impressoes.jsp?op=I&opt=IA" class="snmenu"><label
	title="ImpressAo dos relatOrios e grAficos"><%=trd.Traduz("IMPRESSOES")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - SOLICITANTE")) {
%>
<td
	onClick="JavaScript:window.open('<%=oi%>solicitante/solicitante.jsp?op=SO&opt=CA','_parent');"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>solicitante/solicitante.jsp?op=SO&opt=CA" class="snmenu"><label
	title="Cadastro dos Solicitantes do sistema"><%=trd.Traduz("USUARIO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - FERRAMENTAS")) {
%>
<td
	onClick="JavaScript:window.open('<%=oi%>ferramentas/ferramentas.jsp?op=F&opt=PA','_parent');"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="<%=oi%>ferramentas/ferramentas.jsp?op=F&opt=PA" class="snmenu"><label
	title="Ferramentas de ConfiguraCAo"><%=trd.Traduz("FERRAMENTAS")%></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - AVALIACAO")) {
%>
<td
	onClick="JavaScript:window.open('<%=oi%>avaliacao/avaliacao.jsp?op=AV&opt=PA','_parent');"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="<%=oi%>avaliacao/avaliacao.jsp?op=AV&opt=PA" class="snmenu"><label
	title=""><%=trd.Traduz("AVALIACAO")%></a><img src="imagens/bit.gif"
	width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - SAIR")) {
%>
<td onClick="JavaScript:window.open('<%=oi%>sair.jsp','_parent');"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="<%=oi%>sair.jsp" class="snmenu"><%=trd.Traduz("SAIR")%></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	}
	}

	else if (dequem.equals("F")) {
		if (!(request.getParameter("main") == null))
			oi = "";
		else
			oi = "../";

		if (per.contains("MENU - CADASTRO")) {
%>
<td onClick="location='<%=oi%>cadastro/cadastro.jsp?op=C&opt=CA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>cadastro/cadastro.jsp?op=C&opt=CA" class="snmenu"><label
	title="Cadastro de informaCOes necessArias para utilizaCAo do sistema"><%=trd.Traduz("CADASTRO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - SOLICITACAO")) {
%>
<td onClick="location='<%=oi%>solicitacao/solicitacao.jsp?op=S&opt=SA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>solicitacao/solicitacao.jsp?op=S&opt=SA" class="snmenu"><label
	title="SolicitaCAo de cursos para funcionArios da empresa"><%=trd.Traduz("SOLICITACAO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - REGISTRO")) {
%>
<td onClick="location='<%=oi%>registro/registro.jsp?op=R&opt=RA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>registro/registro.jsp?op=R&opt=RA" class="snmenu"><label
	title="Registro eletronico dos cursos solicitados"><%=trd.Traduz("REGISTRO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - IMPRESS0ES")) {
%>
<td onClick="location='<%=oi%>impressoes/impressoes.jsp?op=I&opt=IA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="../art/bit.gif" width="10" height="5"><a
	href="<%=oi%>impressoes/impressoes.jsp?op=I&opt=IA" class="snmenu"><label
	title="ImpressAo dos relatOrios e grAficos"><%=trd.Traduz("IMPRESSOES")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - SOLICITANTE")) {
%>
<td
	onClick="location='<%=oi%>solicitante/solicitante.jsp?op=SO&opt=CA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>solicitante/solicitante.jsp?op=SO&opt=CA" class="snmenu"><label
	title="Cadastro dos Solicitantes do sistema"><%=trd.Traduz("USUARIO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - FERRAMENTAS")) {
%>
<td onClick="location='<%=oi%>ferramentas/ferramentas.jsp?op=F&opt=PA';"
	onMouseOver="this.className='snonitm';"
	onMouseOut="this.className='snonitm';" nowrap class="snonitm"><img
	src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>ferramentas/ferramentas.jsp?op=F&opt=PA" class="snmenu"><label
	title="SolicitaCAo de cursos para funcionArios da empresa"><label
	title="Ferramentas de ConfiguraCAo"><%=trd.Traduz("FERRAMENTAS")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - AVALIACAO")) {
%>
<td onClick="location='<%=oi%>avaliacao/avaliacao.jsp?op=AV&opt=PA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="<%=oi%>avaliacao/avaliacao.jsp?op=AV&opt=PA" class="snmenu"><label
	title=""><%=trd.Traduz("AVALIACAO")%></a><img src="imagens/bit.gif"
	width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - SAIR")) {
%>
<td onClick="location='<%=oi%>sair.jsp';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="<%=oi%>sair.jsp" class="snmenu"><%=trd.Traduz("SAIR")%></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	}
	}

	else if (dequem.equals("SO")) {
		if (!(request.getParameter("main") == null))
			oi = "";
		else
			oi = "../";

		if (per.contains("MENU - CADASTRO")) {
%>
<td onClick="location='<%=oi%>cadastro/cadastro.jsp?op=C&opt=CA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>cadastro/cadastro.jsp?op=C&opt=CA" class="snmenu"><label
	title="Cadastro de informaCOes necessArias para utilizaCAo do sistema"><%=trd.Traduz("CADASTRO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - SOLICITACAO")) {
%>
<td onClick="location='<%=oi%>solicitacao/solicitacao.jsp?op=S&opt=SA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>solicitacao/solicitacao.jsp?op=S&opt=SA" class="snmenu"><label
	title="SolicitaCAo de cursos para funcionArios da empresa"><%=trd.Traduz("SOLICITACAO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - REGISTRO")) {
%>
<td onClick="location='<%=oi%>registro/registro.jsp?op=R&opt=RA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>registro/registro.jsp?op=R&opt=RA" class="snmenu"><label
	title="Registro eletronico dos cursos solicitados"><%=trd.Traduz("REGISTRO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - IMPRESS0ES")) {
%>
<td onClick="location='<%=oi%>impressoes/impressoes.jsp?op=I&opt=IA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="../art/bit.gif" width="10" height="5"><a
	href="<%=oi%>impressoes/impressoes.jsp?op=I&opt=IA" class="snmenu"><label
	title="ImpressAo dos relatOrios e grAficos"><%=trd.Traduz("IMPRESSOES")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - SOLICITANTE")) {
%>
<td
	onClick="location='<%=oi%>solicitante/solicitante.jsp?op=SO&opt=CA';"
	onMouseOver="this.className='snonitm';"
	onMouseOut="this.className='snonitm';" nowrap class="snonitm"><img
	src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>solicitante/solicitante.jsp?op=SO&opt=CA" class="snmenu"><label
	title="Cadastro dos Solicitantes do sistema"><%=trd.Traduz("USUARIO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - FERRAMENTAS")) {
%>
<td onClick="location='<%=oi%>ferramentas/ferramentas.jsp?op=F&opt=PA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>ferramentas/ferramentas.jsp?op=F&opt=PA" class="snmenu"><label
	title="Ferramentas de ConfiguraCAo"><%=trd.Traduz("FERRAMENTAS")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - AVALIACAO")) {
%>
<td onClick="location='<%=oi%>avaliacao/avaliacao.jsp?op=AV&opt=PA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="<%=oi%>avaliacao/avaliacao.jsp?op=AV&opt=PA" class="snmenu"><label
	title=""><%=trd.Traduz("AVALIACAO")%></a><img src="imagens/bit.gif"
	width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - SAIR")) {
%>
<td onClick="location='<%=oi%>sair.jsp';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="<%=oi%>sair.jsp" class="snmenu"><%=trd.Traduz("SAIR")%></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	}
	}

	else if (dequem.equals("AV")) {
		if (!(request.getParameter("main") == null))
			oi = "";
		else
			oi = "../";

		if (per.contains("MENU - CADASTRO")) {
%>
<td onClick="location='<%=oi%>cadastro/cadastro.jsp?op=C&opt=CA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>cadastro/cadastro.jsp?op=C&opt=CA" class="snmenu"><label
	title="Cadastro de informaCOes necessArias para utilizaCAo do sistema"><%=trd.Traduz("CADASTRO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - SOLICITACAO")) {
%>
<td onClick="location='<%=oi%>solicitacao/solicitacao.jsp?op=S&opt=SA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>solicitacao/solicitacao.jsp?op=S&opt=SA" class="snmenu"><label
	title="SolicitaCAo de cursos para funcionArios da empresa"><%=trd.Traduz("SOLICITACAO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - REGISTRO")) {
%>
<td onClick="location='<%=oi%>registro/registro.jsp?op=R&opt=RA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>registro/registro.jsp?op=R&opt=RA" class="snmenu"><label
	title="Registro eletronico dos cursos solicitados"><%=trd.Traduz("REGISTRO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - IMPRESS0ES")) {
%>
<td onClick="location='<%=oi%>impressoes/impressoes.jsp?op=I&opt=IA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="../art/bit.gif" width="10" height="5"><a
	href="<%=oi%>impressoes/impressoes.jsp?op=I&opt=IA" class="snmenu"><label
	title="ImpressAo dos relatOrios e grAficos"><%=trd.Traduz("IMPRESSOES")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - SOLICITANTE")) {
%>
<td
	onClick="location='<%=oi%>solicitante/solicitante.jsp?op=SO&opt=CA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>solicitante/solicitante.jsp?op=SO&opt=CA" class="snmenu"><label
	title="Cadastro dos Solicitantes do sistema"><%=trd.Traduz("USUARIO")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - FERRAMENTAS")) {
%>
<td onClick="location='<%=oi%>ferramentas/ferramentas.jsp?op=F&opt=PA';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="art/bit.gif" width="10" height="5"><a
	href="<%=oi%>ferramentas/ferramentas.jsp?op=F&opt=PA" class="snmenu"><label
	title="Ferramentas de ConfiguraCAo"><%=trd.Traduz("FERRAMENTAS")%></label></a><img
	src="art/bit.gif" width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - AVALIACAO")) {
%>
<td onClick="location='<%=oi%>avaliacao/avaliacao.jsp?op=AV&opt=PA';"
	onMouseOver="this.className='snonitm';"
	onMouseOut="this.className='snonitm';" nowrap class="snonitm"><img
	src="imagens/bit.gif" width="10" height="5"><a
	href="<%=oi%>avaliacao/avaliacao.jsp?op=AV&opt=PA" class="snmenu"><label
	title=""><%=trd.Traduz("AVALIACAO")%></a><img src="imagens/bit.gif"
	width="10" height="5"></td>
<td width="1" class="snhdiv"><img src="art/bit.gif" width="1"
	height="1"></td>
<%
	}
		if (per.contains("MENU - SAIR")) {
%>
<td onClick="location='<%=oi%>sair.jsp';"
	onMouseOver="this.className='snonitm';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="<%=oi%>sair.jsp" class="snmenu"><%=trd.Traduz("SAIR")%></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	}
	}
%>