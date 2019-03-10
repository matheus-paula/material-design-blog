package controller;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.util.Arrays;
import java.util.Base64;
import java.util.Random;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
 
public class Senha{
    private static final Random VALOR_RANDOMICO = new SecureRandom();
    private static final String ALFABETO = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    private static final int ITERACOES = 10000;
    private static final int TAMANHO_CHAVE = 256;
    
     public static String obterKey(int length) {
        StringBuilder retorno = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            retorno.append(ALFABETO.charAt(VALOR_RANDOMICO.nextInt(ALFABETO.length())));
        }
        return new String(retorno);
    }
     
    public static byte[] hash(char[] senha, byte[] salt) {
        PBEKeySpec spec = new PBEKeySpec(senha, salt, ITERACOES, TAMANHO_CHAVE);
        Arrays.fill(senha, Character.MIN_VALUE);
        try {
            SecretKeyFactory chaveSecreta = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
            return chaveSecreta.generateSecret(spec).getEncoded();
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            throw new AssertionError("Erro durante o hashing da senha: " + e.getMessage(), e);
        } finally {
            spec.clearPassword();
        }
    }
    
    public static String gerarSenha(String senha, String salt) {
        byte[] senhaSegura = hash(senha.toCharArray(), salt.getBytes());
        return (String) Base64.getEncoder().encodeToString(senhaSegura);
    }
    
    public static boolean verificarSenha(String senhaInserida,
            String senhaSegura, String chave){
        String novaSenhaSegura = gerarSenha(senhaInserida, chave);
        return (boolean) novaSenhaSegura.equalsIgnoreCase(senhaSegura);
    }
}
