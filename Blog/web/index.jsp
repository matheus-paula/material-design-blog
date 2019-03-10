<%-- 
    Document   : inicio
    Created on : 31/08/2018, 19:08:00
    Author     : mathe
--%>

<%@page import="java.util.Map"%>
<%@page import="models.Opcoes"%>
<%@page import="models.Tags"%>
<%@page import="java.util.List"%>
<%@page import="models.Posts"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="urlBase" value="${pageContext.request.contextPath}" />
<c:set var="caminhoImagem" value="midia/imagemDestaque/" />

<% 
    List<Posts> posts = (List<Posts>) request.getAttribute("posts");
    String raizDoSite = request.getContextPath();
    Map<String,String[]> mapaOpcoes = (Map<String,String[]>) request.getAttribute("mapaOpcoes");
    int paginas = 1;
    int paginaAtual = 1;
    String itensPorPagina = "";
    if(request.getAttribute("paginas") != null){
        paginas = (int) request.getAttribute("paginas");
    }
    if(request.getAttribute("itensPorPagina") != null){
        if((int) request.getAttribute("itensPorPagina") != 10){
            itensPorPagina = "&itens="+request.getAttribute("itensPorPagina").toString();
        }
    }
    if(request.getAttribute("paginaAtual") != null){
        paginaAtual = (int) request.getAttribute("paginaAtual");
    }
%>
<!DOCTYPE html>
<!-- PÁGINA INCIAL -->
<html>
    <head>
        <title>${mapaOpcoes.get("opc_tituloSite")[1]} | Página Inicial</title>
        <meta name="description" content="${mapaOpcoes.get("opc_descricaoSite")[1]}"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link href="${urlBase}/css/default.css" rel="stylesheet">
        <link href="${urlBase}/fontes/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500" rel="stylesheet">
        <script src="${urlBase}/js/plugins/jquery-3.3.1.min.js" type="text/javascript"></script>
        <script src="${urlBase}/js/scripts/scripts.js" type="text/javascript"></script>
    </head>
    <body>
        <div class="containerPrincipal">
            <div id="menuDeNavegacao" class="barraLateral">
                <jsp:include page="menu.jsp"/>
            </div>
            <div class="conteudo">
                <!-- CABECALHO -->
                <jsp:include page="blogCabecalho.jsp">
                    <jsp:param value="${opcoes}" name="opcoes"/>
                </jsp:include>
                <div class="containerConteudo">
                    <div class="colunaEsquerda">
                        <!- CONTEUDO -->
                        <% 
                           if(posts != null){
                                for(Posts post : posts){ %>
                                    <article class="cartao indice">
                                        <% if(!post.getImagemMiniatura().isEmpty()){ %>
                                            <div class="imagemPost" style="height:200px;background:url('${caminhoImagem}<%=post.getImagemMiniatura() %>') no-repeat center;"></div>                     
                                        <% } %>
                                        <div class="cartaoIndiceConteudo">
                                            <a href="<%="post/"+post.getLinkPermanente()%>"><h2><%=post.getTituloPost() %></a></h2>
                                            <h5>
                                                <i class="fa fa-calendar"></i>
                                                <fmt:formatDate pattern = "dd/MM/yyyy à&#115; hh:mm" value = "<%=post.getDataCriacaoPost()%>" />
                                            </h5>
                                            <p><%=post.getSumarioPost() %></p>
                                            <p><span>Publicado por: </span><a href="<%="perfil/"+post.getUsuarios().getNomeUsuario() %>" class="linkAutor"><%=post.getUsuarios().getNome() %></a></p>
                                            <p>
                                                <ul class="tags">
                                                    <% 
                                                        for(Tags tag : post.getTagsDoPost()){
                                                            out.print("<li><a title=\"Categoria "+tag.getNomeTag()+"\" href=\"categoria/"+tag.getIdTag()+"\"><i class=\"fa fa-tag\"></i><span>"+tag.getNomeTag()+"</span></a></li>");
                                                        }
                                                    %>
                                                </ul>
                                            </p> 
                                        </div>
                                        <div class="cartaoIndiceBotoes">
                                            <% 
                                                int numComentarios = post.getListaDeComentarios().size();
                                                if(numComentarios > 1){
                                                    out.print("<p><a title=\""+numComentarios+" comentários\" href=\"post/"+post.getLinkPermanente()+"#comentarios\" class=\"linkComentarios\">"+numComentarios+" Comentários</a></p>");
                                                }else if(numComentarios == 1){
                                                    out.print("<p><a title=\"Um comentário\" href=\"post/"+post.getLinkPermanente()+"#comentarios\" class=\"linkComentarios\">Um Comentário</a></p>");
                                                }else{
                                                    out.print("<p><a title=\"Nenhum comentário\" href=\"post/"+post.getLinkPermanente()+"#comentarios\" class=\"linkComentarios\">Nenhum Comentário</a></p>");
                                                }
                                            %>
                                            <div class="botaoPadrao alinharDireita">
                                                <a href="<%="post/"+post.getLinkPermanente()%>">Continue Lendo</a>
                                            </div>
                                        </div>
                                    </article>
                            <%  }
                            } %>
                        <jsp:include page="paginacao.jsp"/>
                    </div>
                    <div class="colunaDireita">
                        <div class="cartao">
                            <h3>Posts Populares</h3>
                            <jsp:include page="postsPopulares.jsp"/> 
                        </div>
                        <div class="cartao">
                            <h3>Comentários Recentes</h3>
                            <jsp:include page="comentariosRecentes.jsp"/> 
                        </div>
                    </div>
                    <div class="quebrarFloat"></div>
                </div>
                <div class="rodape">
                    <h3>${mapaOpcoes.get("opc_creditosRodape")[1]} | ${mapaOpcoes.get("opc_tituloSite")[1]}</h3>
                </div>                        
            </div>
        </div>
    </body>
</html>

