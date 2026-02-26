<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
  response.setHeader("Cache-Control", "no-cache");
}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.lang.Math.*, java.util.*"%>


<jsp:useBean id="cmb" scope="page" class="firston.eval.components.FODynamicComboBean" />
<jsp:useBean id="pos" scope="page" class="firston.eval.components.FOUserPositionBean" />

<%
//try{
request.getSession(); 
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");

String usu_tipo   = (String) session.getAttribute("usu_tipo"); 
String usu_nome   = (String) session.getAttribute("usu_nome"); 
String usu_login  = (String) session.getAttribute("usu_login");
String aplicacao  = (String) session.getAttribute("aplicacao");
Integer usu_fil   = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi   = (Integer)session.getAttribute("usu_idi"); 
Integer usu_cod   = (Integer)session.getAttribute("usu_cod");
Vector per = (Vector)session.getAttribute("vetorPermissoes");
//Checagem de demitidos e terceiros
String fun_filtro = "";
boolean contem_grid = false;

ResultSet rs = null, rsgrid = null, rsC = null,rsc=null, rs_uni = null, rs_dir = null, rs_cel = null, rs_tim = null;

if(request.getParameter("Check1") != null)//demitido
  fun_filtro = " AND FUNCIONARIO.FUN_DEMITIDO = 'S' ";
if(request.getParameter("Check3") != null)//ativo
  fun_filtro = " AND FUNCIONARIO.FUN_TERCEIRO = 'N' AND FUNCIONARIO.FUN_DEMITIDO = 'N' ";
if(request.getParameter("Check2") != null)//terceiro
  fun_filtro = " AND FUNCIONARIO.FUN_TERCEIRO = 'S' ";
if((request.getParameter("Check1") != null) && (request.getParameter("Check3") != null))//demitido e ativo
  fun_filtro = " AND ((FUNCIONARIO.FUN_DEMITIDO = 'S') OR (FUNCIONARIO.FUN_TERCEIRO = 'N' AND FUNCIONARIO.FUN_DEMITIDO = 'N')) ";
if((request.getParameter("Check1") != null) && (request.getParameter("Check2") != null))//demitido e terceiro
  fun_filtro = " AND ((FUNCIONARIO.FUN_DEMITIDO = 'S') OR (FUNCIONARIO.FUN_TERCEIRO = 'S')) ";
if((request.getParameter("Check3") != null) && (request.getParameter("Check2") != null))//ativo e terceiro
  fun_filtro = " AND ((FUNCIONARIO.FUN_TERCEIRO = 'N' AND FUNCIONARIO.FUN_DEMITIDO = 'N') OR (FUNCIONARIO.FUN_TERCEIRO = 'S')) ";
if((request.getParameter("Check1") != null) && (request.getParameter("Check3") != null) && (request.getParameter("check_t") != null))//demitido, ativo e terceiro
  fun_filtro = " AND ((FUNCIONARIO.FUN_DEMITIDO = 'S') OR (FUNCIONARIO.FUN_TERCEIRO = 'N' AND FUNCIONARIO.FUN_DEMITIDO = 'N') OR (FUNCIONARIO.FUN_TERCEIRO = 'S')) ";
if(request.getParameter("reload") == null)
  fun_filtro = " AND FUNCIONARIO.FUN_TERCEIRO = 'N' AND FUNCIONARIO.FUN_DEMITIDO = 'N' ";

int pag = Integer.parseInt((String)session.getAttribute("pagina"));

boolean mostraCheck=false;

//VariAveis para as Queryes
String  query = "",   query_grid = "", 
    query_c = "",   loc = ""; 
String  opt_filtro = "", campo = "",
    filtro_q = "";
int sel = -1;
int cont=1;

Vector querys = new Vector();

String lotacao = "", unidade = "", diretoria = "", celula = "", time = ""; 

String filial = ""+usu_fil;
String codigo = ""+usu_cod;

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

lotacao = prm.buscaparam("LOTACAO");

//Pegar parametros
if (request.getParameter("select2") != null){  
  opt_filtro = (String)request.getParameter("select2");
  //Select do Combo escolhido
  if(usu_tipo.equals("F"))
    query = cmb.montaCombo(opt_filtro, "null", "null", aplicacao);  

  if(usu_tipo.equals("P"))
    query = cmb.montaCombo(opt_filtro, filial, "null", aplicacao);  
  
  if(usu_tipo.equals("G"))
    query = cmb.montaCombo(opt_filtro, filial, "null", aplicacao);  

  if(usu_tipo.equals("S"))
    query = cmb.montaCombo(opt_filtro, filial, codigo, aplicacao);  

  //CARGO
  if(opt_filtro.equals("Cargo"))
  {
    if(lotacao.equals("S"))
    {
      if(usu_tipo.equals("F"))
        querys = pos.montaCombo(opt_filtro, "null", "null", aplicacao, unidade, diretoria, celula, time); 
  
      if(usu_tipo.equals("P"))
        querys = pos.montaCombo(opt_filtro, filial, "null", aplicacao, unidade, diretoria, celula, time); 
  
      if(usu_tipo.equals("G"))
        querys = pos.montaCombo(opt_filtro, filial, "null", aplicacao, unidade, diretoria, celula, time); 
  
      if(usu_tipo.equals("S"))
        querys = pos.montaCombo(opt_filtro, filial, codigo, aplicacao, unidade, diretoria, celula, time); 
    }

    else
    {
      if(usu_tipo.equals("F"))
        query = cmb.montaCombo(opt_filtro, "null", "null", aplicacao);  

      if(usu_tipo.equals("P"))
        query = cmb.montaCombo(opt_filtro, filial, "null", aplicacao);  

      if(usu_tipo.equals("G"))
        query = cmb.montaCombo(opt_filtro, filial, "null", aplicacao);  
  
      if(usu_tipo.equals("S"))
        query = cmb.montaCombo(opt_filtro, filial, codigo, aplicacao);  
    }
  }
}
else
{
        //Filtro Padrao
	opt_filtro = "Tabela2";

       if( (opt_filtro.equals("Cargo"))&&(lotacao.equals("S")) )
       {
		if(usu_tipo.equals("F"))
			querys = pos.montaCombo(opt_filtro, "null", "null", aplicacao, unidade, diretoria, celula, time);	
	
		if(usu_tipo.equals("P") || usu_tipo.equals("G"))
			querys = pos.montaCombo(opt_filtro, filial, "null", aplicacao, unidade, diretoria, celula, time);	

		if(usu_tipo.equals("S"))
			querys = pos.montaCombo(opt_filtro, filial, codigo, aplicacao, unidade, diretoria, celula, time);	
	}
	else
	{
		if(usu_tipo.equals("F"))
			query = cmb.montaCombo(opt_filtro, "null", "null", aplicacao);	

		if(usu_tipo.equals("P") || usu_tipo.equals("G"))
			query = cmb.montaCombo(opt_filtro, filial, "null", aplicacao);	
	
		if(usu_tipo.equals("S"))
			query = cmb.montaCombo(opt_filtro, filial, codigo, aplicacao);	
	}
}

