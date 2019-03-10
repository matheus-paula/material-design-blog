/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.OpcoesDAO;
import dao.UsuariosDAO;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Usuarios;

/**
 *
 * @author matheus
 */
@WebServlet("/painel/usuarios")
public class PainelUsuarios extends HttpServlet{
    
    @Override
    public void doGet(HttpServletRequest requisicao,
        HttpServletResponse resposta) throws ServletException, IOException{
        HttpSession sessaoHttp = requisicao.getSession();
        if(sessaoHttp.getAttribute("privilegios") != null){ 
            String privilegios = sessaoHttp.getAttribute("privilegios").toString();
            if(privilegios.equals("A") || privilegios.equals("E") || privilegios.equals("S")){

                List<Usuarios> usuarios = new UsuariosDAO().recuperarTodosUsuarios(false);
                
                requisicao.setAttribute("usuarios",usuarios);
                
                Map<String,String[]> mapaOpcoes = new OpcoesDAO().retornarMapaConfiguracoes();
                requisicao.setAttribute("mapaOpcoes", mapaOpcoes);
        
                RequestDispatcher view = requisicao.getRequestDispatcher("../painelUsuarios.jsp");
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
            int idUsuarioLogado = Integer.valueOf(sessaoHttp.getAttribute("id").toString());
            int idUsuario = Integer.valueOf(requisicao.getParameter("id"));
            Usuarios usuario = new UsuariosDAO().usuarioPorId(idUsuario);
            if(privilegios.equals("A") || privilegios.equals("S")){
                if(acao.equals("alterarPrivilegios") && (privilegios.equals("A") || privilegios.equals("S"))){
                    usuario.setPrivilegios(requisicao.getParameter("privilegio").charAt(0));
                    new UsuariosDAO().atualizarUsuario(usuario);
                }else if((acao.equals("excluirUsuario") && (privilegios.equals("A") || privilegios.equals("S")))
                        || (acao.equals("excluirUsuario") && Objects.equals(idUsuario, idUsuarioLogado)) ){
                    new UsuariosDAO().removerUsuario(usuario);
                    if(Objects.equals(idUsuario, idUsuarioLogado)){
                        sessaoHttp.invalidate();
                        resposta.sendRedirect(requisicao.getContextPath()+"/");
                    }
                }
            }
            resposta.sendRedirect(requisicao.getContextPath()+"/painel/usuarios");
        }
    }
}
