/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.LinkedList;
import java.util.List;
import hibernate.HibernateUtil;
import models.Posts;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author mathe
 */

public class PostsDAO {
    
    /* PERSISTIR UM POST */
    public void persistirPost(Posts post){       
        Transaction transacao = null;
        Session sessao =  HibernateUtil.getSessionFactory().openSession();
        try {
            transacao = sessao.beginTransaction();
            sessao.persist(post);
            transacao.commit();
        }
        catch (HibernateException e) {
           if (transacao!=null) transacao.rollback();
           /*e.printStackTrace();*/
           sessao.close();
        }finally{
            sessao.close();
        }
    }
    
    /* REMOVER UM POST */
    public void removerPost(Posts post){       
        Transaction transacao = null;
        Session sessao =  HibernateUtil.getSessionFactory().openSession();
        try {
            transacao = sessao.beginTransaction();
            sessao.delete(post);
            transacao.commit();
        }
        catch (HibernateException e) {
           if (transacao!=null) transacao.rollback();
           e.printStackTrace();
        }finally{
            sessao.close();
        }
    }
    
    /* ATUALIZAR UM POST */
    public int atualizarPost(Posts post){       
        Transaction transacao = null;
        Session sessao = HibernateUtil.getSessionFactory().openSession();
        try {
            transacao = sessao.beginTransaction();
            sessao.update(post);
            transacao.commit();
            sessao.close();
            return 1;
        }catch (HibernateException e) {
            if (transacao!=null) transacao.rollback();
            /*e.printStackTrace();*/
            sessao.close();
            return 2;
        }finally{
            
        }
    }
    
    /* ATUALIZAR VIEWS UM POST */
    public void atualizarVisualizacoes(String linkPermanente){
        Session sessao = HibernateUtil.getSessionFactory().openSession();
        String q = "Update posts as p set p.visualizacoes=(p.visualizacoes + 1) where p.linkPermanente='"+linkPermanente+"'";
        try {
            sessao.getTransaction().begin();
            sessao.createSQLQuery(q).executeUpdate();
            sessao.getTransaction().commit();
            sessao.close();
        }catch (HibernateException e){
            sessao.getTransaction().rollback();
            sessao.close();
        } 
    }
    
    /* RETORNAR TOTAL DE POSTS */
    public int totalPosts(String publicado, String categoria){
        int total = 0;
        Session sessao = HibernateUtil.getSessionFactory().openSession();
        try {
            sessao.beginTransaction();
            if(!publicado.isEmpty() && !categoria.isEmpty()){
                if(publicado.equals("T")){
                    Query q = sessao.createQuery("select from Posts as p, p.tagsDoPost as t where t.idTag=:tag order by p.dataCriacaoPost")
                        .setParameter("tag", categoria);
                    total = q.list().size();
                }else{
                    Query q = sessao.createQuery("select from Posts as p, p.tagsDoPost as t where p.publicado=:publicado and t.idTag=:tag order by p.dataCriacaoPost")
                        .setParameter("publicado", publicado)
                        .setParameter("tag", categoria);
                    total = q.list().size();
                } 
            }else if(!publicado.isEmpty()){
                if(publicado.equals("T")){
                    Query q = sessao.createQuery("select from Posts p order by p.dataCriacaoPost");
                    total = q.list().size();
                }else{
                    Query q = sessao.createQuery("select from Posts p where p.publicado=:p order by p.dataCriacaoPost")
                        .setParameter("p", publicado);
                    total = q.list().size();
                }
            }
        }catch(Exception e){
            /*e.printStackTrace();*/
        }finally{
            sessao.close();
        }
        return total;
    }
    
    /* RETORNAR POSTS POPULARES */
    public List<Posts> recuperarPostsPopulares(Integer indexarInicio, 
            Integer indexarFim, String categoria){
        final List<Posts> posts = new LinkedList<>();
        Session sessao =  HibernateUtil.getSessionFactory().openSession();
        Query q;
        try {
            sessao.beginTransaction();
            if(categoria.isEmpty()){
                q = sessao.createQuery("select p from Posts as p where p.publicado='S' order by p.visualizacoes desc limit :inicio,:fim")                
                    .setParameter("inicio", indexarInicio)
                    .setParameter("fim", indexarFim);
            }else{
                q = sessao.createQuery("select p from Posts as p, p.tagsDoPost as t where p.publicado='S' and t.idTag=:tag order by p.visualizacoes desc limit :inicio,:fim")                
                    .setParameter("inicio", indexarInicio)
                    .setParameter("fim", indexarFim)
                    .setParameter("tag", categoria);
            }
            q.list().forEach((o) -> {
                posts.add((Posts)o);
            });
        }
        catch(Exception e){
            /*e.printStackTrace();*/
        }finally{
            sessao.close();
        }
        return posts;
    }
    
