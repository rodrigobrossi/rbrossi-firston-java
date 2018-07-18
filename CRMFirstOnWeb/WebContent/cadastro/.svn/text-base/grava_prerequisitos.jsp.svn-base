<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
  response.setHeader("Cache-Control", "no-cache");
}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.util.*"%>

<%
request.getSession();
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
String obrigatorio =  (String)request.getParameter("rdo_req_des");
String sel_titulo  =  (String)request.getParameter("sel_titulo");
String sel_cargo   =  (String)request.getParameter("sel_cargo");
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 

String usu_plano="", query="";
usu_plano = usu_plano.valueOf(session.getAttribute("usu_plano")); 
boolean contem=false;

//try{
  ResultSet rs = null;

{
  Vector Vetpos = new Vector();
  Vector Vettit = new Vector();
  Vector Vetseq = new Vector();

  Vetpos = (Vector)session.getAttribute("vetor_car");
  Vettit = (Vector)session.getAttribute("vetor_tit");
  Vetseq = (Vector)session.getAttribute("vetor_seq");
  
  if((Vetpos.size() == 0) || (Vettit.size() == 0))
  {
    %>
    
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><script language="">
      alert(<%=("\""+trd.Traduz("CARGO OU TITULO NAO FOI SELECIONADO")+"\"")%>);
      window.open("grade_req.jsp","_parent");
    </script>
    <%
  }
  
  obrigatorio = "S";

  for (int c = 0; c < Vetpos.size(); c++){
      for (int t=0; t<Vettit.size(); t++){
            query = "SELECT PLC_CODIGO FROM PLANOCARREIRA "+
                    "WHERE CAR_CODIGO = " +Vetpos.elementAt(c)+ " AND TIT_CODIGO = " +Vettit.elementAt(t)+ " AND PLA_CODIGO = " + usu_plano;
            rs = conexao.executaConsulta(query,session.getId()+"RS_1");
            if (!rs.next()){
                query = "INSERT INTO PLANOCARREIRA (CAR_CODIGO, TIT_CODIGO, PLC_OBRIGATORIO, PLA_CODIGO) VALUES "+
                "("+Vetpos.elementAt(c)+","+Vettit.elementAt(t)+",'"+obrigatorio+"'," + usu_plano + ")";
                conexao.executaAlteracao(query);
                contem = true;
                //out.println(query);
             }
             if(rs!=null){
              rs.close();  
              conexao.finalizaConexao(session.getId()+"RS_1");  
             } 
      }
  }
  %>
  <script language="">
    alert(<%=("\""+trd.Traduz("INCLUSAO EFETUADA COM SUCESSO")+"\"")%>);
    window.open("prerequisitos.jsp","_parent");
  </script>
  <%
}

//}catch(Exception e){  out.println("Erro SQL"+e);} 
%>