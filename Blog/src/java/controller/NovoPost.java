/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import org.apache.commons.lang3.StringUtils;
import dao.OpcoesDAO;
import dao.PostsDAO;
import dao.TagsDAO;
import dao.UsuariosDAO;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ThreadLocalRandom;
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
import models.Posts;
import models.Tags;
import models.Usuarios;

/**
 *
 * @author matheus
 */
@WebServlet("/postagem/nova")
@MultipartConfig(maxFileSize=1024*1024*10,      	
                 maxRequestSize=1024*1024*10)
public class NovoPost extends HttpServlet{
    private static final String DIRETORIO_IMAGENS = "midia\\imagemDestaque";
    
    @Override
    public void doGet(HttpServletRequest requisicao,
        HttpServletResponse resposta) throws ServletException, IOException{
        HttpSession sessaoHttp = requisicao.getSession();
        if(sessaoHttp.getAttribute("privilegios") != null){
            String privilegios = sessaoHttp.getAttribute("privilegios").toString();
            if(privilegios.equals("A") || privilegios.equals("E") || privilegios.equals("S")){
                Map<String,String[]> mapaOpcoes = new OpcoesDAO().retornarMapaConfiguracoes();
                requisicao.setAttribute("mapaOpcoes", mapaOpcoes);
                requisicao.setAttribute("tituloPagina","Nova Postagem");
                RequestDispatcher view = requisicao.getRequestDispatcher("../editor.jsp");
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
        String privilegios = sessaoHttp.getAttribute("privilegios").toString();
        requisicao.setCharacterEncoding("UTF-8");
        Usuarios autor = new UsuariosDAO().recuperarUsuario(sessaoHttp.getAttribute("nomeUsuario").toString());
        Posts post = new Posts();
        post.setUsuarios(autor);  
        
        if(privilegios.equals("A") || privilegios.equals("E") || privilegios.equals("S")){
            
            String caminhoBase = requisicao.getServletContext().getRealPath("");
            Part imagemDestaque = requisicao.getPart("imagemDestaque");
            
            /* INSERE IMAGEM SE ADICIONADA */
            if(imagemDestaque.getSize() > 0){
                String nomeArquivoImagem;
                
                /* CRIA PASTA SE NÃO EXISTIR */
                File diretorioImagem = new File(caminhoBase+File.separator+"midia"+File.separator+"imagemDestaque");
                if (!diretorioImagem.exists()) {
                    diretorioImagem.mkdirs();
                }
                File diretorioMiniatura = new File(caminhoBase+File.separator+"midia"+File.separator+"imagemDestaque"+File.separator+"min");
                if (!diretorioMiniatura.exists()) {
                    diretorioMiniatura.mkdirs();
                }

                nomeArquivoImagem = requisicao.getParameter("linkPermanente")
                        .replaceAll("[^a-zA-Z0-9\\.\\-]", "_")
                         + "_" + String.valueOf(ThreadLocalRandom.current().nextLong(100)) + "." +
                        requisicao.getParameter("imagemDestaqueExtensao");

                /* SALVA IMAGEM DO POST */
                BufferedImage imagem = ImageIO.read(imagemDestaque.getInputStream());
                int altura = imagem.getHeight(),
                    largura = imagem.getWidth(),
                    coordenadasY = altura/2,
                    coordenadasX = largura/2,
                    tamanhoQuadrado = (altura > largura ? largura : altura);
                
                /* SALVA CÓPIA EM TAMANHO REDUZIDO PARA SER USADA COMO MINIATURA */
                BufferedImage miniaturaQuadrada = new BufferedImage(72, 72, BufferedImage.TYPE_INT_RGB);
                BufferedImage imagemCropada = imagem.getSubimage(coordenadasX - (tamanhoQuadrado / 2), coordenadasY - (tamanhoQuadrado / 2), tamanhoQuadrado, tamanhoQuadrado);
                Graphics g = miniaturaQuadrada.createGraphics();
                g.drawImage(imagemCropada, 0, 0, 72, 72, null);
                g.dispose();
                File miniatura = new File(caminhoBase + "midia" + File.separator + "imagemDestaque" + File.separator + "min" + File.separator + nomeArquivoImagem.toLowerCase());
                ImageIO.write(miniaturaQuadrada, requisicao.getParameter("imagemDestaqueExtensao"), miniatura);

                /* TAMANHO ORIGINAL DA IMAGEM */
                File imgDestaque = new File(caminhoBase + "midia" + File.separator + "imagemDestaque" + File.separator + nomeArquivoImagem.toLowerCase());
                ImageIO.write(imagem, requisicao.getParameter("imagemDestaqueExtensao"), imgDestaque);
                
                /* ALTERA CAMINHO DA FOTO PARA USUARIO */
                if(!nomeArquivoImagem.isEmpty()){
                    post.setImagemMiniatura(nomeArquivoImagem);
                }else{
                    post.setImagemMiniatura("");
                }
            }else{
                post.setImagemMiniatura("");
            }

            /* Adiciona tags se forem informadas */
            if(requisicao.getParameter("tagsPost") != null && !requisicao.getParameter("tagsPost").isEmpty()){
                Set<Tags> listaTags = new HashSet<>(0);
                String[] tags;
                String tagsString = requisicao.getParameter("tagsPost").trim();
                if(!tagsString.contains(",")){
                    tags = new String [] {tagsString};
                }else{
                    tags = tagsString.split(",");
                }
                new TagsDAO().inserirMultiplasTags(tags);
                for(String tag: tags){
                    Tags novaTag = new Tags();
                    novaTag.setIdTag(tag);
                    novaTag.setNomeTag(StringUtils.capitalize(tag));
                    listaTags.add(novaTag);
                }
                post.setTagsDoPost(listaTags);
            }     
            
            if(requisicao.getParameter("sumarioPost") != null){
                post.setSumarioPost(requisicao.getParameter("sumarioPost")); 
            }else{
                post.setSumarioPost(""); 
            }
            if(requisicao.getParameter("statusPublicacao") != null){
                post.setPublicado(requisicao.getParameter("statusPublicacao").charAt(0));
            }else{
                post.setPublicado('N');
            }
            if(requisicao.getParameter("tituloPost") != null){
                post.setTituloPost(requisicao.getParameter("tituloPost"));
            }else{
                post.setTituloPost("");
            }
            if(requisicao.getParameter("editorDeTexto") != null){
                post.setConteudoPost(requisicao.getParameter("editorDeTexto")); 
            }else{
                post.setConteudoPost("");
            }
            Posts postExiste = new PostsDAO().postPorLinkPermanente(requisicao.getParameter("linkPermanente"), false);
            if(postExiste != null){
                post.setLinkPermanente(requisicao.getParameter("linkPermanente")+"-"+String.valueOf(ThreadLocalRandom.current().nextLong(100)));
            }else{
                post.setLinkPermanente(requisicao.getParameter("linkPermanente"));
            }
            post.setVisualizacoes(0);
            new PostsDAO().persistirPost(post);
        }
    }
}
