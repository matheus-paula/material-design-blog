<%-- 
    Document   : comentariosRecentes
    Created on : 28/09/2018, 07:34:22
    Author     : mathe
--%>
<%@page import="models.Comentarios"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<ul id="comentariosRecentes" class="cardLateral">
    <c:forEach var="comentario" items="${comentariosRecentes}">
        <li>
            <a rel="nofollow" title="Comentário em: &#34;${comentario.getPosts().getTituloPost()}&#34; por: ${comentario.getUsuarios().getNome()}" target="_blank" href="${pageContext.request.contextPath}/post/${comentario.getPosts().getLinkPermanente()}#comentarios">
                <c:choose>
                    <c:when test="${empty comentario.getUsuarios().getFoto()}">
                        <img src="${pageContext.request.contextPath}/graficos/semfoto.png"/>
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.servletContext.contextPath}/${comentario.getUsuarios().getFoto()}">
                    </c:otherwise>
                </c:choose>
                <span>${comentario.getUsuarios().getNome()}</span>
                <p class="citacaoComentario">${comentario.getComentario()}</p>
                <p>${comentario.getPosts().getTituloPost()}</p>
            </a>
        </li>
    </c:forEach>
</ul>
