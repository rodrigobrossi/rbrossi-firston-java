<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<%@page import=" java.sql.*, java.text.*, java.util.*"%>

<%
//try {

response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")) {
  response.setHeader("Cache-Control", "no-cache");
}

request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi");
int pag = Integer.parseInt((String)session.getAttribute("pagina"));
String usu_plano = "";
usu_plano = usu_plano.valueOf(session.getAttribute("usu_plano")); 
Vector per = (Vector)session.getAttribute("vetorPermissoes");

ResultSet rs = null, rsf = null, rsct = null;
ResultSet rs_1 = null, rs_2 = null, rs_3 = null, rs_4 = null;

Vector funcvet = new Vector();
session.setAttribute("funcs", funcvet);

String query = "", queryf = "", func = "", queryct = "", cor = "", plc_obrigatorio = "", assunto = "", tit_nome = "", cur_versao = "", campo9 = "", campo10 = "", tef_codigo = "", ass_codigo = "", link = ""; 

java.util.Date dia = new java.util.Date();

int tit_codigo = 0, qtd = 0, contador_rs = 0;

boolean vers = false;

if (!(request.getParameter("fun_codigo") == null)){
 func = request.getParameter("fun_codigo");
}
else
{
 func="0";
}

String query_1="", query_2="", query_3="", query_4="";

queryf = "SELECT FUN_CODIGO, FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = " + func + " ";
query_1 = "SELECT DISTINCT PLANOCARREIRA.CAR_CODIGO, ASSUNTO.ASS_NOME, TITULO.TIT_NOME, TITULO.TIT_CODIGO, "+
          "PLANOCARREIRA.PLC_OBRIGATORIO, CURSO.CUR_VERSAOATUAL, 'P' AS COR, TREINAMENTO.TUR_CODIGO_REAL, NULL, NULL, 'N' AS LINK, " +
          "TREINAMENTO.JUS_CODIGO, ASSUNTO.ASS_CODIGO, TREINAMENTO.TEF_CODIGO FROM PLANOCARREIRA, ASSUNTO, TITULO, CURSO, TREINAMENTO "+
          "WHERE TITULO.ASS_CODIGO = ASSUNTO.ASS_CODIGO AND PLANOCARREIRA.TIT_CODIGO = TITULO.TIT_CODIGO AND CURSO.TIT_CODIGO = TITULO.TIT_CODIGO "+
          "AND TREINAMENTO.CUR_CODIGO = CURSO.CUR_CODIGO AND TREINAMENTO.FUN_CODIGO = " + func + " AND TREINAMENTO.TUR_CODIGO_REAL IS NULL AND TREINAMENTO.JUS_CODIGO IS NULL "+
          "AND PLANOCARREIRA.CAR_CODIGO IN (SELECT CAR_CODIGO FROM FUNCIONARIO WHERE FUN_CODIGO = " + func + ") ";
//UNION ALL
query_2 = "SELECT DISTINCT PLANOCARREIRA.CAR_CODIGO, ASSUNTO.ASS_NOME, TITULO.TIT_NOME, TITULO.TIT_CODIGO, PLANOCARREIRA.PLC_OBRIGATORIO, "+
          "NULL, 'AV' AS COR, NULL, NULL, NULL, 'N' AS LINK, NULL, ASSUNTO.ASS_CODIGO, NULL FROM PLANOCARREIRA, ASSUNTO, TITULO " +
          "WHERE TITULO.ASS_CODIGO = ASSUNTO.ASS_CODIGO AND PLANOCARREIRA.TIT_CODIGO = TITULO.TIT_CODIGO "+
          "AND TITULO.TIT_CODIGO NOT IN (SELECT TIT_CODIGO FROM CURSO) "+
          "AND PLANOCARREIRA.CAR_CODIGO IN (SELECT CAR_CODIGO FROM FUNCIONARIO WHERE FUN_CODIGO = " + func + ") ";
