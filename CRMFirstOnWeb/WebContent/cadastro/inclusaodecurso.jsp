
<%
    response.setHeader("Pragma", "no-cache");
    if (request.getProtocol().equals("HTTP/1.1")){
    response.setHeader("Cache-Control", "no-cache");
  }
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.lang.Math.*, java.util.*, java.text.*"%>


<%
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi");
Integer usu_cod = (Integer)session.getAttribute("usu_cod");

ResultSet rs = null, rsAlt = null, rsZ = null, rs2 = null, rsf = null, rsA = null, rsQ = null, rsI = null, hs = null, rsC = null,rsf1 = null;

//try{
//Pega o tipo de cadastro (inclusAo ou alteraCAo) e o codigo da CompetEncia
String tipo2 = "", cod2 = "1", reload = "", replica = "", ativo = "", titulo = "", entidade = "", desenv = "";

String replicado = "", queryZ = "", altera = "", ava_codigo = "", que_codigo = "", query = "";
String envio = "", vencimento = "", porcentagem = "";

String tipoOperacao = "", query2 = "";
int cont_aval = 0;
int index = 0;

Vector vetAvaliacao = new Vector();
Vector vetEnvio = new Vector();
Vector vetVencimento = new Vector();
Vector vetAmostra = new Vector();

//limpa vetores
if (request.getParameter("apagavetor") == null){
  session.setAttribute("vetor_avaliacao", vetAvaliacao);
  session.setAttribute("vetor_envio", vetEnvio);
  session.setAttribute("vetor_vencimento", vetVencimento);
  session.setAttribute("vetor_amostra", vetAmostra);
}
else{
  vetAvaliacao = (Vector)session.getAttribute("vetor_avaliacao");
  vetEnvio      = (Vector)session.getAttribute("vetor_envio");
  vetVencimento = (Vector)session.getAttribute("vetor_vencimento");
  vetAmostra    = (Vector)session.getAttribute("vetor_amostra");
}

if (request.getParameter("tipo_op") != null){
  tipoOperacao = request.getParameter("tipo_op");
  if (tipoOperacao.equals("IA")){
    if(!vetAvaliacao.contains(request.getParameter("sel_quest")))
      vetAvaliacao.add(request.getParameter("sel_quest"));
  }
  if (tipoOperacao.equals("EA")){
        int qtde = Integer.parseInt(request.getParameter("c_avaliacao"));
        for (int ii=0; ii<=qtde; ii++){
            if (request.getParameter("chk_avaliacao"+ii) != null){
              index = vetAvaliacao.indexOf((String)request.getParameter("chk_avaliacao"+ii));
              vetAvaliacao.removeElement((String)request.getParameter("chk_avaliacao"+ii));
              vetEnvio.remove(index);
              vetVencimento.remove(index);
              vetAmostra.remove(index);
            }
        }
    }
}

if(request.getParameter("replicado2") != null)
  replicado = request.getParameter("replicado2");
if(request.getParameter("altera2") != null)
  altera = request.getParameter("altera2");
if (!(request.getParameter("tipo") == null))
  tipo2 = request.getParameter("tipo");
if (!(request.getParameter("cod") == null))
  cod2 = request.getParameter("cod");
if (!(request.getParameter("reload2") == null))
  reload = request.getParameter("reload2");
if (!(request.getParameter("check") == null))
  replica = request.getParameter("check");
if(!(request.getParameter("ativo5") == null))
  ativo = request.getParameter("ativo5");
if(!(request.getParameter("sel_desenv") == null))
  desenv = request.getParameter("sel_desenv");
if(!(request.getParameter("sel_titulo") == null))
  titulo = request.getParameter("sel_titulo");
if(!(request.getParameter("sel_entidade") == null))
  entidade = request.getParameter("sel_entidade");
if(!(request.getParameter("sel_aval") == null))
  ava_codigo = request.getParameter("sel_aval");


//*************** PEGA O TAMANHO DOS CAMPOS ***************
int tam_nome = 0, tam_publalvo = 0, tam_programa = 0,  tam_consideracoes = 0, tam_objetivo = 0;
query = "select length Coluna from syscolumns where name = 'cur_nome'";
rs = conexao.executaConsulta(query,session.getId()+"RS_1");    
if(rs.next()) 
  tam_nome = rs.getInt(1);
conexao.finalizaConexao(session.getId()+"RS_1");
query = "select length Coluna from syscolumns where name = 'cur_publalvo'";
rs = conexao.executaConsulta(query,session.getId()+"RS_1");    
if(rs.next()) 
  tam_publalvo = rs.getInt(1);
conexao.finalizaConexao(session.getId()+"RS_1");
query = "select length Coluna from syscolumns where name = 'cur_programa'";
rs = conexao.executaConsulta(query,session.getId()+"RS_1");    
if(rs.next()) 
  tam_programa = rs.getInt(1);
conexao.finalizaConexao(session.getId()+"RS_1");
query = "select length Coluna from syscolumns where name = 'cur_consideracoes'";
rs = conexao.executaConsulta(query,session.getId()+"RS_1");    
if(rs.next()) 
  tam_consideracoes = rs.getInt(1);
conexao.finalizaConexao(session.getId()+"RS_1");
query = "select length Coluna from syscolumns where name = 'cur_objetivo'";
rs = conexao.executaConsulta(query,session.getId()+"RS_1");    
if(rs.next()) 
  tam_objetivo = rs.getInt(1);
conexao.finalizaConexao(session.getId()+"RS_1");
//*************** PEGA O TAMANHO DOS CAMPOS ***************

//Se for alteracao faz a query 

query = "SELECT C.SAR_CODIGO, C.CUR_CODIGO, C.CUR_NOME, C.DES_CODIGO, C.TIT_CODIGO,  " +           
    " C.CUR_DURACAO, C.CUR_CUSTO, C.CUR_PUBLALVO, C.CUR_CAMPO1, C.CUR_CAMPO2, C.CUR_CAMPO3, C.CUR_CAMPO4, " +  
    " C.CUR_SIMPLES, C.TCU_CODIGO, C.CUR_PROGRAMA, C.CUR_CONSIDERACOES, C.CUR_OBJETIVO, C.CUR_ATIVO, " + 
    " C.CUR_DATACADASTRO, C.CUR_AVALIAEFICACIA , C.CUR_COMOAVALIAR, C.CUR_CUSTO2, C.CUR_VERSAOATUAL, " + 
    " C.CUR_PERIODOREALIZACAO, C.EMP_CODIGO, C.FUN_CODIGO_RESP, C.CUR_MAXPART, C.CUR_MINPART, T.TCU_NOME "+
    "FROM CURSO C, TIPOCURSO T " + 
    "WHERE CUR_CODIGO = " + cod2 + " "+
    "AND C.TCU_CODIGO = T.TCU_CODIGO "+
    "ORDER BY CUR_NOME";     

rsAlt = conexao.executaConsulta(query,session.getId()+"RS_2");    
if (rsAlt.next()){}
        
int qtd_comp = 0, i = 0, a = 0;

Vector vet_comp = new Vector();
  
if(vet_comp.size()!=0)
  vet_comp.clear();

if((Vector)session.getAttribute("vet_compS") != null)
  vet_comp = (Vector)session.getAttribute("vet_compS");


if(request.getParameter("sel_competencia") != null){
  if(!(request.getParameter("sel_competencia").equals(""))){
    if(!(vet_comp.contains(request.getParameter("sel_competencia")))){
      vet_comp.addElement(request.getParameter("sel_competencia"));
    }
  }
}