    /* RETORNAE POSTS RECENTES PUBLICADOS */
    public List<Posts> recuperarPostsPublicados(Integer indexarInicio, 
            Integer indexarFim, String categoria){
        final List<Posts> posts = new LinkedList<>();
        Session sessao = HibernateUtil.getSessionFactory().openSession();
        Query q;
        try {
            sessao.beginTransaction();
            if(categoria.isEmpty()){
                q = sessao.createQuery("select from Posts as p where p.publicado='S' order by p.dataCriacaoPost DESC limit :inicio,:fim")                
                    .setParameter("inicio", indexarInicio)
                    .setParameter("fim", indexarFim);
            }else{
                q = sessao.createQuery("select p from Posts as p, p.tagsDoPost as t where p.publicado = 'S' and t.idTag=:tag order by p.dataCriacaoPost DESC limit :inicio,:fim")                
                    .setParameter("inicio", indexarInicio)
                    .setParameter("fim", indexarFim)
                    .setParameter("tag", categoria);
            }
            q.list().forEach((o) -> {
                posts.add((Posts)o);
            });
        }
        catch(Exception e){
            /*e.printStackTrace();*/
        }finally{
            sessao.close();
        }
        return posts;
    }
    
    /* RETORNAE POSTS RECENTES EM RASCUNHO */
    public List<Posts> recuperarPostsEmRascunho(Integer indexarInicio, Integer indexarFim, String categoria){
        final List<Posts> posts = new LinkedList<>();
        Session sessao =  HibernateUtil.getSessionFactory().openSession();
        Query q;
        try {
            sessao.beginTransaction();
            if(categoria.isEmpty()){
                q = sessao.createQuery("select from Posts p where p.publicado = 'N' order by p.dataCriacaoPost DESC limit :inicio, :fim")                
                .setParameter("inicio", indexarInicio).setParameter("fim", indexarFim);
            }else{
                q = sessao.createQuery("select p from Posts as p, p.tagsDoPost as t where p.publicado = 'N' and t.idTag=:tag order by p.dataCriacaoPost DESC limit :inicio,:fim")                
                .setParameter("inicio", indexarInicio)
                .setParameter("fim", indexarFim)
                .setParameter("tag", categoria);
            }
            q.list().forEach((o) -> {
                posts.add((Posts)o);
            });
        }
        catch(Exception e){
            /*e.printStackTrace();*/
        }finally{
            sessao.close();
        }
        return posts;
    }
    
    /* RETORNAR TODOS POSTS RECENTES */
    public List<Posts> recuperarTodosPosts(Integer indexarInicio, Integer indexarFim, String categoria){
        final List<Posts> posts = new LinkedList<>();
        Query q;
        Session sessao = HibernateUtil.getSessionFactory().openSession();
        try {
            sessao.beginTransaction();
            if(categoria.isEmpty()){
                q = sessao.createQuery("select from Posts p order by p.dataCriacaoPost DESC limit :inicio,:fim")                
                .setParameter("inicio", indexarInicio).setParameter("fim", indexarFim);
            }else{
                q = sessao.createQuery("select p from Posts as p, p.tagsDoPost as t where t.idTag=:tag order by p.dataCriacaoPost DESC limit :inicio,:fim")                
                .setParameter("inicio", indexarInicio).setParameter("fim", indexarFim)
                .setParameter("tag", categoria);
            }
            q.list().forEach((o) -> {
                posts.add((Posts)o);
            });
        }
        catch(Exception e){
            /*e.printStackTrace();*/
        }finally{
            sessao.close();
        }
        return posts;
    }
    
    /* RETORNAE POSTAGENS POR DADA CATEGORIA */
    public Posts postPorId(String id){
        Posts post = null;
        Session sessao = HibernateUtil.getSessionFactory().openSession();
        try {
            sessao.beginTransaction();
            Query q = sessao.createQuery("select from Posts as p where p.id=:id")                
            .setParameter("id", id);
            Object o = q.list().get(0);
            if(o != null){
                post = (Posts) o;
            }
            sessao.close();
            return post;
        }catch(HibernateException e){
            sessao.close();
            return null;
        }
    }
    
    /* RETORNAR POSTAGENS POR LINK PERMANENTE */
    public Posts postPorLinkPermanente(String linkPermanente, boolean contarViews){
        Posts post = null;
        Session sessao =  HibernateUtil.getSessionFactory().openSession();
        try {
            sessao.beginTransaction();
            Query q = sessao.createQuery("select from Posts as p where p.linkPermanente=:link")                
                .setParameter("link", linkPermanente);
 
            
            if(q.list().size() > 0){
                Object o = q.list().get(0);
                post = (Posts) o;
            }
            sessao.close();
            if(contarViews){
                atualizarVisualizacoes(linkPermanente);
            }
            return post;
        }catch(HibernateException e){
            sessao.close();
            return null;
        }
    }
}
