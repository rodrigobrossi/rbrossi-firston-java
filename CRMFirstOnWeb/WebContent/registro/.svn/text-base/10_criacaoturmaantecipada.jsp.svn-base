<!--
Nome do arquivo: registro/10_criacaoturmaantecipada.jsp
Nome da funcionalidade: Criaçao de Turma Antecipada
Função: Oferecer o formulário de cadastro de turmas (antecipada e longa duraçao)
Variáveis necessárias/ Requisitos: 
- sessao: bean de traduçao ("Traducao"), bean de conexao ("Conexao"), bean de param ("Param"), filial do usuario ("usu_fil"),
          idioma do usuário ("usu_idi"), tipo do usuário ("usu_tipo"), nome do usuário ("usu_nome"), login do usuário ("usu_login"),
          plano do usuário ("usu_plano")
- parametro: codigo da turma ("rdo_turma") - se alteraçao
Regras de negócio (pagina):
- validar: data inicial < data final
- validar: a alteracao de turma somente sera permitida se nao houver registro para esta turma (longa duracao)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Histórico
Data de atualizacao: 26/02/2003 - Desenvolvedor: Marcelo Marques
Atividade: padronizacao da página
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-->

<!--***DIRETRIZES DA PAGINA***-->
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<!--***IMPORTAÇOES E BEANS***-->
<%@page import=" java.sql.*, java.lang.Math.*, java.util.*, java.text.*"%>

<!--***FUNÇÕES JSP***-->
<%! 
public String convHora(float minutos) {
  Float ft = new Float(minutos);
  int min = ft.intValue();
  String total = "";
  float result;
  int inteiro = 0, decimal = 0;
  result = min / 60;
  Float ft2 = new Float(result);
  inteiro = ft2.intValue();
  decimal = min % 60;
  total = total.valueOf(inteiro);
  return total;
}
%>

<%! public String convMinuto(float minutos) {
  Float ft = new Float(minutos);
  int min = ft.intValue();
  String total = "";
  float result;
  int inteiro = 0, decimal = 0;
  decimal = min % 60;
  total = total.valueOf(decimal);
  if(decimal < 10)
  total = "0"+total;
  return total;
}
%>

<%!
public String ReaistoStr(float valor) {
  DecimalFormat dcf = new DecimalFormat("0.00");
  dcf.setMaximumFractionDigits(2);
  String strReais = dcf.format(valor);
  return strReais;
}
%>

<%!
public String ReaistoStr2(float valor, String moeda) {
  DecimalFormat dcf = new DecimalFormat("0.00");
  dcf.setMaximumFractionDigits(2);
  String strReais = dcf.format(valor);
  return (moeda + strReais);
}
%>

<%!
public String replaceString(String s, String busca, String troca) {
  String nova = "";
  int ini = s.indexOf(busca);
  boolean ok = false;
  if (ini>0) {
    ok = true;
  } else {
    nova = s;
  }
  while (ok) {
    int fim = busca.length();
    nova = s.substring(0,ini) + troca + s.substring(ini+fim,s.length());
    ini = nova.indexOf(busca);
    if (ini>0) {
      s = nova;
    } else {
      ok = false;
    }
  }
  return nova;
}
%>

<%
//configuracao de cache
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1"))
  response.setHeader("Cache-Control", "no-cache");

//***DECLARAÇÃO DE VARIÁVEIS***

String ent="", inst="", query="", avaliacao="", query_cur="", query_tit="", query_ass="";
String dtini_p="", dtfim_p="", deleta="", desc_logistica="", descricao = "", custo = "", aux="", teste="";
Vector vet_desc = new Vector();
Vector vet_cust = new Vector();
float total=0;
int a=0, cont=0;
ResultSet rs = null;
boolean altera_tipo_turma = true;
Calendar cal_env = Calendar.getInstance();
Calendar cal_ven = Calendar.getInstance();
java.util.Date dataAtual = new java.util.Date();
SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
String dia = formato.format(dataAtual);

//***RECUPERCAO DE PARAMETROS***
//valores de sessao
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");
Integer usu_fil  = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi  = (Integer)session.getAttribute("usu_idi"); 
String usu_tipo  = (String) session.getAttribute("usu_tipo"); 
String usu_nome  = (String) session.getAttribute("usu_nome"); 
String usu_login = (String) session.getAttribute("usu_login"); 
String usu_plano =  String.valueOf(session.getAttribute("usu_plano")); 
//valores da pagina
String op                   = (request.getParameter("tipo")==null)?"":(String)request.getParameter("tipo");
String pag_ass              = (request.getParameter("selectass")== null)?"":(String)request.getParameter("selectass");
String pag_tit              = (request.getParameter("selecttit")== null)?"":(String)request.getParameter("selecttit");
String pag_cur              = (request.getParameter("selectcur")== null)?"":(String)request.getParameter("selectcur");
String pag_dtini            = (request.getParameter("textdatai")== null)?"":(String)request.getParameter("textdatai");
String pag_dtfim            = (request.getParameter("textdataf")== null)?"":(String)request.getParameter("textdataf");
String pag_tipo_treinamento = (request.getParameter("longa") == null)?"2":"3";//2=turma antecipada & 3=lomga duracao
String pag_cuscur           = (request.getParameter("textcustocur")== null)?"":(String)request.getParameter("textcustocur");
String pag_cuslog           = (request.getParameter("textcustolog")== null)?"0":(String)request.getParameter("textcustolog");
String pag_pmin             = (request.getParameter("txtmin")== null)?"":(String)request.getParameter("txtmin");
String pag_pmax             = (request.getParameter("txtmax")== null)?"":(String)request.getParameter("txtmax");
String pag_duracao          = (request.getParameter("textdurh")== null)?"":(String)request.getParameter("textdurh");
String pag_duracao2         = (request.getParameter("textdurm")== null)?"":(String)request.getParameter("textdurm");
String pag_entidade         = (request.getParameter("selectent")== null)?"":(String)request.getParameter("selectent");
String pag_instrutor        = (request.getParameter("selectinst")== null)?"":(String)request.getParameter("selectinst");
String pag_obs              = (request.getParameter("txtobs")== null)?"":(String)request.getParameter("txtobs");
String pag_tipo             = (request.getParameter("selecttip")== null)?"":(String)request.getParameter("selecttip");
//variavel utilizada para alteracao de turma
String turma = (request.getParameter("rdo_turma")==null)?"":request.getParameter("rdo_turma"); 
//parametro do simbolo da moeda
String moeda = prm.buscaparam("MOEDA");

