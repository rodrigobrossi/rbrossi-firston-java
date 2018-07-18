<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1"))
  response.setHeader("Cache-Control", "no-cache");
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*, java.util.*"%>
<jsp:useBean id="pos" scope="page" class="firston.eval.components.FOUserPositionBean" />
<jsp:useBean id="cmb" scope="page" class="firston.eval.components.FODynamicComboBean" />
<%
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");
  

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
String aplicacao = (String) session.getAttribute("aplicacao");
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 

//try{
//variaveis
String cod="", query="", query_cbo="", conexaobanco="", usubanco="", senhabanco="", altera_func="", opt_filtro = "";
ResultSet rs = null, rs_cbo = null;
Vector querys = new Vector();
String filial = ""+usu_fil;

if ((request.getParameter("check1") != null) && (request.getParameter("altera_func") != null)) {
    altera_func = request.getParameter("altera_func");
    if (altera_func.equals("S") || altera_func.equals("A")) {
        cod = request.getParameter("check1");//ALTERACAO
        altera_func = "A";
    }
    else {
        cod = "";//INCLUSAO
        altera_func = "I";
    }
} 
else {
    cod = "";//INCLUSAO
    altera_func = "I";
}

//Faz conexAo ao Banco de Dados
conexaobanco = (String)session.getAttribute("s_conexao");
usubanco = (String)session.getAttribute("s_usubanco");
senhabanco = (String)session.getAttribute("s_senbanco");

//Se for alteracao faz a query 
String db_nome = "", db_chapa = "", db_sexo = "", db_rg = "", db_cpf = "", db_email = "", db_telefone = "", db_codCargo = "",
       db_codDept = "", db_codFil = "", db_tb1 = "", db_tb2 = "", db_tb3 = "", db_tb4 = "", db_codEmp = "";

query = "SELECT FUN_NOME, FUN_CHAPA, FUN_SEXO, FUN_RG, FUN_CPF, FUN_EMAIL, FUN_TELEFONE, CAR_CODIGO, DEP_CODIGO, "+
        "FIL_CODIGO, TB1_CODIGO, TB2_CODIGO, TB3_CODIGO, TB4_CODIGO, EMP_CODIGO FROM "+
        "FUNCIONARIO";
if (!cod.equals(""))
  query = query + " WHERE FUN_CODIGO = " +cod+ " ";

//parametros de exibicao
String tb1="", tb2="", tb3="", tb4="", tb5="", tb6="", tb7="", tb8="", fil="", dep="", car="";
if (prm.buscaparam("USE_TB1") != null)
  tb1 = prm.buscaparam("USE_TB1");
if (prm.buscaparam("USE_TB2") !=null)
  tb2 = prm.buscaparam("USE_TB2");
if (prm.buscaparam("USE_TB3") !=null)
  tb3 = prm.buscaparam("USE_TB3");
if (prm.buscaparam("USE_TB4") !=null)
  tb4 = prm.buscaparam("USE_TB4");
if (prm.buscaparam("USE_TB5") !=null)
  tb5 = prm.buscaparam("USE_TB5");
if (prm.buscaparam("USE_TB6") !=null)
  tb6 = prm.buscaparam("USE_TB6");
if (prm.buscaparam("USE_TB7") !=null)
  tb7 = prm.buscaparam("USE_TB7");
if (prm.buscaparam("USE_TB8") !=null)
  tb8 = prm.buscaparam("USE_TB8");
if (prm.buscaparam("USE_FILIAL") !=null)
  fil = prm.buscaparam("USE_FILIAL");
if (prm.buscaparam("USE_DEPARTAMENTO") !=null)
  dep = prm.buscaparam("USE_DEPARTAMENTO");
if (prm.buscaparam("USE_CARGO") !=null)
  car = prm.buscaparam("USE_CARGO");

String unidade = ""+usu_fil, diretoria = "", celula = "", time = "";

if (request.getParameter("op_uni") != null)
    unidade = request.getParameter("op_uni");
else
    unidade = ""+usu_fil;

