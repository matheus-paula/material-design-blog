<%-- 
    Document   : sobre
    Created on : 02/10/2018, 07:21:10
    Author     : mathe
--%>

<%@page import="java.util.Map"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="urlBase" value="${pageContext.request.contextPath}" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- SOBRE -->
<!DOCTYPE html>
<html>
    <head>
        <title>${mapaOpcoes.get("opc_tituloSite")[1]} | Sobre</title>
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
                            <h2>Sobre</h2>
                            <br />
                            <p>${mapaOpcoes.get("opc_sobreSite")[1]}</p>
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
