/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import org.apache.commons.lang3.StringUtils;
import java.util.LinkedList;
import java.util.List;
import hibernate.HibernateUtil;
import models.Tags;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author mathe
 */
public class TagsDAO {
    public void inserirTag(String tag){
        Transaction transacao = null;
        Session sessao = HibernateUtil.getSessionFactory().openSession();
        Tags novaTag = new Tags();
        novaTag.setIdTag(tag);
        novaTag.setNomeTag(StringUtils.capitalize(tag));
        try {
            transacao = sessao.beginTransaction();
            sessao.persist(novaTag);
            transacao.commit();
        }
        catch (HibernateException e) {
            if (transacao!=null) 
                transacao.rollback();
            /*e.printStackTrace();*/
        }finally{
            sessao.close();
        }
    }
    
    public void inserirMultiplasTags(String[] tags){
        Transaction transacao = null;
        Session sessao = HibernateUtil.getSessionFactory().openSession();
        Tags novaTag;
        try {
            transacao = sessao.beginTransaction();
            for(int i = 0;i < tags.length;i++){
                if(!tags[i].isEmpty()){
                    novaTag = new Tags();
                    novaTag.setNomeTag(StringUtils.capitalize(tags[i]));
                    novaTag.setIdTag(tags[i]);
                    sessao.saveOrUpdate(novaTag);
                    if ( i % 20 == 0 ) {
                        sessao.flush();
                        sessao.clear();
                    }
                }
            }
            transacao.commit();
        }
        catch (HibernateException e) {
            if (transacao!=null) 
                transacao.rollback();
            /*e.printStackTrace();*/
        }finally{
            sessao.close();
        }
    }
    
    public List<Tags> obterTags(){
        final List<Tags> tagsLista = new LinkedList<>();
        Session sessao = HibernateUtil.getSessionFactory().openSession();
        try {
            sessao.beginTransaction();
            Query q = sessao.createQuery("select from Tags");
            q.list().forEach((o) -> {
                tagsLista.add((Tags)o);
            });
        }catch(Exception e){
        
        }finally{
            sessao.close();
        }
        return tagsLista;
    }
}
