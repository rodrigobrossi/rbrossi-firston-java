<!--
Nome do arquivo: cadastro/entidadesgrava.jsp
Nome da funcionalidade: Gravação de Entidade
Função: incluir, excluir ou alterar uma entidade, fazendo as verificações necessárias.
Variáveis necessárias/ Requisitos: 
- sessao: idioma do usuário ("usu_idi"), tipo do usuário ("usu_tipo")
- parametro: código da entidade ("cod"),      tipo da ação ("tipo"),CGC("cgc"),
             inscrição municipal("im"),       endereço("endereco"), CEP("cep"), 
             inscrição estadual ("ie"),       telefone 1("fone1"),  fax ("fax"), 
             nome da entidade   ("nome"),     telefone 2("fone2"),  site("site"), 
             nome fantasia      ("fantasia"), e-mail("email"), 
             endereco de contado("contato"),  bairro("bairro"),
             tipo da entidade   ("emp_tipo"), cidade("cidade");
Regras de negócio (pagina):
- Inclusão: Verifica a existência da entidade na tabela EMPRESA, caso já exista, ele não insere;;
- Alteração: Verifica a existência do entidade na tabela EMPREA, caso já exista, ele não altera;
- Exclusão: Verfica nas tabelas TURMA, INSTRUTOR E FUNCGRADUACAO se a entidade está sendo usada, 
            caso não esteja ele exclui a entidade na tabela EMPRESA;
_________________________________________________________________________________________

Histórico
Data de atualizacao: 11/03/2003 - Desenvolvedor: Anderson Inoue
Atividade:
          - padronizacao da página;
          - retirada da verificação nas tabelas SOLICITACAO e FUNCGRADUACAO pois estas foram apagadas do bd.
_________________________________________________________________________________________
-->

<!--***DIRETRIZES DA PAGINA***-->
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<!--***IMPORTAÇOES E BEANS***-->
<%@page import=" java.sql.*,java.util.*"%>

<%
//*configuracao de cache*//
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
  response.setHeader("Cache-Control", "no-cache");
}

//***DECLARAÇÃO DE VARIÁVEIS***//
ResultSet rs = null, rsConsulta = null;
String  query = "", nome = "",    fantasia = "",  cgc = "", ie = "",  email = "", fone1 = "", fone2 = "",
        fax = "", endereco = "",  bairro = "",  cep = "", cod = "", cidade = "",tipo = "",  site = "", 
        im = "",    contato = "", emp_tipo = null, queryVerifica = "";