String vcampo = "";

//Checagem de demitidos e terceiros
String demitido = "", terceiro = "";
if(request.getParameter("Check1") == null)//demitido
  demitido = " AND FUNCIONARIO.FUN_DEMITIDO = 'N' ";
else
  demitido = " AND (FUNCIONARIO.FUN_DEMITIDO = 'S' OR FUNCIONARIO.FUN_DEMITIDO = 'N' )";
if(request.getParameter("Check2") == null)//terceiro
    terceiro = " AND FUNCIONARIO.FUN_TERCEIRO = 'N' ";
else
  terceiro = "AND (FUNCIONARIO.FUN_TERCEIRO = 'S' OR FUNCIONARIO.FUN_TERCEIRO = 'N')";

//Monta a query do Grid
if (!(query.equals("")))
  if (opt_filtro.equals("Solicitante"))
    campo = query.substring(36,48) + " = ";
  else
    campo = query.substring(7,17) + " = ";
if (!(request.getParameter("select") == null)){
  if (!(request.getParameter("select").equals("Todos"))){
    sel = Integer.parseInt(request.getParameter("select"));
    filtro_q = " FUNCIONARIO." + campo + request.getParameter("select") + " ";
    }
  else{
    filtro_q = " 0=0 ";
    }
  }
else{
  filtro_q = " 0=0 ";
  }

if (!(request.getParameter("textfield") == null)) {
  loc = request.getParameter("textfield").trim();
  if (!(loc == null)){
    filtro_q = filtro_q + "AND FUNCIONARIO.FUN_NOME >= '" + loc + "' ";
    }
    else{
    loc = "";
    }
  }
else{
  loc = "";
  }

String par = "";
 
if (usu_tipo.equals("F")){
   par = "";
}
else if (usu_tipo.equals("P")){
    par = " AND FUNCIONARIO.FIL_CODIGO = " + usu_fil + " "; 
    }
else if (usu_tipo.equals("G")){
    par = " AND FUNCIONARIO.FIL_CODIGO = " + usu_fil + " "; 
    }
else if (usu_tipo.equals("S")){
       par = " AND FUNCIONARIO.FIL_CODIGO = " + usu_fil + " AND FUNCIONARIO.FUN_CODSOLIC = " + usu_cod + " "; 
     } 

query_grid = "SELECT FUNCIONARIO.FUN_CODIGO, FUNCIONARIO.FUN_CHAPA, FUNCIONARIO.FUN_NOME, " + 
"CARGO.CAR_NOME, DEPTO.DEP_NOME, TABELA3.TB3_DESCRICAO, TABELA2.TB2_NOME, " + 
"FILIAL.FIL_NOME, SOLICITANTE.FUN_NOME, FUNCIONARIO.FUN_DEMITIDO, FUNCIONARIO.FUN_TERCEIRO, FUNCIONARIO.EMP_CODIGO " + 
"FROM FUNCIONARIO, FUNCIONARIO SOLICITANTE, CARGO, DEPTO, TABELA3, TABELA2, FILIAL " + 
"WHERE FUNCIONARIO.FUN_CODSOLIC OUTER SOLICITANTE.FUN_CODIGO AND " + 
"CARGO.CAR_CODIGO = FUNCIONARIO.CAR_CODIGO AND " + 
"DEPTO.DEP_CODIGO = FUNCIONARIO.DEP_CODIGO AND " + 
"FUNCIONARIO.TB3_CODIGO OUTER TABELA3.TB3_CODIGO AND " + 
"FUNCIONARIO.TB2_CODIGO OUTER TABELA2.TB2_CODIGO AND " + 
"FUNCIONARIO.FIL_CODIGO OUTER FILIAL.FIL_CODIGO " + 
"AND " + filtro_q + 
 par + " "+ fun_filtro+
" ORDER BY FUNCIONARIO.FUN_NOME";

query_c = "SELECT COUNT(*) " + 
"FROM FUNCIONARIO, FUNCIONARIO SOLICITANTE, CARGO, DEPTO, TABELA3, TABELA2, FILIAL " + 
"WHERE FUNCIONARIO.FUN_CODSOLIC OUTER SOLICITANTE.FUN_CODIGO AND " + 
"CARGO.CAR_CODIGO = FUNCIONARIO.CAR_CODIGO AND " + 
"DEPTO.DEP_CODIGO = FUNCIONARIO.DEP_CODIGO AND " + 
"FUNCIONARIO.TB3_CODIGO OUTER TABELA3.TB3_CODIGO AND " + 
"FUNCIONARIO.TB2_CODIGO OUTER TABELA2.TB2_CODIGO AND " + 
"FUNCIONARIO.FIL_CODIGO OUTER FILIAL.FIL_CODIGO " + 
"AND " + filtro_q + par + " "+ fun_filtro;

//out.println(query_grid+"<br>");
//out.println(query_c+"<br>");

//ConecCAo com o Banco pelo Statement para a PaginaCAo com suas variaveis
String primeiro = "1";
int tot   = 0;
int irpag   = 0;
int irpagtot  = 0;
int pagatual  = 0;
int pagtotal  = 0;
int cont_terceiro=0;
int qtde_terceiro = 0;
//Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
//Connection conn = DriverManager.getConnection((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"));

//Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                      //ResultSet.CONCUR_UPDATABLE);
//rsgrid = stmt.executeQuery(query_grid); //out.println(query_grid);
//rsgrid.setFetchSize(pag);
rsgrid = conexao.paginacao(pag,query_grid,session.getId()+"PAG");

//stmt.setFetchDirection(rs.FETCH_FORWARD);
//Para contar as linhas da query
rsc = conexao.executaConsulta(query_c,session.getId()+"RS_1");

//VariAveis de controle de pAgina
if (request.getParameter("p") != null){
  primeiro = (String)request.getParameter("p");
}

int valor = Integer.parseInt(primeiro);
int valorAnt = Integer.parseInt(primeiro) - pag;

