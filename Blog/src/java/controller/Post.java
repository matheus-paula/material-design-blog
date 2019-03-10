/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.ComentariosDAO;
import dao.OpcoesDAO;
import dao.PostsDAO;
import models.Posts;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Comentarios;


/**
 *
 * @author mathe
 */
@WebServlet("/post/*")
public class Post extends HttpServlet{ 
    @Override
    public void doGet(HttpServletRequest requisicao,HttpServletResponse resposta) 
            throws ServletException, IOException{
        String uri = requisicao.getRequestURI();
        String link = uri.substring(uri.lastIndexOf("/")+1);
        
        PostsDAO c = new PostsDAO();
        Posts post = c.postPorLinkPermanente(link,true);
        requisicao.setAttribute("post", post);
        
        String privilegios;
        HttpSession sessaoHttp = requisicao.getSession();
        
        if(sessaoHttp.getAttribute("privilegios") != null){
            privilegios = sessaoHttp.getAttribute("privilegios").toString();
        }else{
            privilegios = "";
        }

        if(post != null && post.getPublicado() == 'N' && (privilegios.equals("U") || privilegios.isEmpty())){
            resposta.sendRedirect("../");
        }else{
            List<Posts> postsPopulares = new PostsDAO().recuperarPostsPopulares(0,5,"");
            requisicao.setAttribute("postsPopulares", postsPopulares);

            Map<String,String[]> mapaOpcoes = new OpcoesDAO().retornarMapaConfiguracoes();
            requisicao.setAttribute("mapaOpcoes", mapaOpcoes);
            
            List<Comentarios> comentariosRecentes = new ComentariosDAO().recuperarComentariosRecentes(0,5,false);
            requisicao.setAttribute("comentariosRecentes",comentariosRecentes);
        
            RequestDispatcher view = requisicao.getRequestDispatcher("../post.jsp");
            view.forward(requisicao, resposta);
        }
    } 
}
