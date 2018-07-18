<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1"))
    response.setHeader("Cache-Control", "no-cache");
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*"%>


<%
//try{

request.getSession();
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");


String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi");  
Integer usu_plano = (Integer)session.getAttribute("usu_plano");  

ResultSet rs = null, rs2 = null, rs_plano = null;

String moeda = prm.buscaparam("MOEDA");

String query="", query2="", imp="", ord="", classe="ftverdanapreto2", cor="", filtros="", str_solic="", 
       str_curso="", str_depto="", str_funcion="", str_tab1="", str_tab2="", tipo_rel = "", str_filial = "";
int solic=0, depto=0, tabela1=0, tabela2=0, tabela3=0, tabela4=0, tabela5=0, tabela6=0, tabela7=0, tabela8=0, filial=0, tipo=0, cargo=0, curso=0, titulo=0, empresa=0, funcion=0;
int planejado=0, justificado=0, realizado=0, agendado=0, total_plan=0, total_just=0, total_real=0, total_agend=0, primeira=0, solic_cont=0;
float custo=0,custo1=0,custo2=0, total_custo=0,total_custo1=0,total_custo2=0, duracao = 0, total_duracao = 0;
boolean muda = true;

String reload = "";
if(request.getParameter("reload") != null)
  reload = request.getParameter("reload");

//Checagem de demitidos e terceiros
String fun_filtro = "";

if(request.getParameter("check_d") != null)//demitido
  fun_filtro = " AND F.FUN_DEMITIDO = 'S' ";

if((request.getParameter("check_a") != null) || (reload.equals("")))//ativo
  fun_filtro = " AND F.FUN_TERCEIRO = 'N' AND F.FUN_DEMITIDO = 'N' ";

if(request.getParameter("check_t") != null)//terceiro
  fun_filtro = " AND F.FUN_TERCEIRO = 'S' ";

if((request.getParameter("check_d") != null) && (request.getParameter("check_a") != null))//demitido e ativo
  fun_filtro = " AND ((F.FUN_DEMITIDO = 'S') OR (F.FUN_TERCEIRO = 'N' AND F.FUN_DEMITIDO = 'N')) ";

if((request.getParameter("check_d") != null) && (request.getParameter("check_t") != null))//demitido e terceiro
  fun_filtro = " AND ((F.FUN_DEMITIDO = 'S') OR (F.FUN_TERCEIRO = 'S')) ";

if((request.getParameter("check_a") != null) && (request.getParameter("check_t") != null))//ativo e terceiro
  fun_filtro = " AND ((F.FUN_TERCEIRO = 'N' AND F.FUN_DEMITIDO = 'N') OR (F.FUN_TERCEIRO = 'S')) ";

if((request.getParameter("check_d") != null) && (request.getParameter("check_a") != null) && (request.getParameter("check_t") != null))//demitido, ativo e terceiro
  fun_filtro = " AND ((F.FUN_DEMITIDO = 'S') OR (F.FUN_TERCEIRO = 'N' AND F.FUN_DEMITIDO = 'N') OR (F.FUN_TERCEIRO = 'S')) ";

