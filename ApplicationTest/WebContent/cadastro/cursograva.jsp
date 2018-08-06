<!--
Nome do arquivo: cadastro/cursograva.jsp
Nome da funcionalidade: Gravação de Curso
Função: incluir, excluir ou alterar um curso, fazendo as verificações necessárias.
Variáveis necessárias/ Requisitos: 
- sessao: idioma do usuário ("usu_idi"), tipo do usuário ("usu_tipo")
- parametro: tipo da ação ("tipo"), codigo do curso ("cod"), codigo do desenvolvimento("desenv"), 
             codigo da entidade("entidade"),código do título("titulo"), código da saratoga ("saratoga"),
             tipo do curso("tipocur"),nome do curso("nome"),("ativo"),custo ("custo"), custo logística("custol"),
             duração/horas("duracao"),duração/minutos("duracaomin"), período ("periodo"), versão("versao"),
             reponsável("resp"),máximo de participantes("maxpart"), mínimo de participantes("minpart"),
             resumo ("resumo"),conteudo programático("contprog"), como avaliar("comoaval"),
             considerações gerais("consger"),

Regras de negócio (pagina):
- Inclusão: Verifica a existência do curso na tabela CURSO, caso já exista, ele não insere,
            senão insere na tabela CURSOCOMP e PLANO_AVALIA;
- Alteração:Verifica a existência do curso na tabela CURSO, caso já exista, ele não altera,
            senão faz update na tabela CURSO, apaga e insere na tabela CURSOCOMP e PLANO_AVALIA;
- Exclusão: Verfica nas tabelas CURSOCOMP e TURMA, se o curso está sendo usado, 
            caso não esteja ele exclui o curso nas tabelas PLANO_AVALIA e CURSO;
_________________________________________________________________________________________

Histórico
Data de atualizacao: 11/03/2003 - Desenvolvedor: Anderson Inoue
Atividade:
          - padronizacao da página;
          - retirada da verificação nas tabelas FUNCPROJETO e SOLICITACAO pois estas foram apagadas do bd.
_________________________________________________________________________________________

-->

<!--***DIRETRIZES DA PAGINA***-->
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<!--***IMPORTAÇOES E BEANS***-->
<%@page import="java.sql.*,java.text.*,java.lang.*,java.util.*"%>

<!--***FUNÇÕES JSP***-->
<%!public String trataAspas(String conteudo) {
		char troca[] = conteudo.toCharArray();
		int contador = 0;
		while (contador < conteudo.length()) {
			String alfa = "" + troca[contador];
			if (alfa.equals("'")) {
				troca[contador] = '\"';
			} else if (alfa.equals("/")) {
				troca[contador] = '/';
			}
			contador = contador + 1;
		}
		String retorna = "";
		return retorna.copyValueOf(troca);
	}%>
<%!public String replaceString(String s, String busca, String troca) {
		String nova = "";
		int ini = s.indexOf(busca);
		boolean ok = false;
		if (ini > 0) {
			ok = true;
		} else {
			nova = s;
		}
		while (ok) {
			int fim = busca.length();
			nova = s.substring(0, ini) + troca
					+ s.substring(ini + fim, s.length());
			ini = nova.indexOf(busca);
			if (ini > 0) {
				s = nova;
			} else {
				ok = false;
			}
		}
		return nova;
	}%>

