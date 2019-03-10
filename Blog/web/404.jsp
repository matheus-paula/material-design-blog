<%-- 
    Document   : 404
    Created on : 02/10/2018, 08:39:49
    Author     : mathe
--%>

<%@page import="java.util.Map"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="urlBase" value="${pageContext.request.contextPath}" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>${mapaOpcoes.get("opc_tituloSite")[1]} | Erro 404 - Página não existe</title>
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
                <jsp:include page="blogCabecalho.jsp"/> 
                <div class="containerConteudo">
                    <div class="colunaEsquerda">
                        <!- CONTEUDO -->
                        <div class="cartao">
                            <h2>Erro 404</h2>
                            <br />
                            <div align="center">
                                <h4>O endereço abaixo <b>não existe</b> ou foi <b>removido</b> de nosso site:</h4>
                                <h2>
                                    <b>
                                        <script>document.write(window.location.href);</script>
                                    </b>
                                </h2>
                                <br />
                                <div>
                                    <h3>A URL que você está tentando acessar pode ter sido removida pelo autor do site ou você foi direcionado para um link quebrado!</h3>
                                </div>
                            </div>
                        </div>
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
