/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.LinkedList;
import java.util.List;
import hibernate.HibernateUtil;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import models.Opcoes;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author mathe
 */
public class OpcoesDAO {
    
    public Map<String,String[]> retornarMapaConfiguracoes(){
        Map<String,String[]> mapaOpcoes = new HashMap();
        Session sessao = HibernateUtil.getSessionFactory().openSession();
        try {
            sessao.beginTransaction();
            Query q = sessao.createQuery("select from Opcoes");
            q.list().forEach((o) -> {
                Opcoes opcao = (Opcoes)o;
                String[] opcArray = new String[]{
                    opcao.getNome(),
                    opcao.getValor(),
                    opcao.getRotulo(),
                    opcao.getDescricao(),
                };
                mapaOpcoes.put(opcao.getNome(), opcArray);
            });
        }catch(Exception e){
            /*e.printStackTrace();*/
            sessao.close();
            return null;
        }finally{
           
        }
        return mapaOpcoes;
    }
    
    public List<Opcoes> retornarConfiguracoes(){
        Session sessao = HibernateUtil.getSessionFactory().openSession();
        List<Opcoes> opcoes = new LinkedList<>();
        try {
            sessao.beginTransaction();
            Query q = sessao.createQuery("select from Opcoes");
            q.list().forEach((o) -> {
                opcoes.add((Opcoes)o);
            });
        }catch(Exception e){
            sessao.close();
            return null;
        }finally{
            sessao.close();    
        }
        return opcoes;
    }
    
    public void atualizarConfiguracao(Opcoes opcao){       
        Transaction transacao = null;
        Session sessao = HibernateUtil.getSessionFactory().openSession();
        try {
            transacao = sessao.beginTransaction();
            sessao.update(opcao);
            transacao.commit();
            sessao.close();
        }catch (HibernateException e) {
            if (transacao!=null) transacao.rollback();
            /*e.printStackTrace();*/
            sessao.close();
        }finally{
            
        }
    }
    
    public void persistirOpcoes(Map<String,String> opcoes){       
        List<Opcoes> opcoesSalvas = retornarConfiguracoes();
        Iterator<Map.Entry<String, String>> iterador = opcoes.entrySet().iterator();
        while (iterador.hasNext()) {
            Map.Entry<String, String> valor = iterador.next();
            for(Opcoes opc : opcoesSalvas){
                if(opc.getNome().equals(valor.getKey())){
                    opc.setValor(valor.getValue());
                    atualizarConfiguracao(opc);
                }
            }
        }
    }
}
