/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.OpcoesDAO;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author mathe
 */
@WebServlet("/painel/configuracoes")
public class PainelConfiguracoes extends HttpServlet{
    
    @Override
    public void doGet(HttpServletRequest requisicao,
        HttpServletResponse resposta) throws ServletException, IOException{
        HttpSession sessaoHttp = requisicao.getSession();
        if(sessaoHttp.getAttribute("privilegios") != null){ 
            String privilegios = sessaoHttp.getAttribute("privilegios").toString();
            if(privilegios.equals("A") || privilegios.equals("E") || privilegios.equals("S")){
                
                Map<String,String[]> mapaOpcoes = new OpcoesDAO().retornarMapaConfiguracoes();
                requisicao.setAttribute("mapaOpcoes", mapaOpcoes);
                RequestDispatcher view = requisicao.getRequestDispatcher("../painelConfiguracoes.jsp");
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
            String privilegios = sessaoHttp.getAttribute("privilegios").toString();
            if(privilegios.equals("S")){
                Map<String,String> mapaOpcoes = new HashMap(){};
                requisicao.getParameterMap().entrySet().stream().map((obj) -> (Map.Entry<String, String[]>) obj).filter((valor) -> (valor.getValue() != null && valor.getValue().length > 0)).forEachOrdered((valor) -> {
                    mapaOpcoes.put(valor.getKey(), valor.getValue()[0]);
                });
                new OpcoesDAO().persistirOpcoes(mapaOpcoes);
            }else{
                resposta.sendRedirect(requisicao.getContextPath()+"/");
            }
        }
    }
}
