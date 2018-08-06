<%  
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1"))
    response.setHeader("Cache-Control", "no-cache");
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.util.*, java.math.*, java.text.*"%>

<%
//try{

request.getSession();
FOLocalizationBean trd   = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao = (FODBConnectionBean)session.getAttribute("Conexao");

String usu_tipo   = (String) session.getAttribute("usu_tipo"); 
String usu_nome   = (String) session.getAttribute("usu_nome"); 
String usu_login  = (String) session.getAttribute("usu_login"); 
String aplicacao  = (String) session.getAttribute("aplicacao"); 
Integer usu_fil   = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi   = (Integer)session.getAttribute("usu_idi");  
Integer usu_plano = (Integer)session.getAttribute("usu_plano");  

ResultSet rs = null, rs1 = null, rsef = null, rs_filtro = null;

int indice = 1, ncurso = 0, notac = 0, cinefic = 0, porcent = 0, total_div = 0, total_porcent = 0, pendentes = 0,
    cur_ef = 0, cur_in = 0;

String  filtro  = "", dt_inicio  = "", query = "",  cor    = "", comentario   = "",  per_nome = "",   res_nome   = "", 
        query_dt= "", que_codigo = "", max   = "",  min    = "", per_codigo   = "0", ava_codigo = "", query_filtro = "",
        dt_fim  = "", per_tipo   = "";

float efm = 0, eff = 0, cefic = 0;



per_codigo  = ((request.getParameter("selpergunta")     == null)?"":request.getParameter("selpergunta"));
dt_inicio   = ((request.getParameter("text_datainicio") == null)?"":request.getParameter("text_datainicio"));
dt_fim      = ((request.getParameter("text_datafinal")  == null)?"":request.getParameter("text_datafinal"));
ava_codigo  = ((request.getParameter("sel_avaliacao")   == null)?"":request.getParameter("sel_avaliacao"));
que_codigo  = ((request.getParameter("sel_questionario")== null)?"":request.getParameter("sel_questionario"));
notac       = ((request.getParameter("notacorte"))      == null)? 0:Integer.parseInt(request.getParameter("notacorte"));

if(!ava_codigo.equals("")){
  query_filtro = "SELECT AVA_DESCRICAO FROM AVALIACAO WHERE AVA_CODIGO = "+ava_codigo;
  rs_filtro = conexao.executaConsulta(query_filtro,session.getId());
  if(rs_filtro.next()){
    if(rs_filtro.getString(1) != null){
      filtro = filtro + "<br>" + trd.Traduz("AVALIACAO") +  ": " + rs_filtro.getString(1);
    }
  }
  if(rs_filtro!=null){
    rs_filtro.close();
    conexao.finalizaConexao(session.getId());
    }
}

if(!que_codigo.equals("")){
  query_filtro = "SELECT QUE_NOME FROM QUESTIONARIO WHERE QUE_CODIGO = "+que_codigo;
  rs_filtro = conexao.executaConsulta(query_filtro,session.getId());
  if(rs_filtro.next()){
    if(rs_filtro.getString(1) != null){
      filtro = filtro + "<br>" + trd.Traduz("QUESTIONARIO") +  ": " + rs_filtro.getString(1);
    }
  }
if(rs_filtro!=null){
    rs_filtro.close();
    conexao.finalizaConexao(session.getId());
    }
  
}

if(!per_codigo.equals("")){
  query_filtro = "SELECT PER_NOME FROM PERGUNTA WHERE PER_CODIGO = "+per_codigo;
  rs_filtro = conexao.executaConsulta(query_filtro,session.getId());
  if(rs_filtro.next()){
    if(rs_filtro.getString(1) != null){
      filtro = filtro + "<br>" + trd.Traduz("PERGUNTA") +  ": " + rs_filtro.getString(1);
    }
  }
if(rs_filtro!=null){
    rs_filtro.close();
    conexao.finalizaConexao(session.getId());
    }
}

if((!dt_inicio.equals("")) && !(dt_fim.equals(""))){
  filtro = filtro + "<br>" + trd.Traduz("DATA INICIAL") +  " " + dt_inicio + " " + trd.Traduz("DATA FINAL") +  " " + dt_fim;
}
else if(!(dt_fim.equals(""))){
  filtro = filtro + "<br>" + trd.Traduz("DATA FINAL") +  " " + dt_fim;
}
else if(!(dt_inicio.equals(""))){
  filtro = filtro + "<br>" + trd.Traduz("DATA INICIAL") +  " " + dt_inicio;
}

