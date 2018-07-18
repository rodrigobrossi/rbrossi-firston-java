<!--
- O responsável pelo processo foi alterado. Antes era o solicitante do funcionário, agora é o usuário do sistema.
- A tabela avalido recebe o funcionário que vai ser avaliado
- A tabela avaliador recebe o solicitante do avaliado
-->


<%
//Limpa cache
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1"))
  response.setHeader("Cache-Control", "no-cache");
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*, java.util.*"%>


<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<body  onunload='return fecha();' >
<form name="frm" method="post">

<%
//try{
//recupera valores
request.getSession();
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");


String usu_codigo="", questionario="", envio="", vencimento="", query="", fail = "", fail2 = "";
String usu_tipo  = (String) session.getAttribute("usu_tipo"); 
String usu_nome  = (String) session.getAttribute("usu_nome"); 
String usu_login = (String) session.getAttribute("usu_login"); 
Integer usu_fil  = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi  = (Integer)session.getAttribute("usu_idi"); 
usu_codigo       = usu_codigo.valueOf((Integer)session.getAttribute("fun_codigo"));
String turma     = (String) request.getParameter("turma");

String fun_cod = "";
String codigo_trein = "";
int tam_codigo = 0;
boolean virgula = false, boo_contem_processo = false;

Vector func_reg      = new Vector();
Vector func_aval   = new Vector();
Vector func_reg_ant   = new Vector();

ResultSet rs = null, rs_P = null, rs_F = null;

//recupera variaveis da tela ***gera_av
int dur_hora     = (request.getParameter("textdurh")==null)?0: Integer.parseInt(request.getParameter("textdurh"));
int dur_min      = (request.getParameter("textdurm")== null)?0: Integer.parseInt(request.getParameter("textdurm"));
String custo     = (request.getParameter("textcusto")==null)?"0": request.getParameter("textcusto");
String reembolso = (request.getParameter("textreembolso")==null)?"0": request.getParameter("textreembolso");
String historico = (request.getParameter("texthist")==null)?"0": request.getParameter("texthist");
String mes       = (request.getParameter("selectprev")==null)?"": request.getParameter("selectprev");

String gera_av = (request.getParameter("gera_av")==null)?"0": request.getParameter("gera_av");

//String mes       = (Integer.parseInt(mes)<10)?"0"+mes:mes;
String nivel     = (request.getParameter("selectniv")==null)?"": request.getParameter("selectniv");
int cont_avaliacao = (request.getParameter("cont_avaliacao")==null)?0:Integer.parseInt((String)request.getParameter("cont_avaliacao"));

//variaveis
int cont=0, duracao=0, registrados=0, cont_reg=0;
Vector processos = new Vector();
String funcionario = "";
Vector solicitante = new Vector();

String aux = request.getParameter("cont_func");
int cont_func = Integer.parseInt(aux);

String falhou = "";
for (int s=0; s <= cont_func; s++) {
   if (request.getParameter("checkbox"+s) != null) {
      codigo_trein = request.getParameter("checkbox"+s);
   
      query = "SELECT FUN_CODIGO FROM TREINAMENTO WHERE TEF_CODIGO = "+codigo_trein;
      rs = conexao.executaConsulta(query,session.getId()+"RS_1");
      if(rs.next()){
         if(rs.getString(1) != null){
            fun_cod = rs.getString(1);
         }
      }
      if(rs!=null){
        rs.close();
        conexao.finalizaConexao(session.getId()+"RS_1");
        }
      
      if(!fun_cod.equals("")){
         
         /////////////
         // - colocar uma query para verificar se o cod do solicitante existe na tabela funcionario
         // - arrumar a pAgina de deleCAo dos funcionArios. O problema pode ser o novo cOdigo que o radio estA passando
         ////////////
         query = "SELECT FUN_CODSOLIC FROM FUNCIONARIO WHERE FUN_CODIGO = "+fun_cod;
         rs = conexao.executaConsulta(query,session.getId()+"RS_2");
         if(rs.next()){
            if(rs.getString(1) != null){
               if(!solicitante.contains(rs.getString(1))){
                  solicitante.addElement(rs.getString(1));
               }            
            }   
            else{
               if(!func_aval.contains(fun_cod)){
                  func_aval.addElement(fun_cod);
               }
               //falhou = falhou + "<br>- " + rsS.getString(1);
               //out.println("<br>VET1:"+func_aval);
            }
         }
         if(rs!=null){
         rs.close();
         conexao.finalizaConexao(session.getId()+"RS_2");
         }
      }
   }
}


