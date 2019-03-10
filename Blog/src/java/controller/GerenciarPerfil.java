/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.OpcoesDAO;
import dao.PostsDAO;
import dao.UsuariosDAO;
import models.Usuarios;
import models.Posts;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author mathe
 */
@WebServlet("/alterar-perfil/*")
@MultipartConfig(maxFileSize=1024*1024*10,      	
                 maxRequestSize=1024*1024*10) 
public class GerenciarPerfil extends HttpServlet{
    private static final String DIRETORIO_FOTOS = "midia\\foto-perfil";
    @Override
    public void doGet(HttpServletRequest requisicao,HttpServletResponse resposta) 
            throws ServletException, IOException{
        
        requisicao.setCharacterEncoding("UTF-8");
        HttpSession sessaoHttp = requisicao.getSession();
            
        /* recebe uri  recupera apenas ultima parte como parametro */
        String uri = requisicao.getRequestURI();
        String perfil = uri.substring(uri.lastIndexOf("/")+1);
        
        if(sessaoHttp.getAttribute("nomeUsuario").toString().equals(perfil)){
            if(perfil != null && !perfil.isEmpty()){
                try{
                    Usuarios usuario = new UsuariosDAO().recuperarUsuario(perfil);
                    requisicao.setAttribute("usuario",usuario); 

                    List<Posts> postsPopulares = new PostsDAO().recuperarPostsPopulares(0,5,"");
                    requisicao.setAttribute("postsPopulares", postsPopulares);

                    Map<String,String[]> mapaOpcoes = new OpcoesDAO().retornarMapaConfiguracoes();
                    requisicao.setAttribute("mapaOpcoes", mapaOpcoes);

                    RequestDispatcher view = requisicao.getRequestDispatcher("../gerenciarPerfil.jsp");
                    view.forward(requisicao, resposta);
                }catch(IOException | ServletException e){
                    
                }
            }else{
                resposta.sendRedirect(requisicao.getContextPath()+"/");
            } 
        }else{
            resposta.sendRedirect(requisicao.getContextPath()+"/");
        }
    }
    @Override
    public void doPost(HttpServletRequest requisicao, HttpServletResponse resposta) 
            throws ServletException, IOException{
              
        String caminhoBase = requisicao.getServletContext().getRealPath("");
        String caminhoFotos = caminhoBase + DIRETORIO_FOTOS;
        String uri = requisicao.getRequestURI();
        String nomePerfil = uri.substring(uri.lastIndexOf("/")+1);
        HttpSession sessaoHttp = requisicao.getSession();
        requisicao.setCharacterEncoding("UTF-8");
        
        if(sessaoHttp.getAttribute("nomeUsuario").equals(nomePerfil)){
            Usuarios usuario = new UsuariosDAO().recuperarUsuario(nomePerfil);
            Part fotoUsuario = requisicao.getPart("fotoUsuario");

            /* ATUALIZA DADOS DO PERFIL */
            if(!requisicao.getParameter("bio").isEmpty()){
                usuario.setBio(requisicao.getParameter("bio"));
            }
            if(!requisicao.getParameter("nome").isEmpty()){
                usuario.setNome(requisicao.getParameter("nome"));
            }
            if(!requisicao.getParameter("sobrenome").isEmpty()){
                usuario.setSobrenome(requisicao.getParameter("sobrenome"));
            }

            /* ATUALIZA FOTO SE PRECISO */
            if(fotoUsuario.getSize() > 0){
                
                /* VALORES QUE DEFINEM O CORTE NA IMAGEM */
                int imagemX = (int) Math.round(Float.valueOf(requisicao.getParameter("imagemPerfil_x")));
                int imagemY = (int) Math.round(Float.valueOf(requisicao.getParameter("imagemPerfil_y")));
                int imagemW = (int) Math.round(Float.valueOf(requisicao.getParameter("imagemPerfil_w")));
                int imagemH = (int) Math.round(Float.valueOf(requisicao.getParameter("imagemPerfil_h")));

                /* DELETA FOTO DEFINIDA ANTERIORMENTE */
                File foto = new File(caminhoBase + File.separator+ usuario.getFoto());
                if(foto.exists()){
                    foto.delete();
                }

                /* CRIA PASTA SE NÃO EXISTIR */
                File diretorioASalvar = new File(caminhoBase+File.separator+"midia"+File.separator+"foto-perfil");
                if (!diretorioASalvar.exists()) {
                    diretorioASalvar.mkdirs();
                }
                
                String nomeDoArquivo = usuario.getNomeUsuario()
                                .replaceAll("[^a-zA-Z0-9\\.\\-]", "_")
                                .toLowerCase() + "_" +
                                usuario.getId().toString() + "." +
                                requisicao.getParameter("imagemPerfil_extensao");

                /* CORTA E SALVA IMAGEM DO PERFIL */
                
                BufferedImage originalImgage = ImageIO.read(fotoUsuario.getInputStream());    
                BufferedImage imagemCropada = originalImgage.getSubimage(imagemX, imagemY, imagemW, imagemH);
                File arquivoDeSaida = new File(caminhoFotos + File.separator + nomeDoArquivo);
                ImageIO.write(imagemCropada, requisicao.getParameter("imagemPerfil_extensao"), arquivoDeSaida);

                /* ALTERA CAMINHO DA FOTO PARA USUARIO */
                usuario.setFoto("midia/foto-perfil/" + nomeDoArquivo);
            }

            /* ALTERA DADOS NA SESSÃO */
            sessaoHttp.setAttribute("emailUsuario", usuario.getEmail());
            sessaoHttp.setAttribute("fotoUsuario", usuario.getFoto());
            sessaoHttp.setAttribute("primeiroNomeUsuario", usuario.getNome());
            sessaoHttp.setAttribute("sobrenomeUsuario", usuario.getSobrenome());

            /* ALTERA DADOS NO BANCO*/
            new UsuariosDAO().atualizarUsuario(usuario);

            resposta.sendRedirect(requisicao.getContextPath()+"/alterar-perfil/"+nomePerfil+"?status=ok");
        }else{
            resposta.sendRedirect(requisicao.getContextPath()+"/");
        }
    }
    
    public static float arredondarNum(float numero, int casasDecimais) {
        BigDecimal temp = new BigDecimal(Float.toString(numero));
        temp = temp.setScale(casasDecimais, BigDecimal.ROUND_HALF_UP);
        return temp.floatValue();
    }
}
