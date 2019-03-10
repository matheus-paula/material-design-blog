<%-- 
    Document   : areaUsuarioPainel
    Created on : 03/09/2018, 21:53:04
    Author     : mathe
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
 <div class="areaUsuarioPainel">
    <% if(session.getAttribute("nomeUsuario") != null){ %>
        <div>
            <c:choose>
                <c:when test="${empty sessionScope.fotoUsuario}">
                    <img id="detalhesUsuarioFoto" src="../graficos/semfoto.png">
                </c:when>
                <c:otherwise>
                    <img id="detalhesUsuarioFoto" src="../${sessionScope.fotoUsuario}">
                </c:otherwise>
            </c:choose>
            <div id="detalhesUsuarioNome">${primeiroNomeUsuario} ${sobrenomeUsuario}</div>
            <div id="detalhesUsuarioEmail">${emailUsuario}</div>
        </div>
    <%} %>
</div>