//UNION ALL
 query_3 = "SELECT DISTINCT PLANOCARREIRA.CAR_CODIGO, ASSUNTO.ASS_NOME, TITULO.TIT_NOME, TITULO.TIT_CODIGO, PLANOCARREIRA.PLC_OBRIGATORIO, "+
           "CURSO.CUR_VERSAOATUAL, 'AV' AS COR, NULL, NULL, NULL, 'S' AS LINK, NULL, ASSUNTO.ASS_CODIGO, NULL "+
           "FROM PLANOCARREIRA, ASSUNTO, TITULO, CURSO WHERE TITULO.ASS_CODIGO = ASSUNTO.ASS_CODIGO AND PLANOCARREIRA.TIT_CODIGO = TITULO.TIT_CODIGO "+
           "AND CURSO.TIT_CODIGO = TITULO.TIT_CODIGO AND TITULO.TIT_CODIGO NOT IN (SELECT TIT_CODIGO FROM CURSO "+
           "WHERE CUR_CODIGO IN (SELECT CUR_CODIGO FROM TREINAMENTO WHERE FUN_CODIGO = " + func +" AND JUS_CODIGO IS NULL)) "+
           "AND PLANOCARREIRA.CAR_CODIGO IN (SELECT CAR_CODIGO FROM FUNCIONARIO WHERE FUN_CODIGO = " + func + ")";
 //UNION ALL 
query_4 = "SELECT DISTINCT PLANOCARREIRA.CAR_CODIGO, ASSUNTO.ASS_NOME, TITULO.TIT_NOME, TITULO.TIT_CODIGO, PLANOCARREIRA.PLC_OBRIGATORIO, "+
          "CURSO.CUR_VERSAOATUAL, 'V' AS COR,  TREINAMENTO.TUR_CODIGO_REAL, TURMA.TUR_VERSAO, TURMA.TUR_DATAINICIO, 'N' AS LINK, TREINAMENTO.JUS_CODIGO, ASSUNTO.ASS_CODIGO, TREINAMENTO.TEF_CODIGO "+
          "FROM PLANOCARREIRA, ASSUNTO, TITULO, CURSO, TREINAMENTO, TURMA WHERE TITULO.ASS_CODIGO = ASSUNTO.ASS_CODIGO "+
          "AND PLANOCARREIRA.TIT_CODIGO = TITULO.TIT_CODIGO AND CURSO.TIT_CODIGO = TITULO.TIT_CODIGO "+
          "AND TREINAMENTO.CUR_CODIGO = CURSO.CUR_CODIGO AND TURMA.TUR_CODIGO = TREINAMENTO.TUR_CODIGO_REAL "+
          "AND TREINAMENTO.FUN_CODIGO = " + func + " AND TREINAMENTO.TUR_CODIGO_REAL IS NOT NULL "+
          "AND PLANOCARREIRA.CAR_CODIGO IN (SELECT CAR_CODIGO FROM FUNCIONARIO WHERE FUN_CODIGO = " +  func + ") ORDER BY ASSUNTO.ASS_NOME, TITULO.TIT_NOME ";

/*out.println("query_1 =" + query_1);
out.println("query_2 =" + query_2);
out.println("query_3 =" + query_3);
out.println("query_4 =" + query_4);*/

rs_1 = conexao.executaConsulta(query_1,session.getId()+"RS1");
rs_2 = conexao.executaConsulta(query_2,session.getId()+"RS2");
rs_3 = conexao.executaConsulta(query_3,session.getId()+"RS3");
rs_4 = conexao.executaConsulta(query_4,session.getId()+"RS4");

//rs = conexao.executaConsulta(query_4);
%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("SolicitaCAo")%> - <%=trd.Traduz("PrE-Requisitos")%></title>
<script language="JavaScript" src="scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<script language="JavaScript"> 
function msgtitulo(){
  alert(<%=("\""+trd.Traduz("NAO EXISTE CURSO CADASTRADO PARA O TITULO SELECIONADO")+"\"")%>);
  return false;   
}