query = "SELECT DISTINCT F.FUN_CHAPA, F.FUN_NOME, A.CAR_NOME, D.DEP_NOME, C.CUR_NOME, Q.QBR_NOME, "+
    "T.TEF_DURACAO, C.CUR_CUSTO, C.CUR_CUSTO2, T.TEF_PLANEJADO, T.TTR_CODIGO, T.JUS_CODIGO, "+
    "T.TUR_CODIGO_REAL, T.TUR_CODIGO_PLAN_ANT, F.FUN_LOGIN, F.FUN_CODSOLIC, "+
        "(SELECT FU.FUN_NOME FROM FUNCIONARIO FU WHERE FU.FUN_CODIGO = F.FUN_CODSOLIC) AS SOLIC, "+
    "F.FUN_DEMITIDO, F.FUN_TERCEIRO, I.FIL_NOME "+
    "FROM TREINAMENTO T, FUNCIONARIO F, QUEBRA Q, CURSO C, CARGO A, DEPTO D, "+ 
    "FILIAL I, TIPOTREINAMENTO P, TITULO U, EMPRESA E "+
    "WHERE F.FUN_CODIGO = T.FUN_CODIGO "+     
    "AND C.CUR_CODIGO = T.CUR_CODIGO "+ 
    "AND Q.QBR_CODIGO = T.QBR_CODIGO "+ 
    "AND F.CAR_CODIGO = A.CAR_CODIGO "+ 
	"AND U.TIT_CODIGO = C.TIT_CODIGO "+ 
    "AND F.DEP_CODIGO = D.DEP_CODIGO "+
        "AND F.FUN_CODSOLIC IS NOT NULL "+
        "AND (T.TTR_CODIGO = 1 OR T.TTR_CODIGO = 2 OR T.TTR_CODIGO = 3) AND T.TEF_PLANEJADO = 'S' "+//1-LISTA DE PRESENCA; 2-TURMA ANTECIPADA; 3-LONGA DURACAO
    "AND T.PLA_CODIGO = " + usu_plano + " " + fun_filtro;

// *********** TIPO **************
if(request.getParameter("rb_tipo") != null) 
  tipo_rel = request.getParameter("rb_tipo");

// *********** IMPRIMIR **********
if(request.getParameter("rb_imp") != null) {
  imp = request.getParameter("rb_imp");
  if(imp.equals("P")) {
    query = query + "AND T.TEF_PLANEJADO = 'S' "+
              "AND T.JUS_CODIGO IS NULL "+
                    "AND T.TUR_CODIGO_REAL IS NULL "+
                    "AND T.TUR_CODIGO_PLAN_ANT IS NULL ";
  } else if(imp.equals("J")) {
    query = query + "AND T.JUS_CODIGO IS NOT NULL ";
  } else if(imp.equals("R")) {
    query = query + "AND T.TUR_CODIGO_REAL IS NOT NULL ";
  } else if(imp.equals("A")) {
    query = query + "AND T.TUR_CODIGO_PLAN_ANT IS NOT NULL ";
  }
}
// *********** IMPRIMIR **********


// *********** FILTROS **********
if(request.getParameter("sel_filial") != null) {
  filial = Integer.parseInt(request.getParameter("sel_filial"));
  if(filial > 0) {
    query = query + "AND I.FIL_CODIGO = "+filial+" "+
        "AND F.FIL_CODIGO = I.FIL_CODIGO ";
  //FILTRO
  query2 = "SELECT FIL_NOME FROM FILIAL WHERE FIL_CODIGO = "+filial;
  rs2 = conexao.executaConsulta(query2,session.getId()+"RS_1");
  if(rs2.next())
    filtros = filtros + "<BR>" + trd.Traduz("FILIAL") + ": " + rs2.getString(1);
  }
  else
  {    query = query + "AND F.FIL_CODIGO = I.FIL_CODIGO ";

  }  
if(rs2!=null){
    rs2.close();
    conexao.finalizaConexao(session.getId()+"RS_1");
}
}

if(request.getParameter("sel_depto") != null) {
  depto = Integer.parseInt(request.getParameter("sel_depto"));
  if(depto > 0) {
    query = query + "AND D.DEP_CODIGO = "+depto+" "+
              "AND F.DEP_CODIGO = D.DEP_CODIGO ";
    //FILTRO
    query2 = "SELECT DEP_NOME FROM DEPTO WHERE DEP_CODIGO = "+depto;
    rs2 = conexao.executaConsulta(query2,session.getId()+"RS_2");

    if(rs2.next())
      filtros = filtros + "<BR>" + trd.Traduz("DEPARTAMENTO") + ": " + rs2.getString(1);      
  }
if(rs2!=null){
    rs2.close();
    conexao.finalizaConexao(session.getId()+"RS_2");
}

}

