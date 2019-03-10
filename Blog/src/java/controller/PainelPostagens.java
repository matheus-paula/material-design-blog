/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.OpcoesDAO;
import dao.PostsDAO;
import dao.TagsDAO;
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
import models.Posts;
import models.Tags;

/**
 *
 * @author matheus
 */
@WebServlet("/painel/postagens")
public class PainelPostagens extends HttpServlet{
    
    @Override
    public void doGet(HttpServletRequest requisicao,
        HttpServletResponse resposta) throws ServletException, IOException{
        HttpSession sessaoHttp = requisicao.getSession();
        if(sessaoHttp.getAttribute("privilegios") != null){ 
            String privilegios = sessaoHttp.getAttribute("privilegios").toString();
            if(privilegios.equals("A") || privilegios.equals("E") || privilegios.equals("S")){
                String aba;
                int paginaAtual = 1;
                int itensPorPagina = 10;
                int paginas = 0;
                int total = 0;

                if (requisicao.getParameterMap().containsKey("tipo")) {
                    aba = requisicao.getParameter("tipo");
                }else{
                    aba = "todas";
                }
                if(requisicao.getParameter("itens") != null){
                    itensPorPagina = Integer.valueOf(requisicao.getParameter("itens"));
                }
                if(requisicao.getParameter("p") != null){
                    paginaAtual = Integer.valueOf(requisicao.getParameter("p"));
                }

                switch (aba) {
                    case "publicadas":
                        {
                            if(requisicao.getParameter("c") != null){
                                total = new PostsDAO().totalPosts("S","");
                            }else{
                                total = new PostsDAO().totalPosts("S",requisicao.getParameter("c"));
                            }
                            paginas = (int) Math.ceil(((double)total/(double)itensPorPagina));
                            requisicao.setAttribute("paginas",paginas);
                            requisicao.setAttribute("totalPosts",total);
                            requisicao.setAttribute("paginaAtual",paginaAtual);

                            if(paginaAtual == 1){
                                paginaAtual = 0;
                            }else{
                                paginaAtual = ((paginaAtual * itensPorPagina) - itensPorPagina);
                            }

                            if(requisicao.getParameterMap().containsKey("tag")){
                                List<Posts> posts = new PostsDAO().recuperarPostsPublicados(paginaAtual,itensPorPagina,requisicao.getParameter("tag"));
                                requisicao.setAttribute("posts", posts);
                            }else{
                                List<Posts> posts = new PostsDAO().recuperarPostsPublicados(paginaAtual,itensPorPagina,"");
                                requisicao.setAttribute("posts", posts);
                            }

                            break;
                        }
                    case "rascunhos":
                        {
                            if(requisicao.getParameterMap().containsKey("tag")){
                                total = new PostsDAO().totalPosts("T",requisicao.getParameter("tag"));

                            }else{
                                total = new PostsDAO().totalPosts("T",""); 
                            }
                            paginas = (int) Math.ceil(((double)total/(double)itensPorPagina));
                            requisicao.setAttribute("paginas",paginas);
                            requisicao.setAttribute("totalPosts",total);
                            requisicao.setAttribute("paginaAtual",paginaAtual);

                            if(paginaAtual == 1){
                                paginaAtual = 0;
                            }else{
                                paginaAtual = ((paginaAtual * itensPorPagina) - itensPorPagina);
                            }

                            if(requisicao.getParameterMap().containsKey("tag")){
                                List<Posts> posts = new PostsDAO().recuperarPostsEmRascunho(paginaAtual,itensPorPagina,requisicao.getParameter("tag"));
                                requisicao.setAttribute("posts", posts);   
                            }else{
                                List<Posts> posts = new PostsDAO().recuperarPostsEmRascunho(paginaAtual,itensPorPagina,"");
                                requisicao.setAttribute("posts", posts);    
                            }
                            break;
                        }
                    case "todas":
                        {
                            if(requisicao.getParameterMap().containsKey("tag")){
                                total = new PostsDAO().totalPosts("T",requisicao.getParameter("tag"));
                            }else{
                                total = new PostsDAO().totalPosts("T",""); 
                            }
                            paginas = (int) Math.ceil(((double)total/(double)itensPorPagina));
                            requisicao.setAttribute("paginas",paginas);
                            requisicao.setAttribute("totalPosts",total);
                            requisicao.setAttribute("paginaAtual",paginaAtual);

                            if(paginaAtual == 1){
                                paginaAtual = 0;
                            }else{
                                paginaAtual = ((paginaAtual * itensPorPagina) - itensPorPagina);
                            }

                            if(requisicao.getParameterMap().containsKey("tag")){
                                List<Posts> posts = new PostsDAO().recuperarTodosPosts(paginaAtual,itensPorPagina,requisicao.getParameter("tag"));
                                requisicao.setAttribute("posts", posts);
                            }else{
                                List<Posts> posts = new PostsDAO().recuperarTodosPosts(paginaAtual,itensPorPagina,"");
                                requisicao.setAttribute("posts", posts);
                            }
                            break;
                        }
                    default:
                        {
                            if(requisicao.getParameterMap().containsKey("tag")){
                                total = new PostsDAO().totalPosts("T",requisicao.getParameter("tag"));
                            }else{
                                total = new PostsDAO().totalPosts("T",""); 
                            }
                            paginas = (int) Math.ceil(((double)total/(double)itensPorPagina));
                            requisicao.setAttribute("paginas",paginas);
                            requisicao.setAttribute("totalPosts",total);
                            requisicao.setAttribute("paginaAtual",paginaAtual);

                            if(paginaAtual == 1){
                                paginaAtual = 0;
                            }else{
                                paginaAtual = ((paginaAtual * itensPorPagina) - itensPorPagina);
                            }

                            if(requisicao.getParameterMap().containsKey("tag")){
                                List<Posts> posts = new PostsDAO().recuperarTodosPosts(paginaAtual,itensPorPagina,requisicao.getParameter("tag"));
                                requisicao.setAttribute("posts", posts);
                            }else{
                                List<Posts> posts = new PostsDAO().recuperarTodosPosts(paginaAtual,itensPorPagina,"");
                                requisicao.setAttribute("posts", posts);
                            }
                            break;
                        }
                }
                if(requisicao.getParameterMap().containsKey("tag")){
                    requisicao.setAttribute("tagAtual", requisicao.getParameter("tag"));
                }
                List<Tags> tags = new TagsDAO().obterTags();
                requisicao.setAttribute("tags", tags);
                requisicao.setAttribute("tipo", aba);
                
                Map<String,String[]> mapaOpcoes = new OpcoesDAO().retornarMapaConfiguracoes();
                requisicao.setAttribute("mapaOpcoes", mapaOpcoes);
        
                RequestDispatcher view = requisicao.getRequestDispatcher("../painelPostagens.jsp");
                view.forward(requisicao, resposta);
            }
        }else{
            resposta.sendRedirect(requisicao.getContextPath()+"/");
        }
    }
    @Override
    public void doPost(HttpServletRequest requisicao, HttpServletResponse resposta) 
            throws ServletException, IOException{
        HttpSession sessaoHttp = requisicao.getSession();
        if(sessaoHttp.getAttribute("nomeUsuario") != null){
            String acao = requisicao.getParameter("acao");
            String privilegios = sessaoHttp.getAttribute("privilegios").toString();
            Posts post = new PostsDAO().postPorId(requisicao.getParameter("id"));
            if(post.getUsuarios().getNomeUsuario().equals(sessaoHttp.getAttribute("nomeUsuario"))
            || privilegios.equals("A") || privilegios.equals("S")){
               switch(acao){
                    case "excluirPost":
                        new PostsDAO().removerPost(post);
                        ;break;
                    case "publicarPost":
                        post.setPublicado('S');
                        new PostsDAO().atualizarPost(post);
                        ;break;
                    case "reverterParaRascunho":
                        post.setPublicado('N');
                        new PostsDAO().atualizarPost(post);
                        ;break;
                    default:;break;
                } 
            }
            resposta.sendRedirect(requisicao.getRequestURI()+(requisicao.getQueryString() != null ? "?"+requisicao.getQueryString(): ""));
        }
    }
}