<%
	//try{

	//***DECLARAÇÃO DE VARIÁVEIS***
	ResultSet rs = null, rsHelp = null, rsA = null;

	String queryI = "", tipo = "", cod = "", query = "", nome = "", periodo = "", versao = "", resumo = "", contprog = "", comoaval = "", consger = "", lider = "", negoc = "", deleg = "", aprend = "", acint = "", coaching = "", autoconf = "", iniciativa = "", custo = "", custol = "", duracao = "", ativo = "", duracaomin = "", durt = "", envio = "", vencimento = "", porcentagem = "";

	int desenv = 0, entidade = 0, titulo = 0, saratoga = 0, tipocur = 0, resp = 0, minpart = 0, maxpart = 0, cont = 0, i = 0, cur_codigo = 0, cmp_codigo = 0, a = 0;

	Vector vet_comp = new Vector(), vetAvaliacao = new Vector(), vetEnvio = new Vector(), vetVencimento = new Vector(), vetAmostra = new Vector();

	//***RECUPERCAO DE PARAMETROS***//
	/*valores de sessao*/
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	String usu_tipo = (String) session.getAttribute("usu_tipo");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	//conexaoHelp.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"), (String)session.getAttribute("s_driverbanco")); 
	//conexaoA.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"), (String)session.getAttribute("s_driverbanco")); 

	/*Verifica se foram digitados os dados*/
	if (!(request.getParameter("tipo") == null)) {
		tipo = request.getParameter("tipo");
	}

	if (!(request.getParameter("cod") == null)) {
		cod = request.getParameter("cod");
	}

	if (!(tipo.equals("E"))) {
		desenv = ((request.getParameter("sel_desenv") == null)
				? 0
				: Integer.parseInt(request.getParameter("sel_desenv")));
		entidade = ((request.getParameter("sel_entidade") == null)
				? 0
				: Integer
						.parseInt(request.getParameter("sel_entidade")));
		titulo = ((request.getParameter("sel_titulo") == null)
				? 0
				: Integer.parseInt(request.getParameter("sel_titulo")));
		saratoga = ((request.getParameter("sel_saratoga") == null)
				? 0
				: Integer
						.parseInt(request.getParameter("sel_saratoga")));
		tipocur = ((request.getParameter("sel_tipo") == null)
				? 0
				: Integer.parseInt(request.getParameter("sel_tipo")));
		resp = ((request.getParameter("sel_resp") == null)
				? 0
				: Integer.parseInt(request.getParameter("sel_resp")));
		maxpart = ((request.getParameter("tf_maxpart") == null)
				? 0
				: Integer.parseInt(request.getParameter("tf_maxpart")));
		minpart = ((request.getParameter("tf_minpart") == null)
				? 0
				: Integer.parseInt(request.getParameter("tf_minpart")));
		nome = ((request.getParameter("tf_nome") == null)
				? ""
				: request.getParameter("tf_nome"));
		custo = ((request.getParameter("tf_custo") == null)
				? ""
				: request.getParameter("tf_custo"));
		custol = ((request.getParameter("tf_custol") == null)
				? ""
				: request.getParameter("tf_custol"));
		duracao = ((request.getParameter("tf_duracao") == null)
				? ""
				: request.getParameter("tf_duracao"));
		duracaomin = ((request.getParameter("tf_duracao_min") == null)
				? ""
				: request.getParameter("tf_duracao_min"));
		periodo = ((request.getParameter("tf_periodo") == null)
				? ""
				: request.getParameter("tf_periodo"));
		versao = ((request.getParameter("tf_versao") == null)
				? ""
				: request.getParameter("tf_versao"));
		resumo = ((request.getParameter("ta_resumo") == null)
				? ""
				: request.getParameter("ta_resumo"));
		contprog = ((request.getParameter("ta_contprog") == null)
				? ""
				: request.getParameter("ta_contprog"));
		comoaval = ((request.getParameter("ta_comoaval") == null)
				? ""
				: request.getParameter("ta_comoaval"));
		consger = ((request.getParameter("ta_consger") == null)
				? ""
				: request.getParameter("ta_consger"));
		ativo = ((request.getParameter("ativo") == null) ? "N" : "S");
		custo = replaceString(custo, ",", ".");
		custol = replaceString(custol, ",", ".");

		float h = 0, m = 0, du = 0;
		h = (float) Float.parseFloat(duracao);
		m = (float) Float.parseFloat(duracaomin);
		du = (h * 60) + m;
		durt = durt.valueOf(du);
	}

	java.util.Date hoje = new java.util.Date();
	SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
	String str_hoje = formato.format(hoje);

	//Tratamento de Aspas
	/*
	 String aspa = "'";
	 String nova = "";
	 int fim = 0;
	 int ini = comoaval.indexOf(aspa);
	 boolean ok = false;
	 if(ini>0){
	 ok = true;
	 }
	 else{
	 nova = comoaval;
	 }
	 while(ok){
	 fim = aspa.length();
	 nova = comoaval.substring(0,ini) + "\"" + comoaval.substring(ini+fim,comoaval.length());
	 ini = nova.indexOf(aspa);
	 if (ini>0){
	 comoaval = nova;
	 }
	 else{
	 ok = false;
	 }
	 }
	 comoaval = nova;

	 ini = resumo.indexOf(aspa);
	 ok = false;
	 if (ini>0){
	 ok = true;
	 }
	 else{
	 nova = resumo;
	 }
	 while(ok){
	 fim = aspa.length();
	 nova = resumo.substring(0,ini) + "\"" + resumo.substring(ini+fim,resumo.length());
	 ini = nova.indexOf(aspa);
	 if (ini>0){
	 resumo = nova;
	 }
	 else{
	 ok = false;
	 }
	 }
	 resumo = nova;

	 ini = consger.indexOf(aspa);
	 ok = false;
	 if (ini>0){
	 ok = true;
	 }
	 else{
	 nova = consger;
	 }
	 while(ok){
	 fim = aspa.length();
	 nova = consger.substring(0,ini) + "\"" + consger.substring(ini+fim,consger.length());
	 ini = nova.indexOf(aspa);
	 if (ini>0){
	 consger = nova;
	 }
	 else{
	 ok = false;
	 }
	 }
	 consger = nova;
	
	 ini = contprog.indexOf(aspa);
	 ok = false;
	 if(ini>0){
	 ok = true;
	 }
	 else{
	 nova = contprog;
	 }
	 while(ok){
	 fim = aspa.length();
	 nova = contprog.substring(0,ini) + "\"" + contprog.substring(ini+fim,contprog.length());
	 ini = nova.indexOf(aspa);
	 if (ini>0){
	 contprog = nova;
	 }
	 else{
	 ok = false;
	 }
	 }
	 contprog = nova;
	 */
	//comoaval = comoaval.replaceAll("'","\""); versAo jdk 1.4.1
	//resumo = resumo.replaceAll("'","\"");
	//consger = consger.replaceAll("'","\"");
	//contprog = contprog.replaceAll("'","\"");

	if (vet_comp.size() != 0) {
		vet_comp.clear();
	}
	//out.println("vet_comp.size() = " + vet_comp.size());

	if ((Vector) session.getAttribute("vet_compS") != null) {
		vet_comp = (Vector) session.getAttribute("vet_compS");
	}
	if ((Vector) session.getAttribute("vetor_avaliacao") != null) {
		vetAvaliacao = (Vector) session.getAttribute("vetor_avaliacao");
	}
	if ((Vector) session.getAttribute("vetor_envio") != null) {
		vetEnvio = (Vector) session.getAttribute("vetor_envio");
	}
	if ((Vector) session.getAttribute("vetor_vencimento") != null) {
		vetVencimento = (Vector) session
				.getAttribute("vetor_vencimento");
	}
	if ((Vector) session.getAttribute("vetor_amostra") != null) {
		vetAmostra = (Vector) session.getAttribute("vetor_amostra");
	}

	int x = 0;

	//Abre a conexAo com o Banco e faz o Update, Insert ou Delete para gravar o Curso
	if (tipo.equals("I")) {
		String help = "SELECT CUR_NOME FROM CURSO WHERE CUR_NOME = '"
				+ nome + "' AND EMP_CODIGO = " + entidade;
		rsHelp = conexao
				.executaConsulta(help, session.getId() + "RS_1");
		if (rsHelp.next()) {
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><script
	language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("IMPOSSIVEL CADASTRAR CURSO JA EXISTENTE") + "\"")%>);
      window.open("cursos.jsp","_self");
    </script>
