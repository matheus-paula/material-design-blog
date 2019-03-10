<%-- 
    Document   : login
    Created on : 31/08/2018, 19:44:45
    Author     : matheus
--%>

<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="urlBase" value="${pageContext.request.contextPath}" />

<% 
    String acao = request.getParameter("acao");
    String privilegios;
    if(session.getAttribute("nomeUsuario") != null){
        privilegios = session.getAttribute("privilegios").toString();
    }else{
        privilegios = null;
    }
    if(request.getAttribute("cadastro") != null){
        String cadastro = request.getAttribute("cadastro").toString();
    }
%>
<!DOCTYPE html>
<!-- LOGIN -->
<html>
    <head>
        <title>${mapaOpcoes.get("opc_tituloSite")[1]} | Login</title>
        <meta content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1" name="viewport"/>
        <meta name="description" content="${mapaOpcoes.get("opc_descricaoSite")[1]}"/>
        <link href="${urlBase}/css/default.css" rel="stylesheet">
        <link href="${urlBase}/css/login.css" rel="stylesheet">
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
                    <!-- AREA DE CADASTRO -->
                    <% if(acao != null && acao.equals("registrar")){%>
                        <form method="post" action="${urlBase}/login?acao=registrar">
                            <div id="tabelaCadastro" class="cartao">                           
                                <h1>Página de Cadastro</h1>
                                <div class="campoDeTexto">
                                    <input id="usuario" name="usuario" type="text" maxlength="50" autocomplete="off">
                                    <label for="usuario">Usuário</label>
                                    <div></div>
                                </div>
                                <div class="campoDeTexto">
                                    <input id="nome" name="nome" type="text" maxlength="50" autocomplete="off">
                                    <label for="nome">Nome</label>
                                    <div></div>
                                </div>
                                <div class="campoDeTexto">
                                    <input id="sobrenome" name="sobrenome" type="text" maxlength="50" autocomplete="off">
                                    <label for="sobrenome">Sobrenome</label>
                                    <div></div>
                                </div>
                                <div class="campoDeTexto">
                                    <input id="email" name="email" type="email" maxlength="50" autocomplete="off">
                                    <label for="email">E-mail</label>
                                    <div></div>
                                </div>
                                <div class="campoDeTexto">
                                    <input id="senha" name="senha" type="password" maxlength="50" autocomplete="off">
                                    <label for="senha">Senha</label>
                                    <div></div>
                                </div>
                                <div class="campoDeTexto">
                                    <input id="repitaSenha" name="repitaSenha" type="password" maxlength="50" autocomplete="off">
                                    <label for="repitaSenha">Confirme a Senha</label>
                                    <div></div>
                                </div>
                                <% if(privilegios != null){
                                    if(privilegios.equals("S")){
                                 %>
                                 <h2>Quais privilégios o usuário terá no site?</h2>
                                 <div class="containerRadioBtn">
                                    <input id="opcaoUsuarioAdmin" type="radio" name="privilegios" class="radioBtn" value="A">
                                    <label for="opcaoUsuarioAdmin">
                                        <span class="material-radio-outer-circle"></span>
                                        Administrador
                                    </label>
                                    <p class="campoDescricao">Como usuário administrador, este poderá editar e excluir as postagens de todos os outros usuários do site.</p>
                                </div>
                                
                                <div class="containerRadioBtn" style="border:none;">
                                    <input id="opcaoUsuarioEditor" type="radio" name="privilegios" class="radioBtn" value="E" checked>
                                    <label for="opcaoUsuarioEditor">
                                        <span class="material-radio-outer-circle"></span>
                                        Editor
                                    </label>
                                    <p class="campoDescricao">Como usuário editor, apenas será possível editar e excluir os próprios posts, além de visualizar os posts dos outros usuarios, porém sem poder modificá-los.</p>
                                </div>
                                <%   
                                    }
                                   }
                                %> 
                                <div id="cadastroErros">
                                    <% if(request.getAttribute("cadastro") != null){
                                            if(request.getAttribute("cadastro").toString().equals("erro")){
                                    %>
                                            <div id="erroServidor" class="avisoFormulario mostrar">
                                                <p>Erro durante cadastro</p>
                                                <p>Um erro inespearado ocorreu durante o cadastro, tente novamente mais tarde.</p>
                                            </div>
                                    <%            
                                            }else if(request.getAttribute("cadastro").toString().equals("existe")){
                                    %>
                                            <div id="erroCadastroExiste" class="avisoFormulario mostrar">
                                                <p>Usuário inválido!</p>
                                                <p>Um usuário com o mesmo nome já existe no banco de dados, tente outro!</p>
                                            </div>
                                    <%
                                            }else if(request.getAttribute("cadastro").toString().equals("sucesso")){
                                    %>
                                            <div id="avisoCadastroSucesso" class="avisoFormulario mostrar sucesso">
                                                <p>Usuário cadastrado com sucesso!</p>
                                                <c:choose>
                                                    <c:when test="${sessionScope.privilegios eq 'S'}">
                                                        <p>O usuário foi cadastrado com sucesso no sistema!</p>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <p>Sua conta foi cadastrada com sucesso no site!<br/>Faça login, para utilizar!</p>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                    <%
                                            }
                                        }
                                    %>  
                                    <div id="erroSenhas" class="avisoFormulario">
                                        <p>Senha inválida!</p>
                                        <p>As senhas não conferem ou possuem caracteres inválidos.</p>
                                    </div>
                                    <div id="erroFormulario" class="avisoFormulario">
                                        <p>Erro no formulário!</p>
                                        <p>Verifique se preencheu corretamente todos os campos.</p>
                                    </div>
                                </div>
                                <div class="botaoPadrao">
                                <c:choose>
                                    <c:when test="${sessionScope.privilegios eq 'S'}">
                                        <input value="Cadastrar Usuário" type="submit"/>
                                    </c:when>
                                    <c:otherwise>
                                        <input value="Cadastrar-se" type="submit"/>
                                    </c:otherwise>
                                </c:choose>
                                    
                                </div>
                            </div>
                        </form>

                    <% } else { %>
                    <!-- AREA LOGIN -->
                            <div id="conteudoPrincipal" class="cartao">
                                <div>
                                    <div id="apresentacaoCadastro">
                                        <h1>Seja Bem Vindo!</h1>
                                        <h2>Faça login caso já possua uma conta no site ou cadastre-se agora!</h2>
                                        <div class="botaoPadrao">
                                            <a href="login?acao=registrar">Cadastrar-se</a>
                                        </div>
                                    </div>
                                </div>
                                <div>
                                    <form method="post" action="login">
                                        <div class="campoDeTexto">
                                            <input id="usuario" type="text" name="usuario" maxlength="100" autocomplete="off">
                                            <label for="usuario">Usuário</label>
                                            <div></div>
                                        </div>
                                        <br />
                                        <div class="campoDeTexto">
                                            <input id="senha" name="senha" type="password" maxlength="50" autocomplete="off">
                                            <label for="senha">Senha</label>
                                            <div></div>
                                        </div>
                                        <% if(request.getAttribute("statusLogin") != null){
                                                if(request.getAttribute("statusLogin").toString().equals("0")){
                                        %>
                                                <div id="erroUsuario" class="avisoFormulario mostrar">
                                                    <p>Usuário não existe</p>
                                                    <p>O usuário informado não está cadastrado no banco de dados, tente novamente.</p>
                                                </div>
                                        <%            
                                                }else if(request.getAttribute("statusLogin").toString().equals("2")){
                                        %>
                                                <div id="erroSenha" class="avisoFormulario mostrar">
                                                    <p>Senha incorreta</p>
                                                    <p>A senha digitada está incorreta, verifique se a digitou corretamente.</p>
                                                </div>
                                        <%
                                                }
                                            }
                                        %> 
                                        <div class="botaoPadrao">
                                            <input value="Entrar" type="submit"/>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    <% } %>
                    <div class="quebrarFloat"></div>
                </div>
                <div class="rodape">
                    <h3>${mapaOpcoes.get("opc_creditosRodape")[1]} | ${mapaOpcoes.get("opc_tituloSite")[1]}</h3>
                </div>                     
            </div>
        </div>   
    </body>
</html>

