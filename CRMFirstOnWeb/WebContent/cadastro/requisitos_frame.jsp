<!-- saved from url=(0056)http://192.168.0.104:8080/FirstOnEM/cadastro/titulos.jsp -->
<!--
Nome do arquivo: cadastro/titulos.jsp
Nome da funcionalidade: cadastro de titulos
Função: exibe os titulos e as funcionalidades dele

Variáveis necessárias/ Requisitos: 

- sessao:usu_tipo("usu_tipo"), usu_nome("usu_nome"), usu_login("usu_login"),
         usu_fil("usu_fil"), usu_idi("usu_idi"), per("vetorPermissoes");

- parametro: filtro("filtro"), código do assunto("assunto");

Regras de negócio (pagina):
_________________________________________________________________________________________

Histórico
Data de atualizacao: 14/03/2003 - Desenvolvedor: Leonardo Furlan
Atividade:
          - padronizacao da página;
_________________________________________________________________________________________
-->
<!--***DIRETRIZES DA PAGINA***-->
<!--***IMPORTAÇOES E BEANS***-->
<!--***DIRETRIZES DA PAGINA***-->
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<!--***IMPORTAÇOES E BEANS***-->
<%@page import="java.sql.*,java.util.*"%>
<%
	//*configuracao de cache*//
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}

	//***DECLARAÇÃO DE VARIÁVEIS***
	ResultSet rs = null;

	String query = "", msg = "", str_deleta = "";
	int cont_tit = 0, cont_pos = 0, c = 0, int_contdel = 0;

	//***RECUPERCAO DE PARAMETROS***//
	/*valores de sessao*/
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	Integer usu_cod = (Integer) session.getAttribute("usu_cod");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");

	/*Recupera tipo da mensagem*/
	msg = (((String) request.getParameter("msgPro") == null)
			? ""
			: (String) request.getParameter("msgPro"));

	try {

		if (request.getParameter("contapos") != null)
			cont_pos = Integer.parseInt(request
					.getParameter("contapos"));

		if (request.getParameter("contatit") != null)
			cont_tit = Integer.parseInt(request
					.getParameter("contatit"));

		if (request.getParameter("deletar") != null)
			str_deleta = request.getParameter("deletar");

		if (request.getParameter("contador") != null)
			int_contdel = Integer.parseInt(request
					.getParameter("contador"));

		Vector Vetpos = new Vector();
		Vector Vettit = new Vector();

		Vector Vetposaux = new Vector();
		Vector Vettitaux = new Vector();
		Vector Vettam = new Vector();

		Vector Vetposinc = new Vector();
		Vector Vettitinc = new Vector();

		Vector Vetseq = new Vector();

		/* session.setAttribute("vetor_car", null);
		 session.setAttribute("vetor_tit", null);
		 session.setAttribute("vetor_seq", null);*/

		//Verifica se existe um vetor na secao
		if ((Vector) session.getAttribute("vetor_car") == null) {
			Vettam.setSize(0);
		} else {
			Vettam = (Vector) session.getAttribute("vetor_car");
		}

		//Se o vetor da secao estiver vazio preenche os vetores de posicao e titulo
		if (Vettam.size() == 0) {

			for (int i = 1; i <= cont_pos; i++) {
				for (int k = 1; k <= cont_tit; k++) {
					if (request.getParameter("checktit" + k) != null) {
						if (request.getParameter("checkpos" + i) != null) {
							Vetpos.add(request.getParameter("checkpos"
									+ i));
						}

						if (request.getParameter("checkpos" + i) != null) {
							Vettit.add(request.getParameter("checktit"
									+ k));
							c++;
							Vetseq.add("" + c);
						}
					}
				}
			}
		} else {

			//Pega os vetores da secao
			Vetpos = (Vector) session.getAttribute("vetor_car");
			Vettit = (Vector) session.getAttribute("vetor_tit");
			Vetseq = (Vector) session.getAttribute("vetor_seq");

			int ind = 0;
			//verifica se tem algun item para deletar

			if (str_deleta.equals("S")) {
				for (int i = 0; i < int_contdel; i++) {
					if (request.getParameter("checkseq" + i) != null) {
						if (Vetseq.size() > 0) {
							ind = Vetseq.indexOf(request
									.getParameter("checkseq" + i));
							if (ind != -1) {

								Vetseq.remove(ind);
								Vetpos.remove(ind);
								Vettit.remove(ind);

							}
						}
					}
				}
			}

			boolean aux = false;

			//preenche os vetores auxiliares
			for (int i = 1; i <= cont_pos; i++) {
				for (int k = 1; k <= cont_tit; k++) {
					if (request.getParameter("checktit" + k) != null) {
						if (request.getParameter("checkpos" + i) != null) {
							Vetposaux.add(request
									.getParameter("checkpos" + i));
							aux = true;
						}

						if (request.getParameter("checkpos" + i) != null) {
							Vettitaux.add(request
									.getParameter("checktit" + k));
							aux = true;
						}
					}
				}
			}

			//variavel para vetor seq
			int cf = 0;
			String ult = "";

			//Verifica os dados dos vetores auxiliares existem nos vetores da secao 
			if (aux == true) {
				for (int i = 0; i < Vetposaux.size(); i++) {
					boolean existe = true;

					if (Vetseq.size() > 0) {

						for (int k = 0; k < Vetpos.size(); k++) {
							if ((Vetpos.get(k).equals(Vetposaux.get(i)))
									&& (Vettit.get(k).equals(Vettitaux
											.get(i)))) {
								existe = true;
								break;
							} else {
								existe = false;
							}

						}

						if (existe == false) {
							Vetposinc.add(Vetposaux.get(i));
							Vettitinc.add(Vettitaux.get(i));
						}

					}

				}
				//pega o ultimo elemento da sequencia
				ult = (String) Vetseq.lastElement();
				cf = Integer.parseInt(ult);

				//Atribui os vetores de inclusao aos da secao
				if (Vetposinc.size() > 0) {
					for (int i = 0; i < Vetposinc.size(); i++) {
						cf++;
						Vetpos.add(Vetposinc.get(i));
						Vettit.add(Vettitinc.get(i));
						Vetseq.add("" + cf);
					}
				}

			}
		}
%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><HTML>
<HEAD>
<TITLE>FirstOn - CADASTRO - CADASTRO DE PRÉ-REQUISITOS</TITLE>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<SCRIPT language="JavaScript" src="/js/scripts.js"></SCRIPT>
<LINK rel="stylesheet" href="../default.css" type="text/css">
<SCRIPT language=JavaScript>
function del(){

  var paramtit = "";
  var tem = false;

  for(k=0;k<frmpre.contador.value;k++)
  {
    if(eval("frmpre.checkseq"+k+".checked")==true)
    {
	  tem = true;
	  paramtit = paramtit + "checkseq"+k+"="+ eval("frmpre.checkseq"+k+".value") + "&";
    }
  }
  
  if (tem)
  {
	frmpre.deletar.value = "S";
	paramtit = paramtit + "deletar=" + frmpre.deletar.value + "&contador=" + frmpre.contador.value;
	window.open("requisitos_frame.jsp?" + paramtit + "",target="parte_inferior1", "_parent");
  }
  else
  {
    alert(<%=("\"" + trd.Traduz("NENHUM ITEM SELECIONADO") + "\"")%>);
    return false;
  }
}

function cancela(){
   window.open("prerequisitos.jsp","_parent");
}

function envia(){
    var paramtit = "";
  var tem = false;

  for(k=0;k<frmpre.contador.value;k++)
  {
    if(eval("frmpre.checkreq"+k+".checked")==true)
    {
	  tem = true;
	  paramtit = paramtit + "checkreq"+k+"="+ eval("frmpre.checkreq"+k+".value") + "&";
    }
  }
  

	paramtit = paramtit +  "contador=" + frmpre.contador.value;
	window.open("grava_prerequisitos.jsp?" + paramtit + "", "_parent");

}
</SCRIPT>

<META content="MSHTML 6.00.2600.0" name=GENERATOR>
</HEAD>
<body onunload='return fecha();' leftMargin=0 topMargin=0
	marginheight="0" marginwidth="0">
<FORM name="frmpre" method="post">
<TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
	<TR>
		<TD vAlign=top>
		<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
			<TR>

			</TR>
		</TABLE>
		<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
			<TR>
				<TD width=20><IMG height=30 src="../art/bit.gif" width=20></TD>
				<TD align=middle width="100%">
				<TABLE cellSpacing=0 cellPadding=0 border=0>
					<TR>
						<TD width=13><IMG height=15 src="../art/bit.gif" width=13></TD>
						<TD class=trontrk width="296"><%=trd.Traduz("GRADE DE REQUISITOS SELECIONADOS")%></TD>
						<TD width=23><IMG height=15 src="../art/bit.gif" width=13></TD>
					</TR>
				</TABLE>
				</TD>
				<TD width=20>&nbsp;</TD>
			</TR>
			<TR>
				<TD width=20 height=1><IMG height=1 src="../art/bit.gif"
					width=1></TD>
				<TD class=ctvdiv vAlign=top><IMG height=1 src="../art/bit.gif"
					width=1></TD>
				<TD width=20><IMG height=1 src="../art/bit.gif" width=1></TD>
			</TR>
			<TR>
				<TD vAlign=top width=20><IMG height=15 src="../art/bit.gif"
					width=20></TD>

				<TD vAlign=top><IMG height=1 src="../art/bit.gif" width=159><BR>
				<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
					<TR>
						<TD height=13><IMG height=1 src="../art/bit.gif" width=1></TD>
					</TR>
					<TR>
						<TD colSpan=4 align="center">
						<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0
							align="center">
							<td align="center">&nbsp;</td>
							<td align="center"><input type="button" class="botcin"
								value="       <%=trd.Traduz("OK")%>       " name="bok"
								onClick="return envia();"></td>
							<td align="center"><input type="button" class="botcin"
								value=<%=("\"" + trd.Traduz("CANCELAR") + "\"")%> name="bcancel"
								onClick="return cancela();"></td>
							<td align="center"><input type="button" class="botcin"
								value=" <%=trd.Traduz("EXCLUIR")%> " name="bexcluir"
								onClick="return del();"></td>
							<td align="center">&nbsp;</td>
						</TABLE>
						</TD>
					</TR>
				</TABLE>
				<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
					<TR>
						<TD height=12><IMG height=1 src="../art/bit.gif" width=1></TD>
					</TR>
					<TR>
						<TD class=ctvdiv height=1><IMG height=1 src="../art/bit.gif"
							width=1></TD>
					</TR>
					<TR>
						<TD align=middle>&nbsp;<BR>

						<TABLE cellSpacing=1 cellPadding=0 width="80%" border=0>
							<TR>
								<TD width="4%">&nbsp;</TD>
								<TD class=celtittab width="46%"><%=trd.Traduz("TITULO")%></TD>
								<TD class=celtittab width="46%"><%=trd.Traduz("CARGO")%></TD>
								<TD class=celtittab width="4%"><%=trd.Traduz("REQUERIDO")%></TD>
							</TR>

							<%
								String nometit = "", nomepos = "";
									int int_cont = 0;
									for (int i = 0; i < Vetseq.size(); i++) {
										query = "SELECT TIT_NOME FROM TITULO WHERE TIT_CODIGO = "
												+ Vettit.get(i);
										rs = conexao.executaConsulta(query, session.getId()
												+ "RS_1");
										if (rs.next()) {
											nometit = rs.getString(1);
										}
										if (rs != null) {
											rs.close();
											conexao.finalizaConexao(session.getId() + "RS_1");
										}
										query = "SELECT CAR_NOME FROM CARGO WHERE CAR_CODIGO = "
												+ Vetpos.get(i);
										rs = conexao.executaConsulta(query, session.getId()
												+ "RS_2");
										if (rs.next()) {
											nomepos = rs.getString(1);
										}
										if (rs != null) {
											rs.close();
											conexao.finalizaConexao(session.getId() + "RS_2");
										}
							%>

							<TR class="celnortab">
								<TD width="4%"><INPUT type="checkbox"
									value="<%=Vetseq.get(i)%>" name="checkseq<%=i%>"></TD>
								<TD width="46%"><%=nometit%></TD>
								<TD width="46%"><%=nomepos%></TD>
								<TD width="4%" align=middle><INPUT type="checkbox" checked
									name="checkreq<%=i%>"></TD>
							</TR>

							<%
								int_cont++;
									}

									session.setAttribute("vetor_car", Vetpos);
									session.setAttribute("vetor_tit", Vettit);
									session.setAttribute("vetor_seq", Vetseq);
							%>
							<INPUT type="hidden" name="contador" value="<%=int_cont%>">
							<INPUT type="hidden" name="deletar" value="N">

						</TABLE>

						&nbsp;
						<p></P>
				</table>
				</TD>
			</TR>
		</TABLE>

		</TD>
	</TR>
</TABLE>
</FORM>
</BODY>

</HTML>
<%
	} catch (Exception e) {
		out.println(e);
	}
%>