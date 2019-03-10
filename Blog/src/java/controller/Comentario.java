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
import java.util.Arrays;
import java.util.List;
import java.util.Map;
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
@WebServlet("/submeter-comentario")
public class Comentario extends HttpServlet{
    
    @Override
    public void doGet(HttpServletRequest requisicao,HttpServletResponse resposta) 
            throws ServletException, IOException{
        if(requisicao.getParameter("id") != null){
            String id = requisicao.getParameter("id");
            HttpSession sessaoHttp = requisicao.getSession();
            Comentarios comentario = new ComentariosDAO().recuperarComentario(Integer.valueOf(id));            
            if(sessaoHttp.getAttribute("nomeUsuario").equals(comentario.getUsuarios().getNomeUsuario()) 
                    || (sessaoHttp.getAttribute("privilegios").equals("A") && comentario.getUsuarios().getPrivilegios() != 'A' && comentario.getUsuarios().getPrivilegios() != 'S')
                    || sessaoHttp.getAttribute("privilegios").equals("S")){
                new ComentariosDAO().removerComentariosEmCadeia(comentario);
            }
        }
    }
    
    @Override
    public void doPost(HttpServletRequest requisicao, HttpServletResponse resposta) 
            throws ServletException, IOException{
        HttpSession sessaoHttp = requisicao.getSession();
        if(requisicao.getParameter("captcha").equals(sessaoHttp.getAttribute("captchaValido"))){
            Usuarios usuario = new UsuariosDAO().recuperarUsuario(sessaoHttp.getAttribute("nomeUsuario").toString());
            Posts post = new PostsDAO().postPorId(requisicao.getParameter("idPost"));
            boolean palavraEncontrada = false;
            
            Map<String,String[]> mapaOpcoes = new OpcoesDAO().retornarMapaConfiguracoes();
            List<String> palavrasProibidas = Arrays.asList(mapaOpcoes.get("opc_palavrasBloqueadas")[1].split(","));
            for(String p : palavrasProibidas){
                if(requisicao.getParameter("comentario").toLowerCase().contains(p.toLowerCase())){
                    palavraEncontrada = true;
                    break;
                }
            }
            if(palavraEncontrada == false){
                Comentarios comentario = new Comentarios();
                comentario.setPosts(post);
                comentario.setUsuarios(usuario);
                comentario.setComentario(requisicao.getParameter("comentario"));
                comentario.setTipo(requisicao.getParameter("tipoComentario").charAt(0));
                comentario.setComentarioPai(Integer.valueOf(requisicao.getParameter("comentarioPai")));
                new ComentariosDAO().persistirComentario(comentario);
                resposta.sendError(HttpServletResponse.SC_OK);
            }else{
                resposta.sendError(HttpServletResponse.SC_NOT_ACCEPTABLE);
            }
        }else{
            resposta.sendError(HttpServletResponse.SC_PRECONDITION_FAILED);
        }
    }  
}
