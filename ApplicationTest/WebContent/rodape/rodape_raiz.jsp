
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.util.*,java.sql.*,java.text.*"%>


<%
	request.getSession();
	FOLocalizationBean trd3 = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	conexao = conexao.getConection();
	//conexao.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"), (String)session.getAttribute("s_driverbanco")); 
	//conexao.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"), (String)session.getAttribute("s_driverbanco")); 
	//conexao.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"), (String)session.getAttribute("s_driverbanco")); 

	String t = request.getRequestURI();
	String apl = (String) session.getAttribute("aplicacao");

	//try{

	Vector per = (Vector) session.getAttribute("vetorPermissoes");

	Integer fun_idi = (Integer) session.getAttribute("usu_idi");
	Integer usu_cod = (Integer) session.getAttribute("usu_cod");
	String usu_tipo = (String) session.getAttribute("usu_tipo");

	ResultSet rsCount = null, rsIdioma = null, rsPlano = null, rsFilial = null;

	//Contadores de registro de Idioma e Plano
	String query2 = " SELECT Count(IDI_codigo) FROM LNG_IDIOMA ";
	rsCount = conexao.executaConsulta(query2, session.getId() + "RS_1");
	int teste1 = 0;
	if (rsCount.next()) {
		teste1 = rsCount.getInt(1);
	}
	if (rsCount != null) {
		rsCount.close();
		//conexao.finalizaConexao(session.getId()+"RS_1");
	}
	rsCount = null;
	query2 = " SELECT Count(PLA_CODIGO) FROM PLANO ";
	rsCount = conexao.executaConsulta(query2, session.getId() + "RS_2");
	int teste2 = 0;
	if (rsCount.next()) {
		teste2 = rsCount.getInt(1);
	}
	if (rsCount != null) {
		rsCount.close();
		//conexao.finalizaConexao(session.getId()+"RS_2");
	}

	rsCount = null;
	if (!usu_tipo.equals("F")) {
		query2 = " SELECT Count(FIL_CODIGO) FROM FILIAL  WHERE FIL_CODIGO IN (SELECT FIL_CODIGO FROM FOCOFILIAL WHERE FUN_CODIGO="
				+ usu_cod + ")";
	} else {
		query2 = " SELECT Count(FIL_CODIGO) FROM FILIAL";
	}
	rsCount = conexao.executaConsulta(query2, session.getId() + "RS_3");
	int teste3 = 0;
	if (rsCount.next()) {
		teste3 = rsCount.getInt(1);
	}

	if (rsCount != null) {
		rsCount.close();
		conexao.finalizaConexao(session.getId() + "RS_3");
	}
%>


<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<script language="JavaScript1.2">
function sobre(){
  window.open('sobre.jsp','popup','scrollbars=yes,width=384,height=400,left=200,top=100');
}

