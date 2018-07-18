/*jadclipse*/// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.

package firston.eval.components;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.ResultSet;

import firston.eval.connection.FODBConnectionBean;


public class FOImportBean
{

    private FODBConnectionBean conn;

	public FOImportBean()
    {
        conn = new FODBConnectionBean();
    }

    public boolean importa(String tabela, String arquivo)
        throws Exception, IOException
    {
        conn = conn.getConection();
        String info = "";
        String infon = "";
        String query = "";
        String query1 = "";
        String query2 = "";
        String query3 = "";
        String linha = "-1";
        String query10 = "";
        String queryt = "";
        boolean importou = true;
        BufferedReader inn = new BufferedReader(new FileReader(arquivo));
        query1 = "TRUNCATE TABLE BAK_FUNCIONARIO";
        conn.executaAlteracao(query1);
        if(tabela.equals("FUNCIONARIO"))
        {
            query2 = "INSERT INTO BAK_FUNCIONARIO SELECT * FROM FUNCIONARIO";
            conn.executaAlteracao(query2);
        }
        query1 = "TRUNCATE TABLE BAK_CARGO";
        conn.executaAlteracao(query1);
        if(tabela.equals("CARGO"))
        {
            query2 = "INSERT INTO BAK_CARGO SELECT * FROM CARGO";
            conn.executaAlteracao(query2);
        }
        query1 = "TRUNCATE TABLE BAK_DEPTO";
        conn.executaAlteracao(query1);
        if(tabela.equals("DEPARTAMENTO"))
        {
            query2 = "INSERT INTO BAK_DEPTO SELECT * FROM DEPTO";
            conn.executaAlteracao(query2);
        }
        query1 = "TRUNCATE TABLE BAK_FILIAL";
        conn.executaAlteracao(query1);
        if(tabela.equals("FILIAL"))
        {
            query2 = "INSERT INTO BAK_FILIAL SELECT * FROM FILIAL";
            conn.executaAlteracao(query2);
        }
        query1 = "TRUNCATE TABLE BAK_TABELA1";
        conn.executaAlteracao(query1);
        if(tabela.equals("TABELA1"))
        {
            query2 = "INSERT INTO BAK_TABELA1 SELECT * FROM TABELA1";
            conn.executaAlteracao(query2);
        }
        query1 = "TRUNCATE TABLE BAK_TABELA2";
        conn.executaAlteracao(query1);
        if(tabela.equals("TABELA2"))
        {
            query2 = "INSERT INTO BAK_TABELA2 SELECT * FROM TABELA2";
            conn.executaAlteracao(query2);
        }
        query1 = "TRUNCATE TABLE BAK_TABELA3";
        conn.executaAlteracao(query1);
        if(tabela.equals("TABELA3"))
        {
            query2 = "INSERT INTO BAK_TABELA3 SELECT * FROM TABELA3";
            conn.executaAlteracao(query2);
        }
        query1 = "TRUNCATE TABLE BAK_TABELA4";
        conn.executaAlteracao(query1);
        if(tabela.equals("TABELA4"))
        {
            query2 = "INSERT INTO BAK_TABELA4 SELECT * FROM TABELA4";
            conn.executaAlteracao(query2);
        }
        query1 = "TRUNCATE TABLE BAK_TABELA5";
        conn.executaAlteracao(query1);
        if(tabela.equals("TABELA5"))
        {
            query2 = "INSERT INTO BAK_TABELA5 SELECT * FROM TABELA5";
            conn.executaAlteracao(query2);
        }
        query1 = "TRUNCATE TABLE BAK_TABELA6";
        conn.executaAlteracao(query1);
        if(tabela.equals("TABELA6"))
        {
            query2 = "INSERT INTO BAK_TABELA6 SELECT * FROM TABELA6";
            conn.executaAlteracao(query2);
        }
        query1 = "TRUNCATE TABLE BAK_TABELA7";
        conn.executaAlteracao(query1);
        if(tabela.equals("TABELA7"))
        {
            query2 = "INSERT INTO BAK_TABELA7 SELECT * FROM TABELA7";
            conn.executaAlteracao(query2);
        }
        query1 = "TRUNCATE TABLE BAK_TABELA8";
        conn.executaAlteracao(query1);
        if(tabela.equals("TABELA8"))
        {
            query2 = "INSERT INTO BAK_TABELA8 SELECT * FROM TABELA8";
            conn.executaAlteracao(query2);
        }
        boolean imp = true;
        while(linha != null) 
        {
            imp = true;
            linha = inn.readLine();
            if(linha != null)
            {
                if(tabela.equals("FUNCIONARIO"))
                {
                    String depto = "";
                    String cargo = "";
                    String tb1 = "";
                    String tb2 = "";
                    String tb3 = "";
                    String tb4 = "";
                    String tb5 = "";
                    String tb6 = "";
                    String tb7 = "";
                    String tb8 = "";
                    String fone = "";
                    String nascimento = "";
                    String sexo = "";
                    String es = "";
                    String nat = "";
                    String email = "";
                    String admissao = "";
                    String demitido = "";
                    String demissao = "";
                    String solicitante = "";
                    String ftipo = "";
                    String flogin = "";
                    String fsenha = "";
                    info = linha.substring(0, 20);
                    infon = linha.substring(20, 30);
                    depto = linha.substring(30, 40);
                    cargo = linha.substring(40, 50);
                    tb1 = linha.substring(50, 60);
                    tb2 = linha.substring(60, 70);
                    tb3 = linha.substring(70, 80);
                    tb4 = linha.substring(80, 90);
                    tb5 = linha.substring(90, 100);
                    tb6 = linha.substring(100, 110);
                    tb7 = linha.substring(110, 120);
                    tb8 = linha.substring(120, 130);
                    String nome = linha.substring(130, 180);
                    fone = linha.substring(180, 195);
                    nascimento = linha.substring(195, 205);
                    sexo = linha.substring(205, 206);
                    email = linha.substring(206, 246);
                    admissao = linha.substring(246, 256);
                    demitido = linha.substring(256, 257);
                    demissao = linha.substring(257, 267);
                    ftipo = linha.substring(267, 268);
                    flogin = linha.substring(268, 288);
                    fsenha = linha.substring(288, 298);
                    solicitante = linha.substring(298, linha.length());
                    query10 = "SELECT FIL_CODIGO FROM FILIAL WHERE LTRIM(RTRIM(FIL_CODCLI)) = '" + infon.trim() + "'";
                    ResultSet rsf = conn.executaConsulta(query10);
                    if(rsf.next())
                        infon = rsf.getString(1);
                    else
                        infon = "null";
                    rsf.close();
                    query10 = "SELECT CAR_CODIGO FROM CARGO WHERE LTRIM(RTRIM(CAR_CODCLI)) = '" + cargo.trim() + "'";
                    rsf = conn.executaConsulta(query10);
                    if(rsf.next())
                    {
                        cargo = rsf.getString(1);
                    } else
                    {
                        cargo = "null";
                        imp = false;
                    }
                    rsf.close();
                    query10 = "SELECT DEP_CODIGO FROM DEPTO WHERE LTRIM(RTRIM(DEP_CODCLI)) = '" + depto.trim() + "'";
                    rsf = conn.executaConsulta(query10);
                    if(rsf.next())
                    {
                        depto = rsf.getString(1);
                    } else
                    {
                        depto = "null";
                        imp = false;
                    }
                    rsf.close();
                    query10 = "SELECT TB1_CODIGO FROM TABELA1 WHERE LTRIM(RTRIM(TB1_CODCLI)) = '" + tb1.trim() + "'";
                    rsf = conn.executaConsulta(query10);
                    if(rsf.next())
                        tb1 = rsf.getString(1);
                    else
                        tb1 = "null";
                    rsf.close();
                    query10 = "SELECT TB2_CODIGO FROM TABELA2 WHERE LTRIM(RTRIM(TB2_CODCLI)) = '" + tb2.trim() + "'";
                    rsf = conn.executaConsulta(query10);
                    if(rsf.next())
                        tb2 = rsf.getString(1);
                    else
                        tb2 = "null";
                    rsf.close();
                    query10 = "SELECT TB3_CODIGO FROM TABELA3 WHERE LTRIM(RTRIM(TB3_CODCLI)) = '" + tb3.trim() + "'";
                    rsf = conn.executaConsulta(query10);
                    if(rsf.next())
                        tb3 = rsf.getString(1);
                    else
                        tb3 = "null";
                    rsf.close();
                    query10 = "SELECT TB4_CODIGO FROM TABELA4 WHERE LTRIM(RTRIM(TB4_CODCLI)) = '" + tb4.trim() + "'";
                    rsf = conn.executaConsulta(query10);
                    if(rsf.next())
                        tb4 = rsf.getString(1);
                    else
                        tb4 = "null";
                    rsf.close();
                    query10 = "SELECT TB5_CODIGO FROM TABELA5 WHERE LTRIM(RTRIM(TB5_CODCLI)) = '" + tb5.trim() + "'";
                    rsf = conn.executaConsulta(query10);
                    if(rsf.next())
                        tb5 = rsf.getString(1);
                    else
                        tb5 = "null";
                    rsf.close();
                    query10 = "SELECT TB6_CODIGO FROM TABELA6 WHERE LTRIM(RTRIM(TB6_CODCLI)) = '" + tb6.trim() + "'";
                    rsf = conn.executaConsulta(query10);
                    if(rsf.next())
                        tb6 = rsf.getString(1);
                    else
                        tb6 = "null";
                    rsf.close();
                    query10 = "SELECT TB7_CODIGO FROM TABELA7 WHERE LTRIM(RTRIM(TB7_CODCLI)) = '" + tb7.trim() + "'";
                    rsf = conn.executaConsulta(query10);
                    if(rsf.next())
                        tb7 = rsf.getString(1);
                    else
                        tb7 = "null";
                    rsf.close();
                    query10 = "SELECT TB8_CODIGO FROM TABELA8 WHERE LTRIM(RTRIM(TB8_CODCLI)) = '" + tb8.trim() + "'";
                    rsf = conn.executaConsulta(query10);
                    if(rsf.next())
                        tb8 = rsf.getString(1);
                    else
                        tb8 = "null";
                    rsf.close();
                    query10 = "SELECT FUN_CODIGO FROM FUNCIONARIO WHERE LTRIM(RTRIM(FUN_CHAPA)) = '" + solicitante.trim() + "'";
                    rsf = conn.executaConsulta(query10);
                    if(rsf.next())
                        solicitante = rsf.getString(1);
                    else
                        solicitante = "null";
                    rsf.close();
                    if(demitido.equals("S"))
                        demissao = " CONVERT(datetime,'" + demissao + "',103)";
                    else
                        demissao = null;
                    if(!ftipo.trim().equals(""))
                    {
                        query10 = "SELECT * FROM TIPOUSUARIO WHERE TIP_TIPO = '" + ftipo + "'";
                        rsf = conn.executaConsulta(query10);
                        if(rsf.next())
                            ftipo = "'" + ftipo + "'";
                        else
                            imp = false;
                        rsf.close();
                    } else
                    {
                        ftipo = "null";
                    }
                    if(flogin.trim().equals(""))
                        flogin = "null";
                    else
                        flogin = "'" + flogin + "'";
                    if(fsenha.trim().equals(""))
                        fsenha = "null";
                    else
                        fsenha = "'" + fsenha + "'";
                    if(imp)
                    {
                        query3 = "SELECT * FROM FUNCIONARIO WHERE LTRIM(RTRIM(FUN_CHAPA))= '" + info.trim() + "'";
                        ResultSet rs = conn.executaConsulta(query3);
                        if(rs.next())
                            query = "UPDATE FUNCIONARIO SET  FUN_CHAPA = '" + info + "', " + " FIL_CODIGO = " + infon + ", " + " DEP_CODIGO = " + depto + ", " + " CAR_CODIGO = " + cargo + ", " + " TB1_CODIGO = " + tb1 + ", " + " TB2_CODIGO = " + tb2 + ", " + " TB3_CODIGO = " + tb3 + ", " + " TB4_CODIGO = " + tb4 + ", " + " TB5_CODIGO = " + tb5 + ", " + " TB6_CODIGO = " + tb6 + ", " + " TB7_CODIGO  = " + tb7 + ", " + " TB8_CODIGO = " + tb8 + ", " + " FUN_NOME = '" + nome + "', " + " FUN_TELEFONE = '" + fone + "', " + " FUN_NASCIMENTO = CONVERT(datetime,'" + nascimento + "',103), " + " FUN_SEXO = '" + sexo + "', " + " FUN_EMAIL = '" + email + "', " + " FUN_DATAADMISSAO = CONVERT(datetime,'" + admissao + "',103), " + " FUN_DEMITIDO = '" + demitido + "', " + " FUN_DATADEMISSAO = " + demissao + ", " + " FUN_CODSOLIC = " + solicitante + ", FUN_TIPOUSUARIO = " + ftipo + ", FUN_LOGIN = " + flogin + ", FUN_SENHA = " + fsenha + " WHERE LTRIM(RTRIM(FUN_CHAPA)) = '" + info.trim() + "'";
                        else
                            query = "INSERT INTO FUNCIONARIO (FUN_CHAPA, FIL_CODIGO, DEP_CODIGO, CAR_CODIGO, TB1_CODIGO, TB2_CODIGO, TB3_CODIGO, TB4_CODIGO, TB5_CODIGO, TB6_CODIGO, TB7_CODIGO, TB8_CODIGO, FUN_NOME, FUN_TELEFONE, FUN_NASCIMENTO, FUN_SEXO, FUN_EMAIL, FUN_DATAADMISSAO, FUN_DEMITIDO, FUN_DATADEMISSAO, FUN_CODSOLIC, FUN_TIPOUSUARIO, FUN_LOGIN, FUN_SENHA) VALUES ('" + info + "', " + infon + ", " + depto + ", " + cargo + ", " + tb1 + ", " + tb2 + ", " + tb3 + ", " + tb4 + ", " + tb5 + ", " + tb6 + ", " + tb7 + ", " + tb8 + ", '" + nome + "', '" + fone + "', CONVERT(datetime,'" + nascimento + "',103), '" + sexo + "', '" + email + "', CONVERT(datetime,'" + admissao + "',103), '" + demitido + "', " + demissao + ", " + solicitante + "," + ftipo + ", " + flogin + ", " + fsenha + ")";
                        conn.executaAlteracao(query);
                    } else
                    {
                        importou = false;
                    }
                }
                if(tabela.equals("CARGO"))
                {
                    info = linha.substring(0, 10);
                    infon = linha.substring(10, linha.length());
                    query3 = "SELECT * FROM CARGO WHERE LTRIM(RTRIM(CAR_CODCLI)) = '" + info.trim() + "'";
                    ResultSet rs = conn.executaConsulta(query3);
                    if(rs.next())
                        query = "UPDATE CARGO SET CAR_NOME = '" + infon + "' WHERE LTRIM(RTRIM(CAR_CODCLI)) = '" + info.trim() + "'";
                    else
                        query = "INSERT INTO CARGO (CAR_CODCLI, CAR_NOME) VALUES ('" + info + "', '" + infon + "')";
                    conn.executaAlteracao(query);
                }
                if(tabela.equals("DEPARTAMENTO"))
                {
                    info = linha.substring(0, 10);
                    infon = linha.substring(10, linha.length());
                    query3 = "SELECT * FROM DEPTO WHERE LTRIM(RTRIM(DEP_CODCLI)) = '" + info.trim() + "'";
                    ResultSet rs = conn.executaConsulta(query3);
                    if(rs.next())
                        query = "UPDATE DEPTO SET DEP_NOME = '" + infon + "' WHERE LTRIM(RTRIM(DEP_CODCLI)) = '" + info.trim() + "'";
                    else
                        query = "INSERT INTO DEPTO (DEP_CODCLI, DEP_NOME) VALUES ('" + info + "', '" + infon + "')";
                    conn.executaAlteracao(query);
                }
                if(tabela.equals("FILIAL"))
                {
                    String resp = "";
                    String codigoresp = "";
                    info = linha.substring(0, 10);
                    infon = linha.substring(10, 50);
                    resp = linha.substring(50, linha.length());
                    query10 = "SELECT FUN_CODIGO FROM FUNCIONARIO WHERE LTRIM(RTRIM(FUN_CHAPA)) = '" + resp.trim() + "'";
                    ResultSet rsf = conn.executaConsulta(query10);
                    if(rsf.next())
                        codigoresp = rsf.getString(1);
                    else
                        codigoresp = "null";
                    rsf.close();
                    query3 = "SELECT * FROM FILIAL WHERE LTRIM(RTRIM(FIL_CODCLI)) = '" + info.trim() + "'";
                    ResultSet rs = conn.executaConsulta(query3);
                    if(rs.next())
                        query = "UPDATE FILIAL SET FIL_NOME = '" + infon + "', FUN_CODIGO_RESP = " + codigoresp + " WHERE LTRIM(RTRIM(FIL_CODCLI)) = '" + info.trim() + "'";
                    else
                        query = "INSERT INTO FILIAL (FIL_CODCLI, FIL_NOME, FUN_CODIGO_RESP) VALUES ('" + info + "', '" + infon + "', " + codigoresp + ")";
                    conn.executaAlteracao(query);
                    queryt = queryt + query10 + "***" + query3 + "***" + query + "****";
                }
                if(tabela.equals("TABELA1"))
                {
                    info = linha.substring(0, 10);
                    infon = linha.substring(10, linha.length());
                    query3 = "SELECT * FROM TABELA1 WHERE LTRIM(RTRIM(TB1_CODCLI)) = '" + info.trim() + "'";
                    ResultSet rs = conn.executaConsulta(query3);
                    if(rs.next())
                        query = "UPDATE TABELA1 SET TB1_NOME = '" + infon + "' WHERE LTRIM(RTRIM(TB1_CODCLI)) = '" + info.trim() + "'";
                    else
                        query = "INSERT INTO TABELA1 (TB1_CODCLI, TB1_NOME) VALUES ('" + info + "', '" + infon + "')";
                    conn.executaAlteracao(query);
                }
                if(tabela.equals("TABELA2"))
                {
                    info = linha.substring(0, 10);
                    infon = linha.substring(10, linha.length());
                    query3 = "SELECT * FROM TABELA2 WHERE LTRIM(RTRIM(TB2_CODCLI)) = '" + info.trim() + "'";
                    ResultSet rs = conn.executaConsulta(query3);
                    if(rs.next())
                        query = "UPDATE TABELA2 SET TB2_NOME = '" + infon + "' WHERE LTRIM(RTRIM(TB2_CODCLI)) = '" + info.trim() + "'";
                    else
                        query = "INSERT INTO TABELA2 (TB2_CODCLI, TB2_NOME) VALUES ('" + info + "', '" + infon + "')";
                    conn.executaAlteracao(query);
                }
                if(tabela.equals("TABELA3"))
                {
                    info = linha.substring(0, 10);
                    infon = linha.substring(10, linha.length());
                    query3 = "SELECT * FROM TABELA3 WHERE LTRIM(RTRIM(TB3_CODCLI)) = '" + info.trim() + "'";
                    ResultSet rs = conn.executaConsulta(query3);
                    if(rs.next())
                        query = "UPDATE TABELA1 SET TB3_DESCRICAO = '" + infon + "' WHERE LTRIM(RTRIM(TB3_CODCLI)) = '" + info.trim() + "'";
                    else
                        query = "INSERT INTO TABELA3 (TB3_CODCLI, TB3_DESCRICAO) VALUES ('" + info + "', '" + infon + "')";
                    conn.executaAlteracao(query);
                }
                if(tabela.equals("TABELA4"))
                {
                    info = linha.substring(0, 10);
                    infon = linha.substring(10, linha.length());
                    query3 = "SELECT * FROM TABELA4 WHERE LTRIM(RTRIM(TB4_CODCLI)) = '" + info.trim() + "'";
                    ResultSet rs = conn.executaConsulta(query3);
                    if(rs.next())
                        query = "UPDATE TABELA4 SET TB4_DESCRICAO = '" + infon + "' WHERE LTRIM(RTRIM(TB4_CODCLI)) = '" + info.trim() + "'";
                    else
                        query = "INSERT INTO TABELA4 (TB4_CODCLI, TB4_DESCRICAO) VALUES ('" + info + "', '" + infon + "')";
                    conn.executaAlteracao(query);
                }
                if(tabela.equals("TABELA5"))
                {
                    info = linha.substring(0, 10);
                    infon = linha.substring(10, linha.length());
                    query3 = "SELECT * FROM TABELA5 WHERE LTRIM(RTRIM(TB5_CODCLI)) = '" + info.trim() + "'";
                    ResultSet rs = conn.executaConsulta(query3);
                    if(rs.next())
                        query = "UPDATE TABELA5 SET TB5_DESCRICAO = '" + infon + "' WHERE LTRIM(RTRIM(TB5_CODCLI)) = '" + info.trim() + "'";
                    else
                        query = "INSERT INTO TABELA5 (TB5_CODCLI, TB5_DESCRICAO) VALUES ('" + info + "', '" + infon + "')";
                    conn.executaAlteracao(query);
                }
                if(tabela.equals("TABELA6"))
                {
                    info = linha.substring(0, 10);
                    infon = linha.substring(10, linha.length());
                    query3 = "SELECT * FROM TABELA6 WHERE LTRIM(RTRIM(TB6_CODCLI)) = '" + info.trim() + "'";
                    ResultSet rs = conn.executaConsulta(query3);
                    if(rs.next())
                        query = "UPDATE TABELA6 SET TB6_DESCRICAO = '" + infon + "' WHERE LTRIM(RTRIM(TB6_CODCLI)) = '" + info.trim() + "'";
                    else
                        query = "INSERT INTO TABELA6 (TB6_CODCLI, TB6_DESCRICAO) VALUES ('" + info + "', '" + infon + "')";
                    conn.executaAlteracao(query);
                }
                if(tabela.equals("TABELA7"))
                {
                    info = linha.substring(0, 10);
                    infon = linha.substring(10, linha.length());
                    query3 = "SELECT * FROM TABELA7 WHERE LTRIM(RTRIM(TB7_CODCLI)) = '" + info.trim() + "'";
                    ResultSet rs = conn.executaConsulta(query3);
                    if(rs.next())
                        query = "UPDATE TABELA7 SET TB7_DESCRICAO = '" + infon + "' WHERE LTRIM(RTRIM(TB7_CODCLI)) = '" + info.trim() + "'";
                    else
                        query = "INSERT INTO TABELA7 (TB7_CODCLI, TB7_DESCRICAO) VALUES ('" + info + "', '" + infon + "')";
                    conn.executaAlteracao(query);
                }
                if(tabela.equals("TABELA8"))
                {
                    info = linha.substring(0, 10);
                    infon = linha.substring(10, linha.length());
                    query3 = "SELECT * FROM TABELA8 WHERE LTRIM(RTRIM(TB8_CODCLI)) = '" + info.trim() + "'";
                    ResultSet rs = conn.executaConsulta(query3);
                    if(rs.next())
                        query = "UPDATE TABELA8 SET TB8_DESCRICAO = '" + infon + "' WHERE LTRIM(RTRIM(TB8_CODCLI)) = '" + info.trim() + "'";
                    else
                        query = "INSERT INTO TABELA8 (TB8_CODCLI, TB8_DESCRICAO) VALUES ('" + info + "', '" + infon + "')";
                    conn.executaAlteracao(query);
                }
            }
        }
        inn.close();
        return importou;
    }