filtro = filtro + "<br>" + trd.Traduz("NOTA DE CORTE") +  ": " + notac;

%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("APURACAO DAS AVALIACOES")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../art/onenglish.gif','../art/onespanol.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="20">&nbsp;</td>
          <td width="100%"> 
            <table border="0" cellspacing="1" cellpadding="0" width="100%">
              <tr> 
                <td class="trcurso" ><img src="../art/Logo_Cliente.gif" width="317" height="42"></td>
              </tr>       
              <tr>
                <td class="trontrk" width="100%" align="center"><%=trd.Traduz("APURACAO DAS AVALIACOES")%> </td> 
              </tr>
            </table>
          </td>
          <td width="20">&nbsp;</td>
        </tr>
        <tr> 
          <td width="20" valign="top"></td>
        <!--<FORM name="frm">-->
          <td valign="top"> &nbsp;<br>
          <table width="100%" border="0" cellspacing="1" cellpadding="3">                 
            <tr>
        <td width="48%" class="ftverdanapreto"> <%=trd.Traduz("FILTROS ESCOLHIDOS")%>:
          <span class="ftverdanacinza">
            <%=filtro%>
          </span>
        </td>
              </tr>
        </table>
          </td>
        </tr>
      </table>  
          <br>
          
          <table width="100%" border="0" cellspacing="1" cellpadding="3">                         
        <%