function deleta(){
  var teste = 0;
  var cod = 0;
  for(i=1;i<frm.cont.value;i++){
    if(eval("frm.check"+i+".checked")==true){
      teste = teste+1;
      cod = eval("frm.hd"+i+".value");
    }
  }
  if(teste == 0){
    alert(<%=("\""+trd.Traduz("NENHUM ITEM SELECIONADO")+"\"")%>);
    return false;
  }
  else{

    if(confirm(<%=("\""+trd.Traduz("Deseja Excluir o item selecionado?")+"\"")%>)){
      frm.action="solic_deleta.jsp";
      frm.submit();
      return true;
    }
    else{
      return false;
    }
  }
}

function altera(){
  var teste = 0;
  var cod = 0;
  for(i=1;i<frm.cont.value;i++){
    if(eval("frm.check"+i+".checked")==true){
      teste = teste+1;
      cod = eval("frm.hd"+i+".value");
    }
  }
  if(teste == 0){
    alert(<%=("\""+trd.Traduz("NENHUM ITEM SELECIONADO")+"\"")%>);
    return false;
  }
  else{
    if(teste>1){
      alert(<%=("\""+trd.Traduz("Selecione apenas um item")+"\"")%>);
    }
    else{
      window.open("solic_extra.jsp?"+cod,"_parent");
    }
  }
  return false;
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
        %>
              <%if(ponto.equals("..")){%>
               <jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="SO"/></jsp:include> 
               <%}else{%>
               <jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="SO"/></jsp:include> 
               
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
                  oi = "../menu/menu.jsp?op="+"S";
        }
        else
        {
                  oi = "../menu/menu.jsp?op="+request.getParameter("op");
        }
        if (request.getParameter("opt") == null)
        {
                  oia = "../menu/menu1.jsp?opt="+"S&op=S";
        } 
        else
        {  
                  oia = "../menu/menu1.jsp?opt="+request.getParameter("opt")+"&op=S";
        }
        }else{
        if (request.getParameter("op") == null)
                {
                          oi = "/menu/menu.jsp?op="+"S";
                }
                else
                {
                          oi = "/menu/menu.jsp?op="+request.getParameter("op");
                }
                if (request.getParameter("opt") == null)
                {
                          oia = "/menu/menu1.jsp?opt="+"S&op=S";
                } 
                else
                {  
                          oia = "/menu/menu1.jsp?opt="+request.getParameter("opt")+"&op=S";
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
                <td class="trontrk"><%=trd.Traduz("PRE-REQUISITOS")%></td>
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
      <FORM name="frm">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
                </tr>
                <tr> 
                  <td height="12" class="ctfontc" align="center"> 
                    <table border="0" cellspacing="1" cellpadding="1">
                      <tr class="ctfontb"> 
                        <td width="10">St</td>
                        <td width="90">= <%=trd.Traduz("STATUS")%></td>
                        <td width="10"><img src="../art/green.gif" width="17" height="17"></td>
                        <td width="90">= <%=trd.Traduz("REALIZADO")%></td>
                        <td width="10"><img src="../art/black.gif" width="17" height="17"></td>
                        <td width="90">= <%=trd.Traduz("PLANEJADO")%></td>
                        <td width="10"><img src="../art/red.gif" width="17" height="17"></td>
                        <td width="90">= <%=trd.Traduz("REQUERIDO")%></td>
          <%if (prm.buscaparam("PREREQDESEJADO").equals("S")){%>
                        <td width="10"><img src="../art/blue.gif" width="17" height="17"></td>
                        <td width="90">= <%=trd.Traduz("DESEJADO")%></td>
          <%}%>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
                </tr>
                <tr> 
                  <td class="ctvdiv" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
                </tr>
                <tr> 
                  <td>&nbsp;<br>
<%
rsf = conexao.executaConsulta(queryf, session.getId()+"RS5");
if (rsf.next())
{
%>
                    <span class="ftverdanacinza"><%=trd.Traduz("FUNCIONARIO")%>:</span> <span class="ftverdanapreto"><a class="lnk" href="result_solics.jsp?fun_codigo=<%=func%>" ><%=rsf.getString(2)%></a></span> 
<%
}

if(rsf != null){
    rsf.close();
    conexao.finalizaConexao(session.getId()+"RS5");
}

boolean lnk = true;
int titulo = -1;
int cont = 1;

//rs = conexao.executaConsulta(query_4);
//rs = rs_2;
%>
<p>
<table border="0" cellspacing="1" cellpadding="1" width="100%" height="34">
  <tr class="celtittab"> 
    <td width="2%" height="28" bgcolor="FFFFFF">
      <div align="center">&nbsp;</div>
    </td>   
    <td align="center" width="2%" height="28" width="8%"> 
      <div align="center">St</div>
    </td>
    <td width="24%" height="28"> 
      <div align="center"><%=trd.Traduz("ASSUNTO")%></div>
    </td>
    <td width="34%" height="28"> 
      <div align="center"><%=trd.Traduz("TITULO")%></div>
    </td>
    
    <td width="14%" height="28"> 
      <div align="center"><%=trd.Traduz("DATA REALIZACAO")%></div>
    </td>
  </tr>

<%    rs = null; 
      if (true) {
      for (int i = 1; i <= 4; i++) {
        rs = null;
        if (i==1) rs = rs_1;
        if (i==2) rs = rs_2;
        if (i==3) rs = rs_3;
        if (i==4) rs = rs_4;
        if (rs.next()) {
        contador_rs++;
  do{
    if(rs.getString(2) != null)
      assunto = rs.getString(2);
    if(rs.getString(3) != null)
      tit_nome = rs.getString(3);
    if(rs.getString(4) != null)
      tit_codigo = rs.getInt(4);
    if(rs.getString(5) != null)
      plc_obrigatorio = rs.getString(5);
    if(rs.getString(6) != null)
      cur_versao = rs.getString(6);
    if(rs.getString(7) != null)
      cor = rs.getString(7);
    if(rs.getString(9) != null)
      campo9 = rs.getString(9);
    if(rs.getString(10) != null)
    {
      campo10 = rs.getString(10);
      dia = rs.getDate(10);
    }
    if(rs.getString(11) != null)
      link = rs.getString(11);
    if(rs.getString(13) != null)
      ass_codigo = rs.getString(13);
    if(rs.getString(14) != null)
      tef_codigo = rs.getString(14);

    if (titulo != tit_codigo) {%>  
    <tr class="celnortab"> 
    <td align="center" width="1%" height="17"> 
    <%
      if (cor.equals("P"))
      {
        if(per.contains("SOLICITACAO - PRE REQUISITOS - MANUTENCAO"))
        {
          %>
            <div align="center">
            <input type="checkbox" name="check<%=cont%>" value="<%=tef_codigo%>">
            <input type="hidden" name="hd<%=cont%>" value ="origem=prerequisitos&extra=N&fun_codigo=<%=tef_codigo%>&selectass=<%=ass_codigo%>&selecttit=<%=tit_codigo%>&origem=prerequisitos&contador=1&operacao=U&checkbox1=1&fun_cod_fun=<%=func%>">
            </div>
          <%
          cont= cont+1;
        }

        else
        {
          %>
            <div align="center">&nbsp;</div>
          <%
        }       
      }     
      %>          
    
    </td>
    <%
    if (cor.equals("V")) {
      queryct = "SELECT COUNT(*) FROM CURSO WHERE CUR_SIMPLES = 'N' AND TIT_CODIGO = " + tit_codigo + "";
      //out.println(queryct);
      rsct = conexao.executaConsulta(queryct,session.getId()+"RS6");
      if(rsct.next()){
          qtd = rsct.getInt(1);
          lnk = false;
          %><td align="center" width="1%" height="17"><img src="../art/green.gif" width="17" height="17"></td><%
      }
      else{
        lnk = false;
        %><td align="center" width="1%" height="17"><img src="../art/green.gif" width="17" height="17"></td><%
      }
      
      if(rsct != null){
          rsct.close();
          conexao.finalizaConexao(session.getId()+"RS6");
      }

    }

    if (cor.equals("P")) {
      lnk = false;
      %><td align="center" width="2%" height="17"><img src="../art/black.gif" width="17" height="17"></td><%
    }
    if (cor.equals("AV")) {
      if (!(plc_obrigatorio.equals("S"))) {
        %><td align="center" width="2%" height="17"><img src="../art/blue.gif" width="17" height="17"></td><%
      }
      else {
        %><td align="center" width="2%" height="17"><img src="../art/red.gif" width="17" height="17"></td><%
      }
    }%>
    <td width="11%" height="17"><%=assunto%></td>
  <%if (lnk == true) {
    if (link.equals("S")){%>
       <td width="21%" height="17"><a class="lnk" href="solic_extra.jsp?extra=N&fun_codigo=<%=func%>&selectass=<%=ass_codigo%>&selecttit=<%=tit_codigo%>&origem=prerequisitos&contador=1&operacao=I"><%=tit_nome%></a></td>
    <%}else
    {
      %>
        <td width="21%" height="17"><a class="lnk" href="#" onclick="return msgtitulo();"><%=tit_nome%></a></td>
      <%
    }
  }
  else
  {   
  %>
  <td width="21%" height="17"><%=tit_nome%></td>
  <%
  }
    queryct = "SELECT COUNT(*) FROM CURSO WHERE CUR_SIMPLES = 'N' AND TIT_CODIGO = " + tit_codigo + "";
    if(rsct != null){
        rsct.close();
        conexao.finalizaConexao(session.getId()+"RS6");
    }

    String dataf = new String();
    if (!(campo10.equals(""))){     
      SimpleDateFormat data1 = new SimpleDateFormat("dd/MM/yyyy");
      dataf = data1.format(dia);
    }
    
    %>
    <%if (!(campo10.equals(""))){%>
      <td width="10%" height="17" align="left"><%=dataf%>
    <%}else{%>
    <td width="10%" height="17" align="right">&nbsp;
    <%}%>
 
      </td>
  </tr>
<%   
 titulo = tit_codigo;
 lnk = true;
  } 
 } while (rs.next());
 }
 }
}

if (contador_rs == 0 ) {
%>

<p> 
<table border="0" cellspacing="1" cellpadding="1" width="100%" height="34">
    <tr><td>&nbsp;</td></tr>
  <tr class="celtittab"> 
    <td align="center" width="100%" height="28" width="8%"> 
      <div align="center"><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...</div>
    </td>   
  </tr>

<%
}
%>
                    </table>
                    <br>
                    &nbsp; </td>
                </tr>
              </table>
              <center>
        <%
          if(per.contains("SOLICITACAO - PRE REQUISITOS - MANUTENCAO"))
          {
            %>
                    <input type ="button" class="botcin" value=<%=("\""+trd.Traduz("ALTERAR")+"\"")%> Onclick="return altera();">&nbsp;<input type ="button" class="botcin" value=<%=("\""+trd.Traduz("EXCLUIR")+"\"")%> Onclick="return deleta();">
            <%
          }
        %>
              </center>
          </td>
          <input type="hidden" name="fun_codigo" value ="<%=func%>">
          <input type="hidden" name="cont" value="<%=cont%>">
      <input type="hidden" name="origem" value="prerequisitos"> 
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


if(rs_1 != null){
    rs_1.close();
    conexao.finalizaConexao(session.getId()+"RS1");
}

if(rs_2 != null){
    rs_2.close();
    conexao.finalizaConexao(session.getId()+"RS2");
}

if(rs_3 != null){
    rs_3.close();
    conexao.finalizaConexao(session.getId()+"RS3");
}

if(rs_4 != null){
    rs_4.close();
    conexao.finalizaConexao(session.getId()+"RS4");
}


//} catch (Exception e) {
//  out.println(e);
//}


%>