if(request.getParameter("sel_tabela2") != null) {
  tabela2 = Integer.parseInt(request.getParameter("sel_tabela2"));
  if(tabela2 > 0) {
    query = query + "AND F.TB2_CODIGO = "+tabela2+" ";
    //FILTRO
    query2 = "SELECT TB2_NOME FROM TABELA2 WHERE TB2_CODIGO = "+tabela2;
    rs2 = conexao.executaConsulta(query2,session.getId()+"RS_3");
    if(rs2.next())
      filtros = filtros + "<BR>" + trd.Traduz("TABELA2") + ": " + rs2.getString(1);     
  }
    if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"RS_3");
    }

}

if(request.getParameter("sel_tabela3") != null) {
  tabela3 = Integer.parseInt(request.getParameter("sel_tabela3"));
  if(tabela3 > 0) {
  query = query + "AND F.TB3_CODIGO = "+tabela3+" ";
  //FILTRO
  query2 = "SELECT TB3_DESCRICAO FROM TABELA3 WHERE TB3_CODIGO = "+tabela3;
  rs2 = conexao.executaConsulta(query2,session.getId()+"RS_4");
  if(rs2.next())
    filtros = filtros + "<BR>" + trd.Traduz("TABELA3") + ": " + rs2.getString(1);
  }
 if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"RS_4");
    }
}

if(request.getParameter("sel_solic") != null) {
  solic = Integer.parseInt(request.getParameter("sel_solic"));  
  if(solic > 0) {
    query = query + "AND F.FUN_CODSOLIC = "+solic+" ";
    //FILTRO
    query2 = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = "+solic;
    rs2 = conexao.executaConsulta(query2,session.getId()+"RS_5");
    if(rs2.next())
      filtros = filtros + "<BR>" + trd.Traduz("SOLICITANTE") + ": " + rs2.getString(1);       
  }
    if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"RS_5");
    }
}

if(request.getParameter("sel_tabela1") != null) {
  tabela1 = Integer.parseInt(request.getParameter("sel_tabela1"));
  if(tabela1 > 0) {
    query = query + "AND F.TB1_CODIGO = "+tabela1+" ";
    //FILTRO
    query2 = "SELECT TB1_NOME FROM TABELA1 WHERE TB1_CODIGO = "+tabela1;
    rs2 = conexao.executaConsulta(query2,session.getId()+"RS_6");
    if(rs2.next())    
      filtros = filtros + "<BR>" + trd.Traduz("TABELA1") + ": " + rs2.getString(1);     
  }
 if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"RS_6");
    }
}

if(request.getParameter("sel_tabela4") != null) {
  tabela4 = Integer.parseInt(request.getParameter("sel_tabela4"));
  if(tabela4 > 0) {
  query = query + "AND F.TB4_CODIGO = "+tabela4+" ";
  //FILTRO
  query2 = "SELECT TB4_DESCRICAO FROM TABELA4 WHERE TB4_CODIGO = "+tabela4;
  rs2 = conexao.executaConsulta(query2,session.getId()+"RS_7");
  if(rs2.next())
    filtros = filtros + "<BR>" + trd.Traduz("TABELA4") + ": " + rs2.getString(1);
  }
if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"RS_7");
    }
}

if(request.getParameter("sel_tipo") != null) {
  tipo = Integer.parseInt(request.getParameter("sel_tipo"));
  if(tipo > 0) {
    query = query + "AND C.TCU_CODIGO = "+tipo+" ";
    //FILTRO
    query2 = "SELECT TCU_NOME FROM TIPOCURSO WHERE TCU_CODIGO = "+tipo;
    rs2 = conexao.executaConsulta(query2,session.getId()+"RS_8");
    if(rs2.next())
      filtros = filtros + "<BR>" + trd.Traduz("TIPO") + ": " + rs2.getString(1);
  }
    if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"RS_8");
    }
}

if(request.getParameter("sel_cargo") != null) {
  cargo = Integer.parseInt(request.getParameter("sel_cargo"));
    if(cargo > 0) {
      query = query + "AND A.CAR_CODIGO = "+cargo+" "+
                      "AND F.CAR_CODIGO = A.CAR_CODIGO ";   
      //FILTRO
      query2 = "SELECT CAR_NOME FROM CARGO WHERE CAR_CODIGO = "+cargo;
      rs2 = conexao.executaConsulta(query2,session.getId()+"RS_9");
      if(rs2.next())
      filtros = filtros + "<BR>" + trd.Traduz("CARGO") + ": " + rs2.getString(1);
  }
if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"RS_9");
    }
}