/*
          query = "SELECT QE.QUE_NOME, P.PER_NOME, A.AVA_DESCRICAO "+ 
                  "FROM PERGUNTA P,QUEST_PERGUNTA Q, QUESTIONARIO QE, AVALIACAO A "+
                  "WHERE QE.QUE_CODIGO = Q.QUE_CODIGO "+
                  "and q.que_codigo =  "+que_codigo+" "+
                  "AND P.PER_CODIGO = Q.PER_CODIGO "+
                  "AND QE.AVA_CODIGO = A.AVA_CODIGO "+
                  "AND P.PER_CODIGO = " + per_codigo;

          rs = conexao.executaConsulta(query);  

          if(rs.next()){*/
          if(!(dt_inicio.equals(""))){
            //query_dt = "AND TURMA.TUR_DATAINICIO >= (DATETIME, '"+dt_inicio+"', 103) ";
            query_dt = "AND T.TUR_DATAINICIO >= DATEFMT("+dt_inicio+") ";
          }
          if(!(dt_fim.equals(""))){
            //query_dt = query_dt + " AND TURMA.TUR_DATAFINAL <= CONVERT(DATETIME, '"+dt_fim+"', 103) ";
            query_dt = query_dt + " AND T.TUR_DATAFINAL <= DATEFMT("+dt_fim+") ";
          }
            //}                      
            /*
            query = "SELECT TURMA.TUR_CODIGO, CURSO.CUR_NOME,  " + 
                    "COUNT(TREINAMENTO.FUN_CODIGO) AS PARTICIPANTES, " + 
                    "COUNT(AVALIADO.FUN_CODIGO) AS AVALIACOES, " +
                    "COUNT(AVALIADO.AVD_STATUS) AS RESPONDIDAS, " + 
                    "COUNT(AVALIADO.FUN_CODIGO) - " + 
                    "COUNT(AVALIADO.AVD_STATUS) AS PENDENTES, PROCESSO.PRO_INICIO, " + 
                    "PROCESSO.PRO_CODIGO   " + 
                    "FROM PROCESSO, TURMA, CURSO, TREINAMENTO, AVALIADO " + 
                    "WHERE TURMA.TUR_CODIGO = PROCESSO.TUR_CODIGO AND " + 
                    "CURSO.CUR_CODIGO = TURMA.CUR_CODIGO AND " + 
                    "TREINAMENTO.TUR_CODIGO_REAL = TURMA.TUR_CODIGO AND " + 
                    "AVALIADO.PRO_CODIGO = PROCESSO.PRO_CODIGO AND  " + 
                    "PROCESSO.QUE_CODIGO IN (SELECT QUEST_PERGUNTA.QUE_CODIGO " + 
                    "FROM QUEST_PERGUNTA WHERE PER_CODIGO = " + per_codigo + " and que_codigo = "+que_codigo+") " + 
                    query_dt + 
                    "GROUP BY TURMA.TUR_CODIGO, CURSO.CUR_NOME, PROCESSO.PRO_INICIO, " + 
                    "PROCESSO.PRO_CODIGO  ORDER BY CURSO.CUR_NOME ";
            
            */
            
            query = "SELECT T.TUR_CODIGO, C.CUR_NOME, COUNT(DISTINCT TR.FUN_CODIGO) AS PARTICIPANTES, "+
                    "COUNT(DISTINCT A.AVD_CODIGO) AS AVALIACOES, P.PRO_CODIGO "+
                    "FROM QUEST_PERGUNTA QP, TURMA T, PROCESSO P, CURSO C, AVALIADO A, TREINAMENTO TR "+
                    "WHERE QP.QUE_CODIGO = "+que_codigo+" "+
                    "AND QP.PER_CODIGO = "+per_codigo+" "+
                    "AND P.QUE_CODIGO = QP.QUE_CODIGO "+
                    "AND T.TUR_CODIGO = P.TUR_CODIGO "+
                    "AND T.CUR_CODIGO = C.CUR_CODIGO "+
                    "AND A.PRO_CODIGO = P.PRO_CODIGO "+
                    "AND TR.CUR_CODIGO = C.CUR_CODIGO "+
                    "and tr.tur_codigo_real = t.tur_codigo "+
                    query_dt+" "+
                    "GROUP BY T.TUR_CODIGO, C.CUR_NOME, P.PRO_CODIGO ";
            //out.println(query);
            rs1 = conexao.executaConsulta(query,session.getId());
            
            if(rs1.next()){
                %>
                  <tr>
                    <td colspan="6">&nbsp;  </td>
                  </tr> 
                  <tr class="celtitrela">
                    <td width="6%"> <%=trd.Traduz("TURMA")%> </td>
                      <td width="30%"> <%=trd.Traduz("CURSO")%> </td>
                      <td width="10%" align="center"> <%=trd.Traduz("PARTICIPANTES")%> </td>
                      <td width="10%" align="center"> <%=trd.Traduz("AVALIACOES")%> </td>
                      <td width="10%" align="center"> <%=trd.Traduz("RESPONDIDAS")%> </td>
                      <td width="10%" align="center"> <%=trd.Traduz("PENDENTES")%> </td>                    
                      <td width="10%" align="center"> <%=trd.Traduz("EFETIVIDADE")%></td>
                    </tr>
                <%
                cor = "#FFFFFF";          
              do{
                %>
                  <tr class="ftverdanapreto2" bgcolor=<%=cor%>>
                   <td width="6%"> <%=rs1.getString(1)%> </td>
                   <td width="30%"> <%=rs1.getString(2)%> </td>
                   <td width="10%" align="center"> <%=rs1.getString(3)%> </td>
                   <td width="10%" align="center"> <%=rs1.getString(4)%> </td>
                <%      
                String queryCS = "SELECT COUNT(A.AVD_STATUS) "+
                                "FROM AVALIADO A, PROCESSO P "+
                                "WHERE P.QUE_CODIGO = "+que_codigo+" "+
                                "AND P.PRO_CODIGO = A.PRO_CODIGO "+
                                "AND P.TUR_CODIGO = "+rs1.getString(1)+" "+
                                "AND A.AVD_STATUS = 'S'";
                              
                ResultSet rsCS = conexao.executaConsulta(queryCS,session.getId()+"RS2"); 
                rsCS.next();

                String queryCN = "SELECT A.AVD_STATUS "+
                                "FROM AVALIADO A, PROCESSO P "+
                                "WHERE P.QUE_CODIGO = "+que_codigo+" "+
                                "AND P.PRO_CODIGO = A.PRO_CODIGO "+
                                "AND P.TUR_CODIGO = "+rs1.getString(1)+" "+
                                "AND (A.AVD_STATUS IS NULL OR A.AVD_STATUS = 'N')";
                                
                rsCS.close();
                    conexao.finalizaConexao(session.getId()+"RS2");
                ResultSet rsCN = conexao.executaConsulta(queryCN,session.getId()+"RS3"); 
                if(rsCN.next()){
                  pendentes = 0;
                  do{
                    pendentes++;
                  }while(rsCN.next());
                }
            if(rsCN!=null){
                rsCN.close();
                conexao.finalizaConexao(session.getId()+"RS3");
                    }
                %>
                   <td width="10%" align="center"> <%=rsCS.getString(1)%> </td>
                   <td width="10%" align="center"> <%=pendentes%> </td>
                <%
                String queryef = "SELECT LAU_RESPNUMERICA "+
                                 "FROM LAUDO WHERE PRO_CODIGO = " + rs1.getString(5)+ " "+
                                 "AND PER_CODIGO = "+per_codigo;
                //out.println(queryef);
                rsef = conexao.executaConsulta(queryef,session.getId()+"RS4");
                ncurso++;
                if (rsef.next()){
                    total_div = 0;
                    total_porcent = 0;
                    
                    do{
                      porcent = rsef.getInt(1);
                      total_div++;
                      if(porcent >= notac){
                        total_porcent++;
                      }
                      
                    }while(rsef.next());
                    
                      eff = 0;
                      eff = (total_porcent*100)/(rs1.getInt(4));
                      
                      //out.println(total_porcent+"*100/"+rs1.getInt(4));
                      /*
                      cefic++;
                      DecimalFormat dcf = new DecimalFormat("0.00");
                      dcf.setMaximumFractionDigits(2);
                      eff = dcf.format(rsef.getFloat(1)); 
                      if (rsef.getInt(1) >= notac){
                      cefic++;
                      }
                      else{
                      cinefic++;
                      }
                      DecimalFormat dcf = new DecimalFormat("0.00");
                      dcf.setMaximumFractionDigits(2);
                      eff = dcf.format(rsef.getFloat(1)); 
                      if (rsef.getInt(1) >= notac){
                      cefic++;
                      }
                      else{
                      cinefic++;
                      }*/
                  }
                  rsef.close();
                  conexao.finalizaConexao(session.getId()+"RS4");
                %>
                <td width="10%" align="center"> <%=eff%> %</td>
                </tr>
                <% 
                cefic = cefic + eff;
                eff = 0;
                if(cor.equals("#FFFFFF")){
                  cor = "#EEEEEE";
                }
                else{
                  cor = "#FFFFFF";
                }

                if(cefic != 0){
                  cur_ef++;
                }
                else{
                  cur_in++;
                }
                
              }while(rs1.next());
            }
           if(rs1!=null){
            rs1.close();
            conexao.finalizaConexao(session.getId());
            }
            efm = (cefic)/(ncurso);
          %>  
        <tr>
          <td colspan="6">
            <table width="100%" border="0" class="trontrk">
              <tr> 
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td> 
                  <div align="center"><%=trd.Traduz("TOTALIZACAO")%></div>
                </td>
                <td>&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr> 
        <tr>
            <!--<td colspan="6">      -->
            <table border="0" width="100%" class="celtittabcin">
            <%
            if(ncurso != 0){
              %>
              <tr>
               <td width="25%" align="center"> <%=trd.Traduz("CURSOS MINISTRADOS")%>: <%=ncurso%> </td>
               <td width="25%" align="center"> <%=trd.Traduz("CURSOS INEFICAZES")%>: <%=cur_in%> </td>
               <td width="25%" align="center"> <%=trd.Traduz("CURSOS EFICAZES")%>: <%=cur_ef%> </td>
               <td width="25%" align="center"> <%=trd.Traduz("EFETIVIDADE")%>: <%=efm%> %</td>
              </tr>
              <%
            }
            else{
              %>
              <tr>
               <td colspan="100%" align="center"> <%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%></td>
              </tr>
              <%
            }
           %>
            </table>
          <!--</td>-->
            </tr>
        <tr>
          <td colspan="6">&nbsp;  </td>
        </tr>
          </table>
    </td>
  </tr>
</table>

<%

%>
</body>
</html>
<%
//} catch(Exception e){
//  out.println("ERRO: "+e);
//}
%>

