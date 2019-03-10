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
    
    $("#listaDeTags li").on('click',function(){
        var novaPagina = alterarParametro(window.location.href,'p',"1");            
        if($(this).attr("value") !== null){
            window.open(alterarParametro(novaPagina,'tag',$(this).attr("value")),"_self"); 
        }else{    
            window.open(alterarParametro(novaPagina,'tag',""),"_self"); 
        }
        return false;       
    });
    
    $(".listaPostOpcoes > a").on("click",function(){
        var idPostagem = $(this).parent().attr("data-post-id");
        var urlAtual = window.location.pathname;window.location.href;
        switch($(this).attr("class")){
            case "visualizarPost":
                window.open($(this).attr("href"),"_blank");
                ;break;
            case "editarPost":
                window.open("../editor?idPost="+idPostagem,"_self");
                ;break;
            case "excluirPost":
                var botoes = [
                    {
                        funcao:Base64.encode("submeterFormDinamico('"+urlAtual+"',{acao: \'excluirPost\', id:" +idPostagem+"});"),
                        txtBotao:"Excluir"
                    }
                ];
                mostrarCaixaDialogoExcutarFuncao(botoes,"Cancelar","Excluir Postagem?","Tem certeza de que deseja remover esta postagem?");
                /*submeterFormDinamico(urlAtual,{acao: "excluirPost", id: idPostagem});*/
                ;break;
            case "publicarPost":
                var botoes = [
                    {
                        funcao:Base64.encode("submeterFormDinamico('"+urlAtual+"',{acao: \'publicarPost\', id:" +idPostagem+"});"),
                        txtBotao:"Publicar"
                    }
                ];
                mostrarCaixaDialogoExcutarFuncao(botoes,"Cancelar","Publicar Postagem?","Tem certeza de que deseja publicar esta postagem?");
                /*submeterFormDinamico(urlAtual,{acao: "publicarPost", id: idPostagem});*/
                ;break;
            case "reverterParaRascunho":
                var botoes = [
                    {
                        funcao:Base64.encode("submeterFormDinamico('"+urlAtual+"',{acao: \'reverterParaRascunho\', id:" +idPostagem+"});"),
                        txtBotao:"Reverter"
                    }
                ];
                mostrarCaixaDialogoExcutarFuncao(botoes,"Cancelar","Reverter Para Rascunho?","Tem certeza de que deseja reverter esta postagem para um rascunho?");
                /*submeterFormDinamico(urlAtual,{acao: "reverterParaRascunho", id: idPostagem});*/
                ;break;
            default:
                ;break;
        }
        return false;
    });

});