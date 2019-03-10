<%-- 
    Document   : conta
    Created on : 02/10/2018, 09:24:40
    Author     : mathe
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="urlBase" value="${pageContext.request.contextPath}" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%  
    String aba = "conta";
    if(request.getParameter("aba") != null){
        aba = request.getParameter("aba");
    }
%>
<!-- CONTA -->
<!DOCTYPE html>
<html>
    <head>
        <title>${mapaOpcoes.get("opc_tituloSite")[1]} | Configurações da Conta</title>
        <meta name="description" content="${mapaOpcoes.get("opc_descricaoSite")[1]}"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link href="${urlBase}/css/default.css" rel="stylesheet">
        <link href="${urlBase}/fontes/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500" rel="stylesheet">
        <script src="${urlBase}/js/plugins/jquery-3.3.1.min.js" type="text/javascript"></script>
        <script src="${urlBase}/js/scripts/scripts.js" type="text/javascript"></script>
        <script src="${urlBase}/js/scripts/conta.js" type="text/javascript"></script>
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
                        <!- CONTEUDO -->
                        <div class="cartao">
                            <div>
                                <h2>Gerenciar Conta</h2>
                                <br />
                                <ul id="abasConta" class="abas">
                                    <li data-aba="abaConta" class="aba <% if(aba.equals("conta")){out.print("selecionada");}%>"><div>Conta</div></li>
                                    <li data-aba="abaSenha" class="aba <% if(aba.equals("senha")){out.print("selecionada");}%>"><div>Senha</div></li>
                                    <li class="abaAtiva"></li>
                                </ul>  
                            </div>    
                            <br/>
                            <div id="containerAbasConta" class="containerAbas">
                                <div id="abaConta" class="conteudoAba <% if(aba.equals("conta")){out.print("ativa");}%>">
                                    <p>Atualize as informações relacionadas a sua conta no site</p>
                                    <br />
                                    <form id="alterarConta" action="../gerenciar-conta/${usuario.nomeUsuario}" method="post">
                                        <input type="hidden" name="alterar" value="conta" />
                                        <div class="campoDeTexto">
                                            <input id="nomeUsuario" value="${usuario.nomeUsuario}" type="text" name="nomeUsuario" maxlength="150" autocomplete="off"/>
                                            <label for="nomeUsuario">Nome de Usuário</label>
                                            <div></div>
                                        </div>
                                        <br />
                                        <div class="campoDeTexto">
                                            <input id="emailUsuario" value="${usuario.email}" type="email" name="emailUsuario" maxlength="150" autocomplete="off"/>
                                            <label for="emailUsuario">Endereço de E-mail</label>
                                            <div></div>
                                        </div>
                                        <div class="botaoPadrao">
                                            <input id="botaoAlterarConta" disabled title="Salvar Alterações" value="Salvar Alterações" type="submit"/>
                                        </div>
                                    </form>
                                </div>
                                <div id="abaSenha" class="conteudoAba <% if(aba.equals("senha")){out.print("ativa");}%>">
                                    <p>Altere sua senha cadastrada no site</p>
                                    <br />
                                    <form id="alterarSenha" action="../gerenciar-conta/${usuario.nomeUsuario}" method="post">
                                        <input type="hidden" name="alterar" value="senha" />
                                        <div class="campoDeTexto">
                                            <input id="senhaUsuarioAtual" type="password" name="senhaUsuarioAtual" maxlength="100" autocomplete="off"/>
                                            <label for="senhaUsuarioAtual">Senha Atual</label>
                                            <div></div>
                                        </div>
                                        <br />
                                        <div class="campoDeTexto">
                                            <input id="senhaUsuarioNova" type="password" name="senhaUsuarioNova" maxlength="100" autocomplete="off"/>
                                            <label for="senhaUsuarioNova">Nova Senha</label>
                                            <div></div>
                                        </div>
                                        <br />
                                        <div class="campoDeTexto">
                                            <input id="senhaUsuarioNovaConfirmar" type="password" name="senhaUsuarioNovaConfirmar" maxlength="100" autocomplete="off"/>
                                            <label for="senhaUsuarioNovaConfirmar">Confirmar Nova Senha</label>
                                            <div></div>
                                        </div>
                                        <% if(request.getParameter("status") != null && request.getParameter("status").equals("3")){ %>
                                            <div id="erroSenha" class="avisoFormulario mostrar">
                                                <p>Senha Atual inválida</p>
                                                <p>A senha atual informada não confere!</p>
                                            </div>
                                        <% }else if(request.getParameter("status") != null && request.getParameter("status").equals("1")){ %>
                                            <div id="avisoSenha" class="avisoFormulario sucesso mostrar">
                                                <p>Senha Alterada com Sucesso!</p>
                                                <p>Sua senha foi alterada com sucesso, faça login novamente para utiliza-la!</p>
                                            </div>
                                        <% }%>
                                        <div id="erroNoPreenchimento" class="avisoFormulario">
                                            <p></p>
                                            <p></p>
                                        </div>
                                        <div class="botaoPadrao">
                                            <input id="botaoAlterarSenha" disabled title="Salvar Alterações" value="Salvar Alterações" type="submit"/>
                                        </div>
                                    </form>
                                </div>
                            </div>
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