<%
	} else {
			query = "INSERT INTO CURSO (CUR_ATIVO, SAR_CODIGO, CUR_NOME, DES_CODIGO, TIT_CODIGO, CUR_DURACAO, CUR_CUSTO, "
					+ "TCU_CODIGO, CUR_PROGRAMA, CUR_CONSIDERACOES, CUR_OBJETIVO, CUR_DATACADASTRO, CUR_COMOAVALIAR, "
					+ "CUR_CUSTO2, CUR_VERSAOATUAL, CUR_PERIODOREALIZACAO, EMP_CODIGO, FUN_CODIGO_RESP, CUR_MAXPART, "
					+ "CUR_MINPART, CUR_SIMPLES) VALUES " + "('"
					+ trataAspas(ativo)
					+ "',"
					+ saratoga
					+ ", '"
					+ trataAspas(nome)
					+ "', "
					+ desenv
					+ ", "
					+ titulo
					+ ", "
					+ durt
					+ ", "
					+ custo
					+ ", "
					+ tipocur
					+ ", "
					+ "'"
					+ trataAspas(contprog)
					+ "', '"
					+ trataAspas(consger)
					+ "', '"
					+ trataAspas(resumo)
					+ "', DATEFMT("
					+ str_hoje
					+ "), "
					+ "'"
					+ trataAspas(comoaval)
					+ "', "
					+ custol
					+ ", '"
					+ trataAspas(versao)
					+ "', '"
					+ trataAspas(periodo)
					+ "', "
					+ entidade
					+ ", "
					+ resp
					+ ","
					+ maxpart
					+ ", " + minpart + ",'N')";

			conexao.executaAlteracao(query);

			query = "SELECT CUR_CODIGO FROM CURSO "
					+ "WHERE SAR_CODIGO = "
					+ saratoga
					+ " "
					+ "AND DES_CODIGO = "
					+ desenv
					+ " "
					+ "AND TIT_CODIGO = "
					+ titulo
					+ " "
					+ "AND TCU_CODIGO = "
					+ tipocur
					+ " "
					+ "AND EMP_CODIGO = "
					+ entidade
					+ " "
					+ "AND FUN_CODIGO_RESP = "
					+ resp
					+ " "
					+ "AND CUR_MAXPART = "
					+ maxpart
					+ " "
					+ "AND CUR_NOME = '"
					+ trataAspas(nome)
					+ "' "
					+ "AND CUR_MINPART = " + minpart;

			rs = conexao.executaConsulta(query, session.getId()
					+ "RS_2");
			if (rs.next()) {
				cur_codigo = rs.getInt(1);
			}
			if (rs != null) {
				conexao.finalizaConexao(session.getId() + "RS_2");
			}

			if (vet_comp.size() > 0) {
				do {
					String queryA = "SELECT CMP_CODIGO FROM COMPETENCIA WHERE CMP_DESCRICAO = '"
							+ vet_comp.elementAt(x) + "'";
					rsA = conexao.executaConsulta(queryA, session
							.getId()
							+ "RS_3");
					rsA.next();
					query = "INSERT INTO CURSOCOMP (CUR_CODIGO, CMP_CODIGO) VALUES ("
							+ cur_codigo
							+ ", "
							+ rsA.getString(1)
							+ ")";
					//out.println("query = " + query);

					conexao.executaAlteracao(query);
					x = x + 1;
				} while (x < vet_comp.size());
			}
			if (rsA != null) {
				conexao.finalizaConexao(session.getId() + "RS_3");
			}
			if (!vetAvaliacao.isEmpty()) {
				for (i = 1; i <= vetAvaliacao.size(); i++) {
					envio = "";
					vencimento = "";
					porcentagem = "100";
					a = i - 1;
					envio = (String) vetEnvio.elementAt(a);
					vencimento = (String) vetVencimento.elementAt(a);
					porcentagem = (String) vetAmostra.elementAt(a);
					if (porcentagem.equals("")) {
						porcentagem = "100";
					}
					queryI = "INSERT INTO PLANO_AVALIA (QUE_CODIGO,CUR_CODIGO,PLV_DIASENVIO,PLV_DIASVENC,PLV_PORCENTAGEM) "
							+ "VALUES ("
							+ vetAvaliacao.elementAt(i - 1)
							+ ","
							+ cur_codigo
							+ ","
							+ envio
							+ ","
							+ vencimento + "," + porcentagem + ")";
					conexao.executaAlteracao(queryI);
					//out.println("<br>QUERY: "+queryI);
				}
			}
%>
<script language="JavaScript">
        alert(<%=("\""
											+ trd
													.Traduz("INCLUSAO EFETUADA COM SUCESSO") + "\"")%>);
        window.open("cursos.jsp","_self");
      </script>
<%
	}
		if (rsHelp != null) {
			conexao.finalizaConexao(session.getId() + "RS_1");
		}
	} else {
		if (tipo.equals("U")) {
			String help = "SELECT CUR_NOME FROM CURSO WHERE CUR_NOME = '"
					+ nome
					+ "' AND EMP_CODIGO = "
					+ entidade
					+ "AND CUR_CODIGO <> " + cod;
			rsHelp = conexao.executaConsulta(help, session.getId()
					+ "RS_4C");
			if (rsHelp.next()) {
%>
<script language="JavaScript">
        alert(<%=("\""
												+ trd
														.Traduz("IMPOSSIVEL CADASTRAR CURSO JA EXISTENTE") + "\"")%>);
        window.open("cursos.jsp","_self");
        </script>
<%
	} else {
				query = "UPDATE CURSO SET CUR_ATIVO = '" + ativo
						+ "', SAR_CODIGO = " + saratoga
						+ ", CUR_NOME = '" + trataAspas(nome)
						+ "', DES_CODIGO = " + desenv + ", "
						+ "TIT_CODIGO = " + titulo + ", CUR_DURACAO = "
						+ durt + ", CUR_CUSTO = " + custo + ", "
						+ "TCU_CODIGO = " + tipocur
						+ ", CUR_PROGRAMA = '" + trataAspas(contprog)
						+ "', CUR_CONSIDERACOES = '"
						+ trataAspas(consger) + "', "
						+ "CUR_OBJETIVO = '" + trataAspas(resumo)
						+ "', CUR_DATACADASTRO = DATEFMT(" + str_hoje
						+ "), " + "CUR_COMOAVALIAR = '"
						+ trataAspas(comoaval) + "', CUR_CUSTO2 = "
						+ custol + ", CUR_VERSAOATUAL = '"
						+ trataAspas(versao) + "', "
						+ "CUR_PERIODOREALIZACAO = '"
						+ trataAspas(periodo) + "', EMP_CODIGO = "
						+ entidade + ", FUN_CODIGO_RESP = " + resp
						+ ", " + "CUR_MAXPART = " + maxpart
						+ ", CUR_MINPART = " + minpart
						+ " WHERE CUR_CODIGO = " + cod;
				conexao.executaAlteracao(query);
				query = "SELECT CUR_CODIGO FROM CURSO "
						+ "WHERE SAR_CODIGO = "
						+ saratoga
						+ " "
						+ "AND DES_CODIGO = "
						+ desenv
						+ " "
						+ "AND TIT_CODIGO = "
						+ titulo
						+ " "
						+ "AND TCU_CODIGO = "
						+ tipocur
						+ " "
						+ "AND EMP_CODIGO = "
						+ entidade
						+ " "
						+ "AND FUN_CODIGO_RESP = "
						+ resp
						+ " "
						+ "AND CUR_MAXPART = "
						+ maxpart
						+ " "
						+ "AND CUR_MINPART = " + minpart;
				ResultSet rs3 = conexao.executaConsulta(query, session
						.getId()
						+ "RS_5");
				if (rs3.next()) {
					cur_codigo = rs3.getInt(1);
				}
				//if(rs3!=null){ 
				//  conexao.finalizaConexao(session.getId()+"RS_5");
				//}
				String queryA = "DELETE FROM CURSOCOMP WHERE CUR_CODIGO = "
						+ cod;
				conexao.executaAlteracao(queryA);
				//out.println("vet_comp.size() = " + vet_comp.size());
				while (x < vet_comp.size()) {
					queryA = "SELECT CMP_CODIGO FROM COMPETENCIA WHERE CMP_DESCRICAO = '"
							+ vet_comp.elementAt(x) + "'";
					rsA = conexao.executaConsulta(queryA, session
							.getId()
							+ "RS_6" + x);
					rsA.next();
					query = "INSERT INTO CURSOCOMP (CUR_CODIGO, CMP_CODIGO) VALUES ("
							+ cod + ", " + rsA.getString(1) + ")";
					if (rsA != null) {
						rsA.close();
						conexao.finalizaConexao(session.getId()
								+ "RS_6" + x);
					}
					//out.println("query = " + query);
					conexao.executaAlteracao(query);
					x = x + 1;
				}
				queryI = "DELETE PLANO_AVALIA WHERE CUR_CODIGO = "
						+ cod;
				conexao.executaAlteracao(queryI);
				if (!vetAvaliacao.isEmpty()) {
					for (i = 1; i <= vetAvaliacao.size(); i++) {
						envio = "";
						vencimento = "";
						porcentagem = "100";
						a = i - 1;
						envio = (String) vetEnvio.elementAt(a);
						vencimento = (String) vetVencimento
								.elementAt(a);
						porcentagem = (String) vetAmostra.elementAt(a);
						if (porcentagem.equals("")) {
							porcentagem = "100";
						}
						queryI = "INSERT INTO PLANO_AVALIA (QUE_CODIGO,CUR_CODIGO,PLV_DIASENVIO,PLV_DIASVENC,PLV_PORCENTAGEM) "
								+ "VALUES ("
								+ vetAvaliacao.elementAt(i - 1)
								+ ","
								+ cod
								+ ","
								+ envio
								+ ","
								+ vencimento
								+ "," + porcentagem + ")";
						conexao.executaAlteracao(queryI);
					}
				}
%>
<script language="JavaScript">
        alert(<%=("\""
												+ trd
														.Traduz("ALTERACAO EFETUADA COM SUCESSO") + "\"")%>);
        window.open("cursos.jsp","_self");
      </script>
<%
	}//Fim da alteraçao
			if (rsHelp != null) {
				rsHelp.close();
				conexao.finalizaConexao(session.getId() + "RS_4C");
			}
		}
		//Inicio da deleção dos cursos
		if (tipo.equals("E")) {
			//query = "DELETE FROM CURSOCOMP WHERE CUR_CODIGO = "+cod;
			//conexao.executaAlteracao(query);
			query = "SELECT * FROM CURSOCOMP WHERE CUR_CODIGO = " + cod;
			rs = conexao.executaConsulta(query, session.getId()
					+ "RS_7");
			if (rs.next()) {
%>
<script language="JavaScript">
        alert(<%=("\""
												+ trd
														.Traduz("EXCLUSAO NAO PERMITIDA. EXISTE COMPETENCIA VINCULADA A ESTE CURSO") + "\"")%>);
        window.open("cursos.jsp","_self");
      </script>
<%
	} else {
				query = "SELECT * FROM TURMA WHERE TUR_CODIGO = " + cod;
				rs = conexao.executaConsulta(query, session.getId()
						+ "RS_8");
				if (rs.next()) {
%>
<script language="JavaScript">
          alert(<%=("\""
													+ trd
															.Traduz("EXCLUSAO NAO PERMITIDA. EXISTE TURMA VINCULADA A ESTE CURSO") + "\"")%>);
          window.open("cursos.jsp","_self");
        </script>
<%
	} else {
					/**
					 *query = "SELECT * FROM CURSO_AVALIA WHERE CUR_CODIGO = "+cod;
					 *rs = conexao.executaConsulta(query);
					 *if(rs.next())
					 *{
					 *  
					 *  <script language="JavaScript">
					 *    alert(<%=("\""+trd.Traduz("ExclusAo nAo permitida. Existe AvaliaCAo vinculada a este Curso.")");
					 *    window.open("cursos.jsp","_self");
					 *  </script>
					 *  
					 *}
					 *else
					 */
					//{
					query = "DELETE FROM PLANO_AVALIA WHERE CUR_CODIGO = "
							+ cod;
					conexao.executaAlteracao(query);
					query = "DELETE FROM CURSO WHERE CUR_CODIGO = "
							+ cod;
					conexao.executaAlteracao(query);
%>
<script language="JavaScript">
          alert(<%=("\""
													+ trd
															.Traduz("EXCLUSAO EFETUADA COM SUCESSO") + "\"")%>);
          window.open("cursos.jsp","_self");
        </script>
<%
	//}
				}
			}
			if (rs != null) {
				conexao.finalizaConexao(session.getId() + "RS_7");
			}
		} else {
%>
<script language="JavaScript">
      window.open("cursos.jsp","_self");
    </script>
<%
	}
	}
	//if(rs != null){
	//rs.close();
	//}

	//}catch(Exception e){out.println("Erro: "+e);}
%>