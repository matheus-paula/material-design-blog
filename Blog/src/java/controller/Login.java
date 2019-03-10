/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.OpcoesDAO;
import dao.UsuariosDAO;
import models.Usuarios;
import java.io.IOException;
import java.util.Map;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;

/**
 *
 * @author matheus
 */
@WebServlet("/login")
public class Login extends HttpServlet{
    
    @Override
    public void doGet(HttpServletRequest requisicao,HttpServletResponse resposta) 
            throws ServletException, IOException{
        
        String acao = requisicao.getParameter("acao");
        Map<String,String[]> mapaOpcoes = new OpcoesDAO().retornarMapaConfiguracoes();
        requisicao.setAttribute("mapaOpcoes", mapaOpcoes);

        if(acao != null && acao.equals("deslogar")){
            HttpSession sessaoHttp = requisicao.getSession();
            sessaoHttp.invalidate();
            resposta.sendRedirect(requisicao.getContextPath());
        }else{
            RequestDispatcher view = requisicao.getRequestDispatcher("login.jsp");
            view.forward(requisicao, resposta);
        }
    }
    @Override
    public void doPost(HttpServletRequest requisicao, HttpServletResponse resposta) 
            throws ServletException, IOException{
        String acao = requisicao.getParameter("acao");
        Map<String,String[]> mapaOpcoes = new OpcoesDAO().retornarMapaConfiguracoes();
        requisicao.setAttribute("mapaOpcoes", mapaOpcoes);

        RequestDispatcher paginaLogin = requisicao.getRequestDispatcher("login.jsp");
        if(acao != null && acao.equals("registrar")){
            int cadastrado = 2;
            try{
                Usuarios usuario = new Usuarios();
                usuario.setNome(requisicao.getParameter("nome"));
                usuario.setNomeUsuario(requisicao.getParameter("usuario"));
                usuario.setEmail(requisicao.getParameter("email"));
                
                /* GERA A SENHA */
                String key = Senha.obterKey(30);
                usuario.setChave(key);
                usuario.setSenha(Senha.gerarSenha(requisicao.getParameter("senha"), key));
                
                usuario.setSobrenome(requisicao.getParameter("sobrenome"));
                if(requisicao.getParameter("privilegios") != null){
                    usuario.setPrivilegios(requisicao.getParameter("privilegios").charAt(0));
                }else{
                    usuario.setPrivilegios('U');
                }
                cadastrado = new UsuariosDAO().persistirUsuario(usuario);
            }catch(Exception e){
                /*e.printStackTrace();*/
            }
            switch (cadastrado) {
                case 1:
                    requisicao.setAttribute("cadastro", "sucesso");
                    break;
                case 0:
                    requisicao.setAttribute("cadastro", "existe");
                    break;
                case 2:
                    requisicao.setAttribute("cadastro", "erro");
                    break;
                default:
                    break;
            }
            paginaLogin.forward(requisicao,resposta);
        }else{
            //acao para login
            Map<String,String> resultado = new UsuariosDAO().validarLogin(requisicao.getParameter("usuario"),requisicao.getParameter("senha"));
            HttpSession sessaoHttp = requisicao.getSession();
            sessaoHttp.invalidate();
            sessaoHttp = requisicao.getSession(true);
            if(resultado.get("codigoStatus").equals("1")){
                sessaoHttp.setAttribute("id", resultado.get("id"));
                sessaoHttp.setAttribute("nomeUsuario", resultado.get("login"));
                sessaoHttp.setAttribute("chaveUsuario", resultado.get("chave"));
                sessaoHttp.setAttribute("emailUsuario", resultado.get("email"));
                sessaoHttp.setAttribute("fotoUsuario", resultado.get("foto"));
                sessaoHttp.setAttribute("primeiroNomeUsuario", resultado.get("nome"));
                sessaoHttp.setAttribute("sobrenomeUsuario", resultado.get("sobrenome"));
                if(resultado.get("privilegios") != null){
                    sessaoHttp.setAttribute("privilegios", resultado.get("privilegios"));
                }else{
                    sessaoHttp.setAttribute("privilegios", "U");
                }
               
                /* MANDA USUARIO PARA A PAGINA INICIAL APOS LOGIN EFETUADO COM SUCESSO */
                resposta.sendRedirect(requisicao.getContextPath());
            }else{
                requisicao.setAttribute("statusLogin", resultado.get("codigoStatus"));
                sessaoHttp.invalidate();
                paginaLogin.forward(requisicao,resposta);
            }
        }
        
    }
}