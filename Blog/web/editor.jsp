<%-- 
    Document   : editor
    Created on : 05/09/2018, 23:19:48
    Author     : mathe
--%>

<%@page import="java.util.Map"%>
<%@page import="models.Tags"%>
<%@page import="models.Posts"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="urlBase" value="${pageContext.request.contextPath}" />
<c:set var="caminhoImagem" value="midia/imagemDestaque/" />

<% 
    Posts post;
    String raizDoSite = request.getContextPath();
    Map<String,String[]> mapaOpcoes = (Map<String,String[]>) request.getAttribute("mapaOpcoes");
    
    if(request.getAttribute("post") != null){
        post = (Posts) request.getAttribute("post");
    }else{
        post = null;
    }
    
%>
<!DOCTYPE html>
<html>
    <head>
        <title>${mapaOpcoes.get("opc_tituloSite")[1]} - ${tituloPagina}</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="description" content="${mapaOpcoes.get("opc_descricaoSite")[1]}"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link href="${urlBase}/css/plugins/bootstrap.min.css" rel="stylesheet"/>
        <link href="${urlBase}/css/default.css" rel="stylesheet"/>
        <link href="${urlBase}/fontes/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500" rel="stylesheet"/>
        <script src="${urlBase}/js/plugins/jquery-3.3.1.min.js" type="text/javascript"></script>
        <script src="${urlBase}/js/scripts/scripts.js" type="text/javascript"></script>
        <script src="${urlBase}/js/scripts/editorPostagem.js"></script>
        <link href="${urlBase}/css/plugins/editor.css" rel="stylesheet"/>
        <link href="${urlBase}/css/editor.css" rel="stylesheet"/>
        <script src="${urlBase}/js/plugins/bootstrap.min.js"></script>
        <script src="${urlBase}/js/plugins/editor.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                $("#editorDeTexto").Editor();   
                $("#editorDeTexto").Editor("setText",$("#editorDeTexto").val());
                $(".Editor-editor").bind("DOMSubtreeModified",function(){
                    $("#editorDeTexto").val($("#editorDeTexto").Editor("getText"));
                });;
            });
        </script>
    </head>
    <body>
        <div class="containerPrincipal">
            <div id="menuDeNavegacao" class="barraLateral">
                <jsp:include page="menu.jsp"/>
            </div>
            <div class="conteudo">
                <!-- CABECALHO -->
                <jsp:include page="blogCabecalho.jsp">
                    <jsp:param name="botaoEsquerdo" value="voltar"/>
                </jsp:include> 
                <div class="containerConteudo">
                    <form id="publicarPost" method="post" enctype="multipart/form-data" acceptcharset="UTF-8">
                        <input id="statusPublicacao" name="statusPublicacao" type="hidden" value=""/>
                        <input type="hidden" id="imagemDestaqueExtensao" name="imagemDestaqueExtensao" />
                        <div class="colunaEsquerda">
                            <!- CONTEUDO -->
                            <div id="cabecalhoEditor" class="cartao">
                                <div class="agruparCampos">
                                    <div class="campoDeTexto">
                                        <input id="tituloPost" title="Título da Postagem" value="<%if(post != null){out.print(post.getTituloPost());}%>" type="text" name="tituloPost" maxlength="150" autocomplete="off"/>
                                        <label for="tituloPost">Título</label>
                                        <div></div>
                                    </div>
                                        <div class="botaoPadrao publicar">
                                            <% if(post != null && String.valueOf(post.getPublicado()).equals("S")){%>
                                                <button id="botaoRascunho" type="button" value="N"><% if(post != null){%>Reverter para rascunho<%}else{%>Salvar como rascunho<%}%></button>
                                            <%}else{%>
                                                <button id="botaoRascunho" type="button" value="N">Salvar como rascunho</button>
                                            <%}%>
                                            <button id="botaoPublicar" type="button" value="S"><% if(post != null && String.valueOf(post.getPublicado()).equals("N")){%>Atualizar e Publicar<%}else{%>Publicar<%}%></button>
                                        </div>
                                </div>
                                
                            </div>
                            <div id="editor" class="cartao">
                                <textarea id="editorDeTexto" name="editorDeTexto"><%
                                    if(post != null){
                                        out.print(post.getConteudoPost());
                                    }
                                %></textarea>  
                            </div>
                            
                        </div>
                        <div class="colunaDireita">
                            
                            <div class="cartao" id="configuracoesDaPostagem">
                                <h2>Configurações da Postagem</h2>
                                <br />
                                <a href="javascript:void(0)" class="mostrarOpcao semBorda"><i class="fa fa-tags"></i>Categorias</a>
                                <div class="opcao opcaoOculta">
                                    <div class="caixaDeTexto alturaAjustavel">
                                        <textarea id="tagsPost" name="tagsPost" maxlength="254"><%
                                                if(post != null){
                                                    for(Tags tag : post.getTagsDoPost()){
                                                        out.print(tag.getIdTag()+", ");
                                                    }
                                                }
                                            %></textarea>
                                        <label for="tagsPost">Categorias separadas por vírgula</label>
                                        <div></div>
                                    </div>
                                </div>
                                
                                <a href="javascript:void(0)" class="mostrarOpcao"><i class="fa fa-file-text-o"></i>Descrição da Postagem</a>
                                <div class="opcao opcaoOculta">
                                    <div class="caixaDeTexto alturaAjustavel">
                                        <textarea id="sumarioPost" name="sumarioPost" maxlength="254" <% if(post != null && !post.getSumarioPost().isEmpty()){ out.print("class=\"preenchida\"");} %>><%
                                            if(post != null){
                                                out.print(post.getSumarioPost());
                                            }
                                        %></textarea>
                                        <label for="sumarioPost">Breve descrição da postagem</label>
                                        <div></div>
                                    </div>
                                </div>
                                <% if(post == null){ %>
                                <a href="javascript:void(0)" class="mostrarOpcao"><i class="fa fa-link"></i>Link Permanente</a>
                                <div class="opcao opcaoOculta">
                                    <div>
                                        <div class="botaoOnOffContainer">
                                            <input type="checkbox" name="linkPermanentePersonalizado" id="linkPermanentePersonalizado" value="true" class="botaoOnOffPadrao"/>
                                            <label class="botaoOnOff" for="linkPermanentePersonalizado">Usar link permanente personalizado<span class="contornoBotaoOnOff"></span></label>
                                        </div>
                                        <div class="campoDeTexto alturaAjustavel">
                                            <input id="linkPermanente" type="text" <% if(post != null && !post.getLinkPermanente().isEmpty()){ out.print("class=\"preenchida desabilitado\"");}else{out.print("class=\"desabilitado\"");} %> value="<%if(post != null){out.print(post.getLinkPermanente());}%>" name="linkPermanente" maxlength="150" autocomplete="off"/>
                                            <label for="linkPermanente">Link permanente da postagem</label>
                                            <div></div>
                                        </div>
                                    </div>
                                </div>
                                <%}%>
                                <a href="javascript:void(0)" class="mostrarOpcao"><i class="fa fa-file-image-o"></i>Imagem destacada</a>
                                <div class="opcao opcaoOculta">
                                    <div>
                                        <div id="miniaturaImagemDestaque">
                                            <% if(post != null ){
                                                    if(post.getImagemMiniatura().isEmpty()){
                                                    %>
                                                        <img id="imagemDestaque" class="semImagem" src="">
                                            <%}else{%>
                                                <img id="imagemDestaque" src="${pageContext.request.contextPath}/${caminhoImagem}${post.getImagemMiniatura()}">
                                            <%}
                                              }else{ %>
                                                <img id="imagemDestaque" class="semImagem" src="">
                                            <% } %>
                                        </div>
                                        <div class="botaoPadraoFileInput botaoPadrao">
                                            <% if(post != null && post.getImagemMiniatura().isEmpty()){ %>
                                                <input id="botaoImagemDestaque" type="file" name="imagemDestaque" accept=".jpg,.jpeg,.png"></input>
                                                <label for="botaoImagemDestaque">Selecionar imagem</label>
                                                <input id="removerImagemDestaque" type="button" value="Remover Imagem" disabled></input>
                                            <%}else{%>
                                                <input type="hidden" id="removerImgDestaqueAnterior" name="removerImgDestaqueAnterior"></input> 
                                                <input type="hidden" id="imagemDestaqueAnterior" name="imagemDestaqueAnterior" value="${post.getImagemMiniatura()}"></input>
                                                <input id="botaoImagemDestaque" type="file" name="imagemDestaque"  accept=".jpg,.jpeg,.png"></input>
                                                <label for="botaoImagemDestaque">Selecionar imagem</label>
                                                <input id="removerImagemDestaque" type="button" value="Remover Imagem" ></input>
                                            <%}%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="quebrarFloat"></div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
