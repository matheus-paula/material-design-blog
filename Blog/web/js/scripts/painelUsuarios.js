/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/* JS Closures */
var gerenciarUsuarios = {
  alterarPrivilegios: function(idUsuario,idFormulario){
    $.ajax({
        type: "POST",
        cache: false,
        url: "../painel/usuarios?acao=alterarPrivilegios&id="+idUsuario,
        data: $("#"+idFormulario).serialize(),
        success: function(){
            window.open("../painel/usuarios","_self");
        },
        error: function(x){
            var botoes = [];
            mostrarCaixaDialogoExcutarFuncao(botoes,"OK","Erro ao alterar privilégios","Um erro inesperado ocorreu durante a alteração, tente novamente mais tarde!");
        }
    });      
  },
  excluirUsuario: function(idUsuario,idFormulario){
    var formulario = $("#"+idFormulario)[0],
        dados = new FormData(formulario);
    $.ajax({
        type: "POST",
        enctype: 'text/plain',
        processData: false,
        contentType: false,
        cache: false,
        url: "../painel/usuarios?acao=excluirUsuario&id="+idUsuario,
        data: dados,
        success: function(){
            window.open("../painel/usuarios","_self");
        },
        error: function(x){
            var botoes = [];
            mostrarCaixaDialogoExcutarFuncao(botoes,"OK","Erro ao excluir usuário","Um erro inesperado ocorreu durante a exclusão do usuário, tente novamente mais tarde!");
        }
    });      
  }
};

$(document).ready(function() {
    $("body").on("click",".dropdownPadrao ul li",function(){
        var idFormulario = $(this).closest(".formularioPrivilegios").attr("id"),
            idUsuario = $(this).closest(".formularioPrivilegios").attr("data-id-usuario"),
            valor = $(this).attr("value"),
            botoes = [
            {
                funcao:Base64.encode("gerenciarUsuarios.alterarPrivilegios('"+idUsuario+"','"+idFormulario+"');"),
                txtBotao:"Alterar"
            }
        ];
        mostrarCaixaDialogoExcutarFuncao(botoes,"Cancelar","Alterar Privilégios","Tem certeza de que deseja alterar os privilégios deste usuário?");
    });
    $("body").on("click",".excluirUsuario a",function(){
        var idFormulario = $(this).closest(".formularioExcluirUsuario").attr("id"),
            idUsuario = $(this).attr("data-id-usuario"),
            botoes = [
            {
                funcao:Base64.encode("gerenciarUsuarios.excluirUsuario('"+idUsuario+"','"+idFormulario+"');"),
                txtBotao:"Excluir"
            }
        ];
        mostrarCaixaDialogoExcutarFuncao(botoes,"Cancelar","Excluir Usuário","Tem certeza de que deseja remover este usuário?");
    });
});