if (request.getParameter("i") != null){ 
  if (Integer.parseInt(request.getParameter("i")) > 0){ 
     irpag = Integer.parseInt(request.getParameter("i"));
     irpagtot = ((irpag*pag)-pag)+1;
     primeiro = primeiro.valueOf(irpagtot);
     valor = Integer.parseInt(primeiro);
     valorAnt = Integer.parseInt(primeiro) - pag;
  }
}

//Para nAo tentar mover para a linha zero
if(Integer.parseInt(primeiro) <= 0){
primeiro = "1";
}

//Move o Cursor para a PosiCAo
if(primeiro.equals("1")){
rsgrid.absolute(Integer.parseInt(primeiro));
rsgrid.previous();
}
else
{
rsgrid.absolute(Integer.parseInt(primeiro));
rsgrid.previous();
}

//Calcula a Ultima pagina
if (rsc.next()){
  tot = rsc.getInt(1);
  pagatual = (Integer.parseInt(primeiro)/pag)+1;
  Math e=null;
  pagtotal = e.round((tot/pag)+0.5f);
  if ((tot%pag)==0) pagtotal--;//evita erros no numero de paginas
}
//out.println("Pag. Total:"+pagtotal+" - Resto:"+(pagtotal%pag)+" - Primeiro:"+primeiro);

//Busca e Insere dados no vetor de funcionArios selecionados
String n = "";
Vector funcvet = new Vector();
if(request.getParameter("apagavet") != null){ 
  request.getSession();
  funcvet = (Vector)session.getAttribute("funcs");
  //insere os elementos no vetor
  for(int k=0 ; k<=pag;k++) {
    if ((request.getParameter("checkbox" + n.valueOf(k)) != null)) {
      //out.println(request.getParameter("checkbox" + n.valueOf(k)));
      if (!(funcvet.contains(request.getParameter("checkbox" + n.valueOf(k))))) {
        //out.println("MAIS UM INCLUIDO!! ");
        funcvet.add(request.getParameter("checkbox" + n.valueOf(k)));
              }
          }
      }
  } 
else {
    funcvet.clear();
    //session.removeAttribute("funcs");
    //out.println("Apagou!");
  }

//out.println("VecTam: " + funcvet.size());

%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("CADASTRO")%> - <%=trd.Traduz("CADASTRO DE FUNCIONARIOS")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>

<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<script language="JavaScript">
function FormataCampo1(campo, evento, direcao){
  if (campo.value.length < 1000000){
    if(evento != 9 ){//tab
      if(evento != 8 && evento != 46 && evento != 16 && !(evento > 36 && evento < 41)){ //delete, backspace, shift nAo causam evento
        var tam = campo.value.length
        if ((evento >= 48 && evento <= 57) || (evento >= 96 && evento <= 105)){
          if (tam == 2 || tam == 5){
            campo.value = campo.value + "";
          }
        }
        else{
          if (direcao == "up"){
            if (campo.value.length == 0){
              campo.value = ""
            }
            else{
              campo.value = "";//campo.value.substring(0,campo.value.length-1)
            }
          }
        }
        campo.focus()
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
          teste=="?"||teste=="|"||teste=="\\"||teste=="^"){
          alert(<%=("\""+trd.Traduz("Este campo nAo aceita caracteres especiais !")+"\"")%>);
          campo.value="";
          campo.focus();
          return false;
        }
      }
    }
  }
}

function Filtro(){
  window.open("../cadastro/funcionarios.jsp?select2="+frm.select2.value,"_parent");
  return true;
}

function Unidade(){
  window.open("../cadastro/funcionarios.jsp?op_uni="+frm.select_uni.value,"_parent");
  return true;
}    

function Diretoria(){
  window.open("../cadastro/funcionarios.jsp?op_uni="+frm.select_uni.value+"&op_dir="+frm.select_dir.value,"_parent");
  return true;
}    
function Celula(){
  window.open("../cadastro/funcionarios.jsp?op_uni="+frm.select_uni.value+"&op_dir="+frm.select_dir.value+"&op_cel="+frm.select_cel.value,"_parent");
  return true;
}    
function Time(){
  window.open("../cadastro/funcionarios.jsp?op_uni="+frm.select_uni.value+"&op_dir="+frm.select_dir.value+"&op_cel="+frm.select_cel.value+"&op_tim="+frm.select_tim.value,"_parent");
  return true;
}    

function ProximaPag(valor){
  //alert(valor.value);
  document.frm.p.value = valor.value;
  document.frm.i.value = "-1";  
  frm.action ="funcionarios.jsp";
  frm.submit();
  return false;
}            
function AnteriorPag(valor){
  document.frm.p.value = valor.value;
  document.frm.i.value = "-1";  
  frm.action ="funcionarios.jsp";
  frm.submit();
  return false;
}            
function PrimeiraPag(){
  document.frm.p.value = "1";
  document.frm.i.value = "-1";  
  frm.action ="funcionarios.jsp";
  frm.submit();
  return false;
}            

function envia(){
  if(frm.Check1.checked===false&&frm.Check2.checked==false&&frm.Check3.checked==false){
    alert(<%=("\""+trd.Traduz("SELECIONE PELO MENOS UM TIPO DE FUNCIONARIO")+"\"")%>)
    return false;
  }
    document.frm.p.value = "1";
    document.frm.i.value = "-1";  
    frm.action ="funcionarios.jsp";
    frm.submit();
    return false; 
  }
}

function irpag(){
  if((document.frm.textir.value <= document.frm.pagtotal.value) && (document.frm.textir.value > 0) && (document.frm.textir.value != "")){
    document.frm.p.value = "1";
    document.frm.i.value = document.frm.textir.value;
    frm.action = "funcionarios.jsp";
    frm.submit();
    return false;
  }
  else{
    alert(<%=("\""+trd.Traduz("PAGINA INVALIDA")+"\"")%>);
    document.frm.textir.value = "";
    return false;
  }            
}

function irpag2(){
  if((document.frm.textir2.value <= document.frm.pagtotal.value) && (document.frm.textir2.value > 0) && (document.frm.textir2.value != "")){
    document.frm.p.value = "1";
    document.frm.i.value = document.frm.textir2.value;
    frm.action = "funcionarios.jsp";
    frm.submit();
    return false;
  }
  else{
    alert(<%=("\""+trd.Traduz("PAGINA INVALIDA")+"\"")%>);
    document.frm.textir2.value = "";
    return false;
  }
} 