if (request.getParameter("op_dir") != null)
    diretoria = request.getParameter("op_dir");
if (request.getParameter("op_cel") != null)
    celula = request.getParameter("op_cel");
if (request.getParameter("op_tim") != null)
    time = request.getParameter("op_tim");



String matricula   = ((request.getParameter("txt_chapa") == null)?"":request.getParameter("txt_chapa"));
String lotacao = prm.buscaparam("LOTACAO");


opt_filtro = "Cargo";
if(lotacao.equals("S")){
    if(usu_tipo.equals("F")){
        querys = pos.montaCombo(opt_filtro, "null", "null", aplicacao, unidade, diretoria, celula, time);
    }
    if(usu_tipo.equals("P") || usu_tipo.equals("G")){
        querys = pos.montaCombo(opt_filtro, filial, "null", aplicacao, unidade, diretoria, celula, time);
    }
}
else{
    if(usu_tipo.equals("F")){
        query = cmb.montaCombo(opt_filtro, "null", "null", aplicacao);
    }
    if(usu_tipo.equals("P") || usu_tipo.equals("G")){
        query = cmb.montaCombo(opt_filtro, filial, "null", aplicacao);
    }
}

%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("CADASTRO")%> - 
<%
if (!cod.equals("")){
  %>
  <%=trd.Traduz("ALTERACAO DE FUNCIONARIOS")%>
  <%
}
else{
  %>
  <%=trd.Traduz("INCLUSAO DE FUNCIONARIOS")%>
  <%
}
%>
</title>
<script language="JavaScript" src="/js/scripts.js"></script>

<script language="JavaScript">
function inclui(){
    if (frm_cad_func.txt_nome.value == ""){
        alert(<%=("\""+trd.Traduz("DIGITE O NOME")+"\"")%>);
        return false;
    }
    /*
    else if (frm_cad_func.txt_chapa.value == ""){
      alert(<%=("\""+trd.Traduz("DIGITE A CHAPA")+"\"")%>);
        return false;
    }
    */
    /*else if (frm_cad_func.cbo_filial.value == ""){
        alert(<%=("\""+trd.Traduz("SELECIONE A FILIAL")+"\"")%>);
        return false;
    }*/
    else if (frm_cad_func.cbo_cargo.value == ""){
        alert(<%=("\""+trd.Traduz("SELECIONE O CARGO")+"\"")%>);
        return false;
    }
    /*else if (frm_cad_func.cbo_departamento.value == ""){
        alert(<%=("\""+trd.Traduz("SELECIONE O DEPARTAMENTO")+"\"")%>);
        return false;
    }*/
    else if (frm_cad_func.cbo_empresa.value == ""){
        alert(<%=("\""+trd.Traduz("SELECIONE A EMPRESA")+"\"")%>);
        return false;
    }
    /*else if((frm_cad_func.cbo_tb2.value == "") && (frm_cad_func.cbo_tb3.value != "")){
        alert("funciona");
        return false;
    }*/
    else{
      frm_cad_func.action = "funcionarios_sql.jsp";
      frm_cad_func.submit();
      return true;
    }
}

function cancela() {
  window.open("funcionarios.jsp", "_parent");
  return true;
}

