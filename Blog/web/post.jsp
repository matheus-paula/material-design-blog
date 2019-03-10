<%-- 
    Document   : post
    Created on : 01/09/2018, 09:21:42
    Author     : matheus
--%>

<%@page import="java.util.Map"%>
<%@page import="models.Comentarios"%>
<%@page import="models.Usuarios"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="models.Tags"%>
<%@page import="models.Posts"%>
<c:set var="urlBase" value="${pageContext.request.contextPath}" />
<c:set var="caminhoImagem" value="midia/imagemDestaque/" />

<% 
    Posts post;
    String fotoAutor = request.getContextPath()+"/graficos/semfoto.png";;
    String nomeUsuario = "", privilegios = "";
    
    if(request.getAttribute("post") != null){
        post = (Posts) request.getAttribute("post");
        if(post.getUsuarios().getFoto() != null){
            fotoAutor = post.getUsuarios().getFoto();
        }
    }else{
        post = null;
    }
    if(session.getAttribute("nomeUsuario") != null){
        nomeUsuario = session.getAttribute("nomeUsuario").toString();
        try{
            privilegios = session.getAttribute("privilegios").toString();
        }catch(Exception e){ }
    }
    
%>
<!-- POST -->
<!DOCTYPE html>
<html>
    <head>
        <% if(post != null){ %>
            <title>${mapaOpcoes.get("opc_tituloSite")[1]}<%=" | "+post.getTituloPost() %></title>
        <% } else{ %>
            <title>${mapaOpcoes.get("opc_tituloSite")[1]} | Post não encontrado</title>
        <% } %>
        <meta name="description" content="${mapaOpcoes.get("opc_descricaoSite")[1]}"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link href="${urlBase}/css/default.css" rel="stylesheet">
        <link href="${urlBase}/css/post.css" rel="stylesheet">
        <link href="${urlBase}/fontes/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500" rel="stylesheet">
        <script src="${urlBase}/js/plugins/jquery-3.3.1.min.js" type="text/javascript"></script>
        <script src="${urlBase}/js/scripts/scripts.js" type="text/javascript"></script>
        <script src="${urlBase}/js/scripts/post.js" type="text/javascript"></script>
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
                        <!- CONTEUDO -->
                        <% if(post != null){ %>
                            <div class="cartao indice">
                                <% if(!post.getImagemMiniatura().isEmpty()){ %>
                                    <div class="imagemPost" style="height:200px;background:url('../${caminhoImagem}<% out.print(post.getImagemMiniatura()); %>') no-repeat center;"></div>                     
                                <% } %>
                                <div class="cartaoIndiceConteudo">
                                    <h2><%=post.getTituloPost() %></h2>
                                    <h5>
                                        <i class="fa fa-calendar"></i>
                                        <fmt:formatDate pattern = "dd/MM/yyyy à&#115; hh:mm" value = "${post.dataCriacaoPost}" />
                                    </h5>
                                    <h3><%=post.getSumarioPost() %></h3>
                                    <article id="corpoPostagem"><%=post.getConteudoPost() %></article>
                                    <p><span>Publicado por: </span><a href="../perfil/<%=post.getUsuarios().getNomeUsuario() %>" class="linkAutor"><%=post.getUsuarios().getNome() %></a></p>
                                    <p>
                                        <ul class="tags">
                                            <% 
                                                for(Tags tag : post.getTagsDoPost()){
                                                    out.print("<li><a href=\"../categoria/"+tag.getIdTag()+"\"><i class=\"fa fa-tag\"></i><span>"+tag.getNomeTag()+"</span></a></li>");
                                                }
                                            %>
                                        </ul>
                                    </p> 
                                </div>
                                <table id="descricaoAutor">
                                    <tbody>
                                        <tr>
                                            <td rowspan="3" valign="top">
                                                <div>
                                                    <a href="../perfil/<%=post.getUsuarios().getNomeUsuario() %>" target="_blank">
                                                        <div rel="author" class="fotoAutor" style="background:url(${pageContext.request.contextPath}/<%=fotoAutor%>)"></div>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <h2 class="nomeAutor">
                                                    <a href="../perfil/<%=post.getUsuarios().getNomeUsuario() %>" target="_blank"><%=post.getUsuarios().getNome() %></a>
                                                </h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <div class="bioAutor"><%=post.getUsuarios().getBio() %></div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="cartao" id="comentarios">
                                <% 
                                    int numComentarios = post.getListaDeComentarios().size();
                                    if(numComentarios > 1){
                                        out.print("<h3>"+numComentarios+" Comentários</h3>");
                                    }else if(numComentarios == 1){
                                        out.print("<h3>Um Comentário</h3>");
                                    }else{
                                        out.print("<h3>Nenhum Comentário</h3>");
                                    }
                                %>
                                <ul class="listaComentarios">    
                                 <% for(Comentarios comentario : post.getListaDeComentarios()){
                                        if(String.valueOf(comentario.getTipo()).equals("C")){
                                        %>
                                        <li data-id-comentario="<%=comentario.getId()%>">
                                            <div class="comentarioFoto">
                                                <a href="../perfil/<%=comentario.getUsuarios().getNomeUsuario() %>" <% if(comentario.getUsuarios().getPrivilegios() != 'U'){out.print("class=\"editor\" title=\"Editor do site\"");} %>>
                                                    <% 
                                                        if(comentario.getUsuarios().getFoto() != null){
                                                            out.print("<img src=\"../"+comentario.getUsuarios().getFoto()+"\">");
                                                        }else{
                                                            out.print("<img src=\"../graficos/semfoto.png\">");
                                                        } 
                                                    %>
                                                </a>
                                            </div>
                                            <div class="corpoComentario">
                                                <div class="cabecalhoComentarioAutor">
                                                    <a href="../perfil/<%=comentario.getUsuarios().getNomeUsuario() %>" <% if(comentario.getUsuarios().getPrivilegios() != 'U'){out.print("class=\"editor\" title=\"Editor do site\"");} %>><%=comentario.getUsuarios().getNome()+" "+comentario.getUsuarios().getSobrenome()%></a>
                                                    <span class="dataComentario"><fmt:formatDate pattern = "dd/MM/yyyy à&#115; hh:mm" value = "<%=comentario.getDataComentario()%>" /></span>
                                                </div>    
                                                <div class="comentarioTexto"><%=comentario.getComentario()%></div>
                                                <div class="acoesComentario">
                                                    <div class="botaoNavegacao botaoPadrao vermelho alinharEsquerda">
                                                        <% if(privilegios.equals("S") || (privilegios.equals("A") && comentario.getUsuarios().getPrivilegios() != 'A' && comentario.getUsuarios().getPrivilegios() != 'S') || comentario.getUsuarios().getNomeUsuario().equals(nomeUsuario)){ %>
                                                            <a href="javascript:void(0)" id="removerComentario<%=comentario.getId()%>" class="removerComentario" data-id-comentario="<%=comentario.getId()%>">Excluir</a>
                                                        <% }%>
                                                        <a href="javascript:void(0)" data-comentario-pai="<%=comentario.getId()%>" class="responderComentario">Responder</a>
                                                    </div>
                                                </div>
                                                <div class="containerComentarioSecundario"></div>
                                                <div>
                                                    <ul class="respostasComentario">
                                                        <% for(Comentarios resposta : post.getListaDeComentarios()){
                                                                if(resposta.getComentarioPai() == comentario.getId() ){ %>
                                                                <li data-id-comentario="<%=resposta.getId()%>">
                                                                    <div class="comentarioFoto">
                                                                        <a href="../perfil/<%=resposta.getUsuarios().getNomeUsuario() %>" <% if(resposta.getUsuarios().getPrivilegios() != 'U'){out.print("class=\"editor\" title=\"Editor do site\"");} %>>
                                                                            <% 
                                                                                if(resposta.getUsuarios().getFoto() != null){
                                                                                    out.print("<img src=\"../"+resposta.getUsuarios().getFoto()+"\">");
                                                                                }else{
                                                                                    out.print("<img src=\"../graficos/semfoto.png\">");
                                                                                } 
                                                                            %>
                                                                        </a>
                                                                    </div>
                                                                    <div class="corpoComentario">
                                                                        <div class="cabecalhoComentarioAutor">
                                                                            <a href="../perfil/<%=resposta.getUsuarios().getNomeUsuario() %>" <% if(resposta.getUsuarios().getPrivilegios() != 'U'){out.print("class=\"editor\" title=\"Editor do site\"");} %>><%=resposta.getUsuarios().getNome()+" "+resposta.getUsuarios().getSobrenome()%></a>
                                                                            <span class="dataComentario"><fmt:formatDate pattern = "dd/MM/yyyy à&#115; hh:mm" value = "<%=resposta.getDataComentario() %>" /></span>
                                                                        </div>    
                                                                        <div class="comentarioTexto">
                                                                            <%=resposta.getComentario()%>
                                                                        </div>
                                                                        <div class="acoesComentario">
                                                                            <div class="botaoNavegacao botaoPadrao vermelho alinharEsquerda">
                                                                                <% if(privilegios.equals("S") || (privilegios.equals("A") && resposta.getUsuarios().getPrivilegios() != 'A' && resposta.getUsuarios().getPrivilegios() != 'S') || resposta.getUsuarios().getNomeUsuario().equals(nomeUsuario)){ %>
                                                                                    <a class="removerComentario" id="removerComentario<%=resposta.getId()%>" data-id-comentario="<%=resposta.getId()%>" href="javascript:void(0)">Excluir</a>
                                                                                <% }%>
                                                                                <a href="javascript:void(0)" data-comentario-pai="<%=comentario.getId()%>" class="responderComentario">Responder</a>
                                                                            </div>
                                                                        </div>
                                                                        <div class="containerComentarioSecundario"></div>
                                                                    </div>
                                                                </li>
                                                        <%} } %>
                                                    </ul>
                                                </div>  
                                            </div>
                                        </li>
                                    <% 
                                      }  
                                    }
                                %>
                                </ul>
                                <div style="display:none" id="containerRespostasPrincipal">
                                    <div id="formularioResposta" class="comentarioForm">
                                        <form method="post" action="">
                                            <input type="hidden" id="idPost" value="<%=post.getId() %>" name="idPost" />
                                            <jsp:include page="formularioResposta.jsp"/>
                                        </form>
                                        <div class="mensagemErroResposta"></div>
                                    </div>
                                </div>
                                <div id="containerComentariosPrincipal">
                                    <div id="formularioComentario" class="comentarioForm">
                                        <form method="post" action="">
                                            <input type="hidden" id="idPost" value="<%=post.getId() %>" name="idPost" />
                                            <jsp:include page="formularioComentario.jsp"/>
                                        </form>
                                        <div class="mensagemErroComentario"></div>
                                    </div>
                                </div>
                            </div>
                            
                        <% }else{ %>
                        
                        <div class="cartao">
                            <h2>Post não existe, ou não foi informado!</h2>
                        </div>
                        <% } %>
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
