
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.util.*"%>

<%
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	String obrigatorio = (String) request.getParameter("rdo_req_des");
	String sel_titulo = (String) request.getParameter("sel_titulo");
	String sel_cargo = (String) request.getParameter("sel_cargo");
	String update = (((String) request.getParameter("update") == null) ? "N"
			: (String) request.getParameter("update"));
	String plc_codigo = (((String) request.getParameter("plc_codigo") == null) ? "N"
			: (String) request.getParameter("plc_codigo"));
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	String usu_plano = "", query = "";
	usu_plano = usu_plano.valueOf(session.getAttribute("usu_plano"));
	boolean contem = false;

	//try{
	ResultSet rs = null;

	if (update.equals("N")) {
		Vector cargoVet = new Vector();
		Vector tituloVet = new Vector();
		cargoVet = (Vector) session.getAttribute("vetor_cargo");
		tituloVet = (Vector) session.getAttribute("vetor_titulo");

		if ((cargoVet.size() == 0) || (tituloVet.size() == 0)) {
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><script
	language="">
      alert(<%=("\""
											+ trd
													.Traduz("CARGO OU TITULO NAO FOI SELECIONADO") + "\"")%>);
      window.open("inclusaodeprerequisito.jsp","_self");
    </script>
<%
	}

		for (int c = 0; c < cargoVet.size(); c++) {
			for (int t = 0; t < tituloVet.size(); t++) {
				query = "SELECT PLC_CODIGO FROM PLANOCARREIRA "
						+ "WHERE CAR_CODIGO = " + cargoVet.elementAt(c)
						+ " AND TIT_CODIGO = " + tituloVet.elementAt(t)
						+ " AND PLA_CODIGO = " + usu_plano;
				rs = conexao.executaConsulta(query, session.getId()
						+ "RS_1");
				if (!rs.next()) {
					query = "INSERT INTO PLANOCARREIRA (CAR_CODIGO, TIT_CODIGO, PLC_OBRIGATORIO, PLA_CODIGO) VALUES "
							+ "("
							+ cargoVet.elementAt(c)
							+ ","
							+ tituloVet.elementAt(t)
							+ ",'"
							+ obrigatorio + "'," + usu_plano + ")";
					conexao.executaAlteracao(query);
					contem = true;
					//out.println(query);
				}
				if (rs != null) {
					conexao.finalizaConexao(session.getId() + "RS_1");
				}
			}
		}
%>
<script language="">
    alert(<%=("\""
										+ trd
												.Traduz("INCLUSAO EFETUADA COM SUCESSO") + "\"")%>);
    window.open("prerequisitos.jsp","_self");
  </script>
<%
	} else if (update.equals("S")) {
		query = "SELECT PLC_CODIGO FROM PLANOCARREIRA "
				+ "WHERE CAR_CODIGO = " + sel_cargo
				+ " AND TIT_CODIGO = " + sel_titulo
				+ " AND PLC_CODIGO <> " + plc_codigo;
		rs = conexao.executaConsulta(query, session.getId() + "RS_2");
		if (rs.next()) {
%>
<script language="">
        alert(<%=("\""
											+ trd
													.Traduz("IMPOSSIVEL CADASTRAR PRE-REQUISITO JA EXISTENTE") + "\"")%>);
        window.open("altera_prerequisito.jsp?codigo=<%=plc_codigo%>&obrigatorio=<%=obrigatorio%>","_self");
      </script>
<%
	} else {
			query = "Update  planocarreira SET car_codigo=" + sel_cargo
					+ " ,tit_codigo =" + sel_titulo
					+ " , plc_obrigatorio='" + obrigatorio + "'"
					+ " ,pla_codigo = " + usu_plano
					+ " where  plc_codigo=" + plc_codigo;
			//out.println(query);
			conexao.executaAlteracao(query);
			//}
%>
<script language="">
        alert(<%=("\""
											+ trd
													.Traduz("ALTERACAO EFETUADA COM SUCESSO") + "\"")%>);
        window.open("prerequisitos.jsp","_self");
      </script>
<%
	}

	}
	if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId() + "RS_2");
	}

	//}catch(Exception e){  out.println("Erro SQL"+e);}
%>