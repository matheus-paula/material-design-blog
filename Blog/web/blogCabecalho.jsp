<%-- 
    Document   : cabecalho
    Created on : 03/09/2018, 21:53:04
    Author     : mathe
--%>
<%
    String uri = request.getRequestURI();
    String paginaAtual = uri.substring(uri.lastIndexOf("/")+1);
    String privilegios = "";
    if(session.getAttribute("nomeUsuario") != null){
        try{
            privilegios = session.getAttribute("privilegios").toString();
        }catch(Exception e){}
    }
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="cabecalho">
    <div class="containerCabecalho">
        <c:choose>
            <c:when test="${param.botaoEsquerdo eq 'voltar'}">
                <button class="botaoNavegacao" id="navegacaoVoltar">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" style="margin-top:2px;" viewBox="0 0 24 24">
                        <path d="M0 0h24v24H0z" fill="none"/><path style='fill:#fff' d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z"/>
                    </svg>
                </button>
            </c:when>
            <c:otherwise>
                <button class="botaoNavegacao" id="abrirNavegacao">
                    <i class="fa fa-bars"></i>
                </button>
            </c:otherwise>
        </c:choose>
        <h1>${mapaOpcoes.get("opc_tituloSite")[1]}</h1>
        <div class="areaUsuario">
            <c:if test="${not empty sessionScope.nomeUsuario}">
                <div id="abrirDetalhesUsuario" class="fotoPerfil">
                    <c:choose>
                        <c:when test="${empty sessionScope.fotoUsuario}">
                            <img src="${pageContext.request.contextPath}/graficos/semfoto.png"/>
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/${sessionScope.fotoUsuario}"/>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div id="detalhesUsuario" class="cartao">
                    <div>
                        <c:choose>
                            <c:when test="${empty sessionScope.fotoUsuario}">
                                <img id="detalhesUsuarioFoto" src="${pageContext.request.contextPath}/graficos/semfoto.png"/>
                            </c:when>
                            <c:otherwise>
                                <img id="detalhesUsuarioFoto" src="${pageContext.request.contextPath}/${sessionScope.fotoUsuario}"/>
                            </c:otherwise>
                        </c:choose>
                        <div id="detalhesUsuarioNome">${sessionScope.primeiroNomeUsuario} ${sessionScope.sobrenomeUsuario}</div>
                        <div id="detalhesUsuarioEmail">${sessionScope.emailUsuario}</div>
                        <c:choose>
                            <c:when test="${sessionScope.privilegios eq 'A'}">
                                <div id="detalhesUsuarioPrivilegios">Administrador</div>
                            </c:when>
                            <c:when test="${sessionScope.privilegios eq 'E'}">
                                <div id="detalhesUsuarioPrivilegios">Editor</div>
                            </c:when>
                            <c:when test="${sessionScope.privilegios eq 'S'}">
                                <div id="detalhesUsuarioPrivilegios">Super Administrador</div>
                            </c:when>    
                        </c:choose>
                        <div id="detalhesUsuariosGerenciarConta">
                            <a href="${pageContext.request.contextPath}/gerenciar-conta/${sessionScope.nomeUsuario}">Gerenciar Conta</a>
                        </div>
                    </div>
                    <div>
                        <div class="botaoPadrao">
                            <a id="detalhesUsuarioBtnDeslogar" class="deslogar" href="${pageContext.request.contextPath}/login?acao=deslogar" title="Deslogar-se">Sair</a>
                            <% if(privilegios.equals("S")){ %>
                                <a id="detalhesUsuarioBtngerenciarBlog" href="${pageContext.request.contextPath}/painel/postagens?tipo=todas" title="Gerencie usuários, altere configurações e crie novos posts!">Meu Blog</a>
                            <%}else if(privilegios.equals("A")){ %>
                                <a id="detalhesUsuarioBtngerenciarBlog" href="${pageContext.request.contextPath}/painel/postagens?tipo=todas" title="Gerencie usuários e crie novos posts!">Painel</a>
                            <%}else if(privilegios.equals("E")){%>
                                <a id="detalhesUsuarioBtngerenciarPosts" href="${pageContext.request.contextPath}/painel/postagens?tipo=todas" title="Gerencie e crie novos posts!">Meus Posts</a>
                            <%}%>
                            <a id="detalhesUsuarioBtnEditarPerfil" href="${pageContext.request.contextPath}/alterar-perfil/${sessionScope.nomeUsuario}" title="Altere informações de seu perfil">Perfil</a>
                        </div>
                    </div>
                </div>
            </c:if>
            <% if(!paginaAtual.equals("login.jsp") && session.getAttribute("nomeUsuario") == null){ %>
                <div id="btnFazerLogin" class="botaoPadrao caixaAlta branco">
                    <a href="${pageContext.request.contextPath}/login">Fazer Login</a>
                </div>
            <%} %>
        </div>
    </div>
    <% if(privilegios.equals("A") || privilegios.equals("E") || privilegios.equals("S")){ %>
        <div class="botaoFlutuante" id="botaoNovoPost">
            <a href="${pageContext.request.contextPath}/postagem/nova">
                <i class="fa fa-pencil-square-o"></i>
                <span>Nova Postagem</span>
            </a>
        </div>
    <%} %>    
</div> 
