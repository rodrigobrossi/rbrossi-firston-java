
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.util.*"%>



<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	String aplicacao = (String) session.getAttribute("aplicacao");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	Integer usu_codigo = (Integer) session.getAttribute("usu_cod");
	String usu_plano = "";
	usu_plano = usu_plano.valueOf(session.getAttribute("usu_plano"));

	//Variaveis para os filtros
	String cur = "*", query = "", query_gridP = "", opt_filtro = "";
	boolean contem, existe = false;

	ResultSet rscurso = null;
	ResultSet rsgrid = null;

	//try
	//{

	if (request.getParameter("textnome") != null) {
		opt_filtro = (String) request.getParameter("textnome");
	} else {
		opt_filtro = "";
	}

	//Querys do grid de Treinamentos Planejados
	if (request.getParameter("selectcur") != null) {
		if (!(request.getParameter("selectcur").equals(""))) {
			query_gridP = "SELECT T.TEF_CODIGO, F.FUN_CHAPA, F.FUN_NOME, C.CUR_NOME, C.CUR_CODIGO "
			+ "FROM TREINAMENTO T, FUNCIONARIO F, CURSO C "
			+ "WHERE T.FUN_CODIGO = F.FUN_CODIGO AND "
			+ "T.CUR_CODIGO = C.CUR_CODIGO AND (T.TUR_CODIGO_REAL IS NULL) "
			+ "AND (T.TUR_CODIGO_PLAN_ANT IS NULL)  AND (T.JUS_CODIGO IS NULL)  "
			+ " AND T.PLA_CODIGO = " + usu_plano;

			//Select do Filtro escolhido
			query_gridP = query_gridP + "AND T.CUR_CODIGO = "
			+ request.getParameter("selectcur") + " ";
			if (!(opt_filtro.equals(""))) {
		query_gridP = query_gridP + " AND F.FUN_NOME >= '"
				+ opt_filtro + "%'";
			}
			query_gridP = query_gridP + " ORDER BY  F.FUN_NOME";

		} else {
			query_gridP = "SELECT T.TEF_CODIGO, F.FUN_CHAPA, F.FUN_NOME, C.CUR_NOME, C.CUR_CODIGO "
			+ "FROM TREINAMENTO T, FUNCIONARIO F, CURSO C "
			+ "WHERE T.FUN_CODIGO = F.FUN_CODIGO AND "
			+ "T.CUR_CODIGO = C.CUR_CODIGO AND (T.TUR_CODIGO_REAL IS NULL) "
			+ "AND (T.TUR_CODIGO_PLAN_ANT IS NULL)  AND (T.JUS_CODIGO IS NULL)  AND T.CUR_CODIGO = -1 ORDER BY F.FUN_NOME";
		}
	} else {
		query_gridP = "SELECT T.TEF_CODIGO, F.FUN_CHAPA, F.FUN_NOME, C.CUR_NOME, C.CUR_CODIGO "
		+ "FROM TREINAMENTO T, FUNCIONARIO F, CURSO C "
		+ "WHERE T.FUN_CODIGO = F.FUN_CODIGO AND "
		+ "T.CUR_CODIGO = C.CUR_CODIGO AND (T.TUR_CODIGO_REAL IS NULL) "
		+ "AND (T.TUR_CODIGO_PLAN_ANT IS NULL)  AND (T.JUS_CODIGO IS NULL) AND T.CUR_CODIGO = -1 ORDER BY  F.FUN_NOME";
	}

	//out.println("query_gridP = " + query_gridP);
%>

<script language="JavaScript">

function Filtro() {
        frm.action = "frame_planejados.jsp";
        frm.submit();
        return false; 
        }

