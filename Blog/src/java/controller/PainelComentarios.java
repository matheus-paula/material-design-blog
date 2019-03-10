/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.ComentariosDAO;
import dao.OpcoesDAO;
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
@WebServlet("/painel/comentarios")
public class PainelComentarios extends HttpServlet{
    
    @Override
    public void doGet(HttpServletRequest requisicao,
        HttpServletResponse resposta) throws ServletException, IOException{
        HttpSession sessaoHttp = requisicao.getSession();
        if(sessaoHttp.getAttribute("privilegios") != null){ 
            String privilegios = sessaoHttp.getAttribute("privilegios").toString();
            if(privilegios.equals("A") || privilegios.equals("E") || privilegios.equals("S")){
              
                int paginaAtual = 1;
                int itensPorPagina = 10;
                int paginas = 0;
                int total = 0;

                if(requisicao.getParameter("itens") != null){
                    itensPorPagina = Integer.valueOf(requisicao.getParameter("itens"));
                }
                if(requisicao.getParameter("p") != null){
                    paginaAtual = Integer.valueOf(requisicao.getParameter("p"));
                }

                total = new ComentariosDAO().totalDeComentarios();
                paginas = (int) Math.ceil(((double)total/(double)itensPorPagina));
                requisicao.setAttribute("paginas",paginas);
                requisicao.setAttribute("totalComentarios",total);
                requisicao.setAttribute("paginaAtual",paginaAtual);
                
                if(paginaAtual == 1){
                    paginaAtual = 0;
                }else{
                    paginaAtual = ((paginaAtual * itensPorPagina) - itensPorPagina);
                }
                
                List<Comentarios> comentarios = new ComentariosDAO().recuperarComentariosRecentes(paginaAtual,itensPorPagina,true);
                requisicao.setAttribute("comentarios",comentarios);
        
                Map<String,String[]> mapaOpcoes = new OpcoesDAO().retornarMapaConfiguracoes();
                requisicao.setAttribute("mapaOpcoes", mapaOpcoes);
                RequestDispatcher view = requisicao.getRequestDispatcher("../painelComentarios.jsp");
                view.forward(requisicao, resposta);
            }
        }
    }
    @Override
    public void doPost(HttpServletRequest requisicao, HttpServletResponse resposta) 
            throws ServletException, IOException{
        HttpSession sessaoHttp = requisicao.getSession();
        if(sessaoHttp.getAttribute("nomeUsuario") != null){
            String acao = requisicao.getParameter("acao");
            String privilegios = sessaoHttp.getAttribute("privilegios").toString();
            Comentarios comentario = new ComentariosDAO().recuperarComentario(Integer.valueOf(requisicao.getParameter("id")));
            if(comentario.getPosts().getUsuarios().getNomeUsuario().equals(sessaoHttp.getAttribute("nomeUsuario"))
            || privilegios.equals("A") || privilegios.equals("S")){
               switch(acao){
                    case "excluirComentario":
                        new ComentariosDAO().removerComentario(comentario);
                        ;break;
                    default:;break;
                } 
            }
            resposta.sendRedirect(requisicao.getRequestURI()+(requisicao.getQueryString() != null ? "?"+requisicao.getQueryString(): ""));
        }
    }
}
