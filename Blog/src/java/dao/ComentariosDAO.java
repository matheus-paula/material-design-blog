/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.LinkedList;
import java.util.List;
import java.util.Objects;
import models.Comentarios;
import hibernate.HibernateUtil;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author mathe
 */
public class ComentariosDAO {
    public void persistirComentario(Comentarios comentario){       
        Transaction transacao = null;
        Session sessao =  HibernateUtil.getSessionFactory().openSession();
        try {
            transacao = sessao.beginTransaction();
            sessao.persist(comentario);
            transacao.commit();
        }
        catch (HibernateException e) {
            if (transacao!=null) transacao.rollback();
            e.printStackTrace();
            sessao.close();
        }finally{
            sessao.close();
        }
    }
    
    public void removerComentario(Comentarios comentario){
        Transaction transacao = null;
        Session sessao =  HibernateUtil.getSessionFactory().openSession();
        try {
            transacao = sessao.beginTransaction();
            sessao.delete(comentario);
            transacao.commit();
        }
        catch (HibernateException e) {
           if (transacao!=null) transacao.rollback();
           e.printStackTrace();
           sessao.close();
        }finally{
            sessao.close();
        }
    }
    
    public void removerComentariosEmCadeia(Comentarios comentario){
       final List<Comentarios> comentarios = new LinkedList<>();
        Session sessao =  HibernateUtil.getSessionFactory().openSession();
        try {
            sessao.beginTransaction();
            Query q = sessao.createQuery("select from Comentarios");
            q.list().forEach((o) -> {
                comentarios.add((Comentarios) o);
            });
            /*REMOVE TODOS OS COMENTARIOS FOREM RESPOSTA DE UM COMENTARIO PRINCIPAL*/
            comentarios.stream().filter((c) -> (Objects.equals(c.getComentarioPai(), comentario.getId()))).forEachOrdered((c) -> {
                removerComentario(c);
            });
            /* REMOVE COMENTARIO PRINCIPAL */
            removerComentario(comentario);
        }catch(Exception e){
           
        }finally{
            sessao.close();
        } 
    }

    public Comentarios recuperarComentario(int id){
        Comentarios comentario = null;
        Session sessao =  HibernateUtil.getSessionFactory().openSession();
        try {
            sessao.beginTransaction();
            Query q = sessao.createQuery("select from Comentarios as c where c.id=:id")                
            .setParameter("id", id);
            Object o = q.list().get(0);
            if(o != null){
                comentario = (Comentarios) o;
            }
            return comentario;
        }catch(Exception e){
            return null;
        }finally{
            sessao.close();
        } 
    }
    
    /* RETORNA COMENTARIOS RECENTES */
    public List<Comentarios> recuperarComentariosRecentes(Integer indexarInicio, 
            Integer indexarFim, boolean rascunhos){
        final List<Comentarios> comentarios = new LinkedList<>();
        Session sessao = HibernateUtil.getSessionFactory().openSession();
        Query q;
        try {
            sessao.beginTransaction();
            if(rascunhos == true){
                q = sessao.createQuery("select c from Comentarios as c order by c.dataComentario desc limit :inicio,:fim")                
                    .setParameter("inicio", indexarInicio)
                    .setParameter("fim", indexarFim);
            }else{
                q = sessao.createQuery("select c from Comentarios as c where c.posts.publicado='S' order by c.dataComentario desc limit :inicio,:fim")                
                    .setParameter("inicio", indexarInicio)
                    .setParameter("fim", indexarFim);
            }
            q.list().forEach((o) -> {
                comentarios.add((Comentarios)o);
            });
        }
        catch(Exception e){
            /*e.printStackTrace();*/
        }finally{
            sessao.close();
        }
        return comentarios;
    }
    
    /* RETORNA NUMERO TOTAL DE COMENTARIOS DO SITE */
    public int totalDeComentarios(){
        int total = 0;
        Session sessao = HibernateUtil.getSessionFactory().openSession();
        Query q;
        try {
            sessao.beginTransaction();
            q = sessao.createQuery("select from Comentarios");
            total = q.list().size();
        }
        catch(Exception e){
            total = 0;
        }finally{
            sessao.close();
        }
        return total;
    }
}