function Incluir(){

var paramplan = "";
var tem = false;
 
  for(k=1;k<frm.contador.value;k++)
  {
    if(eval("frm.checkplan"+k+".checked")==true)
    {
	  tem = true;
	  paramplan = paramplan + "checkplan"+k+"="+ eval("frm.checkplan"+k+".value") + "&";
    }
  }

  if (tem)
  {	
	paramplan = paramplan + "contaplan=" + (frm.contador.value - 1) + "&curso=" + frm.curso.value;
    window.open("frame_listafuncionarios.jsp?" + paramplan,target="bottomFrame", "_parent");
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
		<td width="30%" class="ctfontc">
		<div align="left"><%=trd.Traduz("LOCALIZAR POR FUNCIONARIO")%>:</div>
		</td>
		<td width="70%"><input type="text" name="textnome"
			value="<%=opt_filtro%>"></td>
	</tr>
	<tr>
		<td class="ctfontc">
		<div align="left"><%=trd.Traduz("CURSO")%>:</div>
		</td>
		<td><select name="selectcur" class="form">
			<option value="" selected><%=trd.Traduz("Selecione")%></option>
			<%
				String query_curso = "";
				query_curso = "SELECT CUR_CODIGO, CUR_NOME FROM CURSO "
						+ "WHERE CUR_ATIVO = 'S' " + "ORDER BY CUR_NOME";
				rscurso = conexao.executaConsulta(query_curso, session.getId());
				if (rscurso.next()) {
					cur = (request.getParameter("selectcur") == null) ? ""
					: request.getParameter("selectcur");
					do {
						if (cur.equals(rscurso.getString(1))) {
			%>
			<option value="<%=rscurso.getInt(1)%>" selected><%=rscurso.getString(2)%></option>
			<%
			} else {
			%>
			<option value="<%=rscurso.getInt(1)%>"><%=rscurso.getString(2)%></option>
			<%
					}
					} while (rscurso.next());
				}
				if (rscurso != null) {
					rscurso.close();
					conexao.finalizaConexao(session.getId());
				}
			%>
		</select></td>
	</tr>
	<tr>
		<td>
		<div align="left"><input type="button" name="button"
			value=<%=("\""+trd.Traduz("FILTRAR")+"\"")%> onClick="return Filtro();"
			class="botcin"></div>
		</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="1" cellpadding="0">
	<tr>
		<td colspan="100%" class="celtittab">
		<div align="center"><%=trd.Traduz("Treinamentos Planejados")%></div>
		</td>
	</tr>

	<tr class="celtittab">
		<%
			//contador para os checks
			int i = 1;
			String curso = "";

			rsgrid = conexao.executaConsulta(query_gridP, session.getId());
			if (rsgrid.next()) {
				existe = true;
			}

			if (existe) {
		%>
		<td width="3%" align="center">&nbsp;</td>
		<td width="10%"><%=trd.Traduz("CHAPA")%>&nbsp;</td>
		<td width="38%"><%=trd.Traduz("NOME")%></td>
		<td width="44%"><%=trd.Traduz("CURSO")%></td>
		<%
		do {
		%>
	
	<tr>
		<td width="3%" class="celnortab"><input type="checkbox"
			name="checkplan<%=i%>" value="<%=rsgrid.getString(1)%>"></td>
		<td width="10%" class="celnortab" align="center"><%=rsgrid.getString(2)%></td>
		<td width="38%" class="celnortab"><%=rsgrid.getString(3)%></td>
		<td width="44%" class="celnortab"><%=rsgrid.getString(4)%></td>
	</tr>
	<%
				i++;
				curso = rsgrid.getString(5);
			} while (rsgrid.next());
		} else {
	%>
	<tr>
		<td colspan="100%" class="celtittab" align="center"><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...</td>
	</tr>
	<%
		}
		if (rsgrid != null) {
			rsgrid.close();
			conexao.finalizaConexao(session.getId());
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
	<INPUT type="hidden" name="curso" value="<%=curso%>">
</table>
</form>
</body>
</html>
<%
	//if(rscurso != null) rscurso.close();
	//if(rsgrid != null) rsgrid.close();

	//conexaoc.finalizaConexao();
	//conexaoc.finalizaBD();

	//} catch(Exception e){
	//  out.println("Erro:"+e);
	//}
%>