/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import controller.Senha;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import hibernate.HibernateUtil;
import java.util.LinkedList;
import models.Usuarios;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author mathe
 */
public class UsuariosDAO {
    
    /* RETORNAR TODOS OS USUARIOS */
    public List<Usuarios> recuperarTodosUsuarios(boolean todos){
        final List<Usuarios> usuarios = new LinkedList<>();
        Query q;
        Session sessao = HibernateUtil.getSessionFactory().openSession();
        try {
            sessao.beginTransaction();
            /* retonrna todos os usuarios ou apenas editores/administradores do site */
            if(todos == false){
                q = sessao.createQuery("select from Usuarios as u where u.privilegios='A' or u.privilegios='E'");
            }else{
                q = sessao.createQuery("select from Usuarios");    
            }
            q.list().forEach((o) -> {
                usuarios.add((Usuarios) o);
            });
        }catch(Exception e){
            /*e.printStackTrace();*/
        }finally{
            sessao.close();
        }
        return usuarios;
    }
    
    /* RETORNA USUARIO POR NOME DE USUARIO */
    public Usuarios recuperarUsuario(String nomeUsuario){
        Usuarios usuario = new Usuarios();
        Session sessao = HibernateUtil.getSessionFactory().openSession();
        try {
            sessao.beginTransaction();
                Query q =  sessao.createQuery("select from Usuarios u where u.nomeUsuario=:usuario")                
            .setParameter("usuario", nomeUsuario);
            List<Object[]> resultados = q.list();
            if(resultados.size() == 1){
                Object o = q.list().get(0);
                if(o != null){
                    usuario = (Usuarios) o;
                }
            }else{
                usuario = null;
            }
        }catch(Exception e){
            /*e.printStackTrace();*/
            usuario = null;
        }finally{
            sessao.close();
        }
        return usuario;
    }
    
    /* FAZ A VALIDAÇÃO DO USUARIO NO BANCO */
    public Map<String,String> validarLogin(String login, String senha){
        Map<String,String> logado = new HashMap<>();
        Session sessao = HibernateUtil.getSessionFactory().openSession();
        try {
            sessao.beginTransaction();
            Usuarios usuario = recuperarUsuario(login);
            if(usuario != null){
                /* USUARIO EXISTE, VERIFICA SE SENHA ESTA CORRETA */
                if(Senha.verificarSenha(senha, usuario.getSenha(), usuario.getChave()) == true){
                    logado.put("login",usuario.getNomeUsuario());
                    logado.put("id",usuario.getId().toString());
                    logado.put("chave",usuario.getChave());
                    logado.put("nome",usuario.getNome());
                    logado.put("sobrenome",usuario.getSobrenome());
                    logado.put("foto",usuario.getFoto());
                    logado.put("email",usuario.getEmail());
                    logado.put("codigoStatus","1");
                    logado.put("privilegios",String.valueOf(usuario.getPrivilegios()));
                }else{
                    /* USUARIO EXITE MAS SENHA ESTÁ INCORRETA */
                    logado.put("codigoStatus","2");
                }
            }else{
                /* USUARIO NAO EXISTE */
                logado.put("codigoStatus","0");
            }
        }catch(Exception e){
            /*e.printStackTrace();*/
            /* EXCEÇÃO NO BANCO DE DADOS */
            logado.put("codigoStatus","3");
        }finally{
            sessao.close();
        }
        return logado;
    }
    
    /* PERSISTE USUARIO NO BANCO */
    public int persistirUsuario(Usuarios usuario){       
        Transaction transacao = null;
        Session sessao = HibernateUtil.getSessionFactory().openSession();
        try {
            if(recuperarUsuario(usuario.getNomeUsuario()) != null){
                return 0;
            }else{
                transacao = sessao.beginTransaction();
                sessao.persist(usuario);
                transacao.commit();
                sessao.close();
                return 1;
            }
        }catch (HibernateException e) {
            if (transacao!=null) transacao.rollback();
            /*e.printStackTrace();*/
            sessao.close();
            return 2;
        }
    }
    
    public void removerUsuario(Usuarios usuario){
        Transaction transacao = null;
        Session sessao =  HibernateUtil.getSessionFactory().openSession();
        try {
            transacao = sessao.beginTransaction();
            sessao.delete(usuario);
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
    
    /* ATUALIZA USUARIO NO BANCO */
    public int atualizarUsuario(Usuarios usuario){       
        Transaction transacao = null;
        Session sessao = HibernateUtil.getSessionFactory().openSession();
        try {
            transacao = sessao.beginTransaction();
            sessao.update(usuario);
            transacao.commit();
            sessao.close();
            return 1;
        }catch (HibernateException e) {
            if (transacao!=null) 
                transacao.rollback();
            /*e.printStackTrace();*/
            sessao.close();
            return 2;
        }
    }
    
    /* RETORNA USUARIO POR ID */
    public Usuarios usuarioPorId(int id){
        Usuarios usuario = new Usuarios();
        Session sessao = HibernateUtil.getSessionFactory().openSession();
        try {
            sessao.beginTransaction();
            Query q = sessao.createQuery("select from Usuarios as u where u.id=:id")                
            .setParameter("id", id);
            List<Object[]> resultados = q.list();
            if(resultados.size() == 1){
                Object o = q.list().get(0);
                if(o != null){
                    usuario = (Usuarios) o;
                }
            }else{
                usuario = null;
            }
        }catch(Exception e){
            /*e.printStackTrace();*/
            usuario = null;
        }finally{
            sessao.close();
        }
        return usuario;
    }
}