    public boolean restaura(String tabela)
        throws Exception, IOException
    {
        boolean ret = true;
        String query1 = "";
        String query2 = "";
        query1 = "TRUNCATE TABLE FUNCIONARIO";
        conn.executaAlteracao(query1);
        if(tabela.equals("FUNCIONARIO"))
        {
            query2 = "INSERT INTO FUNCIONARIO SELECT * FROM BAK_FUNCIONARIO";
            conn.executaAlteracao(query2);
        }
        query1 = "TRUNCATE TABLE CARGO";
        conn.executaAlteracao(query1);
        if(tabela.equals("CARGO"))
        {
            query2 = "INSERT INTO CARGO SELECT * FROM BAK_CARGO";
            conn.executaAlteracao(query2);
        }
        query1 = "TRUNCATE TABLE DEPTO";
        conn.executaAlteracao(query1);
        if(tabela.equals("DEPARTAMENTO"))
        {
            query2 = "INSERT INTO DEPTO SELECT * FROM BAK_DEPTO";
            conn.executaAlteracao(query2);
        }
        query1 = "TRUNCATE TABLE FILIAL";
        conn.executaAlteracao(query1);
        if(tabela.equals("FILIAL"))
        {
            query2 = "INSERT INTO FILIAL SELECT * FROM BAK_FILIAL";
            conn.executaAlteracao(query2);
        }
        query1 = "TRUNCATE TABLE TABELA1";
        conn.executaAlteracao(query1);
        if(tabela.equals("TABELA1"))
        {
            query2 = "INSERT INTO TABELA1 SELECT * FROM BAK_TABELA1";
            conn.executaAlteracao(query2);
        }
        query1 = "TRUNCATE TABLE TABELA2";
        conn.executaAlteracao(query1);
        if(tabela.equals("TABELA2"))
        {
            query2 = "INSERT INTO TABELA2 SELECT * FROM BAK_TABELA2";
            conn.executaAlteracao(query2);
        }
        query1 = "TRUNCATE TABLE TABELA3";
        conn.executaAlteracao(query1);
        if(tabela.equals("TABELA3"))
        {
            query2 = "INSERT INTO TABELA3 SELECT * FROM BAK_TABELA3";
            conn.executaAlteracao(query2);
        }
        query1 = "TRUNCATE TABLE TABELA4";
        conn.executaAlteracao(query1);
        if(tabela.equals("TABELA4"))
        {
            query2 = "INSERT INTO TABELA4 SELECT * FROM BAK_TABELA4";
            conn.executaAlteracao(query2);
        }
        query1 = "TRUNCATE TABLE TABELA5";
        conn.executaAlteracao(query1);
        if(tabela.equals("TABELA5"))
        {
            query2 = "INSERT INTO TABELA5 SELECT * FROM BAK_TABELA5";
            conn.executaAlteracao(query2);
        }
        query1 = "TRUNCATE TABLE TABELA6";
        conn.executaAlteracao(query1);
        if(tabela.equals("TABELA6"))
        {
            query2 = "INSERT INTO TABELA6 SELECT * FROM BAK_TABELA6";
            conn.executaAlteracao(query2);
        }
        query1 = "TRUNCATE TABLE TABELA7";
        conn.executaAlteracao(query1);
        if(tabela.equals("TABELA7"))
        {
            query2 = "INSERT INTO TABELA7 SELECT * FROM BAK_TABELA7";
            conn.executaAlteracao(query2);
        }
        query1 = "TRUNCATE TABLE TABELA8";
        conn.executaAlteracao(query1);
        if(tabela.equals("TABELA8"))
        {
            query2 = "INSERT INTO TABELA8 SELECT * FROM BAK_TABELA8";
            conn.executaAlteracao(query2);
        }
        return ret;
    }

  
}


/*
	DECOMPILATION REPORT

	Decompiled from: C:\eclipseWTC\onix\Oregon\ImportedClasses/ser/comum/importacao/Importacao.class
	Total time: 109 ms
	Jad reported messages/errors:
	Exit status: 0
	Caught exceptions:
*/