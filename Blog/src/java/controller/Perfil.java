/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.ComentariosDAO;
import dao.OpcoesDAO;
import dao.PostsDAO;
import dao.UsuariosDAO;
import models.Usuarios;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Comentarios;
import models.Posts;

/**
 *
 * @author mathe
 */
@WebServlet("/perfil/*")
public class Perfil extends HttpServlet{
    
    @Override
    public void doGet(HttpServletRequest requisicao,HttpServletResponse resposta) 
            throws ServletException, IOException{
        /* recebe uri  recupera apenas ultima parte como parametro */
        String uri = requisicao.getRequestURI();
        String autor = uri.substring(uri.lastIndexOf("/")+1);
        if(autor != null && !autor.isEmpty()){
            try{
                Usuarios usuario = new UsuariosDAO().recuperarUsuario(autor);
                requisicao.setAttribute("usuario",usuario);
            }catch(Exception e){}
        }
        
        List<Posts> postsPopulares = new PostsDAO().recuperarPostsPopulares(0,5,"");
        requisicao.setAttribute("postsPopulares", postsPopulares);
        
        Map<String,String[]> mapaOpcoes = new OpcoesDAO().retornarMapaConfiguracoes();
        requisicao.setAttribute("mapaOpcoes", mapaOpcoes);
        
        List<Comentarios> comentariosRecentes = new ComentariosDAO().recuperarComentariosRecentes(0,5,false);
        requisicao.setAttribute("comentariosRecentes",comentariosRecentes);

        RequestDispatcher view = requisicao.getRequestDispatcher("../perfil.jsp");
        view.forward(requisicao, resposta);
    }
}