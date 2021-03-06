/*
 * Criptografia.java
 *
 * Created on 27 de Agosto de 2003, 08:46
 */

package br.com.crm.util.cypher;

import java.security.Key;
import java.util.LinkedList;
import java.util.Random;

/**
 * @author Rodrigo Luis Nolli Brossi 
 * @date 27/08/2003
 * @description: classe de suporte para criptografia de dados utilizando a API 1.4.0
 */
public class CypherOperations implements Key {
    
    /**
	 * Cripyto ID
	 */
	private static final long serialVersionUID = 1L;
	//declaracao de variaveis
    byte[] key;
    String algorithm;
    String password;
    int size;
    
    /* tamanho da chave*/
    private void setSize(int size) {
        this.size = size;
    }
    /* tamanho da chave*/
    public int getSize() {
        return this.size;
    }
    
    /* senha para a geracao da chave */
    private void setPassword(String password) {
        this.password = password;
    }
    /* senha para a geracao da chave */
    public String getPassword() {
        return this.password;
    }
    
    /* algoritmo a ser utilizado */
    private void setAlgorithm(String algorithm) {
        this.algorithm = algorithm;
    }
    
    /* retorno o algoritimo utilizado para esta chava */
    public String getAlgorithm() {
        return this.algorithm;
    }
    
    /** Construtora da classe */
    public CypherOperations(String algorithm, String password, int size) {
        setAlgorithm(algorithm);
        setPassword(password);
        setSize(size);
        generateKey();
    }
    
    /* gerador da chave (key)*/
    private void generateKey() {
        int sizeInBytes = getSize()/ 8;
        this.key = new byte[sizeInBytes];
        int i = 0, newKeySize = 0;
        LinkedList newKey = new LinkedList();
        while ((newKeySize < getPassword().length()) && (newKeySize < sizeInBytes)) {
            newKey.add(new Byte((byte) getPassword().charAt(newKeySize++)));
        }
        
        /* A �nica finalidade deste trecho (while) � completar a senha com o n�mero de bytes necess�rios para formar a chave.
           Este complemento � feito intercalando bytes na senha, atrav�s de opera��es bin�rias com os pr�prios bytes componentes
           da senha. Esse procedimento visa diminuir a chance de se quebrar a criptografia TripleDES (cuja chave, que j� � pequena,
           poderia ficar ainda "menor" com uma simples repeti��o da senha at� o complemento da chave)
         */
        while (newKeySize < sizeInBytes) {
            int k = i + 1;
            if (i == newKeySize - 1) {
                k = 0;
            }
            byte iB = ((Byte) newKey.get(i == -1 ? (newKeySize - 1) : i)).byteValue(),
            kB = ((Byte) newKey.get(k)).byteValue(),
            nB = (byte) (i % 2 == 0 ? (iB ^ kB) ^ i : (iB + kB) ^ i);
            if (nB < 0) {
                nB = (byte) -nB;
            }
            newKey.add(i + 1, new Byte(nB));
            newKeySize++;
            i += 2;
            if (i >= newKeySize) {
                i = -1;
            }
        }
        
        for (int j = 0; j < newKeySize; j++) {
            this.key[j] = ((Byte) newKey.get(j)).byteValue();
        }
    }
    
    /** Retorna a chave em seu formato codificando preliminar, ou null se esta chave n�o suportar ser codificada. */
    public byte[] getEncoded() {
        return this.key;
    }
    
    /* retorna o primeiro formato para a chave */
    public String getFormat() {
        return "RAW";
    }
    
    /* converte a chave para uma string */
    public String toString() {
        return new String(this.getEncoded());
    }
    
    /** Construtora da classe para criptografia SER*/
    public CypherOperations() {
    }
    
    /* Criptografa a String usando o algoritmo do Marcelo Marques
     * Algoritmo: soma-se '!' no inicio e no fim do valor a se criptografar, pega a primeira letra da mesma, soma-se 2 caracteres
     *            aleatorios dentro do conjunto 'str_strAleatorio' e assim por diante a cada nova letra do valor a se criptografar
     */
    public String cript(String str_param){
        //randomico para adicionar os caracteres
        Random rdo_rand = new Random();
        
        String str_retorno = new String("!");
        int int_tamanhoParam = 0, int_indiceAleatorio = 0;
        String sto_strToken = new String(str_param);
        String str_strAleatorio[] = new String[] {"R","O","T","I","N","A","D","E","C","R","I","P","T","O","G","R","A","F","I","A","D","A","S","E","R"};
        
        if (str_param == null) {
            str_retorno = null;
        } else
            if (str_param.equals("")){
                str_retorno = "";
            } else {
                int_tamanhoParam = str_param.length();
                for (int cont=0; cont < int_tamanhoParam; cont++) {
                    int_indiceAleatorio = rdo_rand.nextInt(22);
                    str_retorno = str_retorno + (str_strAleatorio[int_indiceAleatorio] + sto_strToken.charAt(cont) + str_strAleatorio[int_indiceAleatorio+1]);
                }
                
                str_retorno += "!";
            }
        
        return str_retorno;
    }
    
    /* descriptografa a String usando o algoritmo do Marcelo Marques */
    public String decript(String str_param){
        //declaracao de variaveis
        String str_retorno = null;
        int int_tamanhoParam = str_param.length(),
            int_indiceAtual = 1;
        boolean boo_loop = true;
        
        try {
            
            if (int_tamanhoParam > 0) {
                
                str_param = str_param.substring(1, (int_tamanhoParam - 1));
                
                while (boo_loop) {
                    str_retorno += str_param.substring(int_indiceAtual, (int_indiceAtual + 1));
                    int_indiceAtual = int_indiceAtual + 3;
                    if ((int_indiceAtual + 1) > (int_tamanhoParam - 2)) {
                        boo_loop = false;
                    }
                }
            }
        } catch (Exception e) {
            str_retorno = null;
        }
        
        return str_retorno;
    }
}