//***RECUPERCAO DE PARAMETROS***//
/*valores de sessao*/
request.getSession();
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
String usu_tipo = (String) session.getAttribute("usu_tipo"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi");  

//Verifica se foram digitados os dados
if (!(request.getParameter("tipo") == null)){
  tipo = request.getParameter("tipo");
}
if (!(request.getParameter("cod") == null)){
  cod = request.getParameter("cod");
}

if (!(tipo.equals("E"))){
  if ((request.getParameter("empnome") != null)){
    nome = request.getParameter("empnome");  
  } 
  if ((request.getParameter("empfantasia") != null)){
    fantasia = request.getParameter("empfantasia");  
  }
  if ((request.getParameter("empcgc") != null)){
    cgc = request.getParameter("empcgc");  
  }
  if ((request.getParameter("empie") != null)){
    ie = request.getParameter("empie");  
  }
  if ((request.getParameter("empemail") != null)){
    email = request.getParameter("empemail");
  }
  if ((request.getParameter("empim") != null)){
    im = request.getParameter("empim");  
  }
  if ((request.getParameter("empfone1") != null)){
    fone1 = request.getParameter("empfone1");  
  }
  if ((request.getParameter("empfone2") != null)){
    fone2 = request.getParameter("empfone2");  
  }
  if ((request.getParameter("empfax") != null)){
    fax = request.getParameter("empfax");  
  }
  if ((request.getParameter("empendereco") != null)){
    endereco = request.getParameter("empendereco");  
  }
  if ((request.getParameter("empbairro") != null)){
    bairro = request.getParameter("empbairro");  
  }
  if ((request.getParameter("empcep") != null)){
    cep = request.getParameter("empcep");
  }
  if ((request.getParameter("empcidade") != null)){
    cidade = request.getParameter("empcidade");
  }
  if ((request.getParameter("site") != null)){
    site = request.getParameter("site");
  }
  if ((request.getParameter("contato") != null)){
    contato = request.getParameter("contato");
  }
  if ((request.getParameter("rad") != null)){
    emp_tipo = request.getParameter("rad");
  }
}

//Abre a conexAo com o Banco e faz o Update, Insert ou Delete para gravar a Entidade
if (tipo.equals("I")){
  queryVerifica= "SELECT EMP_NOME FROM EMPRESA WHERE EMP_NOME = '"+nome+"'";
  rsConsulta = conexao.executaConsulta(queryVerifica,session.getId() + "RS1");
  if(!rsConsulta.next()){
    query = "INSERT INTO EMPRESA (EMP_NOME, EMP_FANTASIA, EMP_CGC, EMP_INSCREST, EMP_EMAIL, EMP_INSCRMUN, EMP_FONE1, "+
            "EMP_FONE2, EMP_FAX, EMP_ENDERECO, EMP_BAIRRO, EMP_CEP, MUN_CODIGO, EMP_CONTATO, EMP_SITE, EMP_TIPO) VALUES "+
            "('"+nome+"', '"+fantasia+"', '"+cgc+"', '"+ie+"', '"+email+"', '"+im+"', '"+fone1+"', '"+fone2+"', '"+fax+"', '"+
            ""+endereco+"', '"+bairro+"', '"+cep+"', '"+cidade+"', '"+contato+"', '"+site+"',"+emp_tipo+")"; 

    //out.println("query = " + query);
    conexao.executaAlteracao(query);
    %>
    
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%>

<script language="JavaScript">
      alert(<%=("\""+trd.Traduz("INCLUSAO EFETUADA COM SUCESSO")+"\"")%>);
      window.open("entidades.jsp","_self");
    </script>
    <%
    if(rsConsulta != null){
        rsConsulta.close();
        conexao.finalizaConexao(session.getId() + "RS1");
    }
  }
  else{
    %>
    <script language="JavaScript">
      alert(<%=("\""+trd.Traduz("IMPOSSIVEL CADASTRAR ENTIDADE JA EXISTENTE")+"\"")%>);
      window.open("entidades.jsp","_self");
    </script>
    <%
    if(rsConsulta != null){
        rsConsulta.close();
        conexao.finalizaConexao(session.getId() + "RS1");
    }
  }   
}

else{
  if (tipo.equals("U")){
    queryVerifica = "SELECT EMP_NOME FROM EMPRESA WHERE EMP_NOME = '"+nome+"' AND EMP_CODIGO <> "+cod;
    rsConsulta = conexao.executaConsulta(queryVerifica, session.getId() + "RS2");
    if(!rsConsulta.next()){
      query = "UPDATE EMPRESA SET EMP_NOME = '"+nome+"', EMP_FANTASIA = '"+fantasia+"', EMP_CGC = '"+cgc+"', "+
              "EMP_INSCREST = '"+ie+"', EMP_EMAIL = '"+email+"', EMP_INSCRMUN = '"+im+"', EMP_FONE1 = '"+fone1+"', EMP_FONE2 = '"+fone2+"', "+
              "EMP_FAX = '"+fax+"', EMP_ENDERECO = '"+endereco+"', EMP_BAIRRO = '"+bairro+"', EMP_CEP = '"+cep+"', "+
              "MUN_CODIGO = '"+cidade+"', EMP_CONTATO = '"+contato+"', EMP_SITE = '"+site+"', EMP_TIPO = "+emp_tipo+" WHERE EMP_CODIGO = '" + cod + "'"; 
  
      conexao.executaAlteracao(query);
      %>
      <script language="JavaScript">
        alert(<%=("\""+trd.Traduz("AlteraCAo efetuada com sucesso")+"\"")%>);
        window.open("entidades.jsp","_self");
      </script>
      <%
      if(rsConsulta != null){
        rsConsulta.close();
        conexao.finalizaConexao(session.getId() + "RS2");
      }
    }
    else{
      %>
      <script language="JavaScript">
        alert(<%=("\""+trd.Traduz("IMPOSSIVEL CADASTRAR ENTIDADE JA EXISTENTE")+"\"")%>);
        window.open("entidades.jsp","_self");
      </script>
      <%
      if(rsConsulta != null){
        rsConsulta.close();
        conexao.finalizaConexao(session.getId() + "RS2");
      }
    }
  }


  if (tipo.equals("E")){
    query = "SELECT * FROM TURMA WHERE EMP_CODIGO = '"+cod+"'";
    rs = conexao.executaConsulta(query, session.getId() + "RS3");
    if(rs.next()){
      %>
      <script language="JavaScript">
        alert(<%=("\""+trd.Traduz("EXCLUSAO NAO PERMITIDA. EXISTE TURMA VINCULADA A ESTA ENTIDADE")+"\"")%>);
        window.open("entidades.jsp","_self");
      </script>
      <%
      if(rs != null){
        rs.close();
        conexao.finalizaConexao(session.getId() + "RS3");
      }
    }
    else{
      query = "SELECT * FROM INSTRUTOR WHERE EMP_CODIGO = '"+cod+"'";
       
       if(rs != null){
        rs.close();
        conexao.finalizaConexao(session.getId() + "RS3");
      }

      rs = conexao.executaConsulta(query, session.getId() + "RS4");
      if(rs.next()){
        %>
        <script language="JavaScript">
          alert(<%=("\""+trd.Traduz("ExclusAo nAo permitida. Existe Instrutor vinculado a esta Entidade.")+"\"")%>);
          window.open("entidades.jsp","_self");
        </script>
        <%
        if(rs != null){
          rs.close();
          conexao.finalizaConexao(session.getId() + "RS4");
        }
      }
      else{

    query = "SELECT CUR_CODIGO FROM CURSO WHERE EMP_CODIGO = '"+cod+"'";
    rs = conexao.executaConsulta(query, session.getId() + "RS8");
    if(rs.next()){
      %>
      <script language="JavaScript">
        alert(<%=("\""+trd.Traduz("EXCLUSAO NAO PERMITIDA. EXISTE CURSO VINCULADO A ESTA ENTIDADE")+"\"")%>);
        window.open("entidades.jsp","_self");
      </script>
      <%
      if(rs != null){
        rs.close();
        conexao.finalizaConexao(session.getId() + "RS8");
      }


        
      }
      else
     {
         query = "DELETE FROM EMPRESA WHERE EMP_CODIGO = '"+cod+"'";
        conexao.executaAlteracao(query);
        %>
        <script language="JavaScript">
          alert(<%=("\""+trd.Traduz("ExclusAo efetuada com sucesso")+"\"")%>);
          window.open("entidades.jsp","_self"); 
        </script>
        <%        
     }

    }
  }  

}
}
//***FINALIZAÇÕES***//
%>
