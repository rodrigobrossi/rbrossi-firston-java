<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")) {
  response.setHeader("Cache-Control", "no-cache");
}
%>

<%@page import=" java.sql.*, java.lang.Math.*, java.util.*"%>


<%
try{
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");


String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 
String aplicacao = (String)session.getAttribute("aplicacao");

//variaveis
String query = "", codigo = "", tipo_operacao = "", vinculo = "", emp_codigo = "";
ResultSet rs=null, rsX = null, rsConsulta = null, rscargo = null;
int cont = 0, i = 0;
boolean contem = false, pode = true;
int cont2 = Integer.parseInt(((String)request.getParameter("cont")==null)?"0":(String)request.getParameter("cont"));

String t = "";
if(request.getParameter("t") != null)
  t = request.getParameter("t");

//parametro de tipo da operacao
if (request.getParameter("tipo_operacao") != null)
  tipo_operacao = request.getParameter("tipo_operacao");

//***********EXCLUIR***********
if (tipo_operacao.equals("E")){
  //Busca e Insere dados no vetor de funcionArios selecionados
  int pag = Integer.parseInt((String)session.getAttribute("pagina"));
  String n = "";
  Vector funcvet = new Vector();
  funcvet = (Vector)session.getAttribute("funcs");
  if(funcvet.size() != 0)
    contem = true;
  
  //insere os elementos no vetor
  for(int k=1 ; k<=pag;k++){
    if (!(request.getParameter("checkbox" + n.valueOf(k)) == null)){
      //out.println(request.getParameter("checkbox" + n.valueOf(k)));
      if (!(funcvet.contains(request.getParameter("checkbox" + n.valueOf(k)))))
          funcvet.add(request.getParameter("checkbox" + n.valueOf(k)));
    }
  }
  //recupera o funcionario escolhido
  for(i=0;i<funcvet.size();i++){
    codigo = (String)funcvet.elementAt(i);
    query = "SELECT T.FUN_CODIGO,F.FUN_NOME FROM TREINAMENTO T, FUNCIONARIO F WHERE T.FUN_CODIGO = " +codigo+ " AND T.FUN_CODIGO = F.FUN_CODIGO ";
    rs = conexao.executaConsulta(query,session.getId());
    if(rs.next()){
      pode = false;
      vinculo = "EXISTE TREINAMENTO VINCULADO AO FUNCIONARIO";
    }
    else{
      query = "SELECT C.FUN_CODIGO, F.FUN_NOME FROM COMP_FUNC C, FUNCIONARIO F WHERE C.FUN_CODIGO = "+codigo+" AND F.FUN_CODIGO = C.FUN_CODIGO";
      rs = conexao.executaConsulta(query,session.getId());
      if(rs.next()){
        pode = false;
        vinculo = "EXISTE COMPETENCIA VINCULADO AO FUNCIONARIO";
      }
      else{
        query = "SELECT FF.FUN_CODIGO, F.FUN_NOME FROM FOCOFILIAL FF, FUNCIONARIO F WHERE FF.FUN_CODIGO = "+codigo+" AND F.FUN_CODIGO = FF.FUN_CODIGO";
        rs = conexao.executaConsulta(query,session.getId());
        if(rs.next()){
          pode = false;
          vinculo = "FUNCIONARIO E USUARIO DO SISTEMA";
        }
        else{
          query = "SELECT FU.FUN_CODIGO, F.FUN_NOME FROM FUNC_USUARIO FU, FUNCIONARIO F WHERE FU.FUN_CODIGO = "+codigo+" AND F.FUN_CODIGO = FU.FUN_CODIGO";
          rs = conexao.executaConsulta(query,session.getId());
          if(rs.next()){
            pode = false;
            vinculo = "FUNCIONARIO E USUARIO DO SISTEMA";
          }
          else{
            query = "SELECT C.FUN_CODIGO_RESP, F.FUN_NOME FROM CURSO C, FUNCIONARIO F WHERE C.FUN_CODIGO_RESP = "+codigo+" AND F.FUN_CODIGO = C.FUN_CODIGO_RESP";
            rs = conexao.executaConsulta(query,session.getId());
            if(rs.next()){
              pode = false;
              vinculo = "EXISTE CURSO VINCULADO AO FUNCIONARIO";
            }
            else{
              query = "SELECT FI.FUN_CODIGO_RESP, F.FUN_NOME FROM FILIAL FI, FUNCIONARIO F WHERE FI.FUN_CODIGO_RESP = "+codigo+" AND F.FUN_CODIGO = FI.FUN_CODIGO_RESP";
              rs = conexao.executaConsulta(query,session.getId());
              if(rs.next()){
                pode = false;
                vinculo = "FUNCIONARIO E RESPONSAVEL POR UMA FILIAL";
              }
              else{
                query = "SELECT P.FUN_CODIGO, F.FUN_NOME FROM PLANO_SUCESSORIO P, FUNCIONARIO F WHERE P.FUN_CODIGO = "+codigo+" AND F.FUN_CODIGO = P.FUN_CODIGO";
                rs = conexao.executaConsulta(query,session.getId());
                if(rs.next()){
                  pode = false;
                  vinculo = "EXISTE PLANO SUCESSORIO VINCULADO AO FUNCIONARIO";
                }
                //else{
                //  query = "SELECT S.FUN_CODIGO, F.FUN_NOME FROM SOLICITACAO S, FUNCIONARIO F WHERE S.FUN_CODIGO = "+codigo+" AND F.FUN_CODIGO = S.FUN_CODIGO";
                //  rs = conexao.executaConsulta(query);
                //  if(rs.next()){
                //    pode = false;
                //    vinculo = "EXISTE SOLICITACAO VINCULADA AO FUNCIONARIO";
                //  }
                  else{
                    query = "SELECT T.FUN_CODIGO, F.FUN_NOME FROM TURMA T, FUNCIONARIO F WHERE T.FUN_CODIGO = "+codigo+" AND F.FUN_CODIGO = T.FUN_CODIGO";
                    rs = conexao.executaConsulta(query,session.getId());
                    if(rs.next()){
                      pode = false;
                      vinculo = "FUNCIONARIO POSSUI TREINAMENTOS REALIZADOS";
                    }
                    else{
                      query = "SELECT T.FUN_CODIGO_INSTR, F.FUN_NOME FROM TURMA T, FUNCIONARIO F WHERE T.FUN_CODIGO_INSTR = "+codigo+" AND F.FUN_CODIGO = T.FUN_CODIGO_INSTR";
                      rs = conexao.executaConsulta(query,session.getId());
                      if(rs.next()){
                        pode = false;
                        vinculo = "FUNCIONARIO POSSUI TREINAMENTOS REALIZADOS";
                      }
                      else{
                        /*
                        query = "SELECT C.FUN_CODIGO, F.FUN_NOME FROM CUSTOREAL C, FUNCIONARIO F WHERE C.FUN_CODIGO = "+codigo+" AND F.FUN_CODIGO = C.FUN_CODIGO";
                        rs = conexao.executaConsulta(query);
                        if(rs.next()){
                          pode = false;
                          vinculo = "FUNCIONARIO POSSUI TREINAMENTOS REALIZADOS";
                        }
                        else{
                        */
                          query = "SELECT FUN_CODSOLIC, FUN_NOME FROM FUNCIONARIO WHERE FUN_CODSOLIC = "+codigo;
                          rs = conexao.executaConsulta(query,session.getId());
                          if(rs.next()){
                            pode = false;
                            vinculo = "FUNCIONARIO E SOLICITANTE";
                          }
                        /*}*/
                      }
                    }
                  }
                //}
              }
            }
          }
        }
      }
    }
  }
if(rs!=null){
    rs.close();
    conexao.finalizaConexao(session.getId());
    }
  if(pode == true){
    i = 0;
    for(i=0;i<funcvet.size();i++){
      codigo = (String)funcvet.elementAt(i);
      query = "DELETE FUNCIONARIO WHERE FUN_CODIGO = "+codigo;
      conexao.executaAlteracao(query);
    }
    %>
    
<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><script language="JavaScript">   
    alert(<%=("\""+trd.Traduz("EXCLUSAO EFETUADA COM SUCESSO")+"\" ! ")%>);
    window.open("funcionarios.jsp", "_parent");
    </script>      
    <%
  }
  else{
    %>
    <script language="JavaScript">
    alert(<%=("\""+trd.Traduz("EXCLUSAO NAO PERMITIDA. ")+"")%> <%=(""+trd.Traduz(vinculo)+"\"")%>);
    window.open("funcionarios.jsp","_self");
    
    </script>      
    <%
  }
  if (codigo.equals("")){
    %>
    <script language="JavaScript">
    alert(<%=("\""+trd.Traduz("FAVOR ESCOLHER UM FUNCIONARIO")+"\" ! ")%>);
    history.go(-1);
    </script>      
    <%
  }
}

//***********INCLUIR***********
if (tipo_operacao.equals("I")){
  String nome="", chapa="", sexo="", rg="", cpf="", fone="", mail="", cargo="", departamento="", filial="";
  String tb1="", tb2="", tb3="", tb4="", tb5="", tb6="", tb7="", tb8="";
  nome         = request.getParameter("txt_nome");
  chapa        =  ((request.getParameter("txt_chapa")==null)?"":request.getParameter("txt_chapa"));
  sexo         = request.getParameter("cbo_sexo");
  rg           = request.getParameter("txt_rg");
  cpf          = request.getParameter("txt_cpf");
  fone         = request.getParameter("txt_fone");
  mail         = request.getParameter("txt_mail");
  cargo        = (request.getParameter("cbo_cargo") == null)? "NULL" : request.getParameter("cbo_cargo");
  departamento = (request.getParameter("cbo_departamento") == null)? "NULL" : request.getParameter("cbo_departamento");
  filial       = (request.getParameter("cbo_filial") == null)? "NULL" : request.getParameter("cbo_filial");
  tb1          = (request.getParameter("cbo_tb1") == null)? "NULL" : request.getParameter("cbo_tb1");
  tb2          = (request.getParameter("cbo_tb2") == null)? "NULL" : request.getParameter("cbo_tb2");
  tb3          = (request.getParameter("cbo_tb3") == null)? "NULL" : request.getParameter("cbo_tb3");
  tb4          = (request.getParameter("cbo_tb4") == null)? "NULL" : request.getParameter("cbo_tb4");
  tb5          = (request.getParameter("cbo_tb5") == null)? "NULL" : request.getParameter("cbo_tb5");
  tb6          = (request.getParameter("cbo_tb6") == null)? "NULL" : request.getParameter("cbo_tb6");
  tb7          = (request.getParameter("cbo_tb7") == null)? "NULL" : request.getParameter("cbo_tb7");
  tb8          = (request.getParameter("cbo_tb8") == null)? "NULL" : request.getParameter("cbo_tb8");
  emp_codigo   = request.getParameter("cbo_empresa");
    //testa valores nAo obrigatorios
  if (tb1.equals("")) tb1 = "NULL";
  if (tb2.equals("")) tb2 = "NULL";
  if (tb3.equals("")) tb3 = "NULL";
  if (tb4.equals("")) tb4 = "NULL";
  if (tb5.equals("")) tb5 = "NULL";
  if (tb6.equals("")) tb6 = "NULL";
  if (tb7.equals("")) tb7 = "NULL";
  if (tb8.equals("")) tb8 = "NULL";


//Query para pegar a lotação do Cargo
query = "SELECT TB8_CODIGO, TB7_CODIGO, TB6_CODIGO, TB5_CODIGO FROM CARGO WHERE CAR_CODIGO = " + cargo;
rscargo = conexao.executaConsulta(query,session.getId()+"RS_1");
                          if(rscargo.next())
                          {
                            tb5 = rscargo.getString(4);
                            tb6 = rscargo.getString(3);
                            
                            if (rscargo.getString(2) == null) 
                            {
                              tb7 = "NULL";
                            }
                            else
                            {
                              tb7 = rscargo.getString(2);
                            }

                            if (rscargo.getString(1) == null) 
                            {
                              tb8 = "NULL";
                            }
                            else
                            {
                              tb8 = rscargo.getString(1);
                            }
                          }
                          

    /** verifica a existência da chapa
     *String queryX = "SELECT FUN_CHAPA FROM FUNCIONARIO WHERE FUN_CHAPA = '"+chapa+"'";
     *rsX = conexaoX.executaConsulta(queryX);
     *if(!rsX.next()){
    */
    query = "INSERT INTO FUNCIONARIO "+
              "(FUN_NOME, FUN_CHAPA, FUN_SEXO, FUN_RG, FUN_CPF, FUN_TELEFONE, FUN_EMAIL, CAR_CODIGO, DEP_CODIGO, " +
              "FIL_CODIGO, TB1_CODIGO, TB2_CODIGO, TB3_CODIGO, TB4_CODIGO, " +
                "FUN_DEMITIDO, FUN_TERCEIRO, IDI_CODIGO, EMP_CODIGO, FUN_EMPLID) VALUES " +
              "('" +nome+ "', '" +chapa+ "', '" +sexo+ "', '" +rg+ "', '" +cpf+ "', '" +fone+ "', '" +mail+ "', " +cargo+ ", " +tb6+
              ", " + tb5 + ", " +tb1+ ", " +tb7+ ", " +tb8+ ", " +tb4+ ", " + "'N', 'S', " +  usu_idi + "," +emp_codigo+ ",00000000000)";
    //out.println("INSERÇÃO: "+query);
    conexao.executaAlteracao(query);

    %>
      <script language="JavaScript">
        alert(<%=("\""+trd.Traduz("INCLUSAO EFETUADA COM SUCESSO")+"\" ! ")%>);
        window.open("funcionarios.jsp", "_parent");
      </script>
      <%
  /*}
  else{
    %>
    <%
  /*}*/
}
if(rscargo!=null){
    rscargo.close();
    conexao.finalizaConexao(session.getId()+"RS_1");
}
//***********ALTERAR************
if (tipo_operacao.equals("A")){
  String nome="", chapa="", sexo="", rg="", cpf="", fone="", mail="", cargo="", departamento="", filial="";
  String tb1="", tb2="", tb3="", tb4="", tb5="", tb6="", tb7="", tb8="", cod="";
  cod          =  request.getParameter("cod_funcionario");
  nome         =  request.getParameter("txt_nome");
  chapa        =  ((request.getParameter("txt_chapa")==null)?"":request.getParameter("txt_chapa"));
  sexo         =  request.getParameter("cbo_sexo");
  rg           =  request.getParameter("txt_rg");
  cpf          =  request.getParameter("txt_cpf");
  fone         =  request.getParameter("txt_fone");
  mail         =  request.getParameter("txt_mail");
  cargo        = (request.getParameter("cbo_cargo") == null)? "NULL" : request.getParameter("cbo_cargo");
  departamento = (request.getParameter("cbo_departamento") == null)? "NULL" : request.getParameter("cbo_departamento");
  filial       = (request.getParameter("cbo_filial") == null)? "NULL" : request.getParameter("cbo_filial");
  tb1          = (request.getParameter("cbo_tb1") == null)? "NULL" : request.getParameter("cbo_tb1");
  tb2          = (request.getParameter("cbo_tb2") == null)? "NULL" : request.getParameter("cbo_tb2");
  tb3          = (request.getParameter("cbo_tb3") == null)? "NULL" : request.getParameter("cbo_tb3");
  tb4          = (request.getParameter("cbo_tb4") == null)? "NULL" : request.getParameter("cbo_tb4");
  tb5          = (request.getParameter("cbo_tb5") == null)? "NULL" : request.getParameter("cbo_tb5");
  tb6          = (request.getParameter("cbo_tb6") == null)? "NULL" : request.getParameter("cbo_tb6");
  tb7          = (request.getParameter("cbo_tb7") == null)? "NULL" : request.getParameter("cbo_tb7");
  tb8          = (request.getParameter("cbo_tb8") == null)? "NULL" : request.getParameter("cbo_tb8");
  emp_codigo   = request.getParameter("cbo_empresa");

  //testa valores nAo obrigatorios
  if (tb1.equals("")) tb1 = "NULL";
  if (tb2.equals("")) tb2 = "NULL";
  if (tb3.equals("")) tb3 = "NULL";
  if (tb4.equals("")) tb4 = "NULL";
  if (tb5.equals("")) tb5 = "NULL";
  if (tb6.equals("")) tb6 = "NULL";
  if (tb7.equals("")) tb7 = "NULL";
  if (tb8.equals("")) tb8 = "NULL";

//Query para pegar a lotação do Cargo
query = "SELECT TB8_CODIGO, TB7_CODIGO, TB6_CODIGO, TB5_CODIGO FROM CARGO WHERE CAR_CODIGO = " + cargo;
rscargo = conexao.executaConsulta(query,session.getId()+"RS_2");
                          if(rscargo.next())
                          {
                            tb5 = rscargo.getString(4);
                            tb6 = rscargo.getString(3);
                            
                            if (rscargo.getString(2) == null) 
                            {
                              tb7 = "NULL";
                            }
                            else
                            {
                              tb7 = rscargo.getString(2);
                            }

                            if (rscargo.getString(1) == null) 
                            {
                              tb8 = "NULL";
                            }
                            else
                            {
                              tb8 = rscargo.getString(1);
                            }
                          }


  /*esta query verifica se a matícula já existe.
  String queryVerifica = "SELECT FUN_CHAPA FROM FUNCIONARIO WHERE FUN_CHAPA = '"+chapa+"' AND FUN_CODIGO <> "+cod;
   = conexaoConsulta.executaConsulta(queryVerifica);
  if(!rsConsulta.next()){
  */
    query = "UPDATE FUNCIONARIO SET "+
            "FUN_NOME='" +nome+ "', FUN_CHAPA='" +chapa+ "', FUN_SEXO='" +sexo+ "', FUN_RG='" +rg+ "', FUN_CPF='" +cpf+ "', "+
            "FUN_TELEFONE='" +fone+ "', FUN_EMAIL='" +mail+ "', CAR_CODIGO=" +cargo+ ", DEP_CODIGO= " +tb6+ ", "+
            "FIL_CODIGO=" +tb5+ ", TB1_CODIGO=" +tb1+ ", TB2_CODIGO=" +tb7+ ", TB3_CODIGO=" +tb8+ ", TB4_CODIGO=" +tb4+ " " +  ", EMP_CODIGO = "+emp_codigo+" WHERE FUN_CODIGO = " +cod+ " ";

    conexao.executaAlteracao(query);

    %>
    <script language="JavaScript">
      alert(<%=("\""+trd.Traduz("ALTERACAO EFETUADA COM SUCESSO")+"\" ! ")%>);
      window.open("funcionarios.jsp", "_parent");
    </script>      
    <%
  /*}
  else{

  /*}*/
}
if(rscargo!=null){
rscargo.close();
conexao.finalizaConexao(session.getId()+"RS_2");
}
}catch(Exception e){out.println("ERRO:"+e);}
%>