int f = 0;
String fail = "";
if(replica.equals("1")){
  do{
    vet_comp.removeElement(replicado);
    f++;
  }while(f<=vet_comp.size());

  //out.println("Vetor: "+vet_comp);

  query = "SELECT TIT_CODCLI FROM TITULO WHERE TIT_CODIGO = "+request.getParameter("sel_titulo");
  rsf = conexao.executaConsulta(query,session.getId()+"RS_3");
  if(rsf.next()){
    query = "SELECT CMP_DESCRICAO FROM COMPETENCIA WHERE CMP_CODIGO = "+rsf.getString(1);
    rsf1 = conexao.executaConsulta(query,session.getId()+"RS_4");
    if(rsf1.next()){
      if(!vet_comp.contains(rsf1.getString(1))){
        vet_comp.addElement(rsf1.getString(1));
        replicado = rsf1.getString(1);
      }
      else{
        replicado = rsf1.getString(1);
      }
    }
    else{
      replica = "";
      %>
      <script language="JavaScript">
      alert(<%=("\""+("ESTA COMPETENCIA NAO PODE SER ASSOCIADA")+"\"")%>);
      </script>
      <%
    }
    if(rsf!=null){
    conexao.finalizaConexao(session.getId()+"RS_3");
    }
    if(rsf1!=null){
    conexao.finalizaConexao(session.getId()+"RS_4");
    }
  }
}
else{
  do{
    if(!altera.equals("1")){
      if(vet_comp.contains(replicado)){
        vet_comp.removeElement(replicado);
        replicado = "";
      }
    }
    f++;
  }while(f<=vet_comp.size());

}

request.getSession(true);
session.setAttribute("vet_compS",vet_comp);

String moeda = prm.buscaparam("MOEDA"); //Simbolo da moeda do SO

%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("CADASTRO")%> - 
<%
if(tipo2.equals("I")){
  %>
  <%=trd.Traduz("INCLUSAO DE CURSO")%></title>
  <%
}
else{
  %>
  <%=trd.Traduz("ALTERACAO DE CURSO")%></title>
  <%
}
%>

<script language="JavaScript">

function formataReal(campo){
  campo.value = campo.value * 1.00;
}

function envia(){
  if(document.frm.sel_desenv.value == "0"){
    alert(<%=("\""+trd.Traduz("SELECIONE A ALTERNATIVA DE DESENVOLVIMENTO")+"\"")%>);
    frm.sel_desenv.focus();
    return false;
  }
  if(document.frm.sel_entidade.value == "0"){
    alert(<%=("\""+trd.Traduz("SELECIONE A ENTIDADE")+"\"")%>);
    frm.sel_entidade.focus();
    return false;
  }
  

  if(document.frm.sel_titulo.value == "0"){
    alert(<%=("\""+trd.Traduz("SELECIONE O TITULO")+"\"")%>);
    frm.sel_titulo.focus();
    return false;
  }

  
  
  if(<%=("\""+prm.buscaparam("USE_SARATOGA")+"\"")%> == "S"){
    if(document.frm.sel_saratoga.value == "0"){
    alert(<%=("\""+trd.Traduz("SELECIONE A CLASSIFICACAO SARATOGA")+"\"")%>);
    frm.sel_saratoga.focus();
    return false;
    }
  }
  
  if(document.frm.sel_tipo.value == "0"){
    alert(<%=("\""+trd.Traduz("SELECIONE O TIPO")+"\"")%>);
    frm.sel_tipo.focus();
    return false;
  }
  if(document.frm.tf_nome.value == ""){
    alert(<%=("\""+trd.Traduz("DIGITE O NOME COMERCIAL")+"\"")%>);
    frm.tf_nome.focus();
    return false;
  }
  if(document.frm.tf_custo.value == ""){
    alert(<%=("\""+trd.Traduz("DIGITE O CUSTO")+"\"")%>);
    frm.tf_custo.focus();
    return false;
  }
  if(document.frm.tf_custol.value == ""){
    alert(<%=("\""+trd.Traduz("DIGITE O CUSTO LOGISTICA")+"\"")%>);
    frm.tf_custol.focus();
    return false;
  }
  if((document.frm.tf_duracao.value == "") || (document.frm.tf_duracao_min.value == "")){
    alert(<%=("\""+trd.Traduz("DIGITE A DURACAO")+"\"")%>);
    frm.tf_duracao.focus();
    return false;
  }
  
  if(document.frm.tf_duracao_min.value >= "60"){
    alert(<%=("\""+trd.Traduz("VALOR INVALIDO PARA O CAMPO MINUTO")+"\"")%>);
    frm.tf_duracao_min.focus();
    return false;
  }
  
  if(document.frm.tf_versao.value == ""){
    alert(<%=("\""+trd.Traduz("DIGITE A VERSAO ATUAL")+"\"")%>);
    frm.tf_versao.focus();
    return false;
  }
  if(document.frm.sel_resp.value == "0"){
    alert(<%=("\""+trd.Traduz("SELECIONE O RESPONSAVEL")+"\"")%>);
    frm.sel_resp.focus();
    return false;
  }
  
  if(document.frm.tf_maxpart.value == ""){
    alert(<%=("\""+trd.Traduz("DIGITE O NUMERO MAXIMO DE PARTICIPANTES")+"\"")%>);
    frm.tf_maxpart.focus();
    return false;
  }
  if(document.frm.tf_minpart.value == ""){
    alert(<%=("\""+trd.Traduz("DIGITE O NUM. MINIMO DE PARTICIPANTES")+"\"")%>);
    frm.tf_minpart.focus();
    return false;
  }
  else{
    frm.submit();
    return false; 
  }
}

function cancela(){
  window.open("cursos.jsp","_self");
}

function insere(){
  if(frm.sel_competencia.value == ""){
    alert(<%=("\""+trd.Traduz("ESCOLHA UMA COMPETENCIA")+"\"")%>);
    return false;
  }
  else{
    if(frm.use_replica.value == "1"){
      if(frm.check.checked == true){
        frm.action="inclusaodecurso.jsp";
        frm.reload2.value = "1";
        frm.check.value = "1";
        frm.submit();
      }
      else{
        frm.action="inclusaodecurso.jsp";
        //frm.altera2 = "1";
        frm.reload2.value = "1";
        frm.submit();
      }
    }
    else{
      frm.action="inclusaodecurso.jsp";
      //frm.altera2 = "1";
      frm.reload2.value = "1";
      frm.submit();
    }
  }
}

function deleta(){
  var conta=0;
  for(i=0;i<frm.cont.value;i++){
    if(eval("frm.cb_"+i+".value" != "")){
      if(eval("frm.cb_"+i+".checked")==true){
        conta = conta + 1;
      }
    }
    
  }
  if(conta==0){
    alert(<%=("\""+trd.Traduz("NENHUM ITEM SELECIONADO")+"\"")%>);
    return false;
  }
  else{
    if(confirm(<%=("\""+trd.Traduz("DESEJA EXCLUIR O ITEM SELECIONADO?")+"\"")%>)){
      if(frm.check.checked == true){
        frm.action="deleta_comp.jsp";
        frm.check.value = "1";
        frm.submit();
        return true;
      }
      else{
        frm.action="deleta_comp.jsp";
        frm.submit();
        return true;
      }
    }
    else
      return false;
  }
}

function desativa(){
  if(frm.ativo.checked==false){
    frm.ativo5.value="of";
  }
  else{
    frm.ativo5.value="on";
  }
  return true;
}

function replica(){
  if(frm.use_replica.value == "1"){
    if(frm.check.checked==true){
      if(!(frm.sel_titulo.value == 0)){
        frm.check.value = "1";
        frm.reload2.value = "1";
        frm.action="inclusaodecurso.jsp";
        frm.submit();
        return true;
      }
      else{
        alert(<%=("\""+trd.Traduz("SELECIONE UMA COMPETENCIA")+"\"")%>);
        frm.check.checked = false;
      }
    }
    else{
      frm.check.value = "0";
      frm.reload2.value = "1";
      frm.action = "inclusaodecurso.jsp";
      frm.submit();
      return true;
    }
  }
  else{
    frm.check.value = "0";
    frm.reload2.value = "1";
    frm.action = "inclusaodecurso.jsp";
    frm.submit();
    return true;
  }
}

function aspa(campo, tam_limite){
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
  if(tam == tam_limite){
    aux = campo.value;
    aux = aux.length;
    aux = aux - 1;
    pal = campo.value;
    campo.value = pal.substring(0, aux);
  }
}