function altera() {
  if (frm_cad_func.txt_nome.value == "") {
    alert(<%=("\""+trd.Traduz("O CAMPO NOME NAO PODE SER NULO")+"\" ! ")%>);
    return false;
  }
  /*
  if (frm_cad_func.txt_chapa.value == "") {
    alert(<%=("\""+trd.Traduz("O CAMPO CHAPA NAO PODE SER NULO")+"\" ! ")%>);
    return false;
  }
  */
  /*if (frm_cad_func.cbo_filial.value == "") {
    alert(<%=("\""+trd.Traduz("FAVOR SELECIONAR O CAMPO FILIAL")+"\" ! ")%>);
    return false;
  }*/
  if (frm_cad_func.cbo_cargo.value == "") {
    alert(<%=("\""+trd.Traduz("FAVOR SELECIONAR O CAMPO CARGO")+"\" ! ")%>);
    return false;
  }
  /*if (frm_cad_func.cbo_departamento.value == "") {
    alert(<%=("\""+trd.Traduz("FAVOR SELECIONAR O CAMPO DEPARTAMENTO")+"\" ! ")%>);
    return false;
  }
  if((frm_cad_func.cbo_tb2.value == "") && (frm_cad_func.cbo_tb3.value != "")){
    alert(<%=("\""+trd.Traduz("PARA ESCOLHER UM TIME E NECESSARIO ESCOLHER UMA CELULA")+"\"")%>);
    return false;
  }*/


  frm_cad_func.action = "funcionarios_sql.jsp";
  frm_cad_func.submit();
  return true;
}
function FormataCampo1(campo, evento, direcao){
  if (campo.value.length < 1000000){
    if(evento != 9 ){//tab
      if(evento != 109 && evento != 189 && evento != 8 && evento != 46 && evento != 16 && !(evento > 36 && evento < 41)){ //delete, backspace, shift nAo causam evento
        var tam = campo.value.length
        if ((evento >= 48 && evento <= 57) || (evento >= 96 && evento <= 105)){
          if (tam == 2 || tam == 5){
            campo.value = campo.value + "";
          }
        }
        else{
          if (direcao == "up"){
            if (campo.value.length == 0){
              campo.value = "";
            }
            else{
              campo.value = "";//campo.value.substring(0,campo.value.length-1)
            }
          }
        }
        campo.focus()
      }
      else if(evento == 16){
        campo.value = "";
      }
    } 
    else{
      if (direcao == "down"){
        var teste = campo.value.substring(0,1);
        if(campo.value<0){
          alert(<%=("\""+trd.Traduz("Este campo nAo aceita valores negativos !")+"\"")%>);
          campo.value="";
          campo.focus();
          return false;
        }
        else if(teste=="+"||teste=="~"||teste=="^"||
          teste=="\""||teste=="'"||teste=="!"||teste=="@"||
          teste=="#"||teste=="$"||teste=="%"||teste=="¨"||
          teste=="&"||teste=="*"||teste=="("||teste==")"||
          teste=="_"||teste=="="||teste=="~"||teste=="`"||
          teste=="´"||teste=="{"||teste=="["||teste=="}"||
          teste=="]"||teste=="<"||
          teste==">"||teste==":"||teste==";"||teste=="/"||
          teste=="?"||teste=="|"||teste=="\\"||teste=="^")
        {
          alert(<%=("\""+trd.Traduz("Este campo nAo aceita caracteres especiais !")+"\"")%>);
          campo.value="";
          campo.focus();
          return false;
        }
      }
    }
  }
}
function aspa(campo){
  aux = campo.value;
  tam = aux.length
  aux2 = aux.substring(tam-1,tam);
  if(aux2 == "\"" || aux2 == "\'"){
    aux = campo.value;
    aux = aux.length;
    aux = aux - 1;
    pal = campo.value;
    campo.value = pal.substring(0, aux);
  }
}
function aspa2(campo){
  aux = campo.value;
  tam = aux.length;
  i = 0;
  nova = "";
  while(i != tam){
    aux2 = aux.substring(i,i+1);
    if(aux2 == "\"" || aux2 == "\'")
      nova = nova;
    else
      nova = nova + aux2;
    i++;
    
  }
  campo.value = nova;
}
function tel(campo){
  aux = campo.value;
  tam = aux.length
  aux2 = aux.substring(tam-1,tam);
  if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" &&
     aux2 != "4" && aux2 != "5" && aux2 != "6" && aux2 != "7" &&
     aux2 != "8" && aux2 != "9" && aux2 != " " && aux2 != "-" &&
     aux2 != "(" && aux2 != ")"){
    aux = campo.value;
    aux = aux.length;
    aux = aux - 1;
    pal = campo.value;
    campo.value = pal.substring(0, aux);
  }
}

