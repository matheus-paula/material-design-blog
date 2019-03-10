<%-- 
    Document   : painel comentarios
    Created on : 15/09/2018, 22:38:52
    Author     : mathe
--%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="urlBase" value="${pageContext.request.contextPath}" />

<% 
    int paginaAtual = (int) request.getAttribute("paginaAtual"),
        totalPaginas = (int) request.getAttribute("paginas"),
        totalComentarios = (int) request.getAttribute("totalComentarios");  
%>

<!DOCTYPE html>
<html>
    <head>
        <title>${mapaOpcoes.get("opc_tituloSite")[1]} | Meu Blog - Comentários</title>
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
        <script src="${urlBase}/js/scripts/painelComentarios.js" type="text/javascript"></script>
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
                                <jsp:param name="aba" value="comentarios"/>
                            </jsp:include>
                        </nav>
                    </div>
                    <div class="colunaDireita">
                        <div class="cartao">
                            <div id="abaPostagens">
                                <div>
                                    <div class="botoesTopo">
                                        <div>
                                            <c:choose>
                                                <c:when test="${not empty param.itens}"><h3>Comentarios (${comentarios.size()} de ${totalComentarios})</h3></c:when>
                                                <c:otherwise><h3>Comentarios (${totalComentarios})</h3></c:otherwise>
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
                                                <button id="proximaPagina" class="dropdownSetas direita" <% if(paginaAtual == totalPaginas || totalPaginas == 1){ out.print("disabled");} %> type="button">
                                                    <i class="fa fa-chevron-right"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    <table id="listaPosts" class="tabelaPadrao">
                                        <tbody>
                                            <c:forEach var="comentario" items="${comentarios}">
                                                <tr>
                                                    <td>
                                                        <div>"${comentario.comentario}" em  <a target="_blank" href="../post/${comentario.posts.linkPermanente}#comentarios">${comentario.posts.tituloPost}</a></div>
                                                        <c:if test="${comentario.comentarioPai ne 0}">
                                                            <c:forEach var="c" items="${comentarios}">
                                                                <c:if test="${c.id eq comentario.comentarioPai}">
                                                                    <div class="rotuloResposta">Em resposta a: <a href="../perfil/${c.usuarios.nomeUsuario}#comentarios" target="_blank">${c.usuarios.nome} ${c.usuarios.sobrenome}</a></div>
                                                                </c:if>
                                                            </c:forEach>
                                                        </c:if> 
                                                        <div class="listaOpcoesComentario" data-post-id="${comentario.id}">
                                                            <c:if test="${(sessionScope.nomeUsuario eq comentario.usuarios.nomeUsuario) or ((sessionScope.privilegios.toString() eq 'A') and (comentario.usuarios.privilegios.toString() ne 'A') and (comentario.usuarios.privilegios.toString() ne 'S') ) or sessionScope.privilegios eq 'S'}">
                                                                <a href="javascript:void(0)" class="excluirComentario">Excluir</a>
                                                                <span>|</span>
                                                            </c:if>
                                                            <a href="../post/${comentario.posts.linkPermanente}#comentarios" class="visualizarPost" target="_blank">Visualizar</a>                                                            
                                                        </div>
                                                    </td>
                                                    <td class="autorComentario"><a target="_blank" href="../perfil/${comentario.usuarios.nomeUsuario}">${comentario.usuarios.nome} ${comentario.usuarios.sobrenome}</a></td>
                                                    <td>
                                                        <div class="listaPostData">
                                                            <fmt:formatDate pattern="dd/MM/yyyy" value="${comentario.dataComentario}" />
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