int tam_vet = 0;
for(int i=0; i<=cont_avaliacao; i++) {//loop para as avaliacoes
   if(request.getParameter("chk_"+i) != null) {
      if(!request.getParameter("chk_"+i).equals("")) {
         questionario = request.getParameter("cbo_questionario_"+i);
         envio = request.getParameter("txt_dt_envio_"+i);
         vencimento = request.getParameter("txt_dt_vencimento_"+i);
         query = "SELECT PRO_CODIGO FROM PROCESSO WHERE QUE_CODIGO = " +questionario+ " AND TUR_CODIGO = " +turma;//verifica se a avalicao ja foi cadastrada
         //out.println(query);
         rs = conexao.executaConsulta(query,session.getId()+"RS_3");
         if(rs.next()) {//se existir adiciona no vetor de processos
             processos.addElement(rs.getString(1));//vetor com os processos
             boo_contem_processo = true;
         } else {//senao cria o processo depois adiciona
           boo_contem_processo = false;
         }
         if(rs!=null){
         rs.close();
         conexao.finalizaConexao(session.getId()+"RS_3");
         }
      }
   }
}


//out.println(" envio = " + envio);
//out.println(" vcto = " + vencimento);

//caso for o primeiro registro da turma longa duracao, cria-se os processos necessarios
if (gera_av.equals("1"))
{
 if (!boo_contem_processo) 
 {
            //for(int m=0;m<solicitante.size();m++){
               /*
               query =  "INSERT INTO PROCESSO (FUN_CODIGO_RESP, QUE_CODIGO, PRO_ENVLAUDO, PRO_FIM, TUR_CODIGO) "+
                        "VALUES (" +solicitante.elementAt(m)+ ", " +questionario+ ", CONVERT(datetime, '"+envio+"', 103), "+
                        "CONVERT(datetime, '"+vencimento+"', 103), " +turma+")";
               */
               //a nova query insere como responsável do processo, o usuário que estiver criando, e não mais o solicitante do funcionário//
               query =  "INSERT INTO PROCESSO (FUN_CODIGO_RESP, QUE_CODIGO, PRO_ENVLAUDO, PRO_FIM, TUR_CODIGO) "+
                        "VALUES (" +usu_codigo+ ",, " +questionario+ ", DATEFMT("+envio+"), "+
                        "DATEFMT("+vencimento+"), " +turma+")";
              

               conexao.executaAlteracao(query);
                //out.println("<br>solicitantes:"+solicitante.size());
                //out.println("<br>Processos Query:"+query);
               query = "SELECT PRO_CODIGO FROM PROCESSO WHERE QUE_CODIGO = " +questionario+ " AND TUR_CODIGO = " +turma;
               rs_P = conexao.executaConsulta(query,session.getId()+"RS_5");
            
               if(rs_P.next())
                  processos.addElement(rs_P.getString(1));
            //}
               if(rs_P!=null){
                rs_P.close();
                conexao.finalizaConexao(session.getId()+"RS_5");
                } 
 }
}
//out.println("query4 " + query);

//registra longa duracao
cont = (request.getParameter("contador")==null)?0:Integer.parseInt(request.getParameter("contador"));

