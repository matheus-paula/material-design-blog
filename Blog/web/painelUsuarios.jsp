<%-- 
    Document   : painel usuarios
    Created on : 15/09/2018, 22:38:52
    Author     : mathe
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="urlBase" value="${pageContext.request.contextPath}" />

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
        <script src="${urlBase}/js/scripts/painelUsuarios.js" type="text/javascript"></script>
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
                                <jsp:param name="aba" value="usuarios"/>
                            </jsp:include>
                        </nav>
                    </div>
                    <div class="colunaDireita">
                        <div class="cartao">
                            <div class="botoesTopo">
                                <div id="btnNovaPostage" class="botaoPadrao alinharEsquerda">
                                    <a href="../login?acao=registrar">Novo Usuario</a>
                                </div>
                            </div>
                            <table id="listaUsuarios" class="tabelaPadrao">
                                <tbody>
                                    <c:forEach var="usuario" items="${usuarios}">
                                        <tr>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${empty usuario.getFoto()}">
                                                        <img class="avatarPerfil" src="../graficos/semfoto.png"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img class="avatarPerfil" src="../${usuario.getFoto()}"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div><p>${usuario.getNome()} ${usuario.getSobrenome()}</p></div>
                                                <p>
                                                    <c:choose>
                                                        <c:when test="${usuario.getPrivilegios().toString() eq 'A'}">Administrador</c:when>
                                                        <c:when test="${usuario.getPrivilegios().toString() eq 'S'}">Super Administrador</c:when>
                                                        <c:when test="${usuario.getPrivilegios().toString() eq 'E'}">Editor</c:when>                                                        
                                                    </c:choose>
                                                </p>
                                                <div><p>${usuario.getEmail()}</p></div>
                                            </td>
                                            <td>
                                                <c:if test="${(sessionScope.privilegios eq 'A' or sessionScope.privilegios eq 'S') && !(usuario.privilegios.toString() eq 'A' && privilegios eq 'A')}">
                                                    <form id="usuariosExcluirUID${usuario.getId()}" class="formularioExcluirUsuario">
                                                        <div class="botaoPadrao alinharDireita excluirUsuario vermelho">
                                                            <a data-id-usuario="${usuario.getId()}" href="javascript:void(0)">Remover Usuário</a>
                                                        </div>
                                                    </form>
                                                </c:if>
                                                <c:if test="${sessionScope.privilegios eq 'E'}">
                                                    <div class="botaoPadrao alinharDireita vermelho">
                                                        <a target="_blank" href="../perfil/${usuario.getNomeUsuario()}">Ver Detalhes</a>
                                                    </div>
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:if test="${(sessionScope.privilegios eq 'A' or sessionScope.privilegios eq 'S') && (usuario.nomeUsuario ne sessionScope.nomeUsuario) && !(usuario.privilegios.toString() eq 'A' && privilegios eq 'A')}">
                                                    <form id="privilegiosUID${usuario.getId()}" data-id-usuario="${usuario.getId()}" class="formularioPrivilegios">
                                                        <div id="listaPrivilegios${usuario.getId()}" class="dropdownPadrao">
                                                            <input id="listaPrivilegios${usuario.getId()}" name="privilegio" type="hidden" value="A"></input>
                                                            <div class="dropdownPadraoLegenda">
                                                                <c:choose>
                                                                    <c:when test="${usuario.getPrivilegios().toString() eq 'A'}">Administrador</c:when>
                                                                    <c:otherwise>Editor</c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <ul id="listaDeTags${usuario.getId()}">
                                                                <li value="A">Administrador</li>
                                                                <li value="E">Editor</li>
                                                            </ul>
                                                        </div>
                                                    </form>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
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
