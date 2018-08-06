<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1"))
      response.setHeader("Cache-Control", "no-cache");
%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.lang.*, java.text.*,java.util.*"%>

<%!
public String trataAspas(String conteudo){
  char troca[] = conteudo.toCharArray();
  int contador=0;
  while (contador<conteudo.length()){
    String alfa=""+troca[contador];
    if(alfa.equals("'")){
      troca[contador]='\"';
    }
    else if(alfa.equals("/")){
      troca[contador]='/';
    }
    contador=contador+1;
  }
  String retorna="";
  return retorna.copyValueOf(troca);
}
%>

<%!
public String valida(String conteudo){
  char troca[] = conteudo.toCharArray();
  int contador=0;
  while (contador<conteudo.length()){
    String alfa=""+troca[contador];
    if(alfa.equals(",")){
      troca[contador]='.';
    }
    contador=contador+1;
  }
  String retorna="";
  return retorna.copyValueOf(troca);
}
%>

<%!
public String replaceString(String s, String busca, String troca){
  String nova = "";
  int ini = s.indexOf(busca);
  boolean ok = false;
  if (ini>0){
    ok = true;
  }
  else{
    nova = s;
  }
  while (ok){
    int fim = busca.length();
    nova = s.substring(0,ini) + troca + s.substring(ini+fim,s.length());
    ini = nova.indexOf(busca);
    if (ini>0){
      s = nova;
    }
    else{
      ok = false;
    }
  }
  return nova;
}
%>

<%
//try{

request.getSession();
FODBConnectionBean conexao = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd   = (FOLocalizationBean) session.getAttribute("Traducao");

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi");  

ResultSet rs = null, rsConsulta = null, rsX = null, rsF = null;
String tipo = "", cod = "", pla_codigo = "", queryI = "", que_codigo = "", filial = "";
String query = "", nome = "", plano_anterior = "", data_inicio = "", data_fim = "", periodo = "", acesso = "N", nova_solic = "N", alteracao = "N", exclusao = "N", justificativa = "N", registro = "N", solicextra = "N";

int cod_periodo = 0 , cod_anterior = 0;
if(request.getParameter("sel_filial")!=null){
  filial = request.getParameter("sel_filial");
}

//Verifica se foram digitados os dados
if (request.getParameter("tipo") != null){ 
  tipo = trataAspas(request.getParameter("tipo"));
}
if (request.getParameter("cod") != null){ 
  cod = trataAspas(request.getParameter("cod"));
}
if ((request.getParameter("text_nome") != null))
  nome = trataAspas(request.getParameter("text_nome"));
if ((request.getParameter("sel_planoanterior") != null))
  plano_anterior = trataAspas(request.getParameter("sel_planoanterior"));  
if ((request.getParameter("text_datainicio") != null))
  data_inicio = request.getParameter("text_datainicio");  
if ((request.getParameter("text_datafinal") != null))
  data_fim = request.getParameter("text_datafinal");  
if ((request.getParameter("sel_periodo") != null))
  periodo = trataAspas(request.getParameter("sel_periodo"));  
if ((request.getParameter("chk_Acesso") != null))
  acesso = "S";  
else
    acesso = "N";  
if ((request.getParameter("chk_novasolicitacao") != null))
  nova_solic = "S";
else
  nova_solic = "N";
if ((request.getParameter("chk_justificativa") != null))
  justificativa = "S";
else
  justificativa = "N";
if ((request.getParameter("chk_alteracao") != null))
  alteracao = "S";
else
  alteracao = "N";
if((request.getParameter("chk_registro") != null))
  registro = "S";
else
  registro = "N";
if((request.getParameter("chk_exclusao") != null))
  exclusao = "S";
else
  exclusao = "N";
if((request.getParameter("chk_solicextra") != null))
  solicextra = "S";
else
  solicextra = "N";

java.util.Date hoje = new java.util.Date();
SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
String str_hoje = formato.format(hoje);

String q = "";

String contad = "", envio = "", vencimento = "", porcentagem = "";
int contado = 0, i = 0, a = 0;
Vector vetQuest      = new Vector();
Vector vetEnvio      = new Vector();
Vector vetVencimento = new Vector();
Vector vetAmostra    = new Vector();

vetQuest      = (Vector)session.getAttribute("vetor_avaliacao");
vetEnvio      = (Vector)session.getAttribute("vetor_envio");
vetVencimento = (Vector)session.getAttribute("vetor_vencimento");
vetAmostra    = (Vector)session.getAttribute("vetor_amostra");

if(vetQuest == null)
  contado = 0;
else
  contado = vetQuest.size();

