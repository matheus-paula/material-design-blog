/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function submeterFormDinamico(caminho, parametros) {
    var formulario = $('<form></form>');
        formulario.attr("method", "post");
        formulario.attr("action", caminho);
    $.each(parametros, function(chave, valor) {
        var campo = $('<input></input>');
        campo.attr("type", "hidden");
        campo.attr("name", chave);
        campo.attr("value", valor);
        formulario.append(campo);
    });
    $(document.body).append(formulario);
    formulario.submit();      
}

$(document).ready(function() {
    $('#menuPainel > .menuPadrao > li > a[href="'+window.location.href.replace(window.location.origin,"")+'"]').parent().addClass('ativo');
    
    $("#listaDePaginas").bind("DOMSubtreeModified",function(){
        var numeroPagina = $("#listaDePaginas li.ativo").attr("id").replace("pagina","");
        var novaPagina = alterarParametro(window.location.href,'p',numeroPagina);
        window.open(novaPagina,"_self");
        return false;          
    });
    
    $(".listaOpcoesComentario > a").on("click",function(){
        var idComentario = $(this).parent().attr("data-post-id");
        var urlAtual = window.location.href;
        switch($(this).attr("class")){
            case "visualizarPost":
                window.open($(this).attr("href"),"_blank");
                ;break;
            case "excluirComentario":
                var botoes = [
                    {
                        funcao:Base64.encode("submeterFormDinamico('"+urlAtual+"',{acao: \'excluirComentario\', id:" +idComentario+"});"),
                        txtBotao:"Excluir"
                    }
                ];
                mostrarCaixaDialogoExcutarFuncao(botoes,"Cancelar","Excluir Comentário?","Tem certeza de que deseja remover este comentário?");
                ;break;
            default:
                ;break;
        }
        return false;
    });
});