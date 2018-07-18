<%
//Limpa cache
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")) {
  response.setHeader("Cache-Control", "no-cache");
}
%>


<%@page import=" java.sql.*, java.text.*, java.util.*"%>


<%!
public String replaceString(String s, String busca, String troca){
    String nova = "";
    int ini = s.indexOf(busca);
    boolean ok = false;
    if(ini>0){
        ok = true;
    }
    else{
	nova = s;
    }
    while (ok){
	int fim = busca.length();
	nova = s.substring(0,ini) + troca + s.substring(ini+fim,s.length());
	ini = nova.indexOf(busca);
	if(ini>0){
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
try {

//recupera valores
request.getSession();
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");


String usu_codigo = ""; usu_codigo = (session.getAttribute("fun_codigo")==null)?"":usu_codigo.valueOf((Integer)session.getAttribute("fun_codigo"));
String usu_tipo = (session.getAttribute("usu_tipo")==null)?"":(String)session.getAttribute("usu_tipo");
String usu_nome = (session.getAttribute("usu_nome")==null)?"":(String)session.getAttribute("usu_nome"); 
String usu_login = (session.getAttribute("usu_login")==null)?"":(String)session.getAttribute("usu_login");
Integer usu_fil = (Integer)session.getAttribute("usu_fil");
Integer usu_idi = (Integer)session.getAttribute("usu_idi");
String usu_plano = ""; usu_plano = (session.getAttribute("usu_plano")==null)?"":usu_plano.valueOf(session.getAttribute("usu_plano")); 
int pag = (((String)session.getAttribute("pagina")==null)?7:Integer.parseInt((String)session.getAttribute("pagina")));

ResultSet rs = null, rsnp = null, rsF = null, rsa = null;

String ass = (request.getParameter("selectass")==null)?"":request.getParameter("selectass");
String tit = (request.getParameter("selecttit")==null)?"":request.getParameter("selecttit");
String cur = (request.getParameter("selectcur")==null)?"":request.getParameter("selectcur");
String dtini = (request.getParameter("txtdtinic")==null)?"":request.getParameter("txtdtinic");
String dtfim = (request.getParameter("txtdtfim")==null)?"":request.getParameter("txtdtfim");
String cuscur = (request.getParameter("txtcustocurso")==null)?"":request.getParameter("txtcustocurso"); cuscur = replaceString(cuscur,",",".");
String cuslog = (request.getParameter("txtcustolog")==null)?"":request.getParameter("txtcustolog"); cuslog = replaceString(cuslog,",",".");
String duracao = (request.getParameter("txtduracao")==null)?"":request.getParameter("txtduracao");
String duracao2 = (request.getParameter("txtduracao2")==null)?"":request.getParameter("txtduracao2");
String entidade = (request.getParameter("selectent")==null)?"":request.getParameter("selectent");
String instrutor = (request.getParameter("selectinst")==null)?"":request.getParameter("selectinst");
String obs = (request.getParameter("txtobs")==null)?"":request.getParameter("txtobs");
int cont_avaliacao = (request.getParameter("cont_avaliacao")==null)?0:Integer.parseInt((String)request.getParameter("cont_avaliacao"));

Vector funcvet = new Vector();
Vector funcvetnp = new Vector();

if ((Vector)session.getAttribute("vec_plan") != null)
funcvet = (Vector)session.getAttribute("vec_plan");
else
funcvet.setSize(0);

if ((Vector)session.getAttribute("vec_nplan") != null)
funcvetnp =  (Vector)session.getAttribute("vec_nplan");
else
funcvetnp.setSize(0);

java.util.Date  dataAtual = new java.util.Date();
SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
String dia = formato.format(dataAtual);
String turma="", query="", queryt="", querynp="", versao="", questionario="", envio="", vencimento="", processo="", n="", fun_cod="";

//insere itens no vetor
/*for(int k=1 ; k<=pag;k++) {
    if ((request.getParameter("chktreiplan" + n.valueOf(k)) != null)) {
        //out.println(request.getParameter("chktreiplan" + n.valueOf(k)));
	if (!(funcvet.contains(request.getParameter("chktreiplan" + n.valueOf(k)))))
            funcvet.add(request.getParameter("chktreiplan" + n.valueOf(k)));
    }
}*/

float h = 0, m = 0, dur = 0;
h = (float)Float.parseFloat(duracao);
m = (float)Float.parseFloat(duracao2);
dur = (h * 60) + m;

//versao
query = "SELECT CUR_VERSAOATUAL FROM CURSO WHERE CUR_CODIGO = " +cur;
rs = conexao.executaConsulta(query,session.getId()+"RS_1");
if (rs.next()) versao = rs.getString(1);
else versao = "1";
if(rs!=null){
rs.close();
conexao.finalizaConexao(session.getId()+"RS_1");
}
if(!(instrutor.equals("")))
{
	query = "INSERT INTO TURMA (EMP_CODIGO, FUN_CODIGO, TUR_DATAINICIO, " + 
		    "TUR_DATAFINAL, PLA_CODIGO,  TUR_DURACAO, INS_CODIGO, TUR_CUSTO, CUR_CODIGO, TUR_VAGAS, " + 
			"TUR_OBS, TUR_PLANEJADA, TUR_REPROGRAMADA, TUR_REGISTRADA, TUR_CUSTO2, TTR_CODIGO, TUR_VERSAO) " +
	        "VALUES (" + entidade + ", " + usu_codigo + ", CONVERT(datetime, '" + dtini + "', 103), " +
		    "CONVERT(datetime, '" + dtfim + "', 103), " + usu_plano + ", " + dur + ", " + instrutor + ", " + 
	        cuscur + ", " + cur + ", 0, '" + obs + "', 'S', 'N', 'S', " + cuslog + ", 1, "+versao+")";
}

else
{
	query = "INSERT INTO TURMA (EMP_CODIGO, FUN_CODIGO, TUR_DATAINICIO, " + 
			"TUR_DATAFINAL, PLA_CODIGO,  TUR_DURACAO, TUR_CUSTO, CUR_CODIGO, TUR_VAGAS, " + 
			"TUR_OBS, TUR_PLANEJADA, TUR_REPROGRAMADA, TUR_REGISTRADA, TUR_CUSTO2, TTR_CODIGO, TUR_VERSAO) " +
		    "VALUES (" + entidade + ", " + usu_codigo + ", CONVERT(datetime, '" + dtini + "', 103), " +
			"CONVERT(datetime, '" + dtfim + "', 103), " + usu_plano + ", " + dur + ", " + cuscur + ", " + cur + ", 0, '" + obs + "', 'S', 'N', 'S', " + cuslog + ", 1, "+versao+")";
}

conexao.executaAlteracao(query);

//Para os Planejados
queryt = "SELECT MAX(TUR_CODIGO) FROM TURMA WHERE FUN_CODIGO = " + usu_codigo + " AND CUR_CODIGO = " + cur + " AND TUR_DATAINICIO = CONVERT(datetime, '" + dtini + "', 103) AND TUR_OBS = '" +  obs + "'";

rs = conexao.executaConsulta(queryt,session.getId()+"RS_2");
if (rs.next()) turma = rs.getString(1);
for(int k=0 ; k<funcvet.size(); k++) {
    String[] strpa = (String[])funcvet.elementAt(k);
    query = "UPDATE TREINAMENTO SET TUR_CODIGO_REAL = " + turma + ", TTR_CODIGO = 1 WHERE TEF_CODIGO = " + strpa[0];
    conexao.executaAlteracao(query);    
}
if(rs!=null){
rs.close();
conexao.finalizaConexao(session.getId()+"RS_2");
}
//Para os NAo Planejados se houver
    for (int jj=0; jj<funcvetnp.size(); jj++) {
        //out.println("Entrou");
        String[] strnpa = (String[])funcvetnp.elementAt(jj);
        query = "INSERT INTO TREINAMENTO (FUN_CODIGO, CUR_CODIGO, PLA_CODIGO, TTR_CODIGO, QBR_CODIGO, " +
	        "TEF_DURACAO, TEF_CUSTO, TEF_DATASOLICITACAO, TEF_RESULTADOESPERADO, TEF_PLANEJADO, TEF_TIPOSOLICITACAO) " +
	        "VALUES (" + strnpa[1] + ", " + cur + ", " + usu_plano + ", 1" + ", 1, " + dur + ", " + cuscur + 
                ", CONVERT(datetime, '"+dia+"', 103), '" + obs + "', 'N', 1)";
        conexao.executaAlteracao(query);        
        //out.println("Query = " + query);
        querynp = "SELECT TEF_CODIGO FROM TREINAMENTO WHERE FUN_CODIGO = " +  strnpa[1] + " AND CUR_CODIGO = " + cur + " AND TEF_DATASOLICITACAO = CONVERT(datetime, '"+dia+"', 103) AND TEF_RESULTADOESPERADO = '" +  obs + "'";
        //out.println("querynp = " + querynp);
        rsnp = conexao.executaConsulta(querynp,session.getId()+"RS_3");
        if (rsnp.next()) {                    
            query = "UPDATE TREINAMENTO SET TUR_CODIGO_REAL = " + turma + ", TTR_CODIGO = 1 WHERE TEF_CODIGO = " + rsnp.getString(1);            
            //out.println("queryf = " + query);
            conexao.executaAlteracao(query);
        }
        if(rsnp!=null){
        rsnp.close();
        conexao.finalizaConexao(session.getId()+"RS_3");
        }
    } 


//**Insere custo logistaica em banco (tabela CUSTOREAL)**
Vector vet_desc = new Vector();
Vector vet_cust = new Vector();
//recupera da sessao os vetores de custo
if((Vector)session.getAttribute("vet_descS") != null)
    vet_desc = (Vector)session.getAttribute("vet_descS");
if((Vector)session.getAttribute("vet_custS") != null)
    vet_cust = (Vector)session.getAttribute("vet_custS");
//insere
int cont = 0; 
String desc_vet="", valor_vet="";
while(cont<vet_cust.size()) {
    desc_vet = (String)vet_desc.elementAt(cont);
    valor_vet = (String)vet_cust.elementAt(cont);
    query = "INSERT INTO CUSTOREAL (TUR_CODIGO, CRE_DESCRICAO, CRE_CUSTO, FUN_CODIGO) "+
            "VALUES (" +turma+ ", '" +desc_vet+ "', " +valor_vet+ ", " +usu_codigo+ ")";
    //out.println(query +"<br>");
    conexao.executaAlteracao(query);
    cont++;
}

int s_solic = 0;

//insere avaliacoes
for (int i=0; i<=cont_avaliacao; i++) {//loop para as avaliacoes
	if (request.getParameter("chk_"+i) != null) {
		if (!request.getParameter("chk_"+i).equals("")) {
			//out.println("AVALIACAO "+i);
			questionario = request.getParameter("cbo_questionario_"+i);
			envio = request.getParameter("txt_dt_envio_"+i);
			vencimento = request.getParameter("txt_dt_vencimento_"+i);
			
                        //Planejados
                        for (int ii=0; ii<funcvet.size(); ii++) {
                        String[] strpa = (String[])funcvet.elementAt(ii);
				query = "SELECT FUN_CODIGO FROM TREINAMENTO WHERE TEF_CODIGO = " +strpa[0];
				rsF = conexao.executaConsulta(query,session.getId()+"RS_4");

				if (rsF.next())
					fun_cod = rsF.getString(1);

                                rsF.close();
                                conexao.finalizaConexao(session.getId()+"RS_4");

				query = "SELECT FUN_CODSOLIC FROM FUNCIONARIO WHERE FUN_CODIGO = "+fun_cod;
				rs = conexao.executaConsulta(query,session.getId()+"RS_5");
				rs.next();
      
				if(rs.getString(1)!=null){
					query = "INSERT INTO PROCESSO (FUN_CODIGO_RESP, QUE_CODIGO, PRO_ENVLAUDO, PRO_FIM, TUR_CODIGO) "+
							"VALUES (" +rs.getString(1)+ ", " +questionario+ ", CONVERT(datetime, '"+envio+"', 103), "+
							"CONVERT(datetime, '"+vencimento+"', 103), " +turma+")";

                                        //out.println("query = " + query);

					conexao.executaAlteracao(query);
      	
					query = "SELECT MAX(PRO_CODIGO) FROM PROCESSO";
					rsa = conexao.executaConsulta(query,session.getId()+"RS_6");
      		
					if (rsa.next())
						processo = rsa.getString(1);
                                        if(rsa!=null){
                                          rsa.close();
                                          conexao.finalizaConexao(session.getId()+"RS_6");
                                         }        
					//rsF = null;
	
					query = "INSERT INTO AVALIADO (PRO_CODIGO, FUN_CODIGO) VALUES (" +processo+ ", " +fun_cod+ ")";
					conexao.executaAlteracao(query);
				}
				else{
					s_solic++;
				}

                                if(rs!=null){
                                          rs.close();
                                          conexao.finalizaConexao(session.getId()+"RS_5");
                                }        

			}

                        //Não Planejados                         
			for (int k=0; k<funcvetnp.size(); k++) {
                        
                        String[] strnpa = (String[])funcvetnp.elementAt(k);                        
				
				fun_cod = strnpa[1];                                
				query = "SELECT FUN_CODSOLIC FROM FUNCIONARIO WHERE FUN_CODIGO = "+fun_cod;                               
				rs = conexao.executaConsulta(query,session.getId()+"RS_10");
				rs.next();
      
				if(rs.getString(1)!=null){
					query = "INSERT INTO PROCESSO (FUN_CODIGO_RESP, QUE_CODIGO, PRO_ENVLAUDO, PRO_FIM, TUR_CODIGO) "+
							"VALUES (" +rs.getString(1)+ ", " +questionario+ ", CONVERT(datetime, '"+envio+"', 103), "+
							"CONVERT(datetime, '"+vencimento+"', 103), " +turma+")";

                                        //out.println("query = " + query);

					conexao.executaAlteracao(query);
      	
					query = "SELECT MAX(PRO_CODIGO) FROM PROCESSO";
					rsa = conexao.executaConsulta(query,session.getId()+"RS_11");
      		
					if (rsa.next())
						processo = rsa.getString(1);

                                        if(rsa!=null){
                                          rsa.close();
                                          conexao.finalizaConexao(session.getId()+"RS_11");
                                         }        
					//rsF = null;
	
					query = "INSERT INTO AVALIADO (PRO_CODIGO, FUN_CODIGO) VALUES (" +processo+ ", " +fun_cod+ ")";
					conexao.executaAlteracao(query);
				}
				else{
					s_solic++;
				}

                                if(rs!=null){
                                          rs.close();
                                          conexao.finalizaConexao(session.getId()+"RS_10");
                                } 
			}


		}
	}
}
%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<body  onunload='return fecha();' >
<form name="frm" method="post">
<input type="hidden" name="solic" value="<%=s_solic%>">
</form>
</body>
</html>
<%


//limpa vetores
vet_cust.clear(); vet_desc.clear();
session.setAttribute("vet_descS",vet_desc);
session.setAttribute("vet_custS",vet_cust);
//limpa o vetor
funcvet.clear();

session.setAttribute("vec_plan",null);
session.setAttribute("vec_nplan",null);
session.setAttribute("vec_registro",null);

query = "DELETE FROM INCNPTEMP WHERE INC_USU_CODIGO = " + usu_codigo;

if(s_solic > 0){
	
	out.print("<script language=\"JavaScript\">");
	out.print("	alert( \" "+trd.Traduz("NAO FOI POSSIVEL INSERIR")+ " +frm.solic.value+ \" PARTICIPANTE(S) NA AVALIACAO. FUNCIONARIO(S) SEM SOLICITANTE\" )");
	out.print(" window.open( \"frame_principal.jsp\",\"_self\" )");
	out.print("</script>");
	
	
}


	out.print("<script language=\"JavaScript\">");
	out.print("    alert(\""+trd.Traduz("REGISTRO REALIZADO COM SUCESSO")+"\" ! )");
    out.print("    window.open(\"frame_principal.jsp\",\"_self\"");	    
	out.print("</script>");
  

} catch (Exception e) {
  out.println(e);
}

%>