if (tipo.equals("I")){
  String  queryVerifica= "SELECT PLA_NOME FROM PLANO WHERE PLA_NOME='"+nome+"'";
  rsConsulta = conexao.executaConsulta(queryVerifica,session.getId() + "RS1");
  String parametro= "&";
  //try{
    for (Enumeration e = request.getParameterNames() ; e.hasMoreElements() ;){
      String nomePar = e.nextElement().toString();
      parametro =parametro+ nomePar+"="+(String)request.getParameter(nomePar)+"&";
    }
  //}
  //catch(Exception e ){
  //  out.println("Erro do TransiCAo de Parametros "+e);
  //}

  if(!rsConsulta.next()){
    query = "INSERT INTO PLANO (PLA_NOME, PLA_DATAINICIO, PLA_DATAFINAL, PER_CODIGO, PLA_ANTERIOR,          PLA_ACESSO, PLA_NOVASOLICITACAO, PLA_JUSTIFICATIVA, PLA_ALTERACAO, PLA_EXCLUSAO, PLA_REGISTROTREINAMENTO,  PLA_EXIBIRMENSAGEM, PLA_TERMOMENSAGEM, Pla_Solicitacaoextra ) VALUES "+
      "('" + nome + "', DATEFMT(" + data_inicio + "), DATEFMT(" + data_fim + "), " + periodo + ", " + plano_anterior + ", '" + acesso + "', '" + nova_solic + "', '" + justificativa + "', '" + alteracao + "', '" + exclusao + "', '" + registro + "','S','S', '" + solicextra + "')"; 
    conexao.executaAlteracao(query);
  

    query = "SELECT PLA_CODIGO FROM PLANO WHERE PLA_NOME = '"+nome+"'";
    rs = conexao.executaConsulta(query, session.getId() +  "RS2");
    if (rs.next()) pla_codigo = rs.getString(1);
    
    if(rs != null){
      rs.close();
      conexao.finalizaConexao(session.getId() +  "RS2");
    }

    if(!vetQuest.isEmpty()){
      for(i=1;i<=contado;i++){
        envio = "";
        vencimento = "";
        porcentagem = "100";
        a = i - 1;
        envio = (String)vetEnvio.elementAt(a);
        vencimento = (String)vetVencimento.elementAt(a);
        porcentagem = (String)vetAmostra.elementAt(a);
        if(porcentagem.equals(""))
          porcentagem = "100";
        
        queryI = "INSERT INTO PLANO_AVALIA (QUE_CODIGO,PLA_CODIGO,PLV_DIASENVIO,PLV_DIASVENC,PLV_PORCENTAGEM) "+
           "VALUES ("+vetQuest.elementAt(i-1)+","+pla_codigo+","+envio+","+vencimento+","+porcentagem+")";
        conexao.executaAlteracao(queryI);
        //out.println("<br>QUERY: "+queryI);
      }
    }
                //Insere valores nulos para todas as filiais
    String queryF = "SELECT FIL_CODIGO FROM FILIAL ORDER BY FIL_CODIGO";
    String queryX = "SELECT QBR_CODIGO FROM QUEBRA WHERE PER_CODIGO = 3";//O cOdigo do perIodo estA fixo em mensal (3)
    rsX = conexao.executaConsulta(queryX,session.getId() + "RS3");
                rsF = conexao.executaConsulta(queryF,session.getId() + "RS4"); 
                if(rsF.next()) {
                    do {
                        if(rsX.next()) {
                        do{
                            query = "INSERT INTO INFOMES (PLA_CODIGO,IFM_MES,FIL_CODIGO) " +
                                    "VALUES ("+pla_codigo+", "+rsX.getInt(1)+", " +rsF.getString(1)+")";
                            conexao.executaAlteracao(query);
                        } while(rsX.next());
                        }
                        
                        if(rsX != null){
                          rsX.close();
                          conexao.finalizaConexao(session.getId() + "RS3");
                        }                        


                        rsX = null;
                        rsX = conexao.executaConsulta(queryX,session.getId() + "RS5");
                    } while(rsF.next());

                if(rsF != null){
                    rsF.close();
                    conexao.finalizaConexao(session.getId() + "RS4");
                }
    }

                       if(rsX != null){
                          rsX.close();
                          conexao.finalizaConexao(session.getId() + "RS5");
                        }                        

    %>
    
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><script language="JavaScript">
      alert(<%=("\""+trd.Traduz("InclusAo efetuada com sucesso")+"\"")%>);
      window.open("planodetreinamento.jsp","_self");
    </script>
    <%
  }
  else{
    %>
    <script language="JavaScript">
      alert(<%=("\""+trd.Traduz("IMPOSSIVEL CADASTRAR PLANO JA EXISTENTE")+"\"")%>);
      window.open("inclusaodeplanodetrein.jsp?tipo=I<%=parametro%>","_self");
    </script>
    <%
  }

 if(rsConsulta != null){
    rsConsulta = null;
    conexao.finalizaConexao(session.getId() + "RS1");
 }

} else {

  if (tipo.equals("U")){
    String queryVerifica = "SELECT PLA_NOME FROM PLANO WHERE PLA_NOME = '"+nome+"' AND PLA_CODIGO <> "+cod;
    rsConsulta = conexao.executaConsulta(queryVerifica,session.getId() + "RS6");
    if(!rsConsulta.next()){
      query = "UPDATE PLANO SET PLA_NOME = '" + nome + "' , PLA_DATAINICIO = DATEFMT("+data_inicio+"), PLA_DATAFINAL = DATEFMT(" + data_fim + "), PER_CODIGO = "+ periodo +", PLA_ANTERIOR = "+ plano_anterior +", PLA_ACESSO = '" + acesso + "', PLA_NOVASOLICITACAO = '" + nova_solic + "', PLA_JUSTIFICATIVA = '" + justificativa + "', PLA_ALTERACAO = '" + alteracao + "', PLA_EXCLUSAO = '" + exclusao + "', PLA_REGISTROTREINAMENTO = '" + registro + "',  PLA_EXIBIRMENSAGEM = 'S', PLA_TERMOMENSAGEM = 'S', Pla_Solicitacaoextra =  '" + solicextra + "' WHERE PLA_CODIGO = " + cod;
      conexao.executaAlteracao(query);
      queryI = "DELETE PLANO_AVALIA WHERE PLA_CODIGO = "+cod;
      conexao.executaAlteracao(queryI);

      if(!vetQuest.isEmpty()){
        for(i=1;i<=contado;i++){
          envio = "";
          vencimento = "";
          porcentagem = "100";
          a = i - 1;
          envio = (String)vetEnvio.elementAt(a);
          vencimento = (String)vetVencimento.elementAt(a);
          porcentagem = (String)vetAmostra.elementAt(a);
          if(porcentagem.equals(""))
          porcentagem = "100";
          
          queryI = "INSERT INTO PLANO_AVALIA (QUE_CODIGO,PLA_CODIGO,PLV_DIASENVIO,PLV_DIASVENC,PLV_PORCENTAGEM) "+
                  "VALUES ("+vetQuest.elementAt(i-1)+","+cod+","+envio+","+vencimento+","+porcentagem+")";
          conexao.executaAlteracao(queryI);
        }
      }

      
      %>
      <script language="JavaScript">
        alert(<%=("\""+trd.Traduz("ALTERACAO EFETUADA COM SUCESSO")+"\"")%>);
        window.open("planodetreinamento.jsp","_self");
      </script>
      <%
    }
    else{
      %>
      <script language="JavaScript">
        alert(<%=("\""+trd.Traduz("IMPOSSIVEL CADASTRAR PLANO JA EXISTENTE")+"\"")%>);
        window.open("planodetreinamento.jsp","_self");
      </script>
      <%
    }

    if(rsConsulta != null){
       rsConsulta = null;
      conexao.finalizaConexao(session.getId() + "RS6");
    }

  }
  
    if (tipo.equals("DU")){
      String num = "0", mes="", cod_pla = "";
      String total = "0", valor = "0", min = "0", hora ="0";

      if(request.getParameter("txt_num") != null)
        num = request.getParameter("txt_num");
      if(request.getParameter("txt_hora") != null)
        hora = request.getParameter("txt_hora");
      if(request.getParameter("txt_min") != null)
        min = request.getParameter("txt_min");
      if(request.getParameter("txt_valor") != null)
        valor = request.getParameter("txt_valor");
      if(request.getParameter("cod_mes") != null)
        mes = request.getParameter("cod_mes");
      if(request.getParameter("codigo") != null)
        cod_pla = request.getParameter("codigo");
    
    int aux_h = 0, aux_m = 0, aux_total = 0;
    
    aux_h = Integer.parseInt(hora);
    aux_m = Integer.parseInt(min);
    aux_total = (aux_h * 60) + aux_m;

    valor = replaceString(valor,".","");
        
      query = "UPDATE INFOMES SET IFM_NFUNCIONARIO = "+num+", IFM_HORAS = "+aux_total+", IFM_VALOR = "+valida(valor)+" "+
        "WHERE IFM_MES = "+mes+" AND PLA_CODIGO = "+cod_pla+ " AND FIL_CODIGO = " +filial;
                //out.println(query);
    conexao.executaAlteracao(query);
    %>
    <script language="JavaScript">
      alert(<%=("\""+trd.Traduz("ALTERACAO EFETUADA COM SUCESSO")+"\"")%>);
      //window.open("planodetreinamento.jsp","_self");
      window.open("mostradado.jsp?cod=<%=cod_pla%>","_self");
    </script>
    <%
    }
}
//}catch(Exception e){  out.println("Erro: "+e);}
%>