function solicex(){
  document.frm.extra.value = "S";
  frm.action = "solic_extra.jsp";
        frm.submit();
  return false;
}
function exclui(){
  var teste = 0;
  var cod = 0;
  for(i=1;i<frm.cont.value;i++){
    if(eval("frm.checkbox"+i+".checked")==true){
      teste = teste+1;
    }
  }
  if ((teste==0) && (<%=funcvet.size()%> == 0)){
    alert(<%=("\""+trd.Traduz("FAVOR SELECIONAR UM ITEM")+"\" ! ")%>);
    return false;
  }
  else{
    if (!confirm(<%=("\""+trd.Traduz("DESEJA EXCLUIR O ITEM SELECIONADO")+"\" ? ")%>)){
      return false;
    } 
    else{
      document.frm.tipo_operacao.value = "E";
      frm.action = "funcionarios_sql.jsp";
      frm.submit();
      return true;        
    }
  }
}
function inclui(){
  frm.altera_func.value = "N";
  frm.action = "inclusaodefuncionario.jsp";
  frm.submit();
  return false;        
}

function altera(){
  var valor = 0;
  var cod;
  for (i=1; i<=frm.cont_terceiro.value; i++){
    if(eval("frm.checkbox"+i+".checked")==true){
      valor = valor + 1;
      cod = (eval("frm.checkbox"+i+".value"));
    }
  }
  if(valor == 0){
    alert(<%=("\""+trd.Traduz("FAVOR SELECIONAR UM ITEM")+"\" ! ")%>);
    return false;
  }
  else if(<%=funcvet.size()%>>1 || valor > 1){
    alert(<%=("\""+trd.Traduz("SELECIONE APENAS UM ITEM")+"\" ! ")%>);
    return false;
  }
  else{
    //frm.altera_func.value = "S";
    //frm.action = "inclusaodefuncionario.jsp";
    window.open("inclusaodefuncionario.jsp?check1="+cod+"&altera_func=S","_parent");
    //frm.submit();
    return true;        
  }
  return false;
}

function efetiva(){
  var valor = 0;
  var cod;
  for (i=1; i<=frm.cont_terceiro.value; i++){
    if(eval("frm.checkbox"+i+".checked")==true){
      valor = valor + 1;
      cod = (eval("frm.checkbox"+i+".value"));
    }
  }
  if(valor == 0){
    alert(<%=("\""+trd.Traduz("FAVOR SELECIONAR UM ITEM")+"\" ! ")%>);
    return false;
  }
  /*else if(<%=funcvet.size()%>>1 || valor > 1){
    alert(<%=("\""+trd.Traduz("SELECIONE APENAS UM ITEM")+"\" ! ")%>);
    return false;
  }*/
  else{
    window.open("efetiva.jsp?codigo="+cod,"_self");
    return true;        
  }
  return false;
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
  k = 0;
  while(tam>0){
    aux2 = aux.substring(tam-1,tam);
    if(aux2 == "\"" || aux2 == "\'")
      k = k+1;
    tam--;
  }
  if(k != 0){
    alert(<%=("\""+trd.Traduz("NAO E PERMITIDO DIGITAR ASPA SIMPLES OU DUPLA")+"\"")%>);
    frm.textfield.focus();
    campo.value = "";
  }
}

</script>
<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../art/onenglish.gif','../art/onespanol.gif')">
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
  <jsp:param value="opt" name="SO"/>
  </jsp:include>
  <%}
  else{%>
  <jsp:include page="/menu/banner.jsp" flush="true">
  <jsp:param value="opt" name="SO"/>
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
      if (request.getParameter("op") == null){
                      oi = "../menu/menu.jsp?op="+"C";
      }
      else{
                      oi = "../menu/menu.jsp?op="+request.getParameter("op");
      }
      if (request.getParameter("opt") == null){
                      oia = "../menu/menu1.jsp?opt="+"FU";
      } 
      else{  
                      oia = "../menu/menu1.jsp?opt="+request.getParameter("opt");
      }
    }
    else{
      if (request.getParameter("op") == null){
              oi = "/menu/menu.jsp?op="+"C";
      }
      else{
                    oi = "/menu/menu.jsp?op="+request.getParameter("op");
      }
      if (request.getParameter("opt") == null){
                    oia = "/menu/menu1.jsp?opt="+"FU";
      } 
      else{
                    oia = "/menu/menu1.jsp?opt="+request.getParameter("opt");
      }
    }%>
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
                <td class="trontrk"><%=trd.Traduz("CADASTRO DE FUNCIONARIOS")%></td>
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
      <FORM name = "frm" method="POST">
        <tr> 
          <td width="20" valign="top"></td>
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td height="12" colspan="4"><img src="../art/bit.gif" width="1" height="1"></td>
                </tr>
