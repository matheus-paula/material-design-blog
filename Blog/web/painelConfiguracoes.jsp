<%-- 
    Document   : painel
    Created on : 15/09/2018, 22:38:52
    Author     : mathe
--%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="urlBase" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
    <head>
        <title>${mapaOpcoes.get("opc_tituloSite")[1]} | Meu Blog - Configurações</title>
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
        <script src="${urlBase}/js/scripts/painelConfiguracoes.js" type="text/javascript"></script>
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
                                <jsp:param name="aba" value="configuracoes"/>
                            </jsp:include>
                        </nav>
                    </div>
                    <div class="colunaDireita">
                        <div class="cartao">
                            <h2><i class="fa fa-cog"></i>&nbsp;Configurações</h2>
                            <br />
                            <form id="configuracoesForm">
                                <div class="campoEntradaOpcoes">
                                    <input type="text" id="opc_tituloSite" value="${mapaOpcoes.get("opc_tituloSite")[1]}" name="opc_tituloSite" data-titulo-dialogo="${mapaOpcoes.get("opc_tituloSite")[2]}" data-label-dialogo="${mapaOpcoes.get("opc_tituloSite")[3]}" class="entradaTextoDialogo" readonly></input>
                                    <label for="opc_tituloSite">${mapaOpcoes.get("opc_tituloSite")[2]}</label>
                                </div>
                                <div class="campoEntradaOpcoes">
                                    <input type="text" id="opc_descricaoSite" name="opc_descricaoSite" value="${mapaOpcoes.get("opc_descricaoSite")[1]}" data-titulo-dialogo="${mapaOpcoes.get("opc_descricaoSite")[2]}" data-label-dialogo="${mapaOpcoes.get("opc_descricaoSite")[3]}" class="entradaTextoDialogo" readonly></input>
                                    <label for="opc_descricaoSite">${mapaOpcoes.get("opc_descricaoSite")[2]}</label>
                                </div>
                                <div class="campoEntradaOpcoes">
                                    <input type="text" id="opc_sobreSite" name="opc_sobreSite" value="${mapaOpcoes.get("opc_sobreSite")[1]}" data-titulo-dialogo="${mapaOpcoes.get("opc_sobreSite")[2]}" data-label-dialogo="${mapaOpcoes.get("opc_sobreSite")[3]}" class="entradaTextoDialogo" readonly></input>
                                    <label for="opc_sobreSite">${mapaOpcoes.get("opc_sobreSite")[2]}</label>
                                </div>
                                <div class="campoEntradaOpcoes">
                                    <input type="text" id="opc_creditosRodape" name="opc_creditosRodape" value="${mapaOpcoes.get("opc_creditosRodape")[1]}" data-titulo-dialogo="${mapaOpcoes.get("opc_creditosRodape")[2]}" data-label-dialogo="${mapaOpcoes.get("opc_creditosRodape")[3]}" class="entradaTextoDialogo" readonly></input>
                                    <label for="opc_creditosRodape">${mapaOpcoes.get("opc_creditosRodape")[2]}</label>
                                </div>
                                <div class="campoEntradaOpcoes">
                                    <input type="text" id="opc_palavrasBloqueadas" name="opc_palavrasBloqueadas" value="${mapaOpcoes.get("opc_palavrasBloqueadas")[1]}" data-titulo-dialogo="${mapaOpcoes.get("opc_palavrasBloqueadas")[2]}" data-label-dialogo="${mapaOpcoes.get("opc_palavrasBloqueadas")[3]}" class="entradaTextoDialogo" readonly></input>
                                    <label for="opc_palavrasBloqueadas">${mapaOpcoes.get("opc_palavrasBloqueadas")[2]}</label>
                                </div>
                            </form>
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