//Funcao do menu de idioma
function array1(){
HM_Array3 = [
[70,      	// menu width
,       	// left_position
,       	// top_position
"#666666",  	// font_color
"#000000",  	// mouseover_font_color
"#F4F4F4",   	// background_color
"#CCCCCC",   	// mouseover_background_color
"#C5C5C5",   	// border_color
"#C5C5C5",   	// separator_color
1,         	// top_is_permanent
0,         	// top_is_horizontal
0,         	// tree_is_horizontal
1,         	// position_under
1,         	// top_more_images_visible
1,         	// tree_more_images_visible
"null",    	// evaluate_upon_tree_show
"null",    	// evaluate_upon_tree_hide
,          	// right-to-left
],   		// display_on_click
<%/*Processo de avaliação dos projetos*/
			String query = " SELECT IDI_CODIGO,IDI_NOME FROM LNG_IDIOMA ";
			rsIdioma = conexao.executaConsulta(query, session.getId() + "IDI");
			if (rsIdioma.next()) {
				String cod_idioma = new String(rsIdioma.getString(1));
				String idioma = new String(rsIdioma.getString(2));
				String pagina = request.getRequestURI();
				int i1 = 1;
				do {
					if ((teste1 == 1) || (teste1 == i1)) {%>
	    ["<%=rsIdioma.getString(2)%>","rodape/rodape_atualiza_idioma.jsp?cod=<%=rsIdioma.getInt(1)%>&page=<%=pagina%>",1,0,1]
<%} else {%>
	    ["<%=rsIdioma.getString(2)%>","rodape/rodape_atualiza_idioma.jsp?cod=<%=rsIdioma.getInt(1)%>&page=<%=pagina%>",1,0,1],
<%}
					i1 = i1 + 1;
				} while (rsIdioma.next());
			} else {%>
      	[<%=("\""
										+ trd3
												.Traduz("Não Existe Idioma cadastrado!") + "\"")%>,"#",1,0,1]          	
<%}
			if (rsIdioma != null) {
				rsIdioma.close();
				conexao.finalizaConexao(session.getId() + "IDI");
			}%>
]


HM_Array7 = [
[70,      	// menu width
,       	// left_position
,       	// top_position
"#666666",  	// font_color
"#000000",  	// mouseover_font_color
"#F4F4F4",   	// background_color
"#CCCCCC",   	// mouseover_background_color
"#C5C5C5",   	// border_color
"#C5C5C5",   	// separator_color
1,         	// top_is_permanent
0,         	// top_is_horizontal
0,         	// tree_is_horizontal
1,         	// position_under
1,         	// top_more_images_visible
1,         	// tree_more_images_visible
"null",    	// evaluate_upon_tree_show
"null",    	// evaluate_upon_tree_hide
,          	// right-to-left
],   		// display_on_click
<%/*Processo de avaliação dos projetos*/
			String query3 = "SELECT PLA_CODIGO, PLA_NOME, PLA_ACESSO FROM PLANO";
			rsPlano = conexao.executaConsulta(query3, session.getId() + "PLA");
			if (rsPlano.next()) {
				String pagina2 = request.getRequestURI();
				int i = 1;
				do {
					if (rsPlano.getString(3).equals("S")) {
						if ((teste2 == 1) || (teste2 == i)) {%>
				["<%=rsPlano.getString(2)%>","rodape/rodape_atualiza_plano.jsp?cod=<%=rsPlano.getInt(1)%>&page=<%=pagina2%>",1,0,1]
				<%} else {%>
				["<%=rsPlano.getString(2)%>","rodape/rodape_atualiza_plano.jsp?cod=<%=rsPlano.getInt(1)%>&page=<%=pagina2%>",1,0,1],
				<%}
					}
					i = i + 1;
				} while (rsPlano.next());
			} else {%>
	[<%=("\""
										+ trd3
												.Traduz("Não Existem Plano cadastrados!") + "\"")%>,"#",1,0,1]          	
	<%}
			if (rsPlano != null) {
				rsPlano.close();
				conexao.finalizaConexao(session.getId() + "PLA");
			}%>
]



<%if (!usu_tipo.equals("F")) {%> 
HM_Array8 = [
[240,      	// menu width
,       	// left_position
,       	// top_position
"#666666",  	// font_color
"#000000",  	// mouseover_font_color
"#F4F4F4",   	// background_color
"#CCCCCC",   	// mouseover_background_color
"#C5C5C5",   	// border_color
"#C5C5C5",   	// separator_color
1,         	// top_is_permanent
0,         	// top_is_horizontal
0,         	// tree_is_horizontal
1,         	// position_under
1,         	// top_more_images_visible
1,         	// tree_more_images_visible
"null",    	// evaluate_upon_tree_show
"null",    	// evaluate_upon_tree_hide
,          	// right-to-left
],   		// display_on_click
<%/*Processo de avaliação dos projetos*/
				String query4 = "";
				if (!usu_tipo.equals("F")) {
					query4 = " SELECT FIL_CODIGO,FIL_NOME FROM FILIAL  WHERE FIL_CODIGO IN (SELECT FIL_CODIGO FROM FOCOFILIAL WHERE FUN_CODIGO="
							+ usu_cod + ")";
				} else {
					query4 = " SELECT FIL_CODIGO,FIL_NOME FROM FILIAL";
				}

				rsFilial = conexao.executaConsulta(query4, session.getId()
						+ "FIL");
				if (rsFilial.next()) {
					String pagina3 = request.getRequestURI();
					int i = 1;
					do {
						if ((teste3 == 1) || (teste3 == i)) {%>
	    ["<%=rsFilial.getString(2)%>","rodape/rodape_atualiza_filial.jsp?cod=<%=rsFilial.getInt(1)%>&page=<%=pagina3%>",1,0,1]
<%} else {%>
	    ["<%=rsFilial.getString(2)%>","rodape/rodape_atualiza_filial.jsp?cod=<%=rsFilial.getInt(1)%>&page=<%=pagina3%>",1,0,1],
<%}
						i = i + 1;
					} while (rsFilial.next());
				} else {%>
      	[<%=("\""
											+ trd3
													.Traduz("Não Existem Filial cadastrados!") + "\"")%>,"#",1,0,1]          	
<%}
				if (rsFilial != null) {
					rsFilial.close();
					conexao.finalizaConexao(session.getId() + "FIL");
				}%>
]

<%}%>
}


</script>

<script language="JavaScript1.2">
function abreJanelaFormatada(origem, destino)
{ 
  windowprops = ("top=0,left=0,toolbar=yes,location=no,maximized=yes,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no" +
                ",width=" + (screen.width-6) + ",height=" + (screen.height-80)); 

  window.open(origem,'_self');
  abreJanelaFormatada=window.open(destino,'work',windowprops); 
}

