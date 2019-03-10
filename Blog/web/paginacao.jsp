<%-- 
    Document   : paginacao
    Created on : 23/09/2018, 16:12:15
    Author     : mathe
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<c:if test="${paginas > 1}">
    <div class="cartao">
        <c:if test="${paginaAtual > 1}">
                <div class="botaoNavegacao botaoPadrao paginaAnterior ">
                    <c:if test="${itensPorPagina eq 10}">
                        <a href="${pageContext.servletContext.contextPath}?p=${paginaAtual - 1}">&laquo; Anterior</a>
                    </c:if>
                    <c:if test="${itensPorPagina ne 10}">
                        <a href="${pageContext.servletContext.contextPath}?p=${paginaAtual - 1}&itens=${itensPorPagina}">&laquo; Anterior</a>
                    </c:if>
                </div>
        </c:if>
            <div class="botaoNavegacao botaoPadrao numPagina">
                <c:forEach var="num" begin="1" end="${paginas}">
                    <c:choose>
                        <c:when test="${num < 6 or num eq paginas}">
                            <c:choose>
                                <c:when test="${itensPorPagina eq 10}">
                                    <c:choose>
                                        <c:when test="${num eq paginaAtual}">
                                            <a class="selecionado" href="${pageContext.servletContext.contextPath}?p=${num}">${num}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.servletContext.contextPath}?p=${num}">${num}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${num eq paginaAtual}">
                                            <a class="selecionado" href="${pageContext.servletContext.contextPath}?p=${num}&itens=${itensPorPagina}">${num}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.servletContext.contextPath}?p=${num}&itens=${itensPorPagina}">${num}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>            
                            </c:choose>
                        </c:when>
                        <c:when test="${num eq 6 and paginas > 6}">
                            <a href="javascript:void(0)">...</a>
                        </c:when>
                    </c:choose>                    
                </c:forEach>
            </div>
        <c:if test="${paginaAtual < paginas}">
            <div class="botaoNavegacao botaoPadrao proxPagina">
                <c:if test="${itensPorPagina eq 10}">
                    <a href="${pageContext.servletContext.contextPath}?p=${paginaAtual + 1}">Proximo &raquo;</a>
                </c:if>
                <c:if test="${itensPorPagina ne 10}">
                    <a href="${pageContext.servletContext.contextPath}?p=${paginaAtual + 1}&itens=${itensPorPagina}">Proximo &raquo;</a>
                </c:if>
            </div>
        </c:if>
    </div>
 </c:if>