<%
          //CARGO
          if(opt_filtro.equals("Cargo"))
          {
          if(lotacao.equals("S"))
          {
            %>
            <tr>
              <td class="ctfontc"> <%=trd.Traduz("TABELA5")%>: </td>            
            <td>
              <select name="select_uni" onChange="return Unidade();">   
                <%
                  if(usu_tipo.equals("F")) {
                  %>
                    <option value = "-1"><%=trd.Traduz("Todos")%></option> 
                  <%
                }
                rs_uni = conexao.executaConsulta((String)querys.elementAt(1),session.getId()+"RS_2");
                if (rs_uni.next()){                   
                  do{
                    if((rs_uni.getInt(1)) == (Integer.parseInt(unidade))){
                        %>
                        <option selected value = "<%=rs_uni.getInt(1)%>"><%=rs_uni.getString(2)%></option>
                        <%
                        }
                    else{
                      %>
                      <option value = "<%=rs_uni.getInt(1)%>"><%=rs_uni.getString(2)%></option>
                      <%
                    }
                  }while (rs_uni.next());
                  %> </select> <%                               
                 }
               if(rs_uni!=null){
                rs_uni.close();
                conexao.finalizaConexao(session.getId()+"RS_2");
               }     
              %>
            </td>
            
              <td class="ctfontc"> <%=trd.Traduz("TABELA6")%>: </td>  
            
            <td>
              <select name="select_dir" onChange="return Diretoria();"> <option value = "-1"><%=trd.Traduz("Todos")%></option> 
              <%
              rs_dir = conexao.executaConsulta((String)querys.elementAt(2),session.getId()+session.getId()+"RS_3");
              if (rs_dir.next()){               
                do{                 
                  if(!(diretoria.equals(""))){
                    if((rs_dir.getInt(1)) == (Integer.parseInt(diretoria))){                                       %>
                        <option selected value = "<%=rs_dir.getInt(1)%>"><%=rs_dir.getString(2)%></option>
                        <%
                    }
                    else{
                      %>
                      <option value = "<%=rs_dir.getInt(1)%>"><%=rs_dir.getString(2)%></option>
                      <%    
                    }
                  }
                  else{
                    %>
                      <option value = "<%=rs_dir.getInt(1)%>"><%=rs_dir.getString(2)%></option>
                      <%
                  }
                }while (rs_dir.next());
              }
              if(rs_dir!=null){
                rs_dir.close();
                conexao.finalizaConexao(session.getId()+"RS_3");
              }
              %>
              </select>
            </td>
          </tr>         
          
          <tr>
            <td class="ctfontc"> <%=trd.Traduz("TABELA7")%>: </td>                      
              <td>
              <select name="select_cel" onChange="return Celula();"> <option value = "-1"><%=trd.Traduz("Todos")%></option>
              <%
                rs_cel = conexao.executaConsulta((String)querys.elementAt(3),session.getId()+"RS_4");               
                if (rs_cel.next()){               
                  do{
                    if(!(celula.equals(""))){
                      if((rs_cel.getInt(1)) == (Integer.parseInt(celula))){                                     %>
                          <option selected value = "<%=rs_cel.getInt(1)%>"><%=rs_cel.getString(2)%></option>
                          <%
                      }
                      else{
                        %>
                          <option value = "<%=rs_cel.getInt(1)%>"><%=rs_cel.getString(2)%></option>
                          <%    
                      }
                    }
                    else
                    {
                      %>
                        <option value = "<%=rs_cel.getInt(1)%>"><%=rs_cel.getString(2)%></option>
                        <%
                    }
                  }while (rs_cel.next());
                }
                if(rs_cel!=null){
                rs_cel.close();
                conexao.finalizaConexao(session.getId()+"RS_4");
                }
              %>
              </select> 
            </td>
            
              <td class="ctfontc"> <%=trd.Traduz("TABELA8")%>: </td> 
            
            <td>
              <select name="select_tim" onChange="return Time();"> <option value = "-1"><%=trd.Traduz("Todos")%></option>
              <%
                rs_tim = conexao.executaConsulta((String)querys.elementAt(4),session.getId()+"RS_5");
                if (rs_tim.next()){                 
                  do{
                    if(!(time.equals(""))){
                      if((rs_tim.getInt(1)) == (Integer.parseInt(time))){                                     %>
                          <option selected value = "<%=rs_tim.getInt(1)%>"><%=rs_tim.getString(2)%></option>
                          <%
                      }
                      
                      else
                      {
                        %>
                          <option value = "<%=rs_tim.getInt(1)%>"><%=rs_tim.getString(2)%></option>
                          <%    
                      }
                    }
                    else
                    { 
                      %>
                        <option value = "<%=rs_tim.getInt(1)%>"><%=rs_tim.getString(2)%></option>
                        <%
                    }
                  }while (rs_tim.next());
                }
                if(rs_tim!=null){
                    rs_tim.close();
                    conexao.finalizaConexao(session.getId()+"RS_5");
                    }
              %>
              </select>
            </td>
            </tr>
            <%          
          }
          }
          %>
                <tr> 
                  <td colspan="4">&nbsp; </td>
                </tr>
                <td colspan = "4" height="20" class="ctfontc" align="Center">&nbsp; 
                  <%=trd.Traduz("LOCALIZAR POR FUNCIONARIO")%>: 
                  <input type="text" name="textfield" value="<%=loc%>" onBlur="aspa2(this)" onKeyUp="aspa(this)">                  
                  &nbsp; <%=trd.Traduz("OPCOES")%>: 
                  <select name="select2" class="form" onChange="return Filtro();">
                    <option value ="<%=opt_filtro%>"><%=trd.Traduz(opt_filtro)%></option>
                    <%if (prm.buscaparam("USE_CARGO").equals("S"))
                 {%>
                    <%if (!(opt_filtro.equals("Cargo"))){%>
                    <option value ="Cargo" ><%=trd.Traduz("CARGO")%></option>
                    <%}
         }%>
                    <%if (prm.buscaparam("USE_DEPARTAMENTO").equals("S"))
                 {%>
                    <%if (!(opt_filtro.equals("Departamento"))){%>
                    <option value ="Departamento" ><%=trd.Traduz("DEPARTAMENTO")%></option>
                    <%}
         }%>
                    <%if (prm.buscaparam("USE_FILIAL").equals("S"))
                 {%>
                    <%if (!(opt_filtro.equals("Filial"))){%>
                    <option value ="Filial" ><%=trd.Traduz("FILIAL")%></option>
                    <%}
         }%>
                    <%if (prm.buscaparam("USE_TB1").equals("S"))
                 {%>
                    <%if (!(opt_filtro.equals("Tabela1"))){%>
                    <option value ="Tabela1" ><%=trd.Traduz("TABELA1")%></option>
                    <%}
         }%>
                    <%if (prm.buscaparam("USE_TB2").equals("S"))
                 {%>
                    <%if (!(opt_filtro.equals("Tabela2"))){%>
                    <option value ="Tabela2" ><%=trd.Traduz("TABELA2")%></option>
                    <%}
         }%>
                    <%if (prm.buscaparam("USE_TB3").equals("S"))
                 {%>
                    <%if (!(opt_filtro.equals("Tabela3"))){%>
                    <option value ="Tabela3" ><%=trd.Traduz("TABELA3")%></option>
                    <%}
         }%>
                    <%if (prm.buscaparam("USE_TB4").equals("S"))
                 {%>
                    <%if (!(opt_filtro.equals("Tabela4"))){%>
                    <option value ="Tabela4" ><%=trd.Traduz("TABELA4")%></option>
                    <%}
         }%>
                    <%if (prm.buscaparam("USE_TB5").equals("S"))
                 {%>
                    <%if (!(opt_filtro.equals("Tabela5"))){%>
                    <option value ="Tabela5" ><%=trd.Traduz("TABELA5")%></option>
                    <%}
         }%>
                    <%if (prm.buscaparam("USE_TB6").equals("S"))
                 {%>
                    <%if (!(opt_filtro.equals("Tabela6"))){%>
                    <option value ="Tabela6" ><%=trd.Traduz("TABELA6")%></option>
                    <%}
         }%>
                    <%if (prm.buscaparam("USE_TB7").equals("S"))
                 {%>
                    <%if (!(opt_filtro.equals("Tabela7"))){%>
                    <option value ="Tabela7" ><%=trd.Traduz("TABELA7")%></option>
                    <%}
         }%>
                    <%if (prm.buscaparam("USE_TB8").equals("S"))
                 {%>
                    <%if (!(opt_filtro.equals("Tabela8"))){%>
                    <option value ="Tabela8" ><%=trd.Traduz("TABELA8")%></option>
                    <%}
         }%>
                    <%if (!(opt_filtro.equals("Solicitante")))
          {
            if((usu_tipo.equals("F")) || (usu_tipo.equals("P") || (usu_tipo.equals("G"))))
            {
              %>
                    <option value ="Solicitante" ><%=trd.Traduz("SOLICITANTE")%></option>
                    <%
            }
          }
          %>
                  </select>
                  &nbsp; <%=trd.Traduz("FILTRO")%>:
                  <select name="select">
                    <option value = "Todos"><%=trd.Traduz("Todos")%></option>
                    <%
          if(opt_filtro.equals("Cargo")){
            if(lotacao.equals("S"))
              rs = conexao.executaConsulta((String)querys.elementAt(0),session.getId()+"RS_6");
            else
              rs = conexao.executaConsulta(query,session.getId()+"RS_6");
          }
          else{
            rs = conexao.executaConsulta(query,session.getId()+"RS_6");
          }
                    if (rs.next()){
            do{
              if (sel == rs.getInt(1)){
                %>
                          <option value = "<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
                          <%
                        }
                        else{
                          %>
                          <option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
                          <%
                        }
                        }while (rs.next());
       }
       if(rs!=null){
        rs.close();
        conexao.finalizaConexao(session.getId()+"RS_6");
        }
           %>
                  </select>
                  &nbsp; &nbsp; 
                  </td>
                </tr>
                <tr align="center" class="ctfontc"> 
                  <td align="right" colspan="4">&nbsp;</td>
                </tr>
                <tr><td colspan="100%"><table align="center">
                <tr align="center" class="ctfontc">
                   
                    <td align="center" colspan="4"> 
