<!--

Nome do arquivo: cadastro/planotreinamentoexclui.jsp
Nome da funcionalidade: Exclusão de Plano de Treinamento
Função: excluir um plano de treinamento, fazendo as verificações necessárias.
Variáveis necessárias/ Requisitos: 
- sessao: idioma do usuário ("usu_idi"), tipo do usuário ("usu_tipo")
- parametro: codigo do plano ("codigo")
Regras de negócio (pagina):
- verificar nas tabelas PLANOCARREIRA, SOLIC_PLANO, TREINAMENTO e TURMA se o plano está sendo usado. 
  Se estiver sendo usado, o plano não pode ser excluído senão, o plano é excluído das tabelas INFOMES, PLANO
  e PLANO_AVALIA;
_________________________________________________________________________________________

Histórico
Data de atualizacao: 11/03/2003 - Desenvolvedor: Anderson Inoue
Atividade:
          - padronizacao da página;
          - retirada da verificação na tabela SOLICITACAO pois esta foi apagada do bd.
_________________________________________________________________________________________

-->

<!--***DIRETRIZES DA PAGINA***-->
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<!--***IMPORTAÇOES E BEANS***-->
<%@page import=" java.sql.*, java.lang.*, java.text.*"%>

<%
//*configuracao de cache*//
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
  response.setHeader("Cache-Control", "no-cache");
}

//***DECLARAÇÃO DE VARIÁVEIS***//
ResultSet rs = null;
String query = "", codigo = "";
boolean contem = false;

//***RECUPERCAO DE PARAMETROS***//
/*valores de sessao*/
request.getSession();
FODBConnectionBean conexao = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd   = (FOLocalizationBean) session.getAttribute("Traducao");
String  usu_tipo  = (String) session.getAttribute("usu_tipo"); 
Integer usu_idi   = (Integer)session.getAttribute("usu_idi");  

/*Recupera variavel para a exclusão*/
if (request.getParameter("cod") != null){
  codigo = request.getParameter("cod");
}

//***CORPO DA PÁGINA***//
/*Faz as consistencia*/
query = "SELECT PLA_CODIGO FROM PLANOCARREIRA WHERE PLA_CODIGO = " +codigo+ " ";
rs = conexao.executaConsulta(query,session.getId() + "RS35");
if (rs.next()){
  %>
  
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><script language="JavaScript">
    alert(<%=("\""+trd.Traduz("Este plano nAo pode ser excluIdo")+"\" ! ")%>);
    window.open("planodetreinamento.jsp","_parent");
  </script>
  <%

  if(rs != null){
    rs.close();
    conexao.finalizaConexao(session.getId() + "RS35");
  }

}
else{
  query = "SELECT PLA_CODIGO FROM SOLIC_PLANO WHERE PLA_CODIGO = " +codigo+ " ";

  if(rs != null){
    rs.close();
    conexao.finalizaConexao(session.getId() + "RS35");
  }

  rs = conexao.executaConsulta(query,session.getId() + "RS36");
  if (rs.next()){
    %>
    <script language="JavaScript">
      alert(<%=("\""+trd.Traduz("Este plano nAo pode ser excluIdo")+"\" ! ")%>);
      window.open("planodetreinamento.jsp","_parent");
    </script>
    <%

  if(rs != null){
    rs.close();
    conexao.finalizaConexao(session.getId() + "RS36");
  }

  }
  else{
    query = "SELECT PLA_CODIGO FROM TREINAMENTO WHERE PLA_CODIGO = " +codigo+ " ";

    if(rs != null){
      rs.close();
      conexao.finalizaConexao(session.getId() +  "RS36");
    }

    rs = conexao.executaConsulta(query,session.getId() + "RS37");
    if (rs.next()){
      %>
      <script language="JavaScript">
        alert(<%=("\""+trd.Traduz("Este plano nAo pode ser excluIdo")+"\" ! ")%>);
        window.open("planodetreinamento.jsp","_parent");
      </script>
      <%

    if(rs != null){
      rs.close();
      conexao.finalizaConexao(session.getId() + "RS37");
    }

    }
    else{
      query = "SELECT PLA_CODIGO FROM TURMA WHERE PLA_CODIGO = " +codigo+ " ";
       
      if(rs != null){
        rs.close();
        conexao.finalizaConexao(session.getId() + "RS37");
      }
      
      rs = conexao.executaConsulta(query,session.getId() + "RS38");
      if (rs.next()){
        %>
        <script language="JavaScript">
          alert(<%=("\""+trd.Traduz("Este plano nAo pode ser excluIdo")+"\" ! ")%>);
          window.open("planodetreinamento.jsp","_parent");
        </script>
        <%
       
        if(rs != null){
          rs.close();
          conexao.finalizaConexao(session.getId() + "RS38");
        }
       
      }
      else{

        if(rs != null){
          rs.close();
          conexao.finalizaConexao(session.getId() + "RS38");
        }
     
        query = "DELETE INFOMES WHERE PLA_CODIGO = " +codigo+ " ";
        conexao.executaAlteracao(query);
        query = "DELETE PLANO_AVALIA WHERE PLA_CODIGO = " +codigo+ " ";
        conexao.executaAlteracao(query);
        query = "DELETE PLANO WHERE PLA_CODIGO = " +codigo+ " ";
        conexao.executaAlteracao(query);
        %>
        <script language="JavaScript">
           alert(<%=("\""+trd.Traduz("EXCLUSAO EFETUADA COM SUCESSO")+"\" ! ")%>);
           window.open("planodetreinamento.jsp","_self");
        </script>
        <%
      }
    }
  }
}
//***FINALIZAÇÕES***


%>