function tel2(campo){
  aux = campo.value;
  tam = aux.length;
  k = 0;
  while(tam>0){
    aux2 = aux.substring(tam-1,tam);
    if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" &&
       aux2 != "4" && aux2 != "5" && aux2 != "6" && aux2 != "7" &&
       aux2 != "8" && aux2 != "9" && aux2 != " " && aux2 != "-" &&
       aux2 != "(" && aux2 != ")"){
      k = k+1;
    }
    tam--;
  }
  if(k != 0){
    alert(<%=("\""+trd.Traduz("ESTE CAMPO POSSUI CARACTER NAO PERMITIDO")+"\"")%>);
    campo.focus();
    campo.value = "";
  }
}
function doc(campo){
  aux = campo.value;
  tam = aux.length
  aux2 = aux.substring(tam-1,tam);
  if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" &&
     aux2 != "4" && aux2 != "5" && aux2 != "6" && aux2 != "7" &&
     aux2 != "8" && aux2 != "9" && aux2 != "." && aux2 != "-"){
    aux = campo.value;
    aux = aux.length;
    aux = aux - 1;
    pal = campo.value;
    campo.value = pal.substring(0, aux);
  }
}

function doc2(campo){
  aux = campo.value;
  tam = aux.length;
  k = 0;
  while(tam>0){
    aux2 = aux.substring(tam-1,tam);
    if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" &&
       aux2 != "4" && aux2 != "5" && aux2 != "6" && aux2 != "7" &&
       aux2 != "8" && aux2 != "9" && aux2 != "." && aux2 != "-"){
      k = k+1;
    }
    tam--;
  }
  if(k != 0){
    alert(<%=("\""+trd.Traduz("ESTE CAMPO POSSUI CARACTER NAO PERMITIDO")+"\"")%>);
    campo.focus();
    campo.value = "";
  }
}



function Unidade(){
    /*window.open("../cadastro/inclusaodefuncionario.jsp?op_uni="+frm_cad_func.cbo_filial.value,"_parent");*/
    frm_cad_func.op_uni.value = frm_cad_func.cbo_filial.value;
    frm_cad_func.action = "../cadastro/inclusaodefuncionario.jsp";
    frm_cad_func.submit();
    return true;
}    
function Diretoria(){
    /*window.open("../cadastro/inclusaodefuncionario.jsp?op_uni="+frm_cad_func.cbo_filial.value+"&op_dir="+frm_cad_func.cbo_departamento.value,"_parent");*/
    frm_cad_func.op_uni.value = frm_cad_func.cbo_filial.value;
    frm_cad_func.op_dir.value = frm_cad_func.cbo_departamento.value;
    frm_cad_func.action = "../cadastro/inclusaodefuncionario.jsp";
    frm_cad_func.submit();
    return true;
    
}    
function Celula(){
    /*window.open("../cadastro/inclusaodefuncionario.jsp?op_uni="+frm_cad_func.cbo_filial.value+"&op_dir="+frm_cad_func.cbo_departamento.value+"&op_cel="+frm_cad_func.cbo_tb2.value,"_parent");*/
    frm_cad_func.op_uni.value = frm_cad_func.cbo_filial.value;
    frm_cad_func.op_dir.value = frm_cad_func.cbo_departamento.value;
    frm_cad_func.op_cel.value = frm_cad_func.cbo_tb2.value;
    frm_cad_func.action = "../cadastro/inclusaodefuncionario.jsp";
    frm_cad_func.submit();
    return true;
}    

function Time(){
    /*window.open("../cadastro/inclusaodefuncionario.jsp?op_uni="+frm_cad_func.cbo_filial.value+"&op_dir="+frm_cad_func.cbo_departamento.value+"&op_cel="+frm_cad_func.cbo_tb2.value+"&op_tim="+frm_cad_func.cbo_tb3.value,"_parent");*/
    frm_cad_func.op_uni.value = frm_cad_func.cbo_filial.value;
    frm_cad_func.op_dir.value = frm_cad_func.cbo_departamento.value;
    frm_cad_func.op_cel.value = frm_cad_func.cbo_tb2.value;
    frm_cad_func.op_tim.value = frm_cad_func.cbo_tb3.value;
    frm_cad_func.action = "../cadastro/inclusaodefuncionario.jsp";
    frm_cad_func.submit();
    return true;
}    


