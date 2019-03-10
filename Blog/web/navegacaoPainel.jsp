<%-- 
    Document   : navegacaoPainel
    Created on : 23/09/2018, 21:40:01
    Author     : mathe
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url" value="${req.requestURL}" />
<c:set var="uri" value="${req.requestURI}" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<ul id="menuLateral" class="menuPadrao">
    <li>
        <button type="button" class="mostrarSideNav">
            <i class="fa fa-bars"></i>
        </button>
        <h2>${mapaOpcoes.get("opc_tituloSite")[1]}</h2>
    </li>
    <li class="item">
        <i class="fa fa-file-o"></i>
        <a href="../painel/postagens?tipo=todas">Postagens</a>
    </li>
    <c:if test="${param.aba eq 'postagens'}">
        <li>
            <a href="../painel/postagens?tipo=todas">
                <span itemprop="name">Todas</span>
            </a>
        </li>
        <li>
            <a href="../painel/postagens?tipo=publicadas">
                <span itemprop="name">Publicadas</span>
            </a>
        </li>
        <li>
            <a href="../painel/postagens?tipo=rascunhos">
                <span itemprop="name">Rascunho</span>
            </a>
        </li>
    </c:if>
    <li class="item">
        <i class="fa fa-user"></i>
        <a href="../painel/usuarios">Usuários</a>
    </li>
    <c:if test="${param.aba eq 'usuarios'}">
        <li>
        <a href="../painel/usuarios">
            <c:if test="${privilegios eq 'A' or privilegios eq 'S'}">
               <span itemprop="name">Gerenciar Usuários</span>
            </c:if>
            <c:if test="${privilegios eq 'E'}">
               <span itemprop="name">Ver Usuários</span>
            </c:if>
        </a>
        </li>
    </c:if>
    <c:if test="${privilegios eq 'A' or privilegios eq 'S'}">
        <li class="item">
            <i class="fa fa-comments-o"></i>
            <a href="../painel/comentarios">Comentários</a>
        </li>
        <c:if test="${param.aba eq 'comentarios'}">
            <li>
                <a href="../painel/comentarios">
                    <span itemprop="name">Gerenciar Comentários</span>
                </a>
            </li>
        </c:if>
    </c:if>    
    <c:if test="${privilegios eq 'S'}">
        <li class="item">
            <i class="fa fa-cog"></i>
            <a href="../painel/configuracoes">Configurações</a>
        </li>
        <c:if test="${param.aba eq 'configuracoes'}">
            <li>
                <a href="../painel/configuracoes">
                    <span itemprop="name">Básico</span>
                </a>
            </li>
        </c:if>
    </c:if>
</ul>