//***CORPO DA PÁGINA***

//try {

//padroniza as casas decimais para virgula
pag_cuscur = replaceString(pag_cuscur,".","");
pag_cuscur = replaceString(pag_cuscur,".",",");
pag_cuslog = replaceString(pag_cuslog,".","");
pag_cuslog = replaceString(pag_cuslog,".",",");

//verifica dadas limite do plano
query = "SELECT PLA_DATAINICIO, PLA_DATAFINAL FROM PLANO WHERE PLA_CODIGO = " +usu_plano;
rs = conexao.executaConsulta(query,session.getId());
if (rs.next()) {
  dtini_p = formato.format(rs.getDate(1)); //out.println(dtini_p);
  dtfim_p = formato.format(rs.getDate(2)); //out.println(dtfim_p);
  rs.close();
  conexao.finalizaConexao(session.getId());
}


if(vet_desc.size()!=0) vet_desc.clear();
if(vet_cust.size()!=0) vet_cust.clear();

//limpa os vetores de custo
if (request.getParameter("limpa_vets") == null) {
  //out.println("LIMPOU");
  session.setAttribute("vet_descS",vet_desc);
  session.setAttribute("vet_custS",vet_cust);
}

//recupera da sessao os vetores de custo
if((Vector)session.getAttribute("vet_descS") != null)
  vet_desc = (Vector)session.getAttribute("vet_descS");
if((Vector)session.getAttribute("vet_custS") != null)
  vet_cust = (Vector)session.getAttribute("vet_custS");

//detela itens dos vetores de custo
deleta = (request.getParameter("deleta_vets")==null)?"":(String)request.getParameter("deleta_vets");
if (deleta.equals("S")) {
  int t = vet_cust.size();
  for(int i=t;i>=0;i--) {
    if(request.getParameter("vet"+i) != null) {
      aux = request.getParameter("vet"+i);
      int novo = Integer.parseInt((String)aux);
      vet_desc.remove(novo);
      vet_cust.remove(novo);
    }
  }
}

//adiciona itens aos vetores de custo
desc_logistica = (request.getParameter("txt_desc")==null)?"":(String)request.getParameter("txt_desc");
if(!desc_logistica.equals("")) {
  if(!(vet_desc.contains(request.getParameter("txt_desc")))) {
    vet_desc.addElement(request.getParameter("txt_desc"));
    if(request.getParameter("txt_cust") != null) {
      String xis = request.getParameter("txt_cust");
      xis = replaceString(xis,".","");
      xis = replaceString(xis,",",".");
      vet_cust.addElement(xis);
    }
  }
}

session.setAttribute("vet_descS",vet_desc);
session.setAttribute("vet_custS",vet_cust);

//recupera valores
if(request.getParameter("total2") != null) {  
  String m = replaceString(request.getParameter("total2"),".","");
  total = Float.parseFloat(m);
}

//Recupera os dados se for alteracao
if (op.equals("A")) {
  if (pag_cur.equals("")) {//1a vez que solicita a alteracao
    //dados de curso, titulo e assunto
    query = "SELECT CURSO.CUR_CODIGO, TITULO.TIT_CODIGO, TITULO.ASS_CODIGO FROM CURSO, TITULO " +
            "WHERE  CURSO.TIT_CODIGO = TITULO.TIT_CODIGO AND  " + 
            "CURSO.CUR_CODIGO IN (SELECT CUR_CODIGO FROM TURMA WHERE TUR_CODIGO = " + turma + ")";
    rs = conexao.executaConsulta(query,session.getId()+"RS_1");
    if (rs.next()) {
      pag_cur = rs.getString(1);
      pag_tit = rs.getString(2);
      pag_ass = rs.getString(3);
    }
    if(rs!=null){
        rs.close();
        conexao.finalizaConexao(session.getId()+"RS_1");
    }
    //dados do curso
    //query = "SELECT CUR_CUSTO, CUR_CUSTO2, CUR_DURACAO, CUR_MAXPART, CUR_MINPART, EMP_CODIGO "+
    //        "FROM CURSO WHERE CUR_CODIGO = " +pag_cur;
    //rs = conexao.executaConsulta(query);
    //if(rs.next()) {
    //}
    query = "SELECT EMP_CODIGO, TUR_DATAINICIO, TCU_CODIGO, TUR_DATAFINAL, TUR_DURACAO, INS_CODIGO, " + 
            "TUR_CUSTO, TUR_CUSTO2, TUR_PARTICIPMIN, TUR_PARTICIPMAX, TUR_OBS, TTR_CODIGO FROM TURMA WHERE TUR_CODIGO = " + turma;
    rs = conexao.executaConsulta(query,session.getId()+"RS_2");
    if (rs.next()) {
      pag_tipo = rs.getString(3);
      String dataf = new String();
      java.util.Date diai = rs.getDate(2);
      java.util.Date diaf = rs.getDate(4);
      SimpleDateFormat data1 = new SimpleDateFormat("dd/MM/yyyy");
      pag_dtini = data1.format(diai);
      pag_dtfim = data1.format(diaf);
      pag_instrutor = rs.getString(6);
      pag_obs = rs.getString(11);
      pag_tipo_treinamento = rs.getString(12);
      pag_pmax = rs.getString(10);
      pag_pmin     = rs.getString(9);
      pag_duracao  = convHora(rs.getFloat(5));
      pag_duracao2 = convMinuto(rs.getFloat(5));
      pag_entidade = rs.getString(1);
      pag_cuscur   = replaceString(rs.getString(7),".",",");
      pag_cuslog   = rs.getString(8);
    }
    if(rs!=null){
        rs.close();
        conexao.finalizaConexao(session.getId()+"RS_2");
    }
  }
}
%>

<script language="JavaScript">