if(request.getParameter("sel_curso") != null) {
  curso = Integer.parseInt(request.getParameter("sel_curso"));
  if(curso > 0) {
    query = query + "AND C.CUR_CODIGO = "+curso+" "+
              "AND C.CUR_CODIGO = T.CUR_CODIGO "; 
    //FILTRO
    query2 = "SELECT CUR_NOME FROM CURSO WHERE CUR_CODIGO = "+curso;
    rs2 = conexao.executaConsulta(query2,session.getId()+"RS_10");
    if(rs2.next())
      filtros = filtros + "<BR>" + trd.Traduz("CURSO") + ": " + rs2.getString(1);
  }
if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"RS_10");
    }
}

if(request.getParameter("sel_titulo") != null) {
  titulo = Integer.parseInt(request.getParameter("sel_titulo"));
  if(titulo > 0) {
    query = query + "AND U.TIT_CODIGO = "+titulo+" "+
        "AND C.TIT_CODIGO = U.TIT_CODIGO ";
    //FILTRO
    query2 = "SELECT TIT_NOME FROM TITULO WHERE TIT_CODIGO = "+titulo;
    rs2 = conexao.executaConsulta(query2,session.getId()+"RS_11");
    if(rs2.next())
      filtros = filtros + "<BR>" + trd.Traduz("TITULO") + ": " + rs2.getString(1);
  }
    if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"RS_11");
    }
}

if(request.getParameter("sel_empresa") != null) {
  empresa = Integer.parseInt(request.getParameter("sel_empresa"));
  if(empresa > 0) {
    query = query + "AND E.EMP_CODIGO = "+empresa+" "+
        "AND T.EMP_CODIGO = E.EMP_CODIGO ";
    //FILTRO
    query2 = "SELECT EMP_NOME FROM EMPRESA WHERE EMP_CODIGO = "+empresa;
    rs2 = conexao.executaConsulta(query2,session.getId()+"RS_12");
    if(rs2.next())
      filtros = filtros + "<BR>" + trd.Traduz("EMPRESA") + ": " + rs2.getString(1);
  }
 if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"RS_12");
    }
}

if(request.getParameter("sel_funcion") != null) { 
  funcion = Integer.parseInt(request.getParameter("sel_funcion"));
  if(funcion > 0) {
    query = query + "AND F.FUN_CODIGO = "+funcion+" ";
    //FILTRO
    query2 = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = "+funcion;
    rs2 = conexao.executaConsulta(query2,session.getId()+"RS_13");
    if(rs2.next())
      filtros = filtros + "<BR>" + trd.Traduz("FUNCIONARIO") + ": " + rs2.getString(1);
  }
if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"RS_13");
    }
}

if (filtros.equals(""))
  filtros = trd.Traduz("NENHUM");
// *********** FILTROS **********


// *********** ORDENACAO **********
if(request.getParameter("rb_ord") != null) {
  ord = request.getParameter("rb_ord");

  if(ord.equals("S")) {
    query = query + "ORDER BY SOLIC, F.FUN_NOME";
  } else if(ord.equals("C")) {
    query = query + "ORDER BY C.CUR_NOME, F.FUN_NOME";
  } else if(ord.equals("D")) {
    query = query + "ORDER BY D.DEP_NOME, F.FUN_NOME";
  } else if(ord.equals("F")) {
    query = query + "ORDER BY F.FUN_NOME";
  } else if(ord.equals("U")) {
    query = query + "ORDER BY I.FIL_NOME";
  }
}
// *********** ORDENACAO **********

%>

<%!//funcao para formatacao $$
public String ReaistoStr(float valor){
  DecimalFormat dcf = new DecimalFormat("0.00");
  dcf.setMaximumFractionDigits(2);
  String strReais = dcf.format(valor);
  return strReais;
}
%>

