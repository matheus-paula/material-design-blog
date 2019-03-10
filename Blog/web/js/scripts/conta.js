/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function filtrarNomeUsuario(texto){
    var expressaoRegular = /[^a-zA-Z0-9-. ]/g;                                                    
    texto = texto.replace(new RegExp('[ÁÀÂÃ]','gi'), 'a');
    texto = texto.replace(new RegExp('[ÉÈÊ]','gi'), 'e');
    texto = texto.replace(new RegExp('[ÍÌÎ]','gi'), 'i');
    texto = texto.replace(new RegExp('[ÓÒÔÕ]','gi'), 'o');
    texto = texto.replace(new RegExp('[ÚÙÛ]','gi'), 'u');
    texto = texto.replace(new RegExp('[Ç]','gi'), 'c');
    texto = texto.toLowerCase().replace(expressaoRegular, '_');
    texto = texto.replace(/ /g,  "-");
    return texto;                 
}

function trocarAba(id){
    $('.ativa').fadeOut(150, function(){
        $(this).removeClass('ativa');
        $('#'+id).fadeIn(150).addClass('ativa');
    });
}

function submeterFormulario(id){
    document.getElementById(id).submit();
}

$(document).ready(function() {
    /* BARRA COLORIDA DO MENU */
    $('.abas li').on("click",function(){
        if($(this)[0].hasAttribute("data-aba") === true){
                trocarAba($(this).attr("data-aba"));
        }
        if(!$(this).hasClass("selecionada")){
            $('.abas li.abaAtiva').css('width',$(this).outerWidth()).css('left',$(this).position().left);
            $('.abas li').removeClass('selecionada');
            $(this).addClass('selecionada');
        }
    });

    if(validarEmail($('#emailUsuario').val()) === true){
        $('#emailUsuario').parent().addClass("campoValido");
    }else{
        $('#emailUsuario').parent().removeClass("campoValido");
    }
    $('.abas li.abaAtiva').css('width',$('.abas li.selecionada').outerWidth());
    $('.abas li.abaAtiva').css('width',$('.abas li.selecionada').outerWidth()).css('left',$('.abas li.selecionada').position().left);
    $("body").on('click','#botaoAlterarSenha',function(evento){    
        evento.preventDefault();
        var botoes = [
            {
                funcao:Base64.encode("submeterFormulario('alterarSenha')"),
                txtBotao:"Alterar Senha"
            }
        ];
        mostrarCaixaDialogoExcutarFuncao(botoes,"Cancelar","Alterar Senha","Tem certeza de que deseja alterar sua senha?");
    }).on("keyup","#alterarSenha input",function(){
        if($("#senhaUsuarioAtual").val().length > 0
            && $("#senhaUsuarioNova").val().length > 0
            && $("#senhaUsuarioNovaConfirmar").val().length > 0){
            $("#botaoAlterarSenha").prop("disabled",false);
        }else{
            $("#botaoAlterarSenha").prop("disabled",true);
        }
    }).on("keyup","#alterarConta input",function(){
        if($(this).attr("id") === "nomeUsuario"){
            $(this).val(filtrarNomeUsuario($(this).val()));
        }
        if($("#senhaUsuarioNova").val().length > 0
            || $("#emailUsuario").val().length > 0){
            $("#botaoAlterarConta").prop("disabled",false);
        }else{
            $("#botaoAlterarConta").prop("disabled",true);
        }
    }).on("keyup","#senhaUsuarioNova",function(){
        var erro = $("#erroNoPreenchimento");
        if($(this).val() ===  $("#senhaUsuarioAtual").val() && $(this).val().length >= $("#senhaUsuarioAtual").val().length){
            $("#abaSenha .avisoFormulario").removeClass("mostrar");
            $("#erroNoPreenchimento p:nth-child(1)").html("Senhas iguais!");
            $("#erroNoPreenchimento p:nth-child(2)").html("A nova senha não pode ser igual senha atual!");
            erro.addClass("mostrar");
        }else{
            erro.removeClass("mostrar");
        }
    }).on("keyup","#senhaUsuarioNovaConfirmar",function(){
        var erro = $("#erroNoPreenchimento");
        if($(this).val() !==  $("#senhaUsuarioNova").val() && $(this).val().length >= $("#senhaUsuarioNova").val().length){
            $("#abaSenha .avisoFormulario").removeClass("mostrar");
            $("#erroNoPreenchimento p:nth-child(1)").html("Senhas não coincidem");
            $("#erroNoPreenchimento p:nth-child(2)").html("As senhas informadas não são iguais!");
            erro.addClass("mostrar");
        }else{
            erro.removeClass("mostrar");
        }
    });;
});

