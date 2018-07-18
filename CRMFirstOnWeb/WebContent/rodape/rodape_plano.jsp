<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import ="java.sql.*,java.util.*,java.sql.*,java.text.*"%>

<%
	request.getSession();
	FOLocalizationBean trd2  = (FOLocalizationBean) session.getAttribute("Traducao");
	FODBConnectionBean conn  = (FODBConnectionBean)session.getAttribute("Conexao");

Integer usu_idi = (Integer)session.getAttribute("usu_idi");
%>


<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<script language ="JavaScript1.1"> 
function muda_plano() {
  window.open("rodape/rodape_atualiza_plano.jsp?cod=" +rodape.cbo_plano.value+ "&page=<%=request.getRequestURI()%>", "_self");
}
</script>

<%
//Contadores de registro de Plano
String query      =  " SELECT PLA_CODIGO, PLA_NOME FROM PLANO";
ResultSet rsPlano = conn.executaConsulta(query,session.getId());
Integer sess = (Integer)session.getAttribute("usu_plano");
%>
<!--<td class="trontrk">-->
<form name="rodape">
<select name="cbo_plano" onchange="muda_plano();">  
<%if (rsPlano.next()) {
      do{
        if (rsPlano.getInt(1) == sess.intValue()) {%>
          <option value="<%=rsPlano.getString(1)%>" selected><%=rsPlano.getString(2)%></option>
<%      } else {%>
          <option value="<%=rsPlano.getString(1)%>"><%=rsPlano.getString(2)%></option>
<%      }
      }while(rsPlano.next());
  }

if(rsPlano != null) {
    rsPlano.close();
    conn.finalizaConexao(session.getId());
}  
%>
</select> 
</form>