<%! public String convHora(float minutos)
{ 
  Float ft = new Float(minutos);
  int min = ft.intValue();
  
  String total = "";
  float result;
  int inteiro = 0, decimal = 0;

  result = min / 60;

  Float ft2 = new Float(result);
  inteiro = ft2.intValue();

  decimal = min % 60;

    if((decimal < 10)||(decimal == 0))
    total = inteiro + ":0" + decimal;
  else
      total = inteiro + ":" + decimal;

  return total;
}
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("ImpressOes")%> - <%=trd.Traduz("RelatOrio do Plano de Treinamento")%></title>  
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../art/onenglish.gif','../art/onespanol.gif')">
<table width="100%" border="0" cellspacing="1" cellpadding="0" height="100%">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="1" cellpadding="0">
        <tr> 
          <td width="20">&nbsp;</td>
          <td width="100%">       
              <table border="0" cellspacing="1" cellpadding="0" width="100%">
            <tr> 
            <td class="trcurso" ><img src="../art/Logo_Cliente.gif" width="317" height="42"></td>  
                  </tr>       
<%      String query_plano = "SELECT PLA_NOME FROM PLANO WHERE PLA_CODIGO = "+usu_plano;
      rs_plano = conexao.executaConsulta(query_plano,session.getId()+"RS_plano");
                  if(rs_plano.next())%>
                      <tr>
                        <td class="trontrk" width="100%" align="center"><%=trd.Traduz("RELATORIO DE PLANO DE TREINAMENTO")%> / <%=rs_plano.getString(1)%></td>                              
                </tr>
              </table>
          </td>
    <td width="20">&nbsp;</td>
  </tr>               
  <tr> 
            <td width="20" valign="top"></td>
      <FORM name="frm">
                <td valign="top"> &nbsp;<br>
                    <table width="100%" border="0" cellspacing="1" cellpadding="3">                            
                        <tr valign="top"> 
                            <td width="44%" class="ftverdanapreto"> <%=trd.Traduz("FILTROS ESCOLHIDOS")%>: <span class="ftverdanacinza"> <%=filtros%> </span> </td>
                            <td width="14%" class="ftverdanacinza"><img src="../art/black.gif" width="17" height="17"> = <%=trd.Traduz("PLANEJADOS")%> </td>
                            <td width="14%" class="ftverdanacinza"><img src="../art/blue.gif" width="17" height="17"> = <%=trd.Traduz("JUSTIFICADOS")%> </td>
                            <td width="14%" class="ftverdanacinza"><img src="../art/green.gif" width="17" height="17"> = <%=trd.Traduz("REALIZADOS")%> </td>
                            <td width="14%" class="ftverdanacinza"><img src="../art/orange.gif" width="17" height="17"> = <%=trd.Traduz("AGENDADOS")%> </td>
            </tr>
            <tr>
              <td width="44%">&nbsp;  </td>
              <td width="14%">&nbsp;  </td>
              <td width="14%">&nbsp;  </td>
              <td width="14%" class="ftverdanacinza"> ** - <%=trd.Traduz("DEMITIDO")%> </td>
              <td width="14%"class="ftverdanacinza"> * - <%=trd.Traduz("TERCEIRO")%> </td>
            </tr>
                    </table>
          <% 
                 //out.println("query = " + query);

                    rs = conexao.executaConsulta(query,session.getId()+"RS_16");
                    if(rs.next()) 
          {
                        do 
            {
              if(ord.equals("S")) 
              {
                                if(str_solic.equals(rs.getString(17)))
                                    muda = false;
                                else
                                    muda = true;
                            }
                            else if(ord.equals("C")) 
              {
                                if(str_curso.equals(rs.getString(5)))
                                    muda = false;
                                else
                                    muda = true;
                            }
                            else if(ord.equals("D")) 
              {
                                if(str_depto.equals(rs.getString(4)))
                                    muda = false;             
                                else
                                    muda = true;
                            }
              else if(ord.equals("U")) 
              {
                                if(str_filial.equals(rs.getString(20)))
                                    muda = false;             
                                else
                                    muda = true;
                            }
                            else if(ord.equals("F"))
              {
                                if(str_funcion.equals(rs.getString(2)))
                                    muda = false;             
                                else
                                    muda = true;
                            }
              
              if(muda == true) 
              {
                            cor = "#FFFFFF";
          
                if(primeira != 0) 
                {
                  cor = "#FFFFFF";
                  %>                
                  <tr>          
                    <td colspan="10" class="celtittab" align="center"><%=trd.Traduz("SUBTOTALIZACAO")%></td>
                  </tr>

          <tr class="celcin">
            <td align="center" colspan="6">
              <%=trd.Traduz("PLANEJADOS")%> = <%=planejado%>
              &nbsp; &nbsp; &nbsp;
              <%=trd.Traduz("JUSTIFICADOS")%> = <%=justificado%>
              &nbsp; &nbsp; &nbsp;
              <%=trd.Traduz("REALIZADOS")%> = <%=realizado%>
              &nbsp; &nbsp; &nbsp;
              <%=trd.Traduz("AGENDADOS")%> = <%=agendado%>
            </td>             
            <td align="right" width="10%"> <%=convHora(duracao)%></td>
              <td align="right" width="10%"> <%=ReaistoStr(custo1)%></td>
            <td align="right" width="10%"> <%=ReaistoStr(custo2)%></td>
                        <td align="right" width="10%"> <%=ReaistoStr(custo)%></td>
                    </tr> 
          <tr>
            <td colspan="10">&nbsp;  </td>
          </tr>                
        <%          
            }//if(primeira != 0)%>
        <table width="100%" border="0" cellspacing="1" cellpadding="3">
          <tr>
            <td colspan="8" class="ftverdanapreto">&nbsp; <br>
            <%
            if(ord.equals("S")) {
              %><%=trd.Traduz("SOLICITANTE")%>:<%
              if(rs.getString(17) != null){
                %><%=rs.getString(17)%> 
                <%solic_cont++;
              }
              else{
                out.println(trd.Traduz("NENHUM"));
              }
            }
            else if(ord.equals("C")) {
              %><%=trd.Traduz("CURSO")%>: <%=rs.getString(5)%><%
              solic_cont++;
            }
            else if(ord.equals("D")) {
              %><%=trd.Traduz("DEPARTAMENTO")%>: <%=rs.getString(4)%><%
              solic_cont++;
            }
            else if(ord.equals("F")) {
              %><%=trd.Traduz("FUNCIONARIO")%>: <%=rs.getString(2)%><%
              solic_cont++;
            }
            else if(ord.equals("U")) {
              %><%=trd.Traduz("UNIDADE")%>: <%=rs.getString(20)%><%
              solic_cont++;
            }
            %>
            </td>
        </tr>
          </table>        
          <table width="100%" border="0" cellspacing="1" cellpadding="2">
<%          if(tipo_rel.equals("D")) {%>                    
                                <tr class="celtitrela"> 
                                    <td width="10%" align="center"><%=trd.Traduz("CHAPA")%></td>
                                    <td width="10%" align="center"><%=trd.Traduz("NOME")%></td>
                                    <td width="10%" align="center"><%=trd.Traduz("CARGO")%></td>
                                    <td width="10%" align="center"><%=trd.Traduz("DEPARTAMENTO")%></td>
                                    <td width="10%" align="center"><%=trd.Traduz("CURSO")%></td>
                                    <td width="10%" align="center"><%=trd.Traduz("PREVISAO")%></td>
                                    <td width="10%" align="center"><%=trd.Traduz("DURACAO")%></td>
                                    <td width="10%" align="center"><%=trd.Traduz("CUSTO CURSO")%>(<%=moeda%>)</td>
                                    <td width="10%" align="center"><%=trd.Traduz("CUSTO LOGISTICA")%>(<%=moeda%>)</td>
                                    <td width="10%" align="center"><%=trd.Traduz("CUSTO TOTAL")%>(<%=moeda%>)</td>
                                </tr>
<%
          }//tipo_rel.equals("D")

            planejado = 0; justificado = 0; realizado = 0; agendado = 0;
                            custo = 0; duracao = 0;custo1 = 0;custo2 = 0;
                            
                    }//muda == true

                    //Realizado (1o)
        if(rs.getString(13) != null) {
                        classe = "ftverdanaverde";
                        realizado++;
      total_real++;
        } else
                    //Justificado (2o)
        if(rs.getString(12) != null) {
                        classe = "ftverdanaazul";
      justificado++;
                        total_just++;
        } else
                    //Agendado (3o)
                    if(rs.getString(14) != null) {
                        classe = "ftverdanaamarelo";
                        agendado++;
      total_agend++;
        } else
                    //Planejado (4o)
        if(rs.getString(10) != null) {
                        //if(rs.getString(10).equals("S")) {
                        //1-LISTA DE PRESENCA; 2-TURMA ANTECIPADA; 3-LONGA DURACAO
                            //if(((rs.getInt(11) == 1) || (rs.getInt(11) == 2) || (rs.getInt(11) == 3)) && 
                              //(rs.getString(12) == null) && (rs.getString(13) == null) && (rs.getString(14) == null)) {
                                classe = "ftverdanapreto2";
                                planejado++;
                                total_plan++;
                            //}
                        //}
                    }

        custo = custo + (rs.getFloat(9)) + (rs.getFloat(8));
        custo1 = custo1 +  (rs.getFloat(8));
        custo2= custo2 +  (rs.getFloat(9));
            total_custo = total_custo + (rs.getFloat(9)) + (rs.getFloat(8));
            total_custo1 = total_custo1 + (rs.getFloat(8));
            total_custo2 = total_custo2 + (rs.getFloat(9));
            duracao = duracao + (rs.getFloat(7)); 
            total_duracao = total_duracao + (rs.getFloat(7));

                    if(tipo_rel.equals("D")){%>
                        <tr bgcolor=<%=cor%>>
                            <td width="10%" class=<%=classe%>> <%=rs.getString(1)%> </td>

              <td width="10%" class=<%=classe%>>              
              <%
                              if(rs.getString(18).equals("S"))
                              {
                                %>**
                                <%=((rs.getString(2)==null)?"":rs.getString(2))%></td>
                                <%
                              }
                              else if(rs.getString(19).equals("S"))
                              {
                                %>*
                                <%=((rs.getString(2)==null)?"":rs.getString(2))%></td>
                                <%
                              }
                              else
                              {
                                %>
                                <%=((rs.getString(2)==null)?"":rs.getString(2))%></td>
                                <%
                              }
                            %>
                </td>

                <td width="10%" class=<%=classe%>> <%=rs.getString(3)%> </td>
                <td width="10%" class=<%=classe%>> <%=rs.getString(4)%> </td>
                <td width="10%" class=<%=classe%>> <%=rs.getString(5)%> </td>
                            <td width="10%" class=<%=classe%>> <%=rs.getString(6)%> </td>
                <td width="10%" align="right" class=<%=classe%>> <%=convHora(rs.getFloat(7))%> </td>
                <td width="10%" align="right" class=<%=classe%>> <%=ReaistoStr(rs.getFloat(8))%> </td>
              <td width="10%" align="right" class=<%=classe%>> <%=ReaistoStr(rs.getFloat(9))%> </td>
                            <td width="10%" align="right" class=<%=classe%>> <%=ReaistoStr((rs.getFloat(9)) + (rs.getFloat(8)))%> </td>     
            </tr>                  
<%        }
            if(cor.equals("#FFFFFF"))
        cor = "#EEEEEE";
        else
            cor = "#FFFFFF";
        
        str_solic = ((rs.getString(17)==null)?"":rs.getString(17));
        str_curso = ((rs.getString(5)==null)?"":rs.getString(5));
        str_depto = ((rs.getString(4)==null)?"":rs.getString(4));
        str_funcion = ((rs.getString(2)==null)?"":rs.getString(2));
        str_filial = ((rs.getString(20)==null)?"":rs.getString(20));
        primeira = 1;
      } while(rs.next());%>
      
      <%
        if (filtros.equals("NENHUM") || (solic_cont>1)) 
        {
        %>
          <tr>
            <td colspan="10" class="celtittab" align="center"><%=trd.Traduz("SUBTOTALIZACAO")%></td>
                    </tr>
                    <tr class="celcin">
            <td align="center" colspan="6">
              <%=trd.Traduz("PLANEJADOS")%> = <%=planejado%>
              &nbsp; &nbsp; &nbsp;
              <%=trd.Traduz("JUSTIFICADOS")%> = <%=justificado%>
              &nbsp; &nbsp; &nbsp;
              <%=trd.Traduz("REALIZADOS")%> = <%=realizado%>
              &nbsp; &nbsp; &nbsp;
              <%=trd.Traduz("AGENDADOS")%> = <%=agendado%>
            </td>             
            <td align="right" width="10%"> <%=convHora(duracao)%></td>
              <td align="right" width="10%"> <%=ReaistoStr(custo1)%></td>
            <td align="right" width="10%"> <%=ReaistoStr(custo2)%></td>
                        <td align="right" width="10%"> <%=ReaistoStr(custo)%></td>
                    </tr> 
        <%
        }
      %>

      </table>

      <br><br>

                  <table width="100%" border="0" cellspacing="1" cellpadding="2" align="center">
                    <tr align="center"> 
                        <td colspan="6" class="celtittabcin"><font size="1"><%=trd.Traduz("TOTAL GERAL")%></font></td>
                        <td class="celtittabcin"><font size="1"><%=trd.Traduz("DURACAO")%></font></td>
                        <td class="celtittabcin"><font size="1"><%=trd.Traduz("CUSTO CURSO")%>(<%=moeda%>)</font></td>
                        <td class="celtittabcin"><font size="1"><%=trd.Traduz("CUSTO LOGISTICA")%>(<%=moeda%>)</font></td>
                        <td class="celtittabcin"><font size="1"><%=trd.Traduz("CUSTO TOTAL")%>(<%=moeda%>)</font></td>
                    </tr>
                    <tr class="celcin">
            <td align="center" colspan="6"><font size="1">
              <%=trd.Traduz("PLANEJADOS")%> = <%=total_plan%>
              &nbsp; &nbsp; &nbsp;
              <%=trd.Traduz("JUSTIFICADOS")%> = <%=total_just%>
              &nbsp; &nbsp; &nbsp;
              <%=trd.Traduz("REALIZADOS")%> = <%=total_real%>
              &nbsp; &nbsp; &nbsp;
              <%=trd.Traduz("AGENDADOS")%> = <%=total_agend%></font>
            </td>
            <td align="right" width="10%"><font size="1"> <%=convHora(total_duracao)%></font></td>
                        <td align="right" width="10%"><font size="1"> <%=ReaistoStr(total_custo1)%></font></td>
            <td align="right" width="10%"><font size="1"> <%=ReaistoStr(total_custo2)%></font></td>
                        <td align="right" width="10%"><font size="1"> <%=ReaistoStr(total_custo)%></font></td>
                    </tr>                  
        <tr align="center"> 
                        <td colspan="2">&nbsp;</td>
                    </tr>
                  </table>    
              </td>

<%    } //if(rs.next()) 
      else{
        %>
                
          <p>&nbsp;
          <table width="100%" border="0" cellspacing="1" cellpadding="2">
            <tr> 
                <td align="center" class="celbrarela"><%=trd.Traduz("NENHUM ITEM SELECIONADO")%></td>
            </tr>         
          </table>
<%    }%>

          </FORM>
          <td width="20" valign="top"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>     
</body>
</html>
<%

//out.println("query = " + query);


if(rs!=null){
    rs.close();
    conexao.finalizaConexao(session.getId()+"RS_16");
    }
if(rs_plano!=null){
    rs.close();
    conexao.finalizaConexao(session.getId()+"RS_plano");
    }

//} catch(Exception e){
//  out.println("Erro: "+e);
//}
%>
