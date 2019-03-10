<%-- 
    Document   : postsPopulares
    Created on : 19/09/2018, 16:48:42
    Author     : mathe
--%>
<%@page import="models.Posts"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="caminhoImagem" value="midia/imagemDestaque/" />

<!DOCTYPE html>
<ul id="postsPopulares" class="cardLateral">
    <c:forEach var="post" items="${postsPopulares}">
        <li>
            <a rel="nofollow" title="${post.tituloPost}" href="${pageContext.request.contextPath}/post/${post.linkPermanente}">
                <c:choose>
                    <c:when test="${empty post.imagemMiniatura}">
                        <img src="${pageContext.request.contextPath}/graficos/post-sem-imagem.png"/>
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/${caminhoImagem}min/${post.imagemMiniatura}"/>
                    </c:otherwise>
                </c:choose>
                
                <span>${post.tituloPost}</span>
                <p>${post.getSumarioPost()}</p>
                <p><fmt:formatDate pattern="dd/MM/yyyy à&#115; hh:mm" value="${post.dataCriacaoPost}" /></p>
            </a>
        </li>
    </c:forEach>
</ul>
