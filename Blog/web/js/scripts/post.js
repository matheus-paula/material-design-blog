/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function removerComentario(id) {
    var contexto = $("#"+id);
    var comentario = contexto.closest(".comentarioForm");
    var erro = contexto.closest(".comentarioForm").children(".mensagemErroResposta");
    var url = "../submeter-comentario?id="+contexto.attr("data-id-comentario");
    $.ajax({
        type: "GET",
        url: url,
        data: $("#formularioComentario form").serialize(),
        success: function(){
            location.reload();
        },
        error: function(x){
            if(x.status === 500){
                erro.html("<p>*Erro interno no servidor, tente novamente mais tarde!");
            }else{
                erro.html("<p>*Erro desconhecido, não foi possível remover o comentário!");
            }
            comentario.addClass("mostrarErro");
        }
     });
    return false;
};

$(document).ready(function() {
    $("body").on("click",".responderComentario",function(){
       /* ABRIR FORM DE RESPOSTA PARA COMENTARIO */
       var formulario = $("#formularioResposta").parent().html();
       $("#formularioResposta").parent().html(" ");
       $(this).closest(".corpoComentario").children(".containerComentarioSecundario").html(formulario);
       $("#comentarioPai").val($(this).attr("data-comentario-pai"));
       
    }).on("click",".cancelarResposta",function(){
       /*CANCELA RESPOSTA A COMENTARIO*/
       var formulario = $("#formularioResposta").parent().html();
       $("#formularioResposta").parent().html(" ");
       $("#containerRespostasPrincipal").html(formulario);
       $("#comentarioPai").val($(this).attr("data-comentario-pai"));
       
    }).on("click",".submeterResposta",function() {
        /* SUBMETER RESPOSTA VIA AJAX */    
        var comentario = $(this).closest(".containerComentarioSecundario");
        var erro = $(this).closest(".comentarioForm").children(".mensagemErroResposta");
        var url = "/submeter-comentario";
        $.ajax({
            type: "POST",
            url: url,
            data: $("#formularioResposta form").serialize(),
            success: function(){
                location.reload();
            },
            error: function(x){
                if(x.status === 412){
                    erro.html("<p>*Código de segurança inválido</p>");
                }else if(x.status === 500){
                    erro.html("<p>*Erro interno no servidor, tente novamente mais tarde!");
                }else if(x.status === 406){
                    erro.html("<p>*O comentário possui palavras impróprias ou não permitidas, por favor, reescreva!");
                }else{
                    erro.html("<p>*Erro desconhecido, não foi possível publicar sua resposta!");
                }
                $("#captchaResposta").attr("src", "../gerador-captcha");
                comentario.addClass("mostrarErro");
            }
         });
        return false;
        
    }).on("click",".submeterComentario",function() {    
        /* SUBMETER COMENTARIO VIA AJAX */
        var comentario = $(this).closest(".comentarioForm");
        var erro = $(this).closest(".comentarioForm").children(".mensagemErroComentario");
        var url = "../submeter-comentario";
        $.ajax({
            type: "POST",
            url: url,
            data: $("#formularioComentario form").serialize(),
            success: function(){
                location.reload();
            },
            error: function(x){
                if(x.status === 412){
                    erro.html("<p>*Código de segurança inválido</p>");
                }else if(x.status === 500){
                    erro.html("<p>*Erro interno no servidor, tente novamente mais tarde!");
                }else if(x.status === 406){
                    erro.html("<p>*O comentário possui palavras impróprias ou não permitidas, por favor, reescreva!");
                }else{
                    erro.html("<p>*Erro desconhecido, não foi possível publicar o comentário!");
                }
                $("#captchaComentario").attr("src", "../gerador-captcha");
                comentario.addClass("mostrarErro");
            }
         });
        return false;
        
    }).on("keyup",".comentarioForm textarea",function(){        
        /* HABILITAR BOTAO DE SUBMISSÃO APOS COMENTARIO PREENCHIDO */
        var botao = $(this).closest(".comentarioForm").find("input[type=submit]");
        if($(this).val().length > 0){
            botao.prop('disabled', false);
        }else{
            botao.prop('disabled', true);
        }
        
    }).on("click",".removerComentario",function(){        
        /* MOSTRAR CAIXA DE CONFIRMAÇÃO ANTES DE EXCLUIR COMENTARIO */
        var botoes = [
            {
                funcao:Base64.encode("removerComentario(\""+$(this).attr("id")+"\")"),
                txtBotao:"Remover Comentário"
            }
        ];
        mostrarCaixaDialogoExcutarFuncao(botoes,"Cancelar","Remover comentário","Tem certeza de que deseja remover este comentário?");
    });
});

