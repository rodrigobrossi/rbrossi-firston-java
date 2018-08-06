<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1"))
  response.setHeader("Cache-Control", "no-cache");
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import=" java.sql.*, java.util.*, java.io.*"%>

<%
request.getSession();

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
String aplicacao = (String) session.getAttribute("aplicacao");
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 
Integer usu_codigo = (Integer)session.getAttribute("usu_cod");
String usu_plano = "";
usu_plano = usu_plano.valueOf(session.getAttribute("usu_plano")); 

String ponto = (String)session.getAttribute("barra");

FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
//try{
//Pega o tipo de cadastro (inclusão ou alteração) e o codigo do assunto
String tipo = "", cod = "-1", cont_aux = "", per_codigo = "";
String resp = "", sel_resp = "", peso = "", gp_cod = "", tipo_resp = "";
String min = "NULL", max = "NULL";
int i = 0, cont = 0;

if (request.getParameter("tipo") != null) 
  tipo = request.getParameter("tipo");

if (request.getParameter("cod") != null)
  cod = request.getParameter("cod");

if (request.getParameter("cod_per") != null)
  per_codigo = request.getParameter("cod_per");

if (request.getParameter("gp_cod") != null)
  gp_cod = request.getParameter("gp_cod");

if (request.getParameter("tipo_resp") != null)
  tipo_resp = request.getParameter("tipo_resp");

if (request.getParameter("sel_resp") != null)
  sel_resp = request.getParameter("sel_resp");

if (request.getParameter("txt_peso") != null)
  peso = request.getParameter("txt_peso");

if (request.getParameter("valor_min") != null)
  min = request.getParameter("valor_min");

if (request.getParameter("valor_max") != null)
  max = request.getParameter("valor_max");

String query = "",qgr_valor = "", res_codigo = "", query2 = "";
ResultSet rs=null;

if(tipo.equals("I")){
  query = "SELECT PER_CODIGO FROM QUEST_PERGUNTA WHERE PER_CODIGO = "+per_codigo+" AND QUE_CODIGO = "+cod;
        //out.println(query);
  rs = conexao.executaConsulta(query,session.getId()+"RS1");
  if(!rs.next()){
    if(tipo_resp.equals("ME")){
      query = "INSERT INTO QUEST_PERGUNTA (GRU_CODIGO, PER_TIPO, QUE_CODIGO, PER_CODIGO, QPG_PESO) "+
        "VALUES ("+gp_cod+",'"+tipo_resp+"',"+cod+","+per_codigo+","+peso+")";
    }
    else if(tipo_resp.equals("D")){
      query = "INSERT INTO QUEST_PERGUNTA (GRU_CODIGO, PER_TIPO, QUE_CODIGO, PER_CODIGO, QPG_PESO, QPG_RESPDISSERT) "+
        "VALUES ("+gp_cod+",'"+tipo_resp+"',"+cod+","+per_codigo+","+peso+",'"+resp+"')";
    }
    else if (tipo_resp.equals("N")){
      query = "INSERT INTO QUEST_PERGUNTA (GRU_CODIGO, PER_TIPO, QUE_CODIGO, PER_CODIGO, QPG_PESO, QPG_RESPDISSERT, QPG_MINIMO, QPG_MAXIMO) "+
        "VALUES ("+gp_cod+",'"+tipo_resp+"',"+cod+","+per_codigo+","+peso+",'"+resp+"',"+min+","+max+")";
                }
    conexao.executaAlteracao(query);
                //out.println("TIPO_RESP:"+tipo_resp);
    if(!sel_resp.equals("")){
      query = "SELECT QGR_VALOR, RES_CODIGO FROM RESPGRUPO WHERE QGR_GRUPO = "+sel_resp;

      if(rs != null){
         rs.close();
         conexao.finalizaConexao(session.getId()+"RS1");
      }

      rs = conexao.executaConsulta(query,session.getId()+"RS2");
      if(rs.next()){
        do{
          qgr_valor = rs.getString(1);
          res_codigo = rs.getString(2);
          query2 = "INSERT INTO QUEST_RESP " +
            "(GRU_CODIGO, PER_TIPO, QUE_CODIGO, PER_CODIGO, QPG_PESO, RES_CODIGO, QGR_VALOR, QGR_GRUPO) " +
            "VALUES ("+gp_cod+",'"+tipo_resp+"',"+cod+","+per_codigo+","+peso+
            ","+res_codigo+","+qgr_valor+","+sel_resp+")";
                                        //out.println(query2);
          conexao.executaAlteracao(query2);
        } while(rs.next());
      }
      if(rs != null){
         rs.close();
         conexao.finalizaConexao(session.getId()+"RS2");
      }
       
    }
    %>
    <script language="JavaScript">
      window.open("inclusaodequestionario2.jsp","_self");
      window.close();
    </script>
    <%
  }
  else{
    %>
    <script language="JavaScript">
      alert("ESTA RESPOSTA JA FOI INSERIDA");
      window.open("inclusaodequestionario2.jsp","_self");
      window.close();
    </script>
    <%
  }
  if(rs != null){
      rs.close();
      conexao.finalizaConexao(session.getId()+"RS1"); 
  }
 
}

else if(tipo.equals("E")){
  cont = 0;
  if (request.getParameter("contador") != null)
    cont_aux = request.getParameter("contador");
  if (!cont_aux.equals(""))
    cont = Integer.parseInt(cont_aux);

  if(cont != 0){
    for(i=0;i<cont;i++){
      if(request.getParameter("check"+i) != null){
        per_codigo = request.getParameter("check"+i);
      
        query = "DELETE FROM QUEST_PERGUNTA WHERE PER_CODIGO = "+per_codigo+
          " AND QUE_CODIGO = "+cod;
        conexao.executaAlteracao(query);
        query = "DELETE FROM QUEST_RESP WHERE PER_CODIGO = "+per_codigo+
          " AND QUE_CODIGO = "+cod;
        conexao.executaAlteracao(query);
      }
    } try {
    %>
    <script language="JavaScript">
      alert("EXCLUSAO EFETUADA COM SUCESSO");
      window.open("inclusaodequestionario2.jsp?cod=<%=cod%>","_self");
    </script>
    <%} catch(Exception e){out.println(e);}
  }
}

//}
//catch(Exception e){
//  out.println("Erro: "+e);
//}
%>