<%                      if(request.getParameter("reload") == null) {%>
                            <input type="checkbox" name="Check3" checked><%=trd.Traduz("VISUALIZAR ATIVO")%>
<%                      } else {
                            if(request.getParameter("Check3") == null){%>
                                <input type="checkbox" name="Check3">
                                <%=trd.Traduz("VISUALIZAR ATIVO")%> 
<%                          } else {%>
                                <input checked type="checkbox" name="Check3">
                                <%=trd.Traduz("VISUALIZAR ATIVO")%> 
<%                          }
                        }%>
      <input type="hidden" value="1" name="reload">
                     &nbsp;&nbsp;&nbsp;
<%                      if(request.getParameter("Check2") == null) {%>
                            <input type="checkbox" name="Check2">
                            <%=trd.Traduz("VISUALIZAR TERCEIRO")%> 
<%                      } else {%>
                            <input checked type="checkbox" name="Check2">
                            <%=trd.Traduz("VISUALIZAR TERCEIRO")%> 
<%                      }%>
                     &nbsp;&nbsp;&nbsp;
<%                      if(request.getParameter("Check1") == null){%>
                            <input type="checkbox" name="Check1">
                            <%=trd.Traduz("VISUALIZAR DEMITIDO")%> 
<%                      } else {%>
                            <input checked type="checkbox" name="Check1">
                            <%=trd.Traduz("VISUALIZAR DEMITIDO")%> 
<%                      }%>
                    </td>
                </tr>
                </table></td></tr>
                <tr align="center"> 
                  <td class="ctfontc" colspan="4">&nbsp;</td>
                </tr>
                <tr align="center"> 
                  <td class="ctfontc" colspan="4"> 
                    <input type="button" onClick="return envia();" value=<%=("\""+trd.Traduz("FILTRAR")+"\"")%> class="botcin" name="button">
                  </td>
                </tr>
                <tr align="center"> 
                      <td class="ctfontc" colspan="4">&nbsp;</td>
                </tr>
                <tr> 
      <td class="ctvdiv" height="1"colspan="4"><img src="../art/bit.gif" width="1" height="1"></td>
    </tr>
    <tr> 
      <td height="12"colspan="4"><img src="../art/bit.gif" width="1" height="1"></td>
    </tr>
    <tr align="center">
      <td class="ctfontc" valign="middle" colspan="4"><font size="1">
                    ** - <%=trd.Traduz("DEMITIDO")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    * - <%=trd.Traduz("TERCEIRO")%>
        </font>
      </td>
    </tr>
    <tr> 
      <td height="12"colspan="4"><img src="../art/bit.gif" width="1" height="1"></td>
    </tr>
    <tr> 
      <td class="ctvdiv" height="1"colspan="4"><img src="../art/bit.gif" width="1" height="1"></td>
                </tr>
                </table>
              <table align="center" width='100%'>       
              <tr> 
                <td colspan="100%"><br>
                  <%        
      if (per.contains("CADASTRO FUNCIONARIO - MANUTENCAO")) {
        mostraCheck=true;
    %>     
        <center>
                      <table border="0" cellspacing="0" cellpadding="0" width="100%">
                        <tr> 
                          <td colspan="2" align="center">
                            <table border='0'>
                              <tr>
                                <td align="center">
                                   <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                                     <tr> 
                                        <td onMouseOver="this.className='ctonlnk2';" onClick="return inclui()" width="127" height="22" align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("INCLUIR")%></a></td>
                                     </tr>
                                   </table>
                                 </td>
                                <%if(rsgrid.next()) {
                                    contem_grid = true;
                                    rsgrid.previous();%> 
                                  <td>
                                    <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                                      <tr> 
                                        <td onMouseOver="this.className='ctonlnk2';" onClick="return exclui()" width="127" height="22" align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("EXCLUIR")%></a></td>
                                      </tr>
                                    </table>
                                  </td>
                                  <td>
                                    <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                                      <tr> 
                                        <td onMouseOver="this.className='ctonlnk2';" onClick="return altera()" width="127" height="22" align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("ALTERAR")%></a></td>
                                      </tr>
                                    </table>
                                  </td>
                                  <%
                                if(!usu_tipo.equals("G")){
                                  %>
                                  <td>
                                    <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                                      <tr> 
                                        <td onMouseOver="this.className='ctonlnk2';" onClick="return efetiva()" width="127" height="22" align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("EFETIVAR")%></a></td>
                                      </tr>
                                    </table>
                                  </td>
                                  <%
                                }
                              }%>
                              </tr>
                            </table>
                            
                          </td>
            </tr>
                      </table>
                    </center>
                    <br>
                 </td>
              </tr>
              <tr>
                <td colspan="100%" align="center">
                    <table border="0" cellspacing="1" cellpadding="2" width="100%">
                    <%if(contem_grid) {%> 
                      <tr>
                        <td width="4%" bgcolor="#FFFFFF" height="28">&nbsp;</td>
                        <td width="4%" class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("CHAPA")%></div>
                        </td>
                        <td width="20%" class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("NOME")%></div>
                        </td>
                        <td width="12%" class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("CARGO")%></div>
                        </td>
                        <td width="12%" class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("FILIAL")%></div>
                        </td>
                        <td width="12%" class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("DEPARTAMENTO")%></div>
                        </td>    
                        <%if (prm.buscaparam("USE_TB2").equals("S"))
                        {%>
                        <td width="12%" class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("TABELA2")%></div>
                        </td>
            <%}%>
            <%if (prm.buscaparam("USE_TB3").equals("S"))
                        {%>
                        <td width="12%" class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("TABELA3")%></div>
                        </td>
            <%}%>
                        <td width="12%" class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("SOLICITANTE")%></div>
                        </td>
                        
                        <td class="celtittab" height="28"> 
                          <div align="center"><%=trd.Traduz("EMPRESA")%></div>
                        </td>
                        
                        <%
                        //rsgrid.previous();
                       }
                       else{
                        %>
                        </tr>
                        <tr>
                        <td colspan="100%" class="celtittab" align="center" width="100%"> 
                          <%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...
                        </td>
                        <%
                       }
                       }
                       %> 
                      </tr>
                      