for (int i=0; i <= cont; i++) {
   if (request.getParameter("checkbox"+i) != null) {
      codigo_trein = request.getParameter("checkbox"+i);

      //verifica lancamento anterior
      query = "SELECT L.LAN_CODIGO, F.FUN_CODIGO "+
         "FROM LANCAMENTO L, FUNCIONARIO F, TREINAMENTO T "+
         "WHERE L.TEF_CODIGO = "+codigo_trein+" "+
         "AND L.TEF_CODIGO = T.TEF_CODIGO "+
         "AND T.FUN_CODIGO = F.FUN_CODIGO "+
         "AND L.LAN_MES = "+mes+" ";
      rs = conexao.executaConsulta(query,session.getId()+"RS_6");
      if (rs.next()){
         registrados++;
         
         if(rs.getString(2) != null){
            if(!func_reg_ant.contains(rs.getString(2))){
               func_reg_ant.addElement(rs.getString(2));
            }
         }
      } 
      else {
         //registra
         duracao = (dur_hora * 60) + dur_min;
         query = "INSERT INTO LANCAMENTO (IDI_CODIGO, LAN_MES, TEF_CODIGO, LAN_CUSTO, LAN_REEMBOLSO, LAN_HISTORICO, LAN_DURACAO) "+
            "VALUES ("+usu_idi+", "+mes+", "+codigo_trein+", "+custo+", "+
            reembolso+", '"+historico+"', "+duracao+")";
         conexao.executaAlteracao(query);

         query = "UPDATE TREINAMENTO SET TUR_CODIGO_REAL = " +turma+ " WHERE TEF_CODIGO = " +codigo_trein;
         //out.println("<br><br>QUERY 3: "+query);
         conexao.executaAlteracao(query);

         //insere os funcionarios a serem avaliados nas avaliacoes da turma
         funcionario = "";
         query = "SELECT T.FUN_CODIGO, F.FUN_CODSOLIC FROM TREINAMENTO T, FUNCIONARIO F "+
                 "WHERE T.FUN_CODIGO = F.FUN_CODIGO AND T.TEF_CODIGO = " +codigo_trein;
                        //out.println("<br>QUERY 01: "+query);
                        //out.println("<br>processo:"+processos.size());
         rs_F = conexao.executaConsulta(query,session.getId()+"RS_7");
         if (rs_F.next()){
            if(rs_F.getString(1) != null){
               if(!func_reg.contains(rs_F.getString(1))){
                  if(!func_aval.contains(rs_F.getString(1))){
                     func_reg.addElement(rs_F.getString(1));
                  }
               }
            }
            if (rs_F.getString(2) != null) 
			{
			 if (gera_av.equals("1"))
             {
               //out.println("<br>Tamanho do processo:"+processos.size());
               for (int ii=0; ii < processos.size(); ii++) {
               query = "INSERT INTO AVALIADO (PRO_CODIGO, FUN_CODIGO) "+ 
                       "VALUES (" +processos.elementAt(ii)+ ", " +rs_F.getString(1)+ ")";
               conexao.executaAlteracao(query);
               
               //Verifica qual é o código do avaliado para o processo em questão//
               query = "SELECT AVD_CODIGO "+
                       "FROM AVALIADO WHERE PRO_CODIGO = "+processos.elementAt(ii)+ " "+
                       "AND FUN_CODIGO = "+rs_F.getString(1);
               ResultSet rsU = conexao.executaConsulta(query,session.getId()+"RS_9");
               rsU.next();
               
               //Insere em avaliador o código do solicitante do avaliado//
               query = "INSERT INTO AVALIADOR (PRO_CODIGO, AVD_CODIGO, FUN_CODIGO) "+
                       "VALUES ("+processos.elementAt(ii)+", "+rsU.getString(1)+", "+rs_F.getString(2)+")";
               conexao.executaAlteracao(query);
               if(rsU!=null){
                rsU.close();
                conexao.finalizaConexao(session.getId()+"RS_9");
                }        
               //out.println("<br>QUERY: "+query);
              }
			 }
            }
         }
         if(rs_F!=null){
            rs_F.close();
            conexao.finalizaConexao(session.getId()+"RS_7");
         }
      }
      if(rs!=null){
        rs.close();
        conexao.finalizaConexao(session.getId()+"RS_6");
        }
   }
}

//registra TODA a turma se todos os funcionarios foram registrados em todos os messes
query = "SELECT COUNT(*) FROM LANCAMENTO WHERE TEF_CODIGO IN (SELECT TEF_CODIGO FROM TREINAMENTO WHERE TUR_CODIGO_REAL = " +turma+ ")";
rs = conexao.executaConsulta(query,session.getId()+"RS_10");
if (rs.next()){
  cont_reg = rs.getInt(1);
}
/*se o numero de registros da tabela lancamento for igual ao numero de funcionarios da turma vezes 12 (meses)
significa que todos os funcionarios foram registrados em todos os meses da turma (igual aos meses do plano*/
int qtde_quebra = (request.getParameter("qtde_quebra")==null)?0:Integer.parseInt(request.getParameter("qtde_quebra"));

int func_cont = 0;
query = "SELECT COUNT(TEF_CODIGO) FROM TREINAMENTO WHERE TUR_CODIGO_PLAN_ANT = " + turma;
rs = conexao.executaConsulta(query,session.getId()+"RS_11");

if(rs.next()){
  func_cont = rs.getInt(1);
}

if (cont_reg == (func_cont*qtde_quebra)) {
  query = "UPDATE TURMA SET TUR_REGISTRADA = 'S' WHERE TUR_CODIGO = " +turma;
  conexao.executaAlteracao(query);
   //out.println("<br><br>QUERY 5: "+query);
}
%>
<input type="hidden" name="numero" value="<%=falhou%>">
</form>
</body>
</html>
    <script language="JavaScript">
   //showModalDialog("alert.jsp","popup","center=yes;status=no;dialogWidth=470px;dialogHeight=400px");        
        alert(<%=("\""+trd.Traduz("REGISTRO EFETUADO COM SUCESSO!")+"\"")%>);
        window.open("06_criarturmaantecipada.jsp","_self");
    </script>

<%
request.getSession();
session.setAttribute("vet1",func_reg);
session.setAttribute("vet2",func_aval);
session.setAttribute("vet3",func_reg_ant);
%>
<!--
   
    <script language="JavaScript">
        alert(<%=("\""+trd.Traduz("REGISTRO DA TURMA REALIZADO COM SUCESSO")+"\"")%>);
        window.open("06_criarturmaantecipada.jsp","_self");
    </script>
-->
<%
//} 
if(rs!=null){
rs.close();
conexao.finalizaConexao(session.getId()+"RS_10");
}


//} catch (Exception e) {
//  out.println(e); 
//}
%>