function fecha(){


	var lcmsg="",
		lnx=0,
	    lny=0,
	    loe= window.event,
        lcurl;

	lcmsg+="Type: " + loe.type;
	               if (loe.srcElement && loe.srcElement.name)  lcmsg+="srcElement name: " + loe.srcElement.name;
	               if (loe.clientX || loe.clientY)             lcmsg+="X: " + loe.clientX + " Y: " + loe.clientY;
	               if (loe.button)                             lcmsg+="button: " + loe.button;
	               if (loe.keyCode)                            lcmsg+="keyCode: " + loe.keyCode;
	               if (loe.altKey)                             lcmsg+="altKey";
	               if (loe.ctrlKey)                            lcmsg+="ctrlKey";
    			   if (loe.shiftKey)                           lcmsg+="shiftKey";

		if ((loe.altKey)||  (! loe.ctrlKey) && (loe.clientY) && (loe.clientY <= -128)){
                                showModalDialog('<%=request.getContextPath()%>' + '/servlet/ser.comum.conexao.Sair','','status=no;scroll=no;dialogWidth=300px;dialogHeight=60px');
                               
                                
		}
		else{


		}
	return false
}
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td><img src="art/bit.gif" width="20" height="10"></td>
				<td width="10" nowrap><img src="art/bit.gif" width="10"
					height="10"></td>
				<%
					if (apl.equals("EM")) {
				%>
				<td nowrap><a href="#" onclick="return sobre()" class="dilink"><%=trd3.Traduz("Sobre o")%>
				FirstOn EM</a></td>
				<%
					} else if (apl.equals("CM")) {
				%>
				<td nowrap><a href="#" onclick="return sobre()" class="dilink"><%=trd3.Traduz("Sobre o")%>
				FirstOn CM</a></td>
				<%
					} else {
				%>
				<td nowrap><a href="#" onclick="return sobre()" class="dilink"><%=trd3.Traduz("Sobre o")%>
				eFeedback</a></td>
				<%
					}
					String EMAIL_DE_SUPORTE = ((((String) session
							.getAttribute("email_suporte")) == null)
							? ""
							: (String) session.getAttribute("email_suporte"));
					if (!EMAIL_DE_SUPORTE.equals("")) {
				%>
				<td width="10" nowrap><img src="art/bit.gif" width="10"
					height="10"></td>
				<td width="1" class="dihdiv"><img src="art/bit.gif" width="1"
					height="10"></td>
				<td width="10" nowrap><img src="art/bit.gif" width="10"
					height="10"></td>
				<td nowrap class="difont"><b><%=trd3.Traduz("DUvidas")%>?</b> <%=trd3.Traduz("Entre em contato com")%>:&nbsp;<a
					href="mailto:<%=EMAIL_DE_SUPORTE%>" class="dilink"><%=EMAIL_DE_SUPORTE%></a>
				<%
					}
				%>
				</td>
			</tr>
		</table>
		</td>
		<td align="right" width="15">
		<%
			if (per.contains("FERRAMENTAS - IDIOMA - SELECAO")) {
		%> <a href="#" onMouseOver="HM_f_PopUp('elMenu3',event)"
			onMouseOut="HM_f_PopDown('elMenu3')"><img src="art/idioma.gif"
			width="29" height="20" border="0"
			alt=<%=("\"" + trd3.Traduz("Alterar Idioma") + "\"")%>></a> <%
 	}

 	else {
 %> &nbsp; <%
 	}

 	request.getSession();
 	String app = (((String) session.getAttribute("aplicacao") == null)
 			? "N"
 			: (String) session.getAttribute("aplicacao"));

 	if (app.equals("EM")) {
 %>
		</td>
		<td>&nbsp;</td>
		<td align="right" width="14"><a href="#"
			onMouseOver="HM_f_PopUp('elMenu7',event)"
			onMouseOut="HM_f_PopDown('elMenu7')"><img src="art/plano.gif"
			width="29" height="20" border="0"
			alt=<%=("\"" + trd3.Traduz("Alterar PLANO") + "\"")%>></a></td>
		<td>&nbsp;</td>
		<%
			if (!usu_tipo.equals("F")) {
		%>
		<td align="right" width="14"><a href="#"
			onMouseOver="HM_f_PopUp('elMenu8',event)"
			onMouseOut="HM_f_PopDown('elMenu8')"> <img src="art/filial.gif"
			width="31" height="25" border="0"
			alt=<%=("\"" + trd3.Traduz("Alterar FILIAL") + "\"")%>></a></td>
		<%
			}
				//out.println(usu_tipo);
			}
		%>
		<td align="right" width="20"><img src="art/bit.gif" width="20"
			height="10"></td>
	</tr>
</table>
<script language="JavaScript1.2" src="js/HM_Loader.js"
	type='text/JavaScript'></script>
</html>
<%
	//conexao.finalizaConexao();

	//conexaoIdioma.finalizaConexao();
	//conexaoIdioma.finalizaBD();

	//conexaoPlano.finalizaConexao();
	//conexaoPlano.finalizaBD();

	//conexaoFilial.finalizaConexao();
	//conexaoFilial.finalizaBD();

	//} catch(Exception es ){
	//  out.println(""+es);
	//}
%>
<jsp:include page="acesso.jsp" flush="true">
	<jsp:param value="rod" name="1" />
</jsp:include>