function enviar() {

  var c = frm.cont_avaliacao.value; //aux. loop de verificacao das datas de envio e vencimento
  for(i=1;i<=c;i++) {
    if(eval("frm.chk_"+i+".checked") && ((eval("frm.txt_dt_vencimento_"+i+".value")=="") || (eval("frm.txt_dt_envio_"+i+".value")==""))) {
      alert(<%=("\""+trd.Traduz("Favor escolher data de envio e data de vencimento para as avaliacoes escolhidas!")+"\"")%>);
      return false;
    }
  }

  var data1 = document.frm.textdatai.value; //data inicial da tela
  var data2 = document.frm.textdataf.value; //data final da tela
  var data3 = "<%=dtini_p%>"; //data inicial do plano
  var data4 = "<%=dtfim_p%>"; //data final do plano
  i1=0; i2=0; i3=0; i4=0;
  while(i1<data1.length){
      i1++;
  }
  while(i2<data2.length){
    i2++;
  }
  while(i3<data3.length){
    i3++;
  }
  while(i4<data4.length){
    i4++;
  }
  if(data1.length==9)
    data1 ="0"+data1;
  if(data2.length==9)
    data2 ="0"+data2;
  if(data3.length==9)
    data3 ="0"+data3;
  if(data4.length==9)
    data4 ="0"+data4;

  var dia1 = data1.substring(0,2);
  var dia2 = data2.substring(0,2);
  var dia3 = data3.substring(0,2);
  var dia4 = data4.substring(0,2);
  var mes1 = data1.substring(3,5);
  var mes2 = data2.substring(3,5);
  var mes3 = data3.substring(3,5);
  var mes4 = data4.substring(3,5);
  var ano1 = data1.substring(6,10);
  var ano2 = data2.substring(6,10);
  var ano3 = data3.substring(6,10);
  var ano4 = data4.substring(6,10);    

  if (frm.textdatai.value == "") {
    alert(<%=("\""+trd.Traduz("Favor digitar data inicial!")+"\"")%>);
    frm.textdatai.focus();
  } else {
    if (frm.textdataf.value == "") {
      alert(<%=("\""+trd.Traduz("Favor digitar data final!")+"\"")%>); 
      frm.textdataf.focus();
    } else {
      if (frm.textcustocur.value == "") {
        alert(<%=("\""+trd.Traduz("Favor digitar custo do curso!")+"\"")%>); 
        frm.textcustocur.focus();
      } else {
        if (frm.textcustolog.value == "") {
          alert(<%=("\""+trd.Traduz("Favor digitar custo de logistica!")+"\"")%>); 
          frm.textcustolog.focus();
  } else {
          if (frm.textdurh.value == ""  || frm.textdurm.value == "") {
            alert(<%=("\""+trd.Traduz("Favor digitar duracao do curso!")+"\"")%>); 
            frm.textdurh.focus();
    } else {        
      if (frm.selecttip.value == "") {
              alert(<%=("\""+trd.Traduz("Favor escolher o tipo do curso!")+"\"")%>); 
              frm.selecttip.focus();
      } else {        
            if (frm.selectent.value == "") {
              alert(<%=("\""+trd.Traduz("Favor escolher a entidade")+"\"")%>); 
              frm.selectent.focus();
            } else {
                if(ano1>ano2){
                  alert(<%=("\""+trd.Traduz("A data final nAo pode ser menor que a data de inicial")+"\"")%>);
                  document.frm.textdataf.value="";
                  document.frm.textdataf.focus();
                  return false; 
                }
                else if(ano1==ano2){
                  if (mes1>mes2){
                    alert(<%=("\""+trd.Traduz("A data final nAo pode ser menor que a data de inicial")+"\"")%>);
                    document.frm.textdataf.value="";
                    document.frm.textdataf.focus();
                    return false; 
                  }
                  else if(mes1==mes2){
                    if(dia1>dia2){  
                      alert(<%=("\""+trd.Traduz("A data final nAo pode ser menor que a data de inicial")+"\"")%>);
                      document.frm.textdataf.value="";
                      document.frm.textdataf.focus();
                      return false; 
                    }
                  }
                  if(ano1<ano3 || ano1>ano4){
                    alert(<%=("\""+trd.Traduz("A data inicial estA fora do perIodo do plano")+"\"")%> ("+data3+ " - " +data4+")+ "!");
                    document.frm.textdatai.value("");
                    document.frm.textdatai.focus();
                    return false; 
                  }
                  else if(ano1==ano3){
                    if (mes1<mes3 || mes1>mes4){
                      alert(<%=("\""+trd.Traduz("A data inicial estA fora do perIodo do plano")+"\"")%> ("+data3+ " - " +data4+")+ "!");
                      document.frm.textdatai.value("");
                      document.frm.textdatai.focus();
                      return false; 
                    }
                    else if((dia1<dia3 || dia1>dia4) && (mes1==mes3 || mes1==mes4)){  
                      alert(<%=("\""+trd.Traduz("A data inicial estA fora do perIodo do plano")+"\"")%> ("+data3+ " - " +data4+")+"!");
                      document.frm.textdatai.value="";
                      document.frm.textdatai.focus();
                      return false;
                    }
                  }
                frm.action = "10_criacaoturmaantecipada_grava.jsp";
                frm.submit();
                return false; 
        }
            }
            }
          }
        }
      }
    }
  }
}

function assunto() { 
  frm.selectass.disabled = false;
  frm.selecttit.disabled = false;
  frm.selecttit.value = null;
  frm.selectcur.value = null;
  frm.action ="10_criacaoturmaantecipada.jsp";
  frm.submit();
  return false; 
}

function titulo() {
  frm.selectass.disabled = false;
  frm.selecttit.disabled = false;
  frm.selectcur.value = null;
  frm.action ="10_criacaoturmaantecipada.jsp";
  frm.submit();
  return false; 
}

function curso() {
  frm.selectass.disabled = false;
  frm.selecttit.disabled = false;
  frm.action ="10_criacaoturmaantecipada.jsp";
  frm.submit();
 }

function entidade() {
  frm.action ="10_criacaoturmaantecipada.jsp";
  frm.submit();
  return false; 
}
  
function insere() {
  if(frm.txt_desc.value == "") {
    alert(<%=("\""+trd.Traduz("DIGITE A DESCRICAO")+"\"")%>)
    frm.txt_desc.focus(true);
    return false;
  }
  else if(frm.txt_cust.value == "") 
  {
    alert(<%=("\""+trd.Traduz("DIGITE O CUSTO")+"\"")%>);
    frm.txt_cust.focus();
    return false;
  } else {
    frm.action="10_criacaoturmaantecipada.jsp";
    frm.submit();
    return true;
  }
}