</script>

<%
/*out.println("<br>query1: "+querys.elementAt(1));
out.println("<br>query2: "+querys.elementAt(2));
out.println("<br>query3: "+querys.elementAt(3));
out.println("<br>query4: "+querys.elementAt(4));*/


%>


<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','art/onenglish.gif','art/onespanol.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="59" class="hcfundo"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
               <%
        String ponto = (String)session.getAttribute("barra");
        if(ponto.equals("..")){%>
               <jsp:include page="../menu/banner.jsp" flush="true">
               <jsp:param value="opt" name="CA"/>
               </jsp:include>             
               <%}else{%>
               <jsp:include page="/menu/banner.jsp" flush="true">
               <jsp:param value="opt" name="CA"/>
               </jsp:include>             
               <%}%>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td class="mnfundo"><img src="../art/bit.gif" width="12" height="5"></td>
        </tr>
        <tr> 
          <td height="25" class="mnfundo"> 
            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <%String oi = "", oia = "";
                if(ponto.equals("..")){
        if (request.getParameter("op") == null)
        {
                  oi = "../menu/menu.jsp?op="+"C";
        }
        else
        {
                  oi = "../menu/menu.jsp?op="+request.getParameter("op");
        }
        if (request.getParameter("opt") == null)
        {
                  oia = "../menu/menu1.jsp?opt="+"FU";
        } 
        else
        {  
                  oia = "../menu/menu1.jsp?opt="+request.getParameter("opt");
        }
      }
      else{
      if (request.getParameter("op") == null)
              {
                        oi = "/menu/menu.jsp?op="+"C";
              }
              else
              {
                        oi = "/menu/menu.jsp?op="+request.getParameter("op");
              }
              if (request.getParameter("opt") == null)
              {
                        oia = "/menu/menu1.jsp?opt="+"FU";
              } 
              else
              {  
                        oia = "/menu/menu1.jsp?opt="+request.getParameter("opt");
        }
      
      
      
      
      }
        %>
                <jsp:include page="<%=oi%>" flush="true"></jsp:include>
              </tr>
            </table>
          </td>
        </tr>
        <jsp:include page="<%=oia%>" flush="true"></jsp:include>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="20">&nbsp;</td>
          <td width="100%" align="center"> 
            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
