<%-- 
    Document   : gerenciarPerfil
    Created on : 08/09/2018, 15:36:37
    Author     : mathe
--%>
<%@page import="java.util.Map"%>
<%@page import="models.Usuarios"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="urlBase" value="${pageContext.request.contextPath}" />
<%
    Usuarios perfil;
    Map<String,String[]> mapaOpcoes = (Map<String,String[]>) request.getAttribute("mapaOpcoes");
    if(request.getAttribute("usuario") != null){
        perfil = (Usuarios) request.getAttribute("usuario");
    }else{
        perfil = null;
    }
%>
<!-- POST -->
<!DOCTYPE html>
<html>
    <head>
        <title>${mapaOpcoes.get("opc_tituloSite")[1]} | Meu Perfil</title>
        <meta name="description" content="${mapaOpcoes.get("opc_descricaoSite")[1]}"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link href="${urlBase}/css/default.css" rel="stylesheet">
        <link href="${urlBase}/css/perfil.css" rel="stylesheet">
        <link href="${urlBase}/fontes/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500" rel="stylesheet">
        <link href="${urlBase}/css/plugins/jquery.Jcrop.css" rel="stylesheet">
        <script src="${urlBase}/js/plugins/jquery-3.3.1.min.js" type="text/javascript"></script>
        <script src="${urlBase}/js/plugins/jquery.Jcrop.min.js" type="text/javascript"></script>
        <script src="${urlBase}/js/scripts/scripts.js" type="text/javascript"></script>
        <script src="${urlBase}/js/scripts/editorPerfil.js" type="text/javascript"></script>
    </head>
    <body>
        <div class="containerPrincipal">
            <div id="menuDeNavegacao" class="barraLateral">
                <jsp:include page="menu.jsp"/>
            </div>
            <div class="conteudo">
                <!-- CABECALHO -->
                <jsp:include page="blogCabecalho.jsp"/>  
                <div class="containerConteudo">
                    <div class="colunaEsquerda">
                        <!-- conteudo -->
                        <div class="cartao">
                            <% if(perfil != null){ %>
                                <h1>Alterar Perfil</h1>
                                <form id="alterarPerfil" action="<%="../alterar-perfil/"+perfil.getNomeUsuario()%>" method="post" enctype="multipart/form-data">
                                    <input type="hidden" id="imagemPerfil_x" name="imagemPerfil_x" />
                                    <input type="hidden" id="imagemPerfil_y" name="imagemPerfil_y" />
                                    <input type="hidden" id="imagemPerfil_w" name="imagemPerfil_w" />
                                    <input type="hidden" id="imagemPerfil_h" name="imagemPerfil_h" />
                                    <input type="hidden" id="imagemPerfil_extensao" name="imagemPerfil_extensao" />
                                    <div id="containerImagemPerfil">
                                        <% if(perfil.getFoto() != null && !perfil.getFoto().isEmpty()){%>
                                                <div id="imagemPerfil" rel="author" class="fotoUsuario grande" style="background:url('../<%=perfil.getFoto()%>')">
                                                    <img id="previewImagem" src=""/>    
                                                </div>
                                        <% }else{ %>
                                                <div id="imagemPerfil" rel="author" class="fotoUsuario grande">
                                                    <img id="previewImagem" src=""/>    
                                                </div>
                                        <% } %>
                                        <div id="escolherFoto">
                                            <input id="fotoUsuario" class="botaoCircular" type="file" name="fotoUsuario" accept=".jpg,.jpeg,.png">
                                            <label title="Adicionar foto de perfil" for="fotoUsuario">
                                                <i class="fa fa-camera"></i>
                                            </label>
                                        </div>    
                                    </div>
                                    <div id="camposPerfil">
                                        <div class="campoDeTexto">
                                            <input id="nome" name="nome" value="<%=perfil.getNome() %>"type="text" maxlength="50" autocomplete="off">
                                            <label for="nome">Nome</label>
                                            <div></div>
                                        </div>
                                        <div class="campoDeTexto">
                                            <input id="sobrenome" name="sobrenome" value="<%=perfil.getSobrenome() %>" type="text" maxlength="50" autocomplete="off">
                                            <label for="sobrenome">Sobrenome</label>
                                            <div></div>
                                        </div>
                                        <div class="caixaDeTexto">
                                            <textarea id="bio" name="bio" maxlength="254"><%=perfil.getBio() %></textarea>
                                            <label for="bio">Bio</label>
                                            <div></div>
                                        </div>
                                        <div class="botaoPadrao">
                                            <input id="botaoAtualizarPerfil" title="Atualizar Perfil" value="Atualizar Perfil" type="submit"/>
                                        </div>
                                    </div>
                                </form>
                            <% } else { %>
                                <h2>Autor não encontrado</h2>
                            <% } %>
                        </div>
                    </div>
                    <div class="colunaDireita">
                        <div class="cartao">
                            <h3>Posts Populares</h3>
                           <jsp:include page="postsPopulares.jsp"/>
                        </div>
                    </div>
                    <div class="quebrarFloat"></div>
                </div>      
                <div class="rodape">
                    <h3>${mapaOpcoes.get("opc_creditosRodape")[1]} | ${mapaOpcoes.get("opc_tituloSite")[1]}</h3>
                </div>
            </div>
        </div>
        <div id="cortarImagem">
            <div id="cortarImagemContainer" class="cartao">
                <img src="" id="cortarImagemAlvo"  />
                <div id="confirmarCorteImagem" class="botaoPadrao">
                    <button type="button">Cortar</a>
                </div>
            </div>
        </div>
    </body>
</html>