function deleta() {
    var cont=0;
    for(i=0;i<frm.contador.value;i++) {
        if(eval("frm.vet"+i+".checked")==true) {
            cont = cont + 1;
  }
    }
    if(cont==0) {
        alert(<%=("\""+trd.Traduz("NENHUM ITEM SELECIONADO")+"\"")%>);
  return false;
    }
    else
    {
        if(confirm(<%=("\""+trd.Traduz("DESEJA EXCLUIR O ITEM SELECIONADO?")+"\"")%>)) {
            frm.deleta_vets.value = "S";
            frm.action="10_criacaoturmaantecipada.jsp";
            frm.submit();
            return true;
  }
  else
  return false;
    }
}

function atualiza() {
    //numero2();
    var aux = frm.textcustocur.value;
    var tam = aux.length;
    var nova = "";
    for(i=0;i<tam;i++){
      aux2 = aux.charAt(i);
      if(aux2 == ","){
        aux2 = ".";
        nova = nova + aux2;
      }
      else if(aux2 == "."){
        nova = nova;
      }
      else{
        nova = nova + aux2;
      }
    }
  var c1 = nova;
  
    aux = frm.textcustolog.value;
    tam = aux.length;
    nova = "";
    for(i=0;i<tam;i++){
      aux2 = aux.charAt(i);
      if(aux2 == ","){
        aux2 = ".";
        nova = nova + aux2;
      }
      else if(aux2 == "."){
        nova = nova;
      }
      else{
        nova = nova + aux2;
      }
    }
    var c2 = nova;
    var total = eval(c1+"+"+c2);
    frm.textcustoreal.value = total;
    aux = frm.textcustoreal.value;
    tam = aux.length;
    var nova = "";
    for(i=0;i<tam;i++){
      aux2 = aux.charAt(i);
      if(aux2 == "."){
        aux2 = ",";
        nova = nova + aux2 + aux.charAt(i+1) + aux.charAt(i+2);
        i = tam;
      }
      else{
        nova = nova + aux2;
      }
    }
    frm.textcustoreal.value = nova;
}

function numero(campo){
  aux = campo.value;
  tam = aux.length
  aux2 = aux.substring(tam-1,tam);
  if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" && aux2 != "4" && aux2 != "," &&
     aux2 != "5" && aux2 != "6" && aux2 != "7" && aux2 != "8" && aux2 != "9"){
    aux = campo.value;
    aux = aux.length;
    aux = aux - 1;
    pal = campo.value;
    campo.value = pal.substring(0, aux);
  }
}

function numero2(){
  aux = frm.textcustocur.value;
  tam = aux.length;
  k = 0;
  v = 0;
  if(tam == 1){
    aux2 = aux.substring(tam-1,tam);
    if(aux2 == ","){
      frm.textcustocur.value = "";
    }
  }
  while(tam>0){
    aux2 = aux.substring(tam-1,tam);
    if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" && aux2 != "4" && aux2 != "," &&
       aux2 != "5" && aux2 != "6" && aux2 != "7" && aux2 != "8" && aux2 != "9"){
      k = k+1;
    }
    if(aux2 == ","){
      v = v + 1;
    }
    tam--;
  }
  if(k != 0 || v > 1){
    alert(<%=("\""+trd.Traduz("FORMATO INVALIDO")+"\"")%>);
    frm.textcustocur.value = "";
    frm.textcustocur.focus();
  }
  atualiza();
}

function numero3(campo){
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
    if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" && aux2 != "4" && aux2 != "," &&
       aux2 != "5" && aux2 != "6" && aux2 != "7" && aux2 != "8" && aux2 != "9"){
      k = k+1;
    }
    if(aux2 == ","){
      v = v+1;
    }
    tam--;
  }
  if(k != 0 || v > 1){
    alert(<%=("\""+trd.Traduz("FORMATO INVALIDO")+"\"")%>);
    campo.value = "";
    campo.focus();
  }
}


function FormataData(campo, evento, direcao){
  if (campo.value.length < 10000){
    if (evento != 9 ){//tab
      if(evento != 8 && evento != 46 && evento != 16 && !(evento > 36 && evento < 41)){ //delete, backspace, shift nAo causam evento
        var tam = campo.value.length
        if ((evento >= 48 && evento <= 57) || (evento >= 96 && evento <= 105)) {
          if (tam == 2 || tam == 5){
            campo.value = campo.value + "/";
            }
          } 
        else{
          if (direcao == "up"){
            if (campo.value.length == 0){
              campo.value = ""
              }
            else{
              campo.value = campo.value.substring(0,campo.value.length-1)
              }
            }
          }
        campo.focus()
        }
      } 
    else{
      if (direcao == "down"){
        ChecaData(campo)
        }
      }
    }
  }
  
function ChecaData(THISDATE){
  var erro = 0
  var data = THISDATE.value
  if (data.length != 10) 
    erro=1
  var dia = data.substring(0, 2)// dia
  var barra1 = data.substring(2, 3)// '/'
  var mes = data.substring(3, 5)// mes
  var barra2 = data.substring(5, 6)// '/'
  var ano = data.substring(6, 10)// ano
    
  if (mes < 1 || mes > 12) 
    erro = 1
  if (dia < 1 || dia > 31) 
    erro = 1
  if (ano < 1990) 
    erro = 1
  if (mes == 4 || mes == 6 || mes == 9 || mes == 11){
    if (dia == 31) 
      erro = 1
      }
  if (mes == 2){
    var bis = parseInt(ano/4)
    if (isNaN(bis)){
      erro = 1
      }
    if (dia > 29) 
      erro = 1
    if (dia == 29 && ((ano/4) != parseInt(ano/4))) 
      erro = 1
    }
  if ((erro == 1) && (THISDATE.value != "")) {
    alert(THISDATE.value + ' <%=trd.Traduz("E uma data invAlida!")%>');
    THISDATE.value = "";
    }
  }
function DoCal(elTarget){
  if (showModalDialog){
    var sRtn;
    sRtn = showModalDialog("calendar.htm","","center=yes;status=no;dialogWidth=306px;dialogHeight=220px");
    if (sRtn!="")
      elTarget.value = sRtn;
    } 
  else
    alert(<%=("\""+trd.Traduz("INTERNET EXPLORER 4.0 OU SUPERIOR E NECESSARIO")+"\"")%>)
}

