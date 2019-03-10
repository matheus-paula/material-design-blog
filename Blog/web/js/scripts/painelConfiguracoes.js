/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function alterarConfiguracoes(idFormulario){
    $.ajax({
        type: "POST",
        url: "../painel/configuracoes",
        data: $("#"+idFormulario).serialize(),
        success: function(){
            
        },
        error: function(x){
            var botoes = [];
            mostrarCaixaDialogoExcutarFuncao(botoes,"OK","Erro ao alterar privilégios","Um erro inesperado ocorreu durante a alteração, tente novamente mais tarde!");
        }
    });
}

$(document).ready(function() {
    $(".entradaTextoDialogo").on("campo-alterado",function(){
        alterarConfiguracoes("configuracoesForm");
    });
});
