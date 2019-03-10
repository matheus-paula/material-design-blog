<%-- 
    Document   : perfil
    Created on : 01/09/2018, 09:51:10
    Author     : mathe
--%>

<%@page import="models.Usuarios"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="urlBase" value="${pageContext.request.contextPath}"/>
<%
    Usuarios perfil;
    if(request.getAttribute("usuario") != null){
        perfil = (Usuarios) request.getAttribute("usuario");
    }else{
        perfil = null;
    }
%>
<!-- PERFIL DO USUARIO -->
<!DOCTYPE html>
<html>
    <head>
        <title>${mapaOpcoes.get("opc_tituloSite")[1]} | <%=perfil.getNome()+" "+perfil.getSobrenome() %></title>
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
                        <!-- conteudo -->
                        <div class="cartao" style="height:400px;">
                            <% if(perfil != null){ %>
                                <table class="descricaoAutor">
                                    <tbody>
                                        <tr>
                                            <td valign="top">
                                                <div>
                                                    <a href="javascript:void(0)" target="_blank">
                                                        <div rel="author" class="fotoAutor grande" style="background:url('../<% if(perfil.getFoto() != null || perfil.getFoto().isEmpty()){out.print(perfil.getFoto());}else{out.print("graficos/semfoto.png");} %>')"></div>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <br />
                                                <h2 style="text-align:center;">
                                                    <a href="javascript:void(0)" target="_blank"><% out.print(perfil.getNome() + " " + perfil.getSobrenome()); %></a>
                                                </h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <br />
                                                <div style="text-align:center;" class="bioAutor grande">
                                                    <% if(perfil.getBio() != null){out.print(perfil.getBio());} %>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            <% } else { %>
                                <h2>Perfil não encontrado ou não existe!</h2>
                            <% } %>
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