function FormataCampo(campo, evento, direcao){
    aux = campo.value;
    aux = aux.length;
    aux = aux - 1;
    pal = campo.value;
  if (campo.value.length < 1000000){
    if(evento != 9 ){//tab
      if(evento != 8 && evento != 46 && evento != 16 && !(evento > 36 && evento < 41) && evento!=190 && evento!=110 && evento!=194){ //delete, backspace, shift nAo causam evento
        var tam = campo.value.length
        if ((evento >= 48 && evento <= 57) || (evento >= 96 && evento <= 105)){
          if (tam == 2 || tam == 5){
            campo.value = campo.value + "";
          }
        }
        else{
          if (direcao == "up"){
            if (campo.value.length == 0){
                                                        //campo.value = pal.substring(0, aux);
              campo.value = ""
            }
            else{
                                                        //campo.value = pal.substring(0, aux);
              campo.value = "";//campo.value.substring(0,campo.value.length-1)
            }
          }
        }
        campo.focus()
      }
      else if(evento == 16){
                                //campo.value = pal.substring(0, aux);
        campo.value="";
      }

    } 
    else{
      if (direcao == "down"){
        var teste = campo.value.substring(0,1);
        if(campo.value<0){
          alert(<%=("\""+trd.Traduz("Este campo nAo aceita valores negativos !")+"\"")%>);
                                        //campo.value = pal.substring(0, aux);
          campo.value="";
          campo.focus();
          return false;
        }
        else if(teste=="-"||teste=="+"||teste=="~"||teste=="^"||
          teste=="\""||teste=="'"||teste=="!"||teste=="@"||
          teste=="#"||teste=="$"||teste=="%"||teste=="¨"||
          teste=="&"||teste=="*"||teste=="("||teste==")"||
          teste=="_"||teste=="="||teste=="~"||teste=="`"||
          teste=="´"||teste=="{"||teste=="["||teste=="}"||
          teste=="]"||teste=="<"||
          teste==">"||teste==":"||teste==";"||teste=="/"||
          teste=="?"||teste=="|"||teste=="\\"||teste=="^"){
          alert(<%=("\""+trd.Traduz("Este campo nAo aceita caracteres especiais !")+"\"")%>);
                                        //campo.value = pal.substring(0, aux);
          campo.value="";
          campo.focus();
          return false;
        }
      }
    }
  }
  //formataReal(campo);


function cancelar() {
  window.open("06_criarturmaantecipada.jsp", "_parent");
}
function duracao(campo){
  aux = campo.value;
  tam = aux.length;
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
function duracao2(campo){
  aux = campo.value;
  tam = aux.length;
  i = 0;
  nova = "";
  while(i != tam){
    aux2 = aux.substring(i,i+1);
    if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" && aux2 != "4" &&
        aux2 != "5" && aux2 != "6" && aux2 != "7" && aux2 != "8" && aux2 != "9"){
      nova = nova;
    }
    else{
      nova = nova + aux2;
    }
    i++;
    
  }
  campo.value = nova;
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

</script>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Registro")%> - 
<%if (op.equals("I")) {%>
    <%=trd.Traduz("CriaCAo Turma Antecipada")%>
<%} else {%>
    <%=trd.Traduz("AlteraCAo de Turma Antecipada")%>
<%}%>
</title>
<script language="JavaScript" src="/js/scripts.js"></script>

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
              <%String ponto = (String)session.getAttribute("barra");
          if(ponto.equals("..")){%>
                <jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="RG"/></jsp:include> 
                <%}else{%>
                <jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="RG"/></jsp:include> 
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
                if(ponto.equals("..")) {
                  if (request.getParameter("op") == null) {
                    oi = "../menu/menu.jsp?op="+"R";
                  } else {
                    oi = "../menu/menu.jsp?op="+request.getParameter("op");
                  }
                  if (request.getParameter("opt") == null) {
                    oia = "../menu/menu1.jsp?opt="+"CTA";
                  } else {  
                    oia = "../menu/menu1.jsp?opt="+request.getParameter("opt");
                  }
    } else {
                  if (request.getParameter("op") == null) {
                    oi = "/menu/menu.jsp?op="+"R";
                  } else {
                    oi = "/menu/menu.jsp?op="+request.getParameter("op");
                  }
                  if (request.getParameter("opt") == null) {
                    oia = "/menu/menu1.jsp?opt="+"CTA";
                  } else { 
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
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
                <td class="trontrk" align="center">
    <%if (op.equals("I")){%>
      <%=trd.Traduz("CriaCAo Turma Antecipada")%></td>
    <%}else{%>
      <%=trd.Traduz("AlteraCAo de Turma Antecipada")%></td>
    <%}%>
                <td width="29"><img src="../art/bit.gif" width="13" height="15"></td>
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
    <FORM name="frm" method="post">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1">&nbsp;<br><center>
            <table border="0" cellspacing="2" cellpadding="2" width="80%">
                  <tr> 
                    <td class="ftverdanacinza" align="right" height="30" width="3%"><%=trd.Traduz("Assunto")%>:</td>
                    <td class="ftverdanacinza" colspan="4"> 
                      <select name="selectass" class="form" onChange="return assunto();">
                        <option value = "Selecione" selected><%=trd.Traduz("Selecione")%></option>
                      <%query = "SELECT ASS_CODIGO, ASS_NOME FROM ASSUNTO " +
                                "WHERE ASS_ATIVO = 'S' ORDER BY ASS_NOME";
                        if ((!(pag_cur.equals(""))) && (!(pag_cur.equals("Selecione")))) {
                          query_tit = "SELECT ASS_CODIGO FROM TITULO " + 
                                      "WHERE TIT_CODIGO IN (SELECT TIT_CODIGO FROM CURSO WHERE CUR_CODIGO = " + pag_cur + ") ";
                          rs = conexao.executaConsulta(query_tit,session.getId()+"RS_3"); 
                          if (rs.next()) {
                            pag_ass = rs.getString(1);   
                            }
                            if(rs!=null){
                             rs.close();
                             conexao.finalizaConexao(session.getId()+"RS_3");
                            }
                        }
                        if ((!(pag_tit.equals(""))) && (!(pag_tit.equals("Selecione")))) {
                          query_ass = "SELECT ASS_CODIGO FROM TITULO " + 
                                      "WHERE TIT_CODIGO = " + pag_tit + " ";
                          rs = conexao.executaConsulta(query_ass,session.getId()+"RS_4"); 
                            if (rs.next()) {
                                pag_ass = rs.getString(1);
                            }
                            if(rs!=null){
                                rs.close();
                                conexao.finalizaConexao(session.getId()+"RS_4");
                            }
                        }
                        rs = conexao.executaConsulta(query,session.getId()+"RS_5");
                        if (rs.next()) {
                          do {
                            if (pag_ass.equals(rs.getString(1))) {%>
                              <option value = "<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
                          <%} else {%>
                              <option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
                          <%}
                          } while (rs.next());
                        }
                        if(rs!=null){
                             rs.close();
                             conexao.finalizaConexao(session.getId()+"RS_5");
                            }
                        %>
                      </select>
                    </td>
                  </tr>
                  <tr> 
                    <td class="ftverdanacinza" align="right" height="30" width="3%"><%=trd.Traduz("Titulo")%>:</td>
                    <td class="ftverdanacinza" colspan="4"> 
                      <select name="selecttit" class="form" onChange="return titulo();">
                        <option value = "Selecione" selected><%=trd.Traduz("Selecione")%></option>
                       <%if ((!(pag_ass.equals(""))) && (!(pag_ass.equals("Selecione")))) {
                           query = "SELECT TIT_CODIGO, TIT_NOME FROM TITULO " + 
                                   "WHERE TIT_ATIVO = 'S' AND ASS_CODIGO = " + pag_ass + " " + 
                                   "ORDER BY TIT_NOME";            
             } else {
         query = "SELECT TIT_CODIGO, TIT_NOME FROM TITULO " + 
                                   "WHERE TIT_ATIVO = 'S' ORDER BY TIT_NOME";
       }
        if ((!(pag_cur.equals(""))) && (!(pag_cur.equals("Selecione")))) {
            query_cur = "SELECT TIT_CODIGO FROM CURSO " + 
                      "WHERE CUR_CODIGO = " + pag_cur + " ";
            rs = conexao.executaConsulta(query_cur,session.getId()+"RS_6");
            if (rs.next()) {
                pag_tit = rs.getString(1);
                }
             if(rs!=null){
                rs.close();
                conexao.finalizaConexao(session.getId()+"RS_6");
                }
        }
        rs = conexao.executaConsulta(query,session.getId()+"RS_7"); 
        if (rs.next()) {
            do { 
                if (pag_tit.equals(rs.getString(1))) {%>
                    <option value = "<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
                    <%} else {%>
                    <option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
                    <%}
                } while (rs.next());
        }
        if(rs!=null){   
            rs.close();
            conexao.finalizaConexao(session.getId()+"RS_7");
            }
            %>
    </select>
    </td>
    </tr>
    <tr> 
        <td class="ftverdanacinza" align="right" height="30" width="3%"><%=trd.Traduz("Curso")%>:</td>
        <td class="ftverdanacinza" colspan="5"> 
        <select name="selectcur" class="form" onChange="return curso();">
            <option value = "Selecione" selected><%=trd.Traduz("Selecione")%></option>
            <%if ((!(pag_tit.equals(""))) && (!(pag_tit.equals("Selecione")))){
                query = "SELECT CUR_CODIGO, CUR_NOME FROM CURSO " +
                        "WHERE CUR_ATIVO = 'S' AND TIT_CODIGO = " + pag_tit + " " + 
                        "AND CUR_SIMPLES = 'N' ORDER BY CUR_NOME, CUR_CODIGO";
                } 
               else{
                    if ((!(pag_ass.equals(""))) && (!(pag_ass.equals("Selecione")))) {
                        query = "SELECT CUR_CODIGO, CUR_NOME FROM CURSO " + 
                                "WHERE CUR_ATIVO = 'S' AND CUR_SIMPLES = 'N' AND TIT_CODIGO IN (SELECT TIT_CODIGO FROM TITULO WHERE ASS_CODIGO = " + pag_ass + ") " + 
                                "ORDER BY CUR_NOME";
                    }   
                    else {
                      query = "SELECT CUR_CODIGO, CUR_NOME FROM CURSO " +
                              "WHERE CUR_ATIVO = 'S' AND CUR_SIMPLES = 'N' ORDER BY CUR_NOME";
                    }
                }
                rs = conexao.executaConsulta(query,session.getId()+"RS_8");
                if (rs.next()){
                    do {
                        if (pag_cur.equals(rs.getString(1))) {%>
                            <option value = "<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
                            <%} else {%>
                            <option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
                            <%}
                    }while (rs.next());
                }
                if(rs!=null){
                    rs.close();
                    conexao.finalizaConexao(session.getId()+"RS_8");    
                }
                    %>
                      </select>
                    </td>
                  </tr>
                  <tr> 
                    <td class="ftverdanacinza" align="right" height="30" width="3%"><%=trd.Traduz("Data Inicial")%>:</td>
                    <td class="ftverdanacinza" width="25%"> 
                      <input type="text" name="textdatai" value="<%=pag_dtini%>" size="9" onChange="ChecaData(this)" onKeyDown="FormataData(this, window.event.keyCode,'up')" onKeyUp="FormataData(this, window.event.keyCode,'up')">
                      &nbsp;<img onclick="DoCal(textdatai)" style="cursor:hand" src="../art/icon_cal.gif" title="CalendArio" WIDTH="17" HEIGHT="16"> 
                    </td>
                    <td class="ftverdanacinza" width="13%"><%=trd.Traduz("Data Final")%>: </td>
                    <td class="ftverdanacinza" width="49%"> 
                      <input type="text" name="textdataf" value="<%=pag_dtfim%>" size="9" onChange="ChecaData(this)" onKeyDown="FormataData(this, window.event.keyCode,'up')" onKeyUp="FormataData(this, window.event.keyCode,'up')">
                &nbsp;<img onclick="DoCal(textdataf)" style="cursor:hand" src="../art/icon_cal.gif" title="CalendArio" WIDTH="17" HEIGHT="16"> 
                    </td>
                  </tr>
                  <tr> 
                    <td class="ftverdanacinza" align="right" height="30" width="3%"><%=trd.Traduz("Custo Curso")%>: <%=moeda%></td>
                    <td class="ftverdanacinza" nowrap width="25%"> 
                      <input type="text" name="textcustocur" maxlength="10" size="10" value="<%=(pag_cuscur)%>" onKeyUp="numero(this)" onBlur="numero2(this)">
                      (99999,99) + <%=trd.Traduz("Custo Logistica")%>: <%=moeda%>
                    </td>
                    <td class="ftverdanacinza" width="10%"> 
                    <%
            int i=0;
            total=0;
            while(i < vet_cust.size()) {
                aux = (String)vet_cust.elementAt(i); 
                float nova = Float.parseFloat(aux);
                total = total + nova;
                i=i+1;
                pag_cuslog = pag_cuslog.valueOf(total);
            }
            if (op.equals("A") && vet_desc.size()==0 && vet_cust.size()==0) {
                query = "SELECT CRE_DESCRICAO, CRE_CUSTO FROM CUSTOREAL WHERE TUR_CODIGO = " +turma;
                rs = conexao.executaConsulta(query,session.getId()+"RS_9");
                if (rs.next()) {
                    do {
                            if (!vet_desc.contains(rs.getString(1))) {
                                vet_desc.addElement(rs.getString(1));
                                vet_cust.addElement(rs.getString(2));
                                total = total + rs.getFloat(2);
                            }
                        }while (rs.next());
                }
                if(rs!=null){   
                rs.close();
                conexao.finalizaConexao(session.getId()+"RS_9");
                }
            }%>
                      <input type="text" name="textcustolog" maxlength="10" size="10" readonly value="<%=ReaistoStr(total)%>">
                    </td>
                    <td class="ftverdanacinza" nowrap width="13%">= <%=trd.Traduz("Custo Real")%>: <%=moeda%></td>
                    <td class="ftverdanacinza" width="49%">
                      <input type="text" name="textcustoreal" value="" readonly size="10" maxlength="10" >
                    </td>
                  </tr>
                  <tr> 
                    <td class="ftverdanacinza" align="right" height="30" width="3%"><%=trd.Traduz("DURACAO")%>:</td>
                    <td class="ftverdanacinza"> 
                      <input type="text" name="textdurh" size="2" value="<%=pag_duracao%>" onBlur="duracao2(this)" onKeyUp="duracao(this)">: 
                <input type="text" name="textdurm" size="2" maxlength="2" value="<%=pag_duracao2%>" onBlur="duracao2(this)" onKeyUp="duracao(this)"> hh:mm 
                    </td>
                    <td class="ftverdanacinza">&nbsp;</td>
                    <td class="ftverdanacinza"><%=trd.Traduz("TIPO")%>:</td>
                    <td class="ftverdanacinza" width="49%">
                      <select name="selecttip">
                      <option value = "" selected><%=trd.Traduz("SELECIONE")%></option>
                      <%query = "SELECT TCU_CODIGO, TCU_NOME FROM TIPOCURSO ORDER BY TCU_NOME";
                        rs = conexao.executaConsulta(query,session.getId()+"RS_10"); 
                        if (rs.next()) {
                          do {
                            if (rs.getString(1).equals(pag_tipo)){%>
                              <option value = "<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
                          <%} else {%>
                              <option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
                          <%}
                          } while (rs.next());
                        }
                        if(rs!=null){
                            rs.close();
                            conexao.finalizaConexao(session.getId()+"RS_10");
                        }
                        %>
                      </select>
                    </td>
                  </tr>
                  <tr> 
                    <td class="ftverdanacinza" nowrap align="right" height="30" width="3%"><%=trd.Traduz("Nº MInimo de Participantes")%>:</td>
                    <td class="ftverdanacinza" colspan="4"> 
                      <input type="text" name="txtmin" size="5" maxlength="9" value="<%=pag_pmin%>" onBlur="duracao2(this)" onKeyUp="duracao(this)">
                    </td>
                  </tr>
                  <tr> 
                    <td class="ftverdanacinza" nowrap align="right" height="30" width="3%"><%=trd.Traduz("Nº MAximo de Participantes")%>:</td>
                    <td class="ftverdanacinza" colspan="4"> 
                      <input type="text" name="txtmax" size="5" maxlength="9" value="<%=pag_pmax%>" onBlur="duracao2(this)" onKeyUp="duracao(this)">
                    </td>
                  </tr>
                  <tr> 
                    <td class="ftverdanacinza" align="right" height="30" width="3%"><%=trd.Traduz("Entidade")%>:</td>
                    <td class="ftverdanacinza" colspan="4"> 
                      <select name="selectent" onchange="entidade();" >
                        <option value = "" selected><%=trd.Traduz("Selecione")%></option>
<%                     if ((!(pag_cur.equals(""))) && (!(pag_cur.equals("Selecione")))){
                            query = "SELECT E.EMP_CODIGO, E.EMP_NOME FROM EMPRESA E, CURSO C " +
                                    "WHERE C.CUR_CODIGO = " +pag_cur+ " AND E.EMP_CODIGO = C.EMP_CODIGO "+
                                    "ORDER BY E.EMP_NOME";
                            rs = conexao.executaConsulta(query,session.getId()+"RS_11");
                            if (rs.next()) {
                                pag_entidade = rs.getString(1);
                                do {
                                    if (rs.getString(1).equals(pag_entidade)) {%>
                                    <option value = "<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
<%                                  } else {%>
                                    <option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                                  }
                              } while (rs.next());
                            }
                            if(rs!=null){
                                rs.close();
                                conexao.finalizaConexao(session.getId()+"RS_11");
                            }
                          }%>
                      </select>
                    </td>
                  </tr>
                  <tr> 
                    <td class="ftverdanacinza" align="right" height="30" width="3%"><%=trd.Traduz("Instrutor")%>:</td>
                    <td class="ftverdanacinza" colspan="2"> 
                      <select name="selectinst">
                        <option value = ""><%=trd.Traduz("Selecione")%></option>
<%                      if(!pag_entidade.equals("")) {
                            query = "SELECT INS_CODIGO, INS_NOME FROM INSTRUTOR WHERE EMP_CODIGO = "+pag_entidade+" "+
                                    "ORDER BY INS_NOME";
                          //out.println(query);
                          rs = conexao.executaConsulta(query,session.getId()+"RS_12"); 
                          if (rs.next()) {
                            do {
                                if (rs.getString(1).equals(pag_instrutor)) {%>
                                <option value = "<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
<%                              } else {%>
                                <option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                              }
                            }while (rs.next());
                          }
                          if(rs!=null){
                            rs.close();
                            conexao.finalizaConexao(session.getId()+"RS_12");    
                            }
                        }%>
                      </select>
                    </td>
<%                  //*** A alteracao de turma longa duracao, somente serA permitida se nao houver registro para esta turma ***
                    if (op.equals("A")) {
                      query = "SELECT COUNT(*) FROM TREINAMENTO WHERE TUR_CODIGO_REAL = " +turma;
                      rs = conexao.executaConsulta(query,session.getId()+"RS_13"); 
                      if (rs.next()) {
                        if (rs.getInt(1) != 0) altera_tipo_turma = false;
                      }
                    }
                    if(rs!=null){
                        rs.close();
                        conexao.finalizaConexao(session.getId()+"RS_13");    
                    }
                    if (pag_tipo_treinamento.equals("3")) {//longa duracao
                      if (altera_tipo_turma) {%>
                        <td class="ftverdanacinza" colspan="2"><%=trd.Traduz("Longa duracao")%>: &nbsp; <input type="checkbox" name="longa" value="3" checked></td>
<%                    } else {%>
                        <td class="ftverdanacinza" colspan="2"><%=trd.Traduz("Longa duracao")%>: &nbsp; <input type="checkbox" name="longaDisabled" value="3" checked disabled></td>
                        <input type="hidden" name="longa" value="3"> <!-- campo adicional para manter o tipo da turma como LONGO -->
<%                    }
                    } else {
                      if (altera_tipo_turma) {%>
                        <td class="ftverdanacinza" colspan="2"><%=trd.Traduz("Longa duracao")%>: &nbsp; <input type="checkbox" name="longa" value="3"></td>
<%                    } else {%>
                        <td class="ftverdanacinza" colspan="2"><%=trd.Traduz("Longa duracao")%>: &nbsp; <input type="checkbox" name="longa" value="3" disabled></td>
<%                    }
                    }%>
                  </tr>
                  <tr> 
                    <td class="ftverdanacinza" align="right" width="3%"><%=trd.Traduz("OBSERVACAO")%>:</td>
                    <td class="ftverdanacinza" colspan="4"> 
                      <textarea name="txtobs" rows="4" cols="50" onKeyUp="aspa(this)" onBlur="aspa2(this)"><%=pag_obs%></textarea>
                    </td>
                  </tr>
                  <tr> 
                    <td class="ftverdanacinza" align="center" colspan="5">&nbsp;<br>
                      <input type="button" onClick="return enviar();" value=<%=("\""+trd.Traduz("Confirmar")+"\"")%> class="botcin" name="button">
                      &nbsp;&nbsp;
                      <input type="button" onClick="return cancelar();" value=<%=("\""+trd.Traduz("Cancelar")+"\"")%> class="botcin" name="button">
                    </td>
                  </tr>
                  <tr> 
                    <td class="ftverdanacinza" align="center" colspan="100%"><hr></td>
                  </tr>
                </table>
                <table border="0" cellspacing="0" cellpadding="0" width="100%">
                  <tr align="center" valign="middle">
                    <td>
                      <table border="0" cellspacing="0" cellpadding="0" width="100%">
                        <tr>
                          <td valign="middle" class="trontrk" align="center"><%=trd.Traduz("CADASTRO DE CUSTO LOGISTICA")%></td>
                        </tr>
                        <tr align="center">
                          <td valign="top">
                            &nbsp;&nbsp;&nbsp;
                            <font class="ftverdanacinza"><%=trd.Traduz("DESCRICAO")%>:</font>
                            <input type="text" name="txt_desc" size="50" onKeyUp="aspa(this)" onBlur="aspa2(this)">
                            &nbsp;&nbsp;&nbsp;
                            <font class="ftverdanacinza"><%=trd.Traduz("CUSTO LOGISTICA")%>: <%=moeda%></font>
                            <input type="text" name="txt_cust" size="10" onKeyUp="numero(this)" onBlur="numero3(this)">
                            <font class="ftverdanacinza">(99999,99)</font>
                            <br>
                            <center>
                              <input class="botcin" type="button" value=<%=("\""+trd.Traduz("INCLUIR")+"\"")%> OnClick="return insere();">
                              <input class="botcin" type="button" value=<%=("\""+trd.Traduz("EXCLUIR")+"\"")%> OnClick="return deleta();">
                            </center>
                          &nbsp;&nbsp;&nbsp;
                            <!--<center>-->
                              <table border="0" cellspacing="1" cellpadding="0" width="80%">
                                <tr>
                                  <td>&nbsp;</td>
                                  <td class="celtittab" width="80%">&nbsp;<%=trd.Traduz("DESCRICAO")%></td>
                                  <td class="celtittab" align="center" width="20%"><%=trd.Traduz("CUSTO LOGISTICA")%></td>
                                </tr>
<%                              while(a<vet_cust.size()) {
                                  aux = (String)vet_cust.elementAt(a);
                                  float novo = Float.parseFloat(aux);%>
                                  <tr>
                                    <td class="celnortab" align="center">
                                      <input name="vet<%=a%>" type="checkbox" value="<%=a%>" onblur="numero3(this)">
                                    </td>
                                    <td class="celnortab">&nbsp;<%=vet_desc.elementAt(a)%></td>
                                    <td class="celnortab" align="right"><%=ReaistoStr2(novo, moeda)%></td>
                                  </tr>
<%                                a=a+1;
                                }%>
                                <tr>
                                  <td colspan="3" valign="top" class="ctvdiv"><img src="../art/bit.gif" width="1" height="1"></td>
                                </tr>
                                <tr>
                                  <td class="celnortab">&nbsp;</td>
                                  <td align="right" class="celnortab"><b><%=trd.Traduz("VALOR TOTAL")%>:&nbsp;</b></td>
                                  <td align="right" class="celnortab"><%=ReaistoStr2(total, moeda)%></td>
                                </tr> 
                                <tr><td>&nbsp;</td></tr>
                              </table>
                            <!--</center>-->
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
              <!--</center>-->
              <input type="hidden" name="total2" value="<%=total%>">
              <input type="hidden" name="contador" value="<%=a%>">
              <input type="hidden" name="limpa_vets" value="N">
              <input type="hidden" name="deleta_vets" value="N">
              <input type="hidden" name="log" value="S">
              <input type="hidden" name="tipo" value="<%=op%>">
              <input type="hidden" name="rdo_turma" value="<%=turma%>">
              <input type="hidden" name="cont_avaliacao" value="<%=cont%>">
          </td>
        </tr>
  </form>
      </table>
    </td>
  </tr>
  <script language="JavaScript1.1" >
    document.frm.txt_desc.focus();
  </script>
  <tr> 
    <td align="right" height="30" class="difundo"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td> 
<%          if(ponto.equals("..")){%>
                <jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include>
<%          }else{%>    
                <jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>
<%          }%>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
<script language="JavaScript">

 var test = atualiza();

</script>
</html>
<%
//***FINALIZAÇÕES***
//} catch (Exception r) {
//  out.println(r);
//} finally  {
//if(rs != null) rs.close();
//conexao.finalizaConexao();
//}
%>