<%              if (!cod.equals("")){//ALTERACAO%>
                  <td class="trontrk"><%=trd.Traduz("ALTERACAO DE FUNCIONARIOS")%></td>
<%              } else {//INCLUSAO%>
                  <td class="trontrk"><%=trd.Traduz("INCLUSAO DE FUNCIONARIOS")%></td>
<%              }%>
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
              </tr>
            </table>
          </td>
          <td width="20">&nbsp;</td>
        </tr>
        <tr> 
          <td width="20" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
          <td valign="top" class="ctvdiv"><img src="../art/bit.gif" width="1" height="1"></td>
          <td width="20"><img src="../art/bit.gif" width="1" height="1"></td>
        </tr>
        <tr> 
          <td width="20" valign="top"></td>
    <FORM name = "frm_cad_func" action="cursograva.jsp" method="GET">
            <td valign="top"> <img src="../art/bit.gif" width="159" height="1">&nbsp;<br><center>
              <center>
                <table border="0" cellspacing="2" cellpadding="3" width="90%">
                  <tr class="celnortab">                     
                    <td width="100%" colspan="100%"><%=trd.Traduz("NOME DO PROVEDOR")%><br>
      <%
      rs = conexao.executaConsulta(query, session.getId()+"RS_1");
      if (rs.next()){
        db_nome     = rs.getString(1);
        db_chapa    = rs.getString(2);
        db_sexo     = rs.getString(3);
        db_rg       = rs.getString(4);
        db_cpf      = rs.getString(5);
        db_email    = rs.getString(6);
        db_telefone = rs.getString(7);
        db_codCargo = rs.getString(8);
        db_codDept  = rs.getString(9);
        db_codFil   = rs.getString(10);
        db_tb1      = rs.getString(11);
        db_tb2      = rs.getString(12);
        db_tb3      = rs.getString(13);
        db_tb4      = rs.getString(14);
        db_codEmp   = rs.getString(15);


    /*out.println("<br>NOME: "+db_nome);
    out.println("<br>CHAPA: "+db_chapa);
    out.println("<br>SEXO:"+db_sexo);
    out.println("<br>RG: "+db_rg);
    out.println("<br>CPF: "+db_cpf);
    out.println("<br>EMAIL: "+db_email);
    out.println("<br>FONE: "+db_telefone);
    out.println("<br>CARGO: "+db_codCargo);
    out.println("<br>DEPTO: "+db_codDept);
    out.println("<br>FILIAL: "+db_codFil);
    out.println("<br>TB1: "+db_tb1);
    out.println("<br>TB2: "+db_tb2);
    out.println("<br>TB3: "+db_tb3);
    out.println("<br>TB4: "+db_tb4);
    out.println("<br>EMPRESA: "+db_codEmp);*/
        if (!cod.equals("") && db_nome != null){//ALTERACAO
            %>
            <input type="text" name="txt_nome" size="50" maxlength="50" value="<%=db_nome%>" onBlur="aspa2(this)" onKeyUp="aspa(this)">
            <%
        }
        else{//INCLUSAO
          String i_nome = "";
          if(request.getParameter("txt_nome") != null)
            i_nome = request.getParameter("txt_nome");
            %>
            <input type="text" name="txt_nome" size="50" maxlength="50" value="<%=i_nome%>" onBlur="aspa2(this)" onKeyUp="aspa(this)">
            <%
          }
          %>
            </td>
        </tr>
        <tr class="celnortab">                     
            <td width="50%" align="left"><%=trd.Traduz("CHAPA")%><br>
            <%
            if(!cod.equals("") && db_chapa != null){//ALTERACAO
                %><input type="text" name="txt_chapa" maxlength="20" size="15" value="<%=db_chapa%>" onBlur="aspa2(this)" onKeyUp="aspa(this)"><%
            }
            else{//INCLUSAO
                %><input type="text" name="txt_chapa" maxlength="20" size="15" value="<%=matricula%>" onBlur="aspa2(this)" onKeyUp="aspa(this)"><%
            }
            %>
            </td>
            <td width="50%" align="left"><%=trd.Traduz("SEXO")%><br>
            <select name="cbo_sexo">
                <option value="" selected><%=trd.Traduz("SELECIONE")%></option>
                <%                    
                if (!cod.equals("") && db_sexo != null){//ALTERACAO
                    if (db_sexo.equals("M")){
                        %>
                        <option value="M" selected><%=trd.Traduz("MASCULINO")%></option>
                        <option value="F"><%=trd.Traduz("FEMININO")%></option>
                        <%
                    }
                else{
                    %>
                    <option value="M"><%=trd.Traduz("MASCULINO")%></option>
                    <option value="F" selected><%=trd.Traduz("FEMININO")%></option>
                    <%
                }
          }
          else{//INCLUSAO
            String i_sexo="";
                if(request.getParameter("cbo_sexo") != null){
                    i_sexo = request.getParameter("cbo_sexo");
                }    
                if(i_sexo.equals("M")){
                    %>
                    <option selected value="M"><%=trd.Traduz("MASCULINO")%></option>
                    <option value="F"><%=trd.Traduz("FEMININO")%></option>
                    <%
                    }
                else if(i_sexo.equals("F")){
                    %>
                    <option value="M"><%=trd.Traduz("MASCULINO")%></option>
                    <option selected value="F"><%=trd.Traduz("FEMININO")%></option>
                    <%
                }
                else{
                    %>
                    <option value="M"><%=trd.Traduz("MASCULINO")%></option>
                    <option value="F"><%=trd.Traduz("FEMININO")%></option>
                    <%
                    }
            }//fim do else de inclusão de funcionarios.
            %>
            </select>
            </td>
        </tr>
        <tr class="celnortab">                     
        <td width="50%" align="left"><%=trd.Traduz("RG")%><br>
        <%
        if (!cod.equals("") && db_rg != null){//ALTERACAO
            %>
            <input type="text" name="txt_rg" maxlength="13" size="15" value="<%=db_rg%>" onBlur="aspa2(this)" onKeyUp="aspa(this)" maxlength="8">
            <%
          }
        else{//INCLUSAO
            String i_rg = "";
            if(request.getParameter("txt_rg")!=null)
            i_rg = request.getParameter("txt_rg");
            %>
            <input type="text" value="<%=i_rg%>" name="txt_rg" maxlength="13" size="15"  onBlur="aspa2(this)" onKeyUp="aspa(this)" maxlength="8">
            <%
          }
            %>
            </td>
            <td width="50%" align="left"><%=trd.Traduz("CPF")%><br>
            <%
          if (!cod.equals("") && db_cpf != null){//ALTERACAO
            %>
            <input type="text" name="txt_cpf" maxlength="11" size="15" value="<%=db_cpf%>" onBlur="doc2(this)" onKeyUp="doc(this)" maxlength="8">
            <%
          }
        else{//INCLUSAO
            String i_cpf = "";
            if(request.getParameter("txt_cpf")!=null)
            i_cpf = request.getParameter("txt_cpf");
            %>
            <input type="text" value="<%=i_cpf%>" name="txt_cpf" maxlength="14" size="15" onBlur="doc2(this)" onKeyUp="doc(this)" maxlength="8">
            <%
          }
          %>
        </td>
      </tr>
      <tr class="celnortab">                     
      <td width="50%" align="left"><%=trd.Traduz("FONE")%><br>
        <%
        if (!cod.equals("") && db_telefone != null){//ALTERACAO
            %>
            <input type="text" name="txt_fone" maxlength="14" size="15" value="<%=db_telefone%>" onBlur="tel2(this)" onKeyUp="tel(this)" maxlength="8">
            <%
          }
        else{//INCLUSAO
            String i_fone = "";
            if(request.getParameter("txt_fone")!=null){
                i_fone = request.getParameter("txt_fone");
            }
            %>
            <input type="text" value="<%=i_fone%>" name="txt_fone" maxlength="15" size="15" onBlur="tel2(this)" onKeyUp="tel(this)" maxlength="8">
            <%
        }
          %>
        </td>
        <td width="50%" align="left"><%=trd.Traduz("EMAIL")%><br>
        <%
        if (!cod.equals("") && db_email != null){//ALTERACAO
            %>
            <input type="text" name="txt_mail" maxlength="40" size="40" value="<%=db_email%>" onBlur="tel2(this)" onKeyUp="tel(this)">
            <%
          }
        else{//INCLUSAO
            String i_mail = "";
            if(request.getParameter("txt_mail")!=null){
                i_mail = request.getParameter("txt_mail");
            }
            %>
            <input type="text" value="<%=i_mail%>" name="txt_mail" maxlength="40" size="40" onBlur="aspa2(this)" onKeyUp="aspa(this)">
            <%
          }
          %>
        </td>
        </tr>
    </table>
    <table border="0" cellspacing="2" cellpadding="3" width="90%">                  
        <%
          //estA comentado a verificaCAo de apariCAo da combo cargo (posiCAo) porque na tabela funcionario,
          //o campo car_codigo nAo aceita null
                    //if (car.equals("S")){
        %>
        <tr class="celnortab">
            <td width="50%" align="left"><%=trd.Traduz("CARGO")%><br>
            <select name="cbo_cargo">
                <option value=""><%=trd.Traduz("SELECIONE")%></option>
                <%
                query_cbo = "SELECT CAR_CODIGO, CAR_NOME FROM CARGO WHERE CAR_CODCLI IS NULL ORDER BY CAR_NOME";
                rs_cbo = conexao.executaConsulta(query_cbo,session.getId()+"RS_2");
                if(rs_cbo.next()){
                    do{
                        if(!cod.equals("") && rs_cbo.getString(1).equals(db_codCargo)){//ALTERACAO
                            %>
                            <option value="<%=rs_cbo.getString(1)%>" selected><%=rs_cbo.getString(2)%></option>
                            <%
                        }
                        else{
                            String i_cargo = "";
                            if(request.getParameter("cbo_cargo")!=null){
                                i_cargo = request.getParameter("cbo_cargo");
                            }
                            if(rs_cbo.getString(1).equals(i_cargo)){
                                %>
                                <option selected value="<%=rs_cbo.getString(1)%>"><%=rs_cbo.getString(2)%></option>
                                <%                          
                            }
                            else{
                                %>
                                <option value="<%=rs_cbo.getString(1)%>"><%=rs_cbo.getString(2)%></option>
                                <%                          
                            }
                        }
                    }while (rs_cbo.next());
                }
                if(rs_cbo!=null){
                  rs_cbo.close();
                  conexao.finalizaConexao(session.getId()+"RS_2");  
                }
                %>
            </select>
            </td>
        </tr>
        <%
          //}
        %>
        <tr class="celnortab">
            <td><%=trd.Traduz("EMPRESA")%><br>
                <select name="cbo_empresa">
                <option selected value=""><%=trd.Traduz("SELECIONE")%></option>
                <%
                query_cbo = "SELECT EMP_CODIGO, EMP_NOME, EMP_TIPO FROM EMPRESA ORDER BY EMP_NOME";         
                rs_cbo = conexao.executaConsulta(query_cbo,session.getId()+"RS_3");
          if(rs_cbo.next()){
            do{
              if(rs_cbo.getString(3) != null){
                if(rs_cbo.getString(3).equals("1") || rs_cbo.getString(3).equals("2")){
                  if((db_codEmp != null && db_codEmp.equals(rs_cbo.getString(1))) || (rs_cbo.getString(1).equals(request.getParameter("cbo_empresa")))){
                    %>
                    <option selected value="<%=rs_cbo.getString(1)%>"><%=rs_cbo.getString(2)%></option>
                    <%
                  }
                  else{
                    %>
                    <option value="<%=rs_cbo.getString(1)%>"><%=rs_cbo.getString(2)%></option>
                    <%
                  }
                }
              }
            }while(rs_cbo.next());
          }
          if(rs_cbo!=null){
            rs_cbo.close();
            conexao.finalizaConexao(session.getId()+"RS_3");
            }
          %>
        </select>
        </td>
        </tr>
    <%
    }