function aspa2(campo, tam_limite){
  aux = campo.value;
  tam = aux.length;
  aux2 = aux.substring(tam-1,tam);
  //verifica o tamanho da string//  
  if(tam >= tam_limite){
    alert("ESTE CAMPO DEVE CONTER, NO MAXIMO, "+tam_limite+" CARACTERES.");
    campo.focus(); 
  }
    /////////////////////////////////

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

function custo(campo){
  aux = campo.value;
  tam = aux.length
  aux2 = aux.substring(tam-1,tam);
  if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" &&
     aux2 != "4" && aux2 != "5" && aux2 != "6" && aux2 != "7" &&
     aux2 != "8" && aux2 != "9" && aux2 != ","){
    aux = campo.value;
    aux = aux.length;
    aux = aux - 1;
    pal = campo.value;
    campo.value = pal.substring(0, aux);
  }
}

function custo2(campo){
  aux = campo.value;
  tam = aux.length;
  k = 0;
  v = 0;
  if(tam == 1){
    aux2 = aux.substring(tam-1,tam);
    if(aux2 == ","){
      campo.value = "";
    }
  }
  while(tam>0){
    aux2 = aux.substring(tam-1,tam);
    if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" &&
       aux2 != "4" && aux2 != "5" && aux2 != "6" && aux2 != "7" &&
       aux2 != "8" && aux2 != "9" && aux2 != ","){
      k = k+1;
    }
    if(aux2 == ","){
      v = v + 1;
    }
    tam--;
  }
  if(k != 0 || v > 1){
    alert(<%=("\""+trd.Traduz("FORMATO INVALIDO")+"\"")%>);
    campo.value = "";
    campo.focus();
  }
}

function numero(campo){
  aux = campo.value;
  tam = aux.length
  aux2 = aux.substring(tam-1,tam);
  if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" && aux2 != "4" &&
     aux2 != "5" && aux2 != "6" && aux2 != "7" && aux2 != "8" && aux2 != "9"){
    aux = campo.value;
    aux = aux.length;
    aux = aux - 1;
    pal = campo.value;
    campo.value = pal.substring(0, aux);
  }
}

function numero2(campo){
  aux = campo.value;
  tam = aux.length;
  k = 0;
  while(tam>0){
    aux2 = aux.substring(tam-1,tam);
    if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" && aux2 != "4" &&
       aux2 != "5" && aux2 != "6" && aux2 != "7" && aux2 != "8" && aux2 != "9"){
      k = k+1;
    }
    tam--;
  }
  if(k != 0){
    alert(<%=("\""+trd.Traduz("ESTE CAMPO POSSUI CARACTER NAO PERMITIDO")+"\"")%>);
    campo.value = "";
    campo.focus();
  }
}


function quest(){
    frm.action = "inclusaodecurso.jsp";
    frm.reload2.value="1";
  if(frm.check.checked == true){
    frm.check.value = "1";
  }
    //frm.tipo_op.value = "IA";
    frm.submit();
    return true;
}

function insere2(){
  if (frm.sel_quest.value == ""){
    alert(<%=("\""+trd.Traduz("FAVOR SELECIONAR UM QUESTIONARIO")+"\"")%>);
    return false;
    }
    else{
      var ret = showModalDialog("incluidadosavaliacao.jsp?que="+frm.sel_quest.value,"","center=yes;status=no;scroll=no;dialogWidth=300px;dialogHeight=270px");
      if(ret == 2){
        frm.apagavetor.value = "N";
        frm.tipo_op.value = "IA";
        frm.reload2.value="1";
        if(frm.check.checked == true){
          frm.check.value = "1";
        }
        frm.action = "inclusaodecurso.jsp";
        frm.submit();
        return true;
      }
      else{
        return false;
      }
    }
}

function exclui2(){
  var teste = 0;
  for(i=1;i<=frm.c_avaliacao.value;i++){
    if(eval("frm.chk_avaliacao"+i+".checked")==true){
      teste = teste+1;
    }
  }
  if(teste == 0){
    alert(<%=("\""+trd.Traduz("NENHUM ITEM SELECIONADO")+"\"")%>);
    return false;
  }
  else{
    if(confirm("DESEJA EXCLUIR O ITEM SELECIONADO?")){
      frm.tipo_op.value = "EA";
      frm.reload2.value="1";
        if(frm.check.checked == true){
          frm.check.value = "1";
        }
      frm.action = "inclusaodecurso.jsp";
      frm.submit();
      return true;
    }
    else
      return false;
  }
}

function descreve(){
  if(frm.sel_saratoga.value == "0"){
    alert("ESCOLHA UMA SARATOGA");
    return false;
  }
  else{
    showModalDialog("descricao_saratoga.jsp?sar_codigo="+frm.sel_saratoga.value,"","center=yes;status=no;dialogWidth=500px;dialogHeight=300px");
  }
}
</script>
<script language="JavaScript" src="/js/scripts.js"></script>

<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<%!
public String ReaistoStr(float valor){
  DecimalFormat dcf = new DecimalFormat("0.00");
  dcf.setMaximumFractionDigits(2);
  String strReais = dcf.format(valor);
  return strReais;
}
%>

<%! public String durhora(float valor){
  int ho = 0;
  Float h;
  h = new Float(valor);;
  ho = h.intValue();
  ho = ho / 60;
  String hora = "";
  hora = hora.valueOf(ho);
  return hora;
}
%>

