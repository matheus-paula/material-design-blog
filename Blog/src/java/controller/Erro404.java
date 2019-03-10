/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.ComentariosDAO;
import dao.OpcoesDAO;
import dao.PostsDAO;
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
@WebServlet("/404")
public class Erro404 extends HttpServlet{
       
    @Override
    public void doGet(HttpServletRequest requisicao,HttpServletResponse resposta) 
            throws ServletException, IOException{
     
        List<Posts> postsPopulares = new PostsDAO().recuperarPostsPopulares(0,5,"");
        requisicao.setAttribute("postsPopulares", postsPopulares);
        
        Map<String,String[]> mapaOpcoes = new OpcoesDAO().retornarMapaConfiguracoes();
        requisicao.setAttribute("mapaOpcoes", mapaOpcoes);
        
        List<Comentarios> comentariosRecentes = new ComentariosDAO().recuperarComentariosRecentes(0,5,false);
        requisicao.setAttribute("comentariosRecentes",comentariosRecentes);

        RequestDispatcher view = requisicao.getRequestDispatcher("404.jsp");
        view.forward(requisicao, resposta);
    }
}
