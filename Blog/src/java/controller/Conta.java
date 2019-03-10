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
import models.Posts;
import models.Usuarios;

/**
 *
 * @author mathe
 */
@WebServlet("/gerenciar-conta/*")
public class Conta extends HttpServlet{
    
    @Override
    public void doGet(HttpServletRequest requisicao,HttpServletResponse resposta) 
            throws ServletException, IOException{
   
        HttpSession sessaoHttp = requisicao.getSession();

        /* recebe uri  recupera apenas ultima parte como parametro */
        String uri = requisicao.getRequestURI();
        String perfil = uri.substring(uri.lastIndexOf("/")+1);
        requisicao.setCharacterEncoding("UTF-8");
        
        if(perfil != null && !perfil.isEmpty()){
            if(sessaoHttp != null && sessaoHttp.getAttribute("nomeUsuario").toString().equals(perfil)){
                try{
                    Usuarios usuario = new UsuariosDAO().recuperarUsuario(perfil);
                    requisicao.setAttribute("usuario",usuario); 

                    List<Posts> postsPopulares = new PostsDAO().recuperarPostsPopulares(0,5,"");
                    requisicao.setAttribute("postsPopulares", postsPopulares);

                    Map<String,String[]> mapaOpcoes = new OpcoesDAO().retornarMapaConfiguracoes();
                    requisicao.setAttribute("mapaOpcoes", mapaOpcoes);

                    List<Comentarios> comentariosRecentes = new ComentariosDAO().recuperarComentariosRecentes(0,5,false);
                    requisicao.setAttribute("comentariosRecentes",comentariosRecentes);

                }catch(Exception e){
                    /*e.printStackTrace();*/
                }finally{
                    RequestDispatcher view = requisicao.getRequestDispatcher("/conta.jsp");
                    view.forward(requisicao, resposta);
                }
            }else{
                resposta.sendRedirect("../");
            } 
        }else{
            resposta.sendRedirect("../");
        }
    }
        @Override
    public void doPost(HttpServletRequest requisicao, HttpServletResponse resposta) 
            throws ServletException, IOException{
        
        requisicao.setCharacterEncoding("UTF-8");
        HttpSession sessaoHttp = requisicao.getSession();
        
        /* recebe uri  recupera apenas ultima parte como parametro */
        String uri = requisicao.getRequestURI();
        String perfil = uri.substring(uri.lastIndexOf("/")+1);
        RequestDispatcher gerenciarConta = requisicao.getRequestDispatcher("conta.jsp");
        String statusSenha;
        
        if(sessaoHttp.getAttribute("nomeUsuario").toString().equals(perfil)){
            if(perfil != null && !perfil.isEmpty()){
                Usuarios usuario = new UsuariosDAO().recuperarUsuario(perfil);
                
                if(requisicao.getParameter("alterar") != null && requisicao.getParameter("alterar").equals("conta")){
                    if(!requisicao.getParameter("nomeUsuario").isEmpty()){
                        usuario.setNomeUsuario(requisicao.getParameter("nomeUsuario"));
                        sessaoHttp.setAttribute("nomeUsuario", requisicao.getParameter("nomeUsuario"));
                    }
                    if(!requisicao.getParameter("emailUsuario").isEmpty()){
                        usuario.setEmail(requisicao.getParameter("emailUsuario"));
                        sessaoHttp.setAttribute("emailUsuario", requisicao.getParameter("emailUsuario"));
                    }
                    /* ALTERA DADOS NO BANCO*/
                    new UsuariosDAO().atualizarUsuario(usuario);
                    resposta.sendRedirect("../gerenciar-conta/"+usuario.getNomeUsuario());
                }else if(requisicao.getParameter("alterar") != null && requisicao.getParameter("alterar").equals("senha")){
                    if(!requisicao.getParameter("senhaUsuarioNova").isEmpty()
                    && !requisicao.getParameter("senhaUsuarioNovaConfirmar").isEmpty()
                    && !requisicao.getParameter("senhaUsuarioAtual").isEmpty()){
                        Map<String,String> resultado = new UsuariosDAO().validarLogin(usuario.getNomeUsuario(),requisicao.getParameter("senhaUsuarioAtual"));
                        if(resultado.get("codigoStatus").equals("1")){
                            if(requisicao.getParameter("senhaUsuarioNova").equals(requisicao.getParameter("senhaUsuarioNovaConfirmar"))){
                                /* GERA A SENHA */
                                String chave = Senha.obterKey(30);
                                usuario.setChave(chave);
                                usuario.setSenha(Senha.gerarSenha(requisicao.getParameter("senhaUsuarioNova"), chave));
                                sessaoHttp.setAttribute("chaveUsuario", chave);
                                statusSenha = "1";
                            }else{
                                statusSenha = "2";
                            }
                        }else{
                            statusSenha = "3";
                        }
                        /* ALTERA DADOS NO BANCO*/
                        new UsuariosDAO().atualizarUsuario(usuario);
                        resposta.sendRedirect("../gerenciar-conta/"+usuario.getNomeUsuario()+"?status="+statusSenha+"&aba=senha");
                    }
                }
            }
        }
    }
}