<%! public String durmin(float valor){
  int mi =0;
  Float m;
  m = new Float(valor);
  mi = m.intValue();
  mi = mi % 60;
  String min = "";
  if(mi < 10){
    min = "0"+min.valueOf(mi);
  }
  else{
    min = min.valueOf(mi);
  }
  return min;
}
%>

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
             oia = "../menu/menu1.jsp?opt="+"CU";
      } 
      else 
      {  
             oia = "../menu/menu1.jsp?opt="+request.getParameter("opt");
      }
      }else{
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
                   oia = "/menu/menu1.jsp?opt="+"CU";
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
                <td class="trontrk">
                <%
                if(tipo2.equals("I")){
                  %><%=trd.Traduz("INCLUSAO DE CURSO")%><%
                }
                else{
                  %><%=trd.Traduz("ALTERACAO DE CURSO")%><%
                }
                %>
                </td>
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
      <FORM name="frm" action="cursograva.jsp" method="POST">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1">&nbsp;<br><center>
                <table border="0" cellspacing="2" cellpadding="3" width="98%">
                  <tr class="celnortab"> 
                    <td width="34%" colspan="3"><%=trd.Traduz("ALTERNATIVA DE DESENVOLVIMENTO")%><br>
                      <select name="sel_desenv">
                        <option value="0">Selecione</option>
                        <%
        
        query = "SELECT DES_CODIGO, DES_DESCRICAO FROM DESENVOLVIMENTO ORDER BY DES_DESCRICAO";
        rs = conexao.executaConsulta(query,session.getId()+"RS_5");
    
        if (rs.next()){
          do{
            if (tipo2.equals("I")){
              if((desenv != null)&&(desenv.equals(rs.getString(1)))){
                %>
                                  <option selected value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                  <%
                                }
                                else{
                %>
                                  <option value=<%=((rs.getString(1).equals(null))?0:rs.getInt(1))%>><%=rs.getString(2)%></option>
                                  <%
                                }
            }
            else{
              if(!(reload.equals("1"))){
                if(rs.getInt(1) == rsAlt.getInt(4)){
                  %>
                                    <option selected value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                    <%
                }
                else{
                  %>
                                    <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                    <% 
                }
              }
              else{
                if(rs.getString(1).equals(desenv)){
                  %>
                                    <option selected value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                    <%
                }
                else{
                  %>
                                    <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                    <% 
                }
              }

            } 
          }while(rs.next());
          if(rs!=null){
            conexao.finalizaConexao(session.getId()+"RS_5");
            }
        }
        %>
                      </select>
                    </td>
                    <td colspan="3"><%=trd.Traduz("ENTIDADE")%><br>
                      <select name="sel_entidade">
                        <option value="0">Selecione</option>
                        <%
      query = "SELECT EMP_CODIGO, EMP_NOME FROM EMPRESA where emp_tipo <> 2 ORDER BY EMP_NOME";
      rs = conexao.executaConsulta(query,session.getId()+"RS_6");
    
      if (rs.next()){
        do{
          if (tipo2.equals("I")){
            if((entidade != null)&&(entidade.equals(rs.getString(1)))){
              %>
                                <option selected value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                <%
                              }
                              else{
              %>
                                <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                <%
                              }
          }
          else{
            if(!(reload.equals("1"))){
              if(rs.getInt(1) == (rsAlt.getInt(25))){
                %>
                                  <option selected value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                  <%                      
                                }
              else{
                %>
                                  <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                  <% 
              }
            }
            else{
              if(rs.getString(1).equals(entidade)){
                %>
                                  <option selected value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                  <%                      
                                }
              else{
                %>
                                  <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                  <% 
              }
            }
          } 
        }while(rs.next());
        if(rs!=null){
          conexao.finalizaConexao(session.getId()+"RS_6") ;
        }    
      }
      %>
                      </select>
                    </td>
                    </tr>
                    <tr class="celnortab">
                    <td colspan="6"><%=trd.Traduz("TITULO")%><br>
                      <%
                      if(replica.equals("1")){
                        %>
                        <select name="sel_titulo" OnChange="return replica();">
                        <%
                      }
                      else{
                        %>
                        <select name="sel_titulo">
                        <%
                      }
                      %>
                        <option value="0">Selecione</option>
                        <%
      query = "SELECT TIT_CODIGO, TIT_NOME, TIT_CODCLI FROM TITULO ORDER BY TIT_NOME";
      rs = conexao.executaConsulta(query, session.getId()+"RS_7");
      if (rs.next()){
        do{
          if (tipo2.equals("I")){
            if((titulo != "")&&(titulo.equals(rs.getString(1)))){
              %>
                                <option selected value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                <%
                              }
                              else if(replicado.equals(rs.getString(2))){
              %>
                                <option selected value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                <%
                              }
                              else{
              %>
                                <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                                <%
                              }
                              
          }
          else{
            if(titulo.equals("")){
              if(rs.getString(1).equals(rsAlt.getString(5))){
                %>
                <option selected value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
                <%
                queryZ = "SELECT CMP_DESCRICAO FROM COMPETENCIA WHERE CMP_CODIGO = "+rs.getString(3);
                rsZ = conexao.executaConsulta(queryZ, session.getId()+"RS_8");
                if(rsZ.next()){
                                    //vet_comp.removeElement(replicado);
                                    replicado = rs.getString(2);
                                  }
                }
              else{
                %>
                                  <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
                                  <% 
              }
              if(rsZ!=null){
                conexao.finalizaConexao(session.getId()+"RS_8");
                }
            }
            else{
              if(rs.getString(1).equals(titulo)){
                %>
                                  <option selected value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
                                  <%
                queryZ = "SELECT CMP_DESCRICAO FROM COMPETENCIA WHERE CMP_CODIGO = "+rs.getString(3);
                rsZ = conexao.executaConsulta(queryZ,session.getId()+"RS_8");
                if(rsZ.next()){
                                    //vet_comp.removeElement(replicado);
                                    replicado = rs.getString(2);
                                  }
              }
              else{
                %>
                <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
                                  <% 
              }
                if(rsZ!=null){
                conexao.finalizaConexao(session.getId()+"RS_8");
                }
            }
          } 
        }while(rs.next());
         if(rs!=null){
         conexao.finalizaConexao(session.getId()+"RS_7");
        }   
      }
      %>
            </select>
          <%              
    String use_replica = "";
    if(prm.buscaparam("REPLICA_COMPETENCIA").equals("S")){
      use_replica = "1";
      if(!replica.equals("1")){
        %>
        <input type="checkbox" name="check" OnClick="return replica();">
                          <%
      }
                      else{
        %>
        <input checked type="checkbox" name="check" OnClick="return replica();">
                          <%
      }
      %>
      <%=trd.Traduz("REPLICACAO")%>       
      <% 
    }
    else{
      use_replica = "0";
    }
    %>
    <input type="hidden" name="use_replica" value="<%=use_replica%>">
    </td>
                </tr>
                  
                 <tr class="celnortab">
                  <%
                  if(prm.buscaparam("USE_SARATOGA").equals("S")){
                  
                  %>
                    <td colspan="2"><%=trd.Traduz("CLASSIFICACAO SARATOGA")%><br>
                      <select name="sel_saratoga">
                        <option value="0">Selecione</option>
                        <%
      query = "SELECT SAR_CODIGO, SAR_DESCRICAO FROM SARATOGA ORDER BY SAR_DESCRICAO";
      rs = conexao.executaConsulta(query,session.getId()+"RS_9");
      if (rs.next()){
        do{
          if (tipo2.equals("I")){
            if((request.getParameter("sel_saratoga")!=null)&&(request.getParameter("sel_saratoga").equals(rs.getString(1)))){
              %>
                                <option selected value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                <%  
                              }
                              else{
              %>
                                <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                <%  
                              }
                              
          }
          else{
            if(!(reload.equals("1"))){
              if(rs.getInt(1) == (rsAlt.getInt(1))){
                %>
                                  <option selected value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                  <%
              }
              else{
                %>
                                  <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                  <% 
              }
            }
            else{
              if(rs.getString(1).equals(request.getParameter("sel_saratoga"))){
                %>
                                  <option selected value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                  <%
              }
              else{
                %>
                                  <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                  <% 
              }
            }
          } 
        }while(rs.next());
        if(rs!=null){
        conexao.finalizaConexao(session.getId()+"RS_9");
        }
      }
      %>
        &nbsp;<input type="button" value="DESCRICAO" class="botcin" onClick="return descreve();">
                      </select>
                    </td>
                    <td colspan="2"><%=trd.Traduz("TIPO")%><br>
                    <%
                    }
                    else{
                      %>
                      <td colspan="2"><%=trd.Traduz("TIPO")%><br>
                      <%
                    }
                    %>
                    
                      <select name="sel_tipo">
                        <option value="0">Selecione</option>
                        <%
      query = "SELECT TCU_CODIGO, TCU_NOME FROM TIPOCURSO ORDER BY TCU_NOME";
      rs = conexao.executaConsulta(query,session.getId()+"RS_10");
      if (rs.next()){
        do{
          if (tipo2.equals("I")){
            if((request.getParameter("sel_tipo")!=null)&&(request.getParameter("sel_tipo").equals(rs.getString(1)))){
              %>
                                <option selected value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                  <%
                }
                else{
              %>
                                <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                  <%
                }
          }
          else{
            if(!(reload.equals("1"))){
              if(rs.getInt(1) == (rsAlt.getInt(14))){
                %>
                                  <option selected value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                  <%
              }
              else{
                %>
                                  <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                  <% 
              }
            }
            else{
              if(rs.getString(1).equals(request.getParameter("sel_tipo"))){
                %>
                                  <option selected value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                  <%
              }
              else{
                %>
                                  <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                  <% 
              }
            }
          } 
        }while(rs.next());
        if(rs!=null){
            conexao.finalizaConexao(session.getId()+"RS_10");
        }
      }
      %>
                      </select>
                    </td>
                    <td colspan="2"> 
                      <%
      if (tipo2.equals("I")){
        if(ativo.equals("on")){
          %>
                            <input type="checkbox" checked name="ativo" onClick="return desativa();">
                            <%
                          }
                          else{
          %>
                            <input type="checkbox" name="ativo" onClick="return desativa();">
                            <%
                          }
                          %>
                          <%=trd.Traduz("ATIVO")%>&nbsp; 
                          <%
                        }
      else{
        if(!(reload.equals("1"))){
          if (rsAlt.getString(18).equals("S")){
            %>
                              <input type="checkbox" checked name="ativo">
            <%=trd.Traduz("ATIVO")%>&nbsp; 
                        <%
                      }
          else{
            %>
                              <input type="checkbox" name="ativo">
            <%=trd.Traduz("ATIVO")%>&nbsp; 
            <%
          }
        }
        else{
          if((ativo.equals("on"))||(ativo.equals(""))){
            %>
                              <input type="checkbox" checked name="ativo" onClick="return desativa();">
                              <%
                            }
                            else{
            %>
                              <input type="checkbox" name="ativo" onClick="return desativa();">
                              <%
                            }
                            %>
                            <%=trd.Traduz("ATIVO")%>&nbsp; 
                            <%
        }
      }%>
                    </td>
                  </tr>
                  <tr class="celnortab"> 
                    <td colspan="6"><%=trd.Traduz("NOME COMERCIAL")%><br>
                      <%
      if (tipo2.equals("I")){
        if(request.getParameter("tf_nome")!=null){
          %>
                            <input type="text" name="tf_nome" size="70" value=<%=("\""+request.getParameter("tf_nome")+"\"")%> onBlur="aspa2(this, <%=tam_nome%>)" onKeyUp="aspa(this)">
                            <%
                          }
                          else{
          %>
                            <input type="text" name="tf_nome" size="70" onBlur="aspa2(this, <%=tam_nome%>)" onKeyUp="aspa(this)">
                            <%
                          }
      }
      else{
        if(!(reload.equals("1"))){
          %>
                            <input type="text" name="tf_nome" size="70" maxlength="60" value="<%=rsAlt.getString(3)%>"  onBlur="aspa2(this, <%=tam_nome%>)" onKeyUp="aspa(this)">
                            <%
                          }
                          else{
          %>
                            <input type="text" name="tf_nome" size="70" maxlength="60" value=<%=("\""+request.getParameter("tf_nome")+"\"")%>  onBlur="aspa2(this, <%=tam_nome%>)" onKeyUp="aspa(this)">
                            <%
                          }
      }
      %>
                    </td>
                  </tr>
                  <tr class="celnortab"> 
                    <td colspan="2"><%=trd.Traduz("CUSTO PREVISTO")%> <%=moeda%><br>
                      <%
      if (tipo2.equals("I")){
        if(request.getParameter("tf_custo")!=null){
          %>
                            <input type="text" name="tf_custo" maxlength="8" value=<%=("\""+request.getParameter("tf_custo")+"\"")%> onBlur="custo2(this)" onKeyUp="custo(this)">
                            <%
                          }
                          else{
          %>
                            <input type="text" name="tf_custo" maxlength="8" onBlur="custo2(this)" onKeyUp="custo(this)">
                            <%
                          }
      }
      else{
        if(!(reload.equals("1"))){
          %>
                            <input type="text" name="tf_custo" maxlength="8" value="<%=ReaistoStr(rsAlt.getFloat(7))%>"  onBlur="custo2(this)" onKeyUp="custo(this)">
                            <%
                          }
                          else{
          %>
                            <input type="text" name="tf_custo" maxlength="8" value=<%=("\""+request.getParameter("tf_custo")+"\"")%> onBlur="custo2(this)" onKeyUp="custo(this)">
                            <%
                          }
      }
      %>
                    </td>
                    <td colspan="2"><%=trd.Traduz("CUSTO LOGISTICA PREVISTO")%> <%=moeda%><br>
                      <%
      if (tipo2.equals("I")){
        if(request.getParameter("tf_custol")!=null){
          %>
          <input type="text" name="tf_custol" maxlength="8" value=<%=("\""+request.getParameter("tf_custol")+"\"")%> onBlur="custo2(this)" onKeyUp="custo(this)">
                <%
              }
              else{
          %>
          <input type="text" name="tf_custol" maxlength="8" onBlur="custo2(this)" onKeyUp="custo(this)">
                <%
              }
      }
      else{
        if(!(reload.equals("1"))){
          %>
                      <input type="text" name="tf_custol" maxlength="8" value="<%=ReaistoStr(rsAlt.getFloat(22))%>" onBlur="custo2(this)" onKeyUp="custo(this)">
                            <%
                          }
                          else{
          %>
                      <input type="text" name="tf_custol" maxlength="8" value=<%=("\""+request.getParameter("tf_custol")+"\"")%> onBlur="custo2(this)" onKeyUp="custo(this)">
                            <%
                          }
      }
      %>
                    </td>
                    <td colspan="2"><%=trd.Traduz("DURACAO")%><br>
                      <%
      if (tipo2.equals("I")){
        if(request.getParameter("tf_duracao")!=null){
          %>
                            <input type="text" name="tf_duracao" size="3" value=<%=("\""+request.getParameter("tf_duracao")+"\"")%> maxlength="8" onBlur="numero2(this)" onKeyUp="numero(this)">:
                            <%
                          }
        else{
          %>
                            <input type="text" name="tf_duracao" size="3" onBlur="numero2(this)" onKeyUp="numero(this)" maxlength="8" onBlur="numero2(this)" onKeyUp="numero(this)">:
                            <%
                          }
                          if(request.getParameter("tf_duracao_min")!=null){
                            %>
                            <input type="text" name="tf_duracao_min" maxlength="2" size="2" value=<%=("\""+request.getParameter("tf_duracao_min")+"\"")%> onBlur="numero2(this)" onKeyUp="numero(this)" maxlength="2">
                            hh:mm 
                            <%
                          }
        else{
          %>
                            <input type="text" name="tf_duracao_min" maxlength="2" size="2" onBlur="numero2(this)" onKeyUp="numero(this)" maxlength="2">
                            hh:mm 
                            <%
                          }
      }
      else{
        if(!(reload.equals("1"))){
          %>
                            <input type="text" name="tf_duracao" size="2" value="<%=durhora(rsAlt.getFloat(6))%>" onBlur="numero2(this)" onKeyUp="numero(this)">
                            <input type="text" name="tf_duracao_min" maxlength="2" size="2" value = "<%=durmin(rsAlt.getFloat(6))%>" onBlur="numero2(this)" onKeyUp="numero(this)">
          <%
        }
        else{
          %>
                            <input type="text" name="tf_duracao" size="2" value=<%=("\""+request.getParameter("tf_duracao")+"\"")%> onBlur="numero2(this)" onKeyUp="numero(this)">
                            <input type="text" name="tf_duracao_min" maxlength="2" size="2" value = <%=("\""+request.getParameter("tf_duracao_min")+"\"")%> onBlur="numero2(this)" onKeyUp="numero(this)">
          <%
        }
                          %>
                          hh:mm 
                          <%
      }
      %>
                    </td>
                  </tr>
                  <tr class="celnortab"> 
                    <td colspan="3"><%=trd.Traduz("VERSAO ATUAL")%><br>
                      <%
      if (tipo2.equals("I")){
        if(request.getParameter("tf_versao")!=null){
          %>
          <input type="text" name="tf_versao" maxlength="5" value=<%=("\""+request.getParameter("tf_versao")+"\"")%>  onBlur="aspa2(this)" onKeyUp="aspa(this)">
          <%
        }
        else{
          %>
          <input type="text" name="tf_versao" maxlength="5" onBlur="aspa2(this)" onKeyUp="aspa(this)">
          <%
        }
      }
      else{
        if(!(reload.equals("1"))){
          %>
                            <input type="text" name="tf_versao" maxlength="5" value="<%=rsAlt.getString(23)%>"  onBlur="aspa2(this)" onKeyUp="aspa(this)">
                            <%
                          }
                          else{
          %>
                            <input type="text" name="tf_versao" maxlength="5" value=<%=("\""+request.getParameter("tf_versao")+"\"")%>  onBlur="aspa2(this)" onKeyUp="aspa(this)">
                            <%
                          }
      }
      %>
                    </td>
                    <td colspan="3"><%=trd.Traduz("RESPONSAVEL")%><br>
                      <select name="sel_resp">
                        <option value="0">Selecione</option>
                        <%
      query = "SELECT FUN_CODIGO, FUN_NOME FROM FUNCIONARIO ORDER BY FUN_NOME";
      rs = conexao.executaConsulta(query,session.getId()+"RS_11");
    
      if (rs.next()){
        do{
          if (tipo2.equals("I")){
            if((request.getParameter("sel_resp")!=null) &&(request.getParameter("sel_resp").equals(rs.getString(1)))){
              %>
                                <option selected value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                <%
                              }
                              else{
              if (usu_cod.intValue() == rs.getInt(1)) {%>
                                                            <option selected value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                    <%} else {%>
                                                            <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                                      <%}
                              }
          }
          else{
            if(!reload.equals("1")){
              if(rs.getInt(1) == (rsAlt.getInt(26))){
                %>
                                  <option selected value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                  <%
              }
              else{
                %>
                                  <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                  <% 
              }
            }
            else{
              if(rs.getString(1).equals(request.getParameter("sel_resp"))){
                %>
                                  <option selected value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                  <%
              }
              else{
                %>
                                  <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
                                  <% 
              }
            }
          } 
        }while(rs.next());
        if(rs!=null){
        conexao.finalizaConexao(session.getId()+"RS_11");
        }
      }
      %>
                      </select>
                    </td>
                  </tr>
                  <tr class="celnortab"> 
                    <td colspan="3"><%=trd.Traduz("NUM. MAXIMO DE PARTICIPANTES")%><br>
                      <%
      if (tipo2.equals("I")){
        if(request.getParameter("tf_maxpart")!=null){
          %>
                            <input type="text" name="tf_maxpart" maxlength="9" value=<%=("\""+request.getParameter("tf_maxpart")+"\"")%> onBlur="numero2(this)" onKeyUp="numero(this)">
                            <%
                          }
                          else{
          %>
                            <input type="text" name="tf_maxpart" maxlength="9" onBlur="numero2(this)" onKeyUp="numero(this)">
                            <%
                          }
      }
      else{
        if(!reload.equals("1")){
          %>
                            <input type="text" name="tf_maxpart" maxlength="9" value="<%=rsAlt.getString(27)%>" onBlur="numero2(this)" onKeyUp="numero(this)">
                            <%
                          }
                          else{
          %>
                            <input type="text" name="tf_maxpart" maxlength="9" value=<%=("\""+request.getParameter("tf_maxpart")+"\"")%> onBlur="numero2(this)" onKeyUp="numero(this)">
                            <%
                          }
      }
      %>
                    </td>
                    <td colspan="3"><%=trd.Traduz("NUM. MINIMO DE PARTICIPANTES")%><br>
      <%
      if (tipo2.equals("I")){
        if(request.getParameter("tf_minpart")!=null){
          %>
                            <input type="text" name="tf_minpart" maxlength="9" value=<%=("\""+request.getParameter("tf_minpart")+"\"")%> onBlur="numero2(this)" onKeyUp="numero(this)">
                            <%
                          }
                          else{
          %>
                            <input type="text" name="tf_minpart" maxlength="9" onBlur="numero2(this)" onKeyUp="numero(this)">
                            <%
                          }
      }
      else{
        if(!reload.equals("1")){
          %>
                            <input type="text" name="tf_minpart" maxlength="9" value="<%=rsAlt.getString(28)%>" onBlur="numero2(this)" onKeyUp="numero(this)">
                            <%
                          }
                          else{
          %>
                            <input type="text" name="tf_minpart" maxlength="9" value=<%=("\""+request.getParameter("tf_minpart")+"\"")%> onBlur="numero2(this)" onKeyUp="numero(this)">  
                            <%
                          }
      }
      %>
                    </td>
                  </tr>
                  <tr class="celnortab"> 
                    <td colspan="6"><%=trd.Traduz("RESUMO")%> / <%=trd.Traduz("SUMULA")%> / <%=trd.Traduz("OBJETIVO")%> / <%=trd.Traduz("APLICABILIDADE")%><br>
      <%
      if (tipo2.equals("I")){
        if(request.getParameter("ta_resumo")!=null){
          %>
                            <textarea name="ta_resumo" cols="70" rows="3"  onBlur="aspa2(this, <%=tam_objetivo%>)" onKeyUp="aspa(this, <%=tam_objetivo%>)"><%=request.getParameter("ta_resumo")%></textarea>
                            <%
                          }
                          else{
          %>
                            <textarea name="ta_resumo" cols="70" rows="3"  onBlur="aspa2(this, <%=tam_objetivo%>)" onKeyUp="aspa(this, <%=tam_objetivo%>)"></textarea>
                            <%
                          }
      }
      else{
        if(!reload.equals("1")){
          %>
                            <textarea name="ta_resumo" cols="70" rows="3"  onBlur="aspa2(this, <%=tam_objetivo%>)" onKeyUp="aspa(this, <%=tam_objetivo%>)"><%=rsAlt.getString(17)%></textarea>
                            <%
                          }
                          else{
          %>
                            <textarea name="ta_resumo" cols="70" rows="3"  onBlur="aspa2(this, <%=tam_objetivo%>)" onKeyUp="aspa(this, <%=tam_objetivo%>)"><%=request.getParameter("ta_resumo")%></textarea>
                            <%
                          }
      }
      %>
                    </td>
                  </tr>
                  <tr class="celnortab"> 
                    <td colspan="6"><%=trd.Traduz("CONTEUDO PROGRAMATICO")%> / <%=trd.Traduz("PRATICAS ADOTADAS")%><br>
      <%
      if (tipo2.equals("I")){
        if(request.getParameter("ta_contprog")!=null){
          %>
                            <textarea name="ta_contprog" cols="70" rows="3"  onBlur="aspa2(this, <%=tam_programa%>)" onKeyUp="aspa(this, <%=tam_programa%>)"><%=request.getParameter("ta_contprog")%></textarea>
                            <%
                          }
                          else{
          %>
                            <textarea name="ta_contprog" cols="70" rows="3"  onBlur="aspa2(this, <%=tam_programa%>)" onKeyUp="aspa(this, <%=tam_programa%>)"></textarea>
                            <%
                          }
      }
      else{
        if(!reload.equals("1")){
          %>
                            <textarea name="ta_contprog" cols="70" rows="3"  onBlur="aspa2(this, <%=tam_programa%>)" onKeyUp="aspa(this, <%=tam_programa%>)"><%=rsAlt.getString(15)%></textarea>
                            <%
                          }
                          else{
          %>
                            <textarea name="ta_contprog" cols="70" rows="3"  onBlur="aspa2(this, <%=tam_programa%>)" onKeyUp="aspa(this, <%=tam_programa%>)"><%=request.getParameter("ta_contprog")%></textarea>
                            <%
                          }
      }
      %>
                    </td>
                  </tr>
                  <tr class="celnortab">
                    <td colspan="6"><%=trd.Traduz("COMO AVALIAR")%><br>
      <%
      if (tipo2.equals("I")){
        if(request.getParameter("ta_comoaval")!=null){
          %>
                            <textarea name="ta_comoaval" cols="70" rows="3"  onBlur="aspa2(this, <%=tam_publalvo%>)" onKeyUp="aspa(this, <%=tam_publalvo%>)"><%=request.getParameter("ta_comoaval")%></textarea>
                            <%
                          }
                          else{
          %>
                            <textarea name="ta_comoaval" cols="70" rows="3"  onBlur="aspa2(this, <%=tam_publalvo%>)" onKeyUp="aspa(this, <%=tam_publalvo%>)"></textarea>
                            <%
                          }
      }
      else{
        if(!reload.equals("1")){
          %>
                            <textarea name="ta_comoaval" cols="70" rows="3"  onBlur="aspa2(this, <%=tam_publalvo%>)" onKeyUp="aspa(this, <%=tam_publalvo%>)"><%=rsAlt.getString(21)%></textarea>
            <%
          }
          else{
          %>
                            <textarea name="ta_comoaval" cols="70" rows="3"  onBlur="aspa2(this, <%=tam_publalvo%>)" onKeyUp="aspa(this, <%=tam_publalvo%>)"><%=request.getParameter("ta_comoaval")%></textarea>
            <%
          }
      }
      %>
                    </td>
                  </tr>
                  <tr class="celnortab"> 
                    <td colspan="6"><%=trd.Traduz("CONSIDERACOES GERAIS")%><br>
      <%
      if (tipo2.equals("I")){
        if(request.getParameter("ta_consger")!=null){
          %>
                            <textarea name="ta_consger" cols="70" rows="3"  onBlur="aspa2(this, <%=tam_consideracoes%>)" onKeyUp="aspa(this, <%=tam_consideracoes%>)"><%=request.getParameter("ta_consger")%></textarea>
                            <%
                          }
                          else{
          %>
                            <textarea name="ta_consger" cols="70" rows="3"  onBlur="aspa2(this, <%=tam_consideracoes%>)" onKeyUp="aspa(this, <%=tam_consideracoes%>)"></textarea>
                            <%
                          }
      }
      else{
        if(!reload.equals("1")){
          %>
                            <textarea name="ta_consger" cols="70" rows="3"  onBlur="aspa2(this, <%=tam_consideracoes%>)" onKeyUp="aspa(this, <%=tam_consideracoes%>)"><%=rsAlt.getString(16)%></textarea>
                            <%
                          }
                          else{
          %>
                            <textarea name="ta_consger" cols="70" rows="3"  onBlur="aspa2(this, <%=tam_consideracoes%>)" onKeyUp="aspa(this, <%=tam_consideracoes%>)"><%=request.getParameter("ta_consger")%></textarea>
                            <%
                          }
      }
      %>
                    </td>
                  </tr>

    
      <tr class="celnortab"> 
       <td colspan="3"> 
                    <%=trd.Traduz("AVALIACAO")%>: <br>
                     <select name="sel_aval" onChange="return quest();">
                      <option value="0"><%=("SELECIONE")%></option>
                      <%
                      String queryA = "SELECT AVA_CODIGO, AVA_DESCRICAO FROM AVALIACAO";
                      rsA = conexao.executaConsulta(queryA,session.getId()+"RS_12");
                      if(rsA.next()){
                        do{
                          //if(!vetAvaliacao.contains(rsA.getString(1))){
                          if(ava_codigo.equals(rsA.getString(1))){
                            %>
                            <option selected value="<%=rsA.getString(1)%>"><%=rsA.getString(2)%></option>
                            <%
                          }
                          else{
                            %>
                            <option value="<%=rsA.getString(1)%>"><%=rsA.getString(2)%></option>
                            <%
                          }
                          //}
                        }while(rsA.next());
                        if(rsA!=null){
                            conexao.finalizaConexao(session.getId()+"RS_12");
                        }    
                      }
          %>
        </select>
                   </td>
                   <td colspan="3">
          <%=trd.Traduz("QUESTIONARIO")%>:<br>
          <select name="sel_quest">
          <option value="">SELECIONE</option>         
      <%
      if(!ava_codigo.equals("")){
        String queryQ = "SELECT QUE_CODIGO, QUE_NOME "+
            "FROM QUESTIONARIO "+
            "WHERE AVA_CODIGO = "+ava_codigo+" "+
            "ORDER BY QUE_NOME";

        rsQ = conexao.executaConsulta(queryQ,session.getId()+"RS_13");
                          if(rsQ.next()){
          do{
            if(!vetAvaliacao.contains(rsQ.getString(1))){       
              %>
                <option value=<%=rsQ.getInt(1)%>><%=rsQ.getString(2)%></option>
              <%
            }
          }while(rsQ.next());
          if(rsQ!=null){
            conexao.finalizaConexao(session.getId()+"RS_13");
            }
        }
      }
      %>
      </select>                       
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;          
                    <input type="button" value=<%=("\""+trd.Traduz("INSERIR")+"\"")%> class="botcin" onClick="return insere2();">&nbsp;&nbsp;&nbsp;
                    <input type="button" value=<%=("\""+trd.Traduz("EXCLUIR")+"\"")%> class="botcin" onClick="return exclui2();">
       </td>
      </tr>
                  
    <%
  
  if(request.getParameter("reload") != null){
    reload = request.getParameter("reload");
  }
  if(tipo2.equals("U") && !reload.equals("1")){
    if(vetAvaliacao.isEmpty()){
      query2 = "SELECT QUE_CODIGO FROM PLANO_AVALIA WHERE CUR_CODIGO = "+cod2;
      rs2 = conexao.executaConsulta(query2,session.getId()+"RS_14");
      if(rs2.next()){
        do{
          que_codigo = rs2.getString(1);
          vetAvaliacao.add(que_codigo);
        }while(rs2.next());
      }
      if(rs2!=null){
        conexao.finalizaConexao(session.getId()+"RS_14");
        }
    }
    
  }
    
    //query2 ="SELECT QUE_CODIGO, QUE_NOME FROM QUESTIONARIO ";
  if(!vetAvaliacao.isEmpty()){
          i=0;
          cont_aval=0;
          do{
      query2 ="SELECT Q.QUE_CODIGO, Q.QUE_NOME, A.AVA_DESCRICAO "+
          "FROM QUESTIONARIO Q, AVALIACAO A "+
          "WHERE Q.AVA_CODIGO = A.AVA_CODIGO "+
          "AND QUE_CODIGO = "+vetAvaliacao.elementAt(i);

                    cont_aval++;
      rs2 = conexao.executaConsulta(query2,session.getId()+"RS_15");
      if(rs2.next()){
        que_codigo = rs2.getString(1);

        if(tipo2.equals("U") && !reload.equals("1")){
          String queryI = "SELECT PLV_DIASENVIO,PLV_DIASVENC,PLV_PORCENTAGEM, QUE_CODIGO FROM PLANO_AVALIA WHERE CUR_CODIGO = "+cod2+" AND QUE_CODIGO = "+que_codigo;
          rsI = conexao.executaConsulta(queryI,session.getId()+"RS_16");
          rsI.next();
          //vetAvaliacao.add(rsI.getString(4));
          vetEnvio.addElement(rsI.getString(1));
          vetVencimento.addElement(rsI.getString(2));
          vetAmostra.addElement(rsI.getString(3));
         }
         if(rsI!=null){
            rsI.close();
            conexao.finalizaConexao(session.getId()+"RS_16");
            }
         envio = (String)vetEnvio.elementAt(i);
         vencimento = (String)vetVencimento.elementAt(i);
         porcentagem = (String)vetAmostra.elementAt(i);

         %>
        <tr class="celnortab"> 
          <td>
            <input type="checkbox" name="chk_avaliacao<%=cont_aval%>" value="<%=rs2.getInt(1)%>" > 
          </td>
          <td>
            <b> <%=rs2.getString(3)%> </b>
          </td>
          <td>
            <%=trd.Traduz("QUESTIONARIO")%>: &nbsp; <b> <%=rs2.getString(2)%> </b>
          </td>
          <td>
            <%=trd.Traduz("DIAS PARA ENVIO")%>: &nbsp; <b> <%=envio%> </b>
          </td>
          <td>
                  <%=trd.Traduz("DIAS PARA VENCIMENTO")%>: &nbsp; <b> <%=vencimento%> </b>
          </td>
          <td>
            <%
              if(porcentagem.equals("") || porcentagem.equals("100")) { %>
                <%=trd.Traduz("TOTAL")%>: &nbsp; <b> 100% </b> <%
                      }
                      else { %>
                <%=trd.Traduz("AMOSTRAGEM")%>: &nbsp; <b> <%=porcentagem%>% </b> <%
              }
                  %>
          </td>
                </tr>
        <%
        i++;
      }
      if(rs2!=null){
        rs2.close();
        conexao.finalizaConexao(session.getId()+"RS_15");
        }
    }while(i<vetAvaliacao.size());
  }
            else{
            %>
                 <tr class="celnortab"> 
                     <td colspan="100%"><%=trd.Traduz("NENHUM ITEM ADICIONADO")%>...</td>
                 </tr>
      <%
    }
    %>
                  
    
                  </table><br><br>
                <table border="0" cellspacing="1" cellpadding="0" width="100%">

          <tr> 
            <td valign="top" class="ctvdiv"><img src="../art/bit.gif" width="1" height="1"></td>
          </tr>
          <tr><td>&nbsp;</td></tr>
                  <tr class="hcfont" align="center">
                  <td width="33%"><%=trd.Traduz("COMPETENCIAS")%>&nbsp;&nbsp;&nbsp;
    <%
    if(replica.equals("1")){
      if(!reload.equals("1")){
        query = "SELECT TIT_CODCLI FROM TITULO WHERE TIT_CODIGO = "+titulo;
        hs = conexao.executaConsulta(query,session.getId()+"RS_17");
        hs.next();
        
        query = "SELECT CMP_DESCRICAO "+
          "FROM COMPETENCIA "+
          "WHERE CMP_CODIGO = "+hs.getString(1);
          if(hs!=null){
            hs.close();
            conexao.finalizaConexao(session.getId()+"RS_17");
            }
        rs = conexao.executaConsulta(query,session.getId()+"RS_17");
        if(rs.next()){
          if(!(vet_comp.contains(rs.getString(1)))){
            replicado = rs.getString(1);
            vet_comp.addElement(rs.getString(1));
          }
        }
        if(rs!=null){
            conexao.finalizaConexao(session.getId()+"RS_18");
            }
      }
    }
    else{
      i=0;
      while(i<vet_comp.size()){
        if(!altera.equals("1")){
          if(replicado.equals(vet_comp.elementAt(i))){
            vet_comp.remove(i);
            replicado = "";
          }
        }
        i++;
      }
    }
    %>
    <input type="hidden" name="replicado2" value="<%=replicado%>">
    <%
    if(!(tipo2.equals("I"))){
                        query = "SELECT CMP_CODIGO, CMP_DESCRICAO FROM COMPETENCIA ORDER BY CMP_DESCRICAO";
      rs = conexao.executaConsulta(query,session.getId()+"RS_19");
      i=0;
      if(rs.next()){
                      %>    
                      <select name="sel_competencia">
        <option value=""><%=trd.Traduz("SELECIONE")%> 
        <%
        do{
          String queryC = "SELECT CMP_CODIGO FROM CURSOCOMP WHERE CUR_CODIGO = "+cod2+" AND CMP_CODIGO = "+rs.getString(1);
          rsC = conexao.executaConsulta(queryC,session.getId()+"RS_20");
          if(!reload.equals("1")){
            if(rsC.next()){
              do{
                                     if(!(vet_comp.contains(rs.getString(2)))){
                  vet_comp.addElement(rs.getString(2));
                   }
              }while(rsC.next());
            }
            if(rsC!=null){  
            conexao.finalizaConexao(session.getId()+"RS_20");
            }
          }
          if(!(vet_comp.contains(rs.getString(2)))){
            %>
            <option value="<%=rs.getString(2)%>"><%=rs.getString(2)%>
            <%
          }
        }while(rs.next());
      }
      if(rs!=null){
            conexao.finalizaConexao(session.getId()+"RS_19");
            }
    }
    else{
                        query = "SELECT CMP_CODIGO, CMP_DESCRICAO FROM COMPETENCIA ORDER BY CMP_DESCRICAO";
      rs = conexao.executaConsulta(query,session.getId()+"RS_21");
      i=0;
      if(rs.next()){
                        %>    
                        <select name="sel_competencia">
        <option value=""><%=trd.Traduz("SELECIONE")%> 
        <%
        do{
          if(!(vet_comp.contains(rs.getString(2)))){
            %>
            <option value="<%=rs.getString(2)%>"><%=rs.getString(2)%>
            <%
          }
        }while(rs.next());
      }
      if(rs!=null){
        conexao.finalizaConexao(session.getId()+"RS_21");
        }
    }
       %>
                    </select>&nbsp;&nbsp;&nbsp;
                    <input class="botcin" type="button" value=<%=("\""+trd.Traduz("INCLUIR")+"\"")%> OnClick="return insere();">&nbsp;
                    <input class="botcin" type="button" value=<%=("\""+trd.Traduz("EXCLUIR")+"\"")%> OnClick="return deleta();">
                  </td>
                  </tr>
          <tr><td>&nbsp;</td></tr>
          <tr> 
            <td valign="top" class="ctvdiv"><img src="../art/bit.gif" width="1" height="1"></td>
          </tr>
                  
              <tr>
              <td align="center">
                <table border="0" cellspacing="2" cellpadding="3" width="90%">
                <tr>
                  <td width="3%">&nbsp;</td>
                  <td class="celtittab"><%=trd.Traduz("COMPETENCIAS REQUERIDAS")%></td>
                </tr>
                   
    <%
      i=0;//out.println("Vet: "+vet_comp);
      while(i<vet_comp.size()){
        %>
        <tr>
        <td class="celnortab" align="center">
        <%
        if(replicado.equals(vet_comp.elementAt(i))){
          
          %>
          <input type="hidden" name="cb_<%=i%>" value="">
          &nbsp;
          <%
        }
        else{
          %>
          <input type="checkbox" name="cb_<%=i%>" value="<%=vet_comp.elementAt(i)%>">
          <%
        }
        %>
        
        </td>
        <td class="celnortab">&nbsp;<%=vet_comp.elementAt(i)%></td>
        </tr>
        <%
        i=i+1;  
      }

    %>
                      </table>
                       </td>
                        </tr>
          <input type="hidden" name="cont" value="<%=i%>">                         
          
                      <input type="hidden" name="tipo" value="<%=tipo2%>">
                      <input type="hidden" name="cod" value="<%=cod2%>">
                      <input type="hidden" name="reload2" value="<%=reload%>">
          <input type="hidden" name="ativo5" value="<%=ativo%>">
          <%
          if(tipo2.equals("U"))
            altera = "1";
          %>
          <input type="hidden" name="altera2" value="<%=altera%>">
                      
                      <input type="hidden" name="sel_saratoga2" value=<%=("\""+request.getParameter("sel_saratoga")+"\"")%>>
                      <input type="hidden" name="sel_tipo2" value=<%=("\""+request.getParameter("sel_tipo")+"\"")%>>
                                   
                      <input type="hidden" name="tf_nome2" value=<%=("\""+request.getParameter("tf_nome")+"\"")%>>
                      <input type="hidden" name="tf_custo2" value=<%=("\""+request.getParameter("tf_custo")+"\"")%>>
                      <input type="hidden" name="tf_custol2" value=<%=("\""+request.getParameter("tf_custol")+"\"")%>>
                      <input type="hidden" name="tf_duracao2" value=<%=("\""+request.getParameter("tf_duracao")+"\"")%>>
                      <input type="hidden" name="tf_duracao_min2" value=<%=("\""+request.getParameter("tf_duracao_min")+"\"")%>>
                      <input type="hidden" name="tf_versao2" value=<%=("\""+request.getParameter("tf_versao")+"\"")%>>
                      <input type="hidden" name="sel_resp2" value=<%=("\""+request.getParameter("sel_resp")+"\"")%>>
                      <input type="hidden" name="tf_maxpart2" value=<%=("\""+request.getParameter("tf_maxpart")+"\"")%>>
                      <input type="hidden" name="tf_minpart2" value=<%=("\""+request.getParameter("tf_minpart")+"\"")%>>
                      <input type="hidden" name="ta_resumo2" value=<%=("\""+(String)request.getParameter("ta_resumo")+"\"")%>>
                      <input type="hidden" name="ta_contprog2" value=<%=("\""+(String)request.getParameter("ta_contprog")+"\"")%>>
                      <input type="hidden" name="ta_comoaval2" value=<%=("\""+(String)request.getParameter("ta_comoaval")+"\"")%>>
                      <input type="hidden" name="ta_consger2" value=<%=("\""+(String)request.getParameter("ta_consger")+"\"")%>>
                      
                      <!--/*para o novo vetor*/-->
                      <input type="hidden" name="apagavetor" value="N">
          <input type="hidden" name="tipo_op">
                <input type="hidden" name="c_avaliacao" value="<%=cont_aval%>">
          <!--/*para o novo vetor*/-->
                      
                      <tr> 
                    <td align="center">&nbsp;<br>
                      <input type="button" onClick="return envia();"  value="        <%=trd.Traduz("OK")%>        " class="botcin" name="buttonok">
                      &nbsp; 
                      <input type="button" onClick="return cancela()"  value=<%=("\""+trd.Traduz("CANCELAR")+"\"")%> class="botcin" name="buttoncancel">
                    </td>
                  </tr>
                </table>
                <p>&nbsp;
              </center>
          </td>

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
/*if(rs != null)
  rs.close();
conexao.finalizaConexao();

conexaoAlt.finalizaConexao();
conexaoAlt.finalizaBD();

conexaoZ.finalizaConexao();
conexaoZ.finalizaBD();

conexao2.finalizaConexao();
conexao2.finalizaBD();

conexaof.finalizaConexao();
conexaof.finalizaBD();

conexaoA.finalizaConexao();
conexaoA.finalizaBD();

conexaoQ.finalizaConexao();
conexaoQ.finalizaBD();

conexaoI.finalizaConexao();
conexaoI.finalizaBD();

conexaohs.finalizaConexao();
conexaohs.finalizaBD();

conexaoC.finalizaConexao();
conexaoC.finalizaBD();*/
//}catch (Exception e){out.println("ERRO: "+e);}
%>