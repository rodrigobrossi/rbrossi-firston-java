<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*"%>

<%@page import="firston.eval.connection.FODBConnectionBean"%>
<jsp:useBean id="acesso" scope="page"
	class="firston.eval.access.FOAccessBean" />

<%
	try {

		String str_op = (((String) request.getParameter("op") == null) ? ""
				: (String) request.getParameter("op"));
		String str_vez = (((String) request.getParameter("vez") == null) ? ""
				: (String) request.getParameter("vez"));
		String endGetId = "" + session.getId();
		String endHost = "" + request.getRemoteAddr();
		Integer usu_cod = (Integer) session.getAttribute("usu_cod");
		java.util.Date dat_DataAtual = new java.util.Date();
		FODBConnectionBean conexao = (FODBConnectionBean) session
				.getAttribute("Conexao");

		if (str_op.equals("3") || str_op.equals("4")) {
			try {
				acesso.validaSaida(conexao, dat_DataAtual, usu_cod,
						endHost, endGetId, str_op, session.getId());
			} catch (Exception ex) {
			}
		} else {
			if (!str_vez.equals("1")) {
				try {
					acesso.validaSaida(conexao, dat_DataAtual, usu_cod,
							endHost, endGetId, session.getId());
				} catch (Exception ex) {
				}
			}
		}

		String msg = (((String) request.getParameter("msg") == null) ? ""
				: (String) request.getParameter("msg"));
		request.getSession();

		//response.sendRedirect(request.getContextPath() + "/servlet/ser.comum.conexao.Sair");
%>
<script language="JavaScript">                                   
                                showModalDialog('<%=request.getContextPath()%>' + '/servlet/ser.comum.conexao.Sair','','status=no;scroll=no;dialogWidth=300px;dialogHeight=60px');                                                               		
                                window.close();    
		</script>
<%
	} catch (Exception e) {
%>
<script language="JavaScript">
		                showModalDialog('<%=request.getContextPath()%>' + '/servlet/ser.comum.conexao.Sair',
	    '', 'status=no;scroll=no;dialogWidth=300px;dialogHeight=60px');
    window.close(
);    
		  </script>
<%
	//response.sendRedirect(request.getContextPath() + "/servlet/ser.comum.conexao.Sair");
	}
%>