if(rs!=null){
rs.close();

conexao.finalizaConexao(session.getId()+"RS_1");
}
    %>
</table>
<table border="0" cellspacing="2" cellpadding="3" width="90%">
    <tr>
        <td colspan="100%" align="center">&nbsp;<br>
<%                    if (!cod.equals("")){//ALTERACAO%>
                        <input type="button" onClick="return altera()" value="        <%=trd.Traduz("OK")%>        " class="botcin" name="buttonok"> 
<%                    } else {%>
                        <input type="button" onClick="return inclui()" value="        <%=trd.Traduz("OK")%>        " class="botcin" name="buttonok"> 
<%                    }%>
                      &nbsp; <input type="button" onClick="return cancela()"  value=<%=("\""+trd.Traduz("CANCELAR")+"\"")%> class="botcin" name="buttoncancel"></td>
                  </tr>
                </table>
                <p>&nbsp;
              </center>
            </td>
            <input type="hidden" name="tipo_operacao" value="<%=altera_func%>">
            <input type="hidden" name="cod_funcionario" value="<%=cod%>">
            <input type="hidden" name="check1" value="<%=cod%>">
            <input type="hidden" name="altera_func" value="<%=altera_func%>">
            <input type="hidden" name="op_uni">
            <input type="hidden" name="op_dir">
            <input type="hidden" name="op_cel">
            <input type="hidden" name="op_tim">
    </FORM>
          <td width="20" valign="top"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td align="right" height="30" class="difundo"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td> 
          <%if(ponto.equals("..")){%>
              <jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include>
              <%}else{%>
              <jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>
              <%}%>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
<%
//}catch (Exception e){out.println(e);}
%>