<%               //Faz o loop no nº de vezes da paginaCAo
    for(int i=1 ; i<=pag;i++){
        if(contem_grid){
            if (rsgrid.next()) {
                valor = valor + 1;
                String queryC = "SELECT EMP_NOME FROM EMPRESA WHERE EMP_CODIGO = "+rsgrid.getString(12);
                rsC = conexao.executaConsulta(queryC,session.getId()+"RS_7");
                %>
                <tr class="celnortab"> 
                <%
                String teste = "";
                if(rsgrid.getString(11) != null)
                    teste = rsgrid.getString(11);
                if(rsgrid.getString(10).equals("S")){//demitido
                    %>
                    <td width="4%"></td>
                    <td width="4%"><div align="center"><%=((rsgrid.getString(2)==null)?"":rsgrid.getString(2))%></div></font></td>
                    <td width="20%">**<%=((rsgrid.getString(3)==null)?"":rsgrid.getString(3))%></font></td>
                    <td width="12%"><%=((rsgrid.getString(4)==null)?"":rsgrid.getString(4))%></font></td>
                    <td width="12%"><%=((rsgrid.getString(8)==null)?"":rsgrid.getString(8))%></font></td>
                    <td width="12%"><%=((rsgrid.getString(5)==null)?"":rsgrid.getString(5))%></font></td>
                    <%
                    if (prm.buscaparam("USE_TB2").equals("S")){
                        %>
                        <td width="12%"><%=((rsgrid.getString(7)==null)?"":rsgrid.getString(7))%></font></td>
                        <%
                    }
                    if (prm.buscaparam("USE_TB3").equals("S")){
                        %>
                        <td width="12%"><%=((rsgrid.getString(6)==null)?"":rsgrid.getString(6))%></font></td>
                        <%
                        }
                        %>
                    <td width="12%"><%=((rsgrid.getString(9)==null)?"":rsgrid.getString(9))%></font></td>
                    <%if (rsC.next()){%>
                          <td width="12%"><%=((rsC.getString(1)==null)?"":rsC.getString(1))%></font></td>
                    <%}else{%>
                          <td width="12%"></font></td>
                    <%}%>
                <%
                }
              else if(teste.equals("S")){//terceiro
                    cont_terceiro++;
                    if(mostraCheck){ 
                    qtde_terceiro++;
                        if (!funcvet.contains(rsgrid.getString(1))){
                            %>
                            <td width="4%">
                            <input type="checkbox" name="checkbox<%=cont%>"  value="<%=rsgrid.getString(1)%>">
                            <%
                        }//fim do if
                        else{
                            %>
                            <td width="4%">
                            <input type="checkbox" name="checkbox<%=cont%>"  value="<%=rsgrid.getString(1)%>" checked>
                            <%                                    
                            funcvet.remove(rsgrid.getString(1));
                        }//fimdo else
                    }//fim do if principal
                    else{
                        %>
                        &nbsp;
                        <%
                        }%>
                    </td>
                    <td width="4%"><div align="center"><%=((rsgrid.getString(2)==null)?"":rsgrid.getString(2))%></div></font></td>                          
                    <td width="20%">*<%=((rsgrid.getString(3)==null)?"":rsgrid.getString(3))%></font></td>
                    <td width="12%"><%=((rsgrid.getString(4)==null)?"":rsgrid.getString(4))%></font></td>
                    <td width="12%"><%=((rsgrid.getString(8)==null)?"":rsgrid.getString(8))%></font></td>
                    <td width="12%"><%=((rsgrid.getString(5)==null)?"":rsgrid.getString(5))%></font></td>
                    <%
                    if (prm.buscaparam("USE_TB2").equals("S")){
                        %>
                        <td width="12%"><%=((rsgrid.getString(7)==null)?"":rsgrid.getString(7))%></font></td>
                        <%
                    }
                    if (prm.buscaparam("USE_TB3").equals("S")){
                        %>
                        <td width="12%"><%=((rsgrid.getString(6)==null)?"":rsgrid.getString(6))%></font></td>
                        <%
                    }
                    %>
                    <td width="12%"><%=((rsgrid.getString(9)==null)?"":rsgrid.getString(9))%></font></td>
                    <%if (rsC.next()){%>
                          <td width="12%"><%=((rsC.getString(1)==null)?"":rsC.getString(1))%></font></td>
                    <%}else{%>
                          <td width="12%"></font></td>
                    <%}%>
                    <%
                    cont = cont+1;  
                }//fim do else maior 
            else{//ativos
                %>
                <td width="4%"></td>
                <td width="4%"><div align="center"><%=((rsgrid.getString(2)==null)?"":rsgrid.getString(2))%></div></td>                                                   
                <td width="20%"><%=((rsgrid.getString(3)==null)?"":rsgrid.getString(3))%></font></td>
                <td width="12%"><%=((rsgrid.getString(4)==null)?"":rsgrid.getString(4))%></font></td>
                <td width="12%"><%=((rsgrid.getString(8)==null)?"":rsgrid.getString(8))%></font></td>
                <td width="12%"><%=((rsgrid.getString(5)==null)?"":rsgrid.getString(5))%></font></td>
                <%
                if (prm.buscaparam("USE_TB2").equals("S")){
                    %>
                    <td width="12%"><%=((rsgrid.getString(7)==null)?"":rsgrid.getString(7))%></font></td>
                    <%
                }
                if (prm.buscaparam("USE_TB3").equals("S")){
                    %>
                    <td width="12%"><%=((rsgrid.getString(6)==null)?"":rsgrid.getString(6))%></font></td>
                    <%
                }
                %>
                <td width="12%"><%=((rsgrid.getString(9)==null)?"":rsgrid.getString(9))%></font></td>
                <%if (rsC.next()){%>
                    <td width="12%"><%=((rsC.getString(1)==null)?"":rsC.getString(1))%></font></td>
                <%}else{%>
                    <td width="12%"></font></td>
                <%}%>
                <%
              }//fim do else
              %>
              </tr>
              <%
            }
          }
        }
        %>
                    
                  </table>
                  </td>
              </tr>
              <tr> 
                <td height="30" colspan="3" align="center"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="5">
                    <tr>
                        <td align="left" class="ctfontc" width="16%"><%=trd.Traduz("PAGINA")%> 
                          <b><%=pagatual%></b> <%=trd.Traduz("DE")%> <b><%=pagtotal%></b></td>
                        <td align="right" class="ctfontc" width="16%"><%=trd.Traduz("Total de")%> 
                          <b><%=tot%></b> <%=trd.Traduz("PESSOAS")%></td>
                          <input type="hidden" name="pagtotal" value="<%=pagtotal%>">
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td class="cthdivb" colspan="3" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                <td height="30" colspan="3" class="ctfundo"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="9">
                    <tr> 
          <input type="hidden" name="p">
          <input type="hidden" name="i">
          <input type="hidden" name="extra">
                      <td class="ctfontc" width="17%"> <a href="#" onClick = "PrimeiraPag();" class="ctoflnkb"><%=trd.Traduz("Primeira PAgina")%></a></td>
<%                    if(pagatual > 1){%>
                        <td class="ctfontc" width="17%"><a href="#" value = "<%=valorAnt%>" onClick = "return AnteriorPag(this);" class="ctoflnkb"><%=trd.Traduz("PAgina Anterior")%></a></td> 
      <td class="ctfontc" width="17%"><a><%=trd.Traduz("PAGINA")%> <input type="text" name="textir2" size="3" onKeyDown="FormataCampo1(this, window.event.keyCode,'down')" onKeyUp="FormataCampo1(this, window.event.keyCode,'up')">
                          <input type="button" name="ir2" class="botcin" value="  <%=trd.Traduz("IR")%>  " onClick="return irpag2();"> </a>
                        </td>
<%                    }else{%>
                        <td class="ctfontc" width="17%"><a><%=trd.Traduz("PAgina Anterior")%></a></td>
                        <td class="ctfontc" width="17%"><a><%=trd.Traduz("PAGINA")%> <input type="text" name="textir" size="3" onKeyDown="FormataCampo1(this, window.event.keyCode,'down')" onKeyUp="FormataCampo1(this, window.event.keyCode,'up')">
                          <input type="button" name="ir" class="botcin" value="  <%=trd.Traduz("IR")%>  " onClick="return irpag();"> </a>
                        </td>
<%                    }
                       if (pagatual < pagtotal){%>
                        <td align="right" class="ctfontc" width="17%"><a href="#" value = "<%=valor%>"  onClick = "return ProximaPag(this);" class="ctoflnkb"><%=trd.Traduz("PrOxima PAgina")%></a></td>
<%                     } else {%>
                        <td align="right" class="ctfontc" width="17%"><a><%=trd.Traduz("PrOxima PAgina")%></a></td>
<%                     }%>
                      <td align="right" class="ctfontc" width="16%"><a href="#" name="valor" value = "<%=((pagtotal*pag)-(pag-1))%>" onClick = "return ProximaPag(this);" class="ctoflnkb"><%=trd.Traduz("Ultima PAgina")%></a></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>

            <input type="hidden" name="contador" value="<%=pag%>">
            <input type="hidden" name="origem" value="result_filtro">
            <input type="hidden" name="tipo_operacao">
            <input type="hidden" name="rdo_valor" value="">
            <input type="hidden" name="altera_func">
            <input type="hidden" name="cont" value="<%=cont%>">
            <input type="hidden" name="apagavet" value="N">
            <input type="hidden" name="qtde_chk" value="F">
            <input type="hidden" name="cont_terceiro" value="<%=cont_terceiro%>">
          </FORM>
          </td>
          <td width="20" valign="top"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  <tr> 
    <td align="right" height="30" class="difundo" colspan="100%"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="100%"> 
          <%if(ponto.equals("..")){%>
            <jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include>
            <%}else{%>
            <jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>
            <%}%>
        
    </td>
  </tr>
</table>
<!--<script language="JavaScript1.2" src="..\jsscript\HM_Loader.js" type='text/JavaScript'></script>-->
</body>
</html>

<%
session.setAttribute("funcs",funcvet);

if(rsC!=null){
rsC.close();
conexao.finalizaConexao(session.getId()+"RS_7");
}

if(rsgrid!=null){
rsgrid.close();
conexao.finalizaConexao(session.getId()+"PAG");
}

if(rsc!=null){
rsc.close();
conexao.finalizaConexao(session.getId()+"RS_1");
}


/**
if(rs != null)
  rs.close();
conexao.finalizaConexao();

if(conn != null)
  conn.close();

conexaogrid.finalizaConexao();
conexaogrid.finalizaBD();

conexaoc.finalizaConexao();
conexaoc.finalizaBD();

conexaouni.finalizaConexao();
conexaouni.finalizaBD();

conexaodir.finalizaConexao();
conexaodir.finalizaBD();

conexaocel.finalizaConexao();
conexaocel.finalizaBD();

conexaotim.finalizaConexao();
conexaotim.finalizaBD();
*/
%>
<%
//}catch(Exception t){out.println(""+t);}
%>