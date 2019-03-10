<%-- 
    Document   : painel postagens
    Created on : 15/09/2018, 22:38:52
    Author     : mathe
--%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="models.Posts"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="urlBase" value="${pageContext.request.contextPath}" />

<% 
    List<Posts> posts = (List<Posts>) request.getAttribute("posts");
    int paginaAtual = (int) request.getAttribute("paginaAtual"),
        totalPaginas = (int) request.getAttribute("paginas"),
        totalPosts = (int) request.getAttribute("totalPosts"),
        publicadosContador = 0,
        rascunhosContador = 0;

    for(int i = 0;i < posts.size();i++){
        if(posts.get(i).getPublicado() == 'S'){
            publicadosContador++;
        }else if(posts.get(i).getPublicado() == 'N'){
            rascunhosContador++;
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>${mapaOpcoes.get("opc_tituloSite")[1]} | Meu Blog - Postagens</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="description" content="${mapaOpcoes.get("opc_descricaoSite")[1]}"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link href="${urlBase}/css/default.css" rel="stylesheet">
        <link href="${urlBase}/css/painel.css" rel="stylesheet">
        <link href="${urlBase}/fontes/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500" rel="stylesheet">
        <script src="${urlBase}/js/plugins/jquery-3.3.1.min.js" type="text/javascript"></script>
        <script src="${urlBase}/js/scripts/scripts.js" type="text/javascript"></script>
        <script src="${urlBase}/js/scripts/painel.js" type="text/javascript"></script>
        <script src="${urlBase}/js/scripts/painelPostagens.js" type="text/javascript"></script>
    </head>
    <body>
        <div class="containerPrincipal">
            <div id="menuDeNavegacao" class="barraLateral">
                <jsp:include page="menu.jsp"/>
            </div>
            <div class="conteudo">
                <!-- CABECALHO -->
                <div class="cabecalhoPainel">
                    <div class="containerCabecalhoPainel">
                        <div class="botaoPadrao botaoDeslogarCabecalho branco">
                            <a title="Gerenciar Conta" href="../gerenciar-conta/${sessionScope.nomeUsuario}">Conta</a>
                            <a title="Gerenciar Perfil" href="../alterar-perfil/${sessionScope.nomeUsuario}">Perfil</a>
                            <a title="Deslogar-se" class="deslogar" href="../login?acao=deslogar">Sair</a>
                        </div>
                    </div>
                    <button type="button" class="mostrarSideNav">
                        <i class="fa fa-bars"></i>
                    </button>
                </div>
                <div class="containerConteudo">
                    <div class="colunaEsquerda">
                        <!- CONTEUDO -->
                        <jsp:include page="areaUsuarioPainel.jsp"/>
                        <h2 style='text-align: center'>${mapaOpcoes.get("opc_tituloSite")[1]}</h2>
                        <div id="btnNovaPostage" class="botaoPadrao">
                            <a href="../" target="_blank">Visualizar Blog</a>
                        </div>
                        <div class="cabecalhoEscondido">
                            <div class="containerCabecalhoPainel">
                                <div class="botaoPadrao botaoDeslogarCabecalho branco">
                                    <a title="Gerenciar Conta" href="../gerenciar-conta/${sessionScope.nomeUsuario}">Conta</a>
                                    <a title="Gerenciar Perfil" href="../alterar-perfil/${sessionScope.nomeUsuario}">Perfil</a>
                                    <a title="Deslogar-se" class="deslogar" href="../login?acao=deslogar">Sair</a>
                                </div>
                            </div>
                            <button type="button" class="mostrarSideNav">
                                <i class="fa fa-bars"></i>
                            </button>
                            <h2>${mapaOpcoes.get("opc_tituloSite")[1]}</h2>
                        </div>
                        <nav id="menuPainel">
                            <jsp:include page="navegacaoPainel.jsp">
                                <jsp:param name="aba" value="postagens"/>
                            </jsp:include>
                        </nav>
                    </div>
                    <div class="colunaDireita">
                        <div class="cartao">
                            <div id="abaPostagens">
                                <div class="botoesTopo">
                                    <div id="btnNovaPostage" class="botaoPadrao alinharEsquerda">
                                        <a href="../postagem/nova">Nova Postagem</a>
                                    </div>
                                    <div>
                                        <div id="listaTagsDropdown" class="dropdownPadrao">
                                            <input id="listaTags" type="hidden" value="">
                                            <div class="dropdownPadraoLegenda">
                                                <c:choose>
                                                    <c:when test="${empty tagAtual}">Todos</c:when>
                                                    <c:otherwise>${tagAtual}</c:otherwise>
                                                </c:choose>
                                            </div>
                                            <ul id="listaDeTags">
                                                <li value="" >Todos</li>
                                                <c:forEach var="tag" items="${tags}">
                                                    <c:choose>
                                                        <c:when test="${tag.idTag eq tagAtual}">
                                                            <li value="${tag.idTag}" class="selecionado">${tag.nomeTag}</li>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <li value="${tag.idTag}">${tag.nomeTag}</li>
                                                        </c:otherwise>
                                                   </c:choose>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div >
                                    <div class="botoesTopo">
                                        <div>
                                            <c:choose>
                                                <c:when test="${param.tipo.toString() eq 'publicadas'}">
                                                    <h3>Postagens Publicadas (${posts.size()})</h3>
                                                </c:when>
                                                <c:when test="${param.tipo.toString() eq 'rascunhos'}">
                                                    <h3>Postagens Salvas como Rascunho (${posts.size()})</h3>
                                                </c:when>    
                                                <c:otherwise>
                                                    <h3>Todas as Postagens (${posts.size()}/${totalPosts})</h3>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div>
                                            <div id="navegacaoPorPaginas" class="dropdownNavegacao alinharDireita">
                                                <button id="paginaAnterior" class="dropdownSetas esquerda" type="button" <% if(paginaAtual == 1){ out.print("disabled");} %>>
                                                    <i class="fa fa-chevron-left"></i>
                                                </button>
                                                <div id="seasonsDropdown" class="dropdown">
                                                    <button type="button" value="pagina<%=paginaAtual%>" id="dropdownPaginas">Página <%=paginaAtual%></button>
                                                    <div>
                                                        <ul id="listaDePaginas">
                                                            <c:forEach var="i" begin="1" end="<%=totalPaginas%>" step="1">
                                                                <c:choose>
                                                                    <c:when test="${i eq paginaAtual}">
                                                                        <li id="pagina${i}" class="ativo">Página ${i}</li>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <li id="pagina${i}">Página ${i}</li>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:forEach>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <button id="proximaPagina" class="dropdownSetas direita"  <% if(paginaAtual == totalPaginas || totalPaginas == 1){ out.print("disabled");} %> type="button">
                                                    <i class="fa fa-chevron-right"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    <table id="listaPosts" class="tabelaPadrao">
                                        <tbody>
                                            <c:forEach var="post" items="${posts}">
                                                <tr>
                                                    <td>
                                                        <div class="listaNomePost">${post.tituloPost}</div>
                                                        <div class="listaPostOpcoes" data-post-id="${post.id}">
                                                            <c:if test="${sessionScope.nomeUsuario eq post.usuarios.getNomeUsuario() or sessionScope.privilegios eq 'A' or sessionScope.privilegios eq 'S'}">
                                                                <c:choose>
                                                                    <c:when test="${post.publicado.toString() eq 'N'}">
                                                                        <a href="javascript:void(0)" class="publicarPost">Publicar</a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a href="javascript:void(0)" class="reverterParaRascunho">Reveter para Rascunho</a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <c:if test="${post.listaDeComentarios.size() le 0}">       
                                                                    <span>|</span>
                                                                    <a href="javascript:void(0)" class="editarPost">Editar</a>
                                                                </c:if>
                                                                <span>|</span>
                                                                <a href="javascript:void(0)" class="excluirPost">Excluir</a>
                                                                <span>|</span>
                                                            </c:if>
                                                            <a href="../post/${post.linkPermanente}" class="visualizarPost" target="_blank">Visualizar</a>                                                            
                                                        </div>
                                                    </td>
                                                    <c:choose>
                                                        <c:when test="${post.publicado.toString() eq 'N'}">
                                                            <td><span class="rotuloRascunho">Rascunho</span></td>
                                                        </c:when>
                                                         <c:otherwise>
                                                            <td style="padding:0"></td>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <td>
                                                        <div class="listaPostAutor">
                                                            <a href="../autor/${post.usuarios.nomeUsuario}" target="_blank">${post.usuarios.nome}</a>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="listaPostComentarios">${post.listaDeComentarios.size()}</div>
                                                    </td>
                                                    <td>
                                                        <div class="listaPostViews">${post.visualizacoes}</div>
                                                    </td>
                                                    <td>
                                                        <div class="listaPostData">
                                                            <fmt:formatDate pattern = "dd/MM/yyyy" value = "${post.dataCriacaoPost}" />
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
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
