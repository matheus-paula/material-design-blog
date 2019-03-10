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
import models.Comentarios;

/**
 *
 * @author matheus
 */
@WebServlet("")
public class Principal extends HttpServlet{
    
    @Override
    public void doGet(HttpServletRequest requisicao,
        HttpServletResponse resposta) throws ServletException, IOException{
        int paginaAtual = 1;
        int itensPorPagina = 10;
        int paginas;
        int total;
        if(requisicao.getParameter("itens") != null){
            itensPorPagina = Integer.valueOf(requisicao.getParameter("itens"));
        }
        if(requisicao.getParameter("p") != null){
            paginaAtual = Integer.valueOf(requisicao.getParameter("p"));
        }
        
        total = new PostsDAO().totalPosts("S","");
        paginas = (int) Math.ceil(((double)total/(double)itensPorPagina));
        requisicao.setAttribute("paginas",paginas);
        requisicao.setAttribute("totalPosts",total);
        requisicao.setAttribute("paginaAtual",paginaAtual);
        requisicao.setAttribute("itensPorPagina",itensPorPagina);

        if(paginaAtual == 1){
            paginaAtual = 0;
        }else{
            paginaAtual = ((paginaAtual * itensPorPagina) - itensPorPagina);
        }
        
        List<Posts> posts = new PostsDAO().recuperarPostsPublicados(paginaAtual,itensPorPagina,"");
        requisicao.setAttribute("posts", posts);
        
        Map<String,String[]> mapaOpcoes = new OpcoesDAO().retornarMapaConfiguracoes();
        requisicao.setAttribute("mapaOpcoes", mapaOpcoes);

        List<Posts> postsPopulares = new PostsDAO().recuperarPostsPopulares(0,5,"");
        requisicao.setAttribute("postsPopulares", postsPopulares);

        List<Comentarios> comentariosRecentes = new ComentariosDAO().recuperarComentariosRecentes(0,5,false);
        requisicao.setAttribute("comentariosRecentes",comentariosRecentes);
        
        RequestDispatcher view = requisicao.getRequestDispatcher("/index.jsp");
        view.forward(requisicao, resposta);
    }  
}
