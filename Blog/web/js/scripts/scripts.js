/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* OBJETO PARA CONVERTER STRINGS PARA BASE64 
 * USADO PARA 'ESCONDER' CHAMADA DA FUNCAO EM ALGUMAS SITUACOES ESPECÍFICAS
 * */
var Base64 = {_keyStr:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",encode:function(e){var t="";var n,r,i,s,o,u,a;var f=0;e=Base64._utf8_encode(e);while(f<e.length){n=e.charCodeAt(f++);r=e.charCodeAt(f++);i=e.charCodeAt(f++);s=n>>2;o=(n&3)<<4|r>>4;u=(r&15)<<2|i>>6;a=i&63;if(isNaN(r)){u=a=64}else if(isNaN(i)){a=64}t=t+this._keyStr.charAt(s)+this._keyStr.charAt(o)+this._keyStr.charAt(u)+this._keyStr.charAt(a)}return t},decode:function(e){var t="";var n,r,i;var s,o,u,a;var f=0;e=e.replace(/[^A-Za-z0-9+/=]/g,"");while(f<e.length){s=this._keyStr.indexOf(e.charAt(f++));o=this._keyStr.indexOf(e.charAt(f++));u=this._keyStr.indexOf(e.charAt(f++));a=this._keyStr.indexOf(e.charAt(f++));n=s<<2|o>>4;r=(o&15)<<4|u>>2;i=(u&3)<<6|a;t=t+String.fromCharCode(n);if(u!=64){t=t+String.fromCharCode(r)}if(a!=64){t=t+String.fromCharCode(i)}}t=Base64._utf8_decode(t);return t},_utf8_encode:function(e){e=e.replace(/rn/g,"n");var t="";for(var n=0;n<e.length;n++){var r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r)}else if(r>127&&r<2048){t+=String.fromCharCode(r>>6|192);t+=String.fromCharCode(r&63|128)}else{t+=String.fromCharCode(r>>12|224);t+=String.fromCharCode(r>>6&63|128);t+=String.fromCharCode(r&63|128)}}return t},_utf8_decode:function(e){var t="";var n=0;var r=c1=c2=0;while(n<e.length){r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r);n++}else if(r>191&&r<224){c2=e.charCodeAt(n+1);t+=String.fromCharCode((r&31)<<6|c2&63);n+=2}else{c2=e.charCodeAt(n+1);c3=e.charCodeAt(n+2);t+=String.fromCharCode((r&15)<<12|(c2&63)<<6|c3&63);n+=3}}return t}}

function validarEmail(email){
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

function confirmarAlteracaoDialogo(elemento){
    var campo = $("#"+elemento.attr("data-input-atrelada")),
        entrada = elemento.parents(".dialogoJanela").children(".entradaTexto").children().children("input");
        if(entrada.val().length > 0){
            campo.val(entrada.val());
        }
        campo.trigger("campo-alterado");
        elemento.closest(".dialogo").toggleClass("mostrar");
}

function mostrarCaixaDialogoAbrirLink(botoes,textoCancelar,tituloDialogo,textoDialogo){
    if($("#dialogoFuncao").length === 0){
        $("body").append("<div id=\"dialogoFuncao\" class=\"dialogo\"><div class=\"dialogoJanela cartao\"></div></div>");
    }
    var corpoDialogo = "<h2 class=\"dialogoTitulo\">"+tituloDialogo+"</h2>";
        corpoDialogo += "<div class=\"dialogoTexto\">"+textoDialogo+"</div>";
        corpoDialogo += "<div class=\"botaoPadrao dialogoBotoes alinharDireita\">";
        for(var i =0;i < botoes.length;i++){
            corpoDialogo += "<a href=\""+botoes[i].link+"\">"+botoes[i].txtBotao+"</a>";
        }
        corpoDialogo += "<a class=\"fecharDialogo\" href=\"javascript:void(0)\">"+textoCancelar+"</a></div>";
    $("#dialogoFuncao .dialogoJanela").html(corpoDialogo);
    $("#dialogoFuncao").addClass("mostrar");
}

function mostrarCaixaDialogoExcutarFuncao(botoes,textoCancelar,tituloDialogo,textoDialogo){
    /*
	botoes[{funcao:"minhafuncao",txtBotao:"meubotao",cancelar:"Cancelar"}];
    */	
    if($("#dialogoFuncao").length === 0){
        $("body").append("<div id=\"dialogoFuncao\" class=\"dialogo\"><div class=\"dialogoJanela cartao\"></div></div>");
    }
    var corpoDialogo = "<h2 class=\"dialogoTitulo\">"+tituloDialogo+"</h2>";
        corpoDialogo += "<div class=\"dialogoTexto\">"+textoDialogo+"</div>";
        corpoDialogo += "<div class=\"botaoPadrao dialogoBotoes alinharDireita\">";
        for(var i =0;i < botoes.length;i++){
            corpoDialogo += "<a data-funcao=\""+botoes[i].funcao+"\" href=\"javascript:void(0)\" class=\"executarFuncao\">"+botoes[i].txtBotao+"</a>";
        }
        corpoDialogo += "<a class=\"fecharDialogo\" href=\"javascript:void(0)\">"+textoCancelar+"</a></div>";
    $("#dialogoFuncao .dialogoJanela").html(corpoDialogo);
    $("#dialogoFuncao").addClass("mostrar");
}

function mostrarCaixaDialogoEntrada(textoOK,textoCancelar,tituloDialogo,labelEntrada,input){
    var valorOriginal = $("#"+input).val(),
        preenchida;
    if($("#dialogoEntrada").length === 0){
        $("body").append("<div id=\"dialogoEntrada\" class=\"dialogo\"><div class=\"dialogoJanela cartao\"></div></div>");
    }
    if(valorOriginal.length > 0){
        preenchida = "preenchida";
    }
    var corpoDialogo = "<h2 class=\"dialogoEntradaTitulo\">"+tituloDialogo+"</h2><br />";
        corpoDialogo += "<div class=\"entradaTexto\"><div class=\"campoDeTexto alturaAjustavel\">";
        corpoDialogo += "<input value=\""+valorOriginal+"\"class=\"dialogoEntradaTexto "+preenchida+"\" type=\"text\"  value=\"\" name=\"dialogoEntradaTexto\" maxlength=\"500\" autocomplete=\"off\"/>";
        corpoDialogo += "<label for=\"dialogoEntradaTexto\">"+labelEntrada+"</label><div></div></div></div>";
        corpoDialogo += "<div class=\"botaoPadrao dialogoBotoes alinharDireita\">";
        corpoDialogo += "<a class=\"confirmarAlteracao\" data-input-atrelada=\""+input+"\" href=\"javascript:void(0)\">"+textoOK+"</a><a class=\"fecharDialogo\" href=\"javascript:void(0)\">"+textoCancelar+"</a></div>";
    $("#dialogoEntrada .dialogoJanela").html(corpoDialogo);
    $("#dialogoEntrada").addClass("mostrar");
}

function alterarParametro(url, parametro, novoValor){
    if(novoValor === null){
        novoValor = '';
    }
    var pattern = new RegExp('\\b(' + parametro + '=).*?(&|#|$)');
    if(url.search(pattern)>=0){
        return url.replace(pattern,'$1' + novoValor + '$2');
    }
    url = url.replace(/[?#]$/,'');
    return url + (url.indexOf('?')>0 ? '&' : '?') + parametro + '=' + novoValor;
}

function atualizarDropdown(elem){
    elemPai = elem.parent().parent();
    elemPai.parent().children("button").text(elem.text());
    elem.parent().children("li").removeClass("ativo");
    elem.addClass("ativo");
    elemPai.parent().removeClass("mostrar");
    elemPai.parent().children("button").attr("value",elem.attr("id"));
    return false;
}

/*SEM USO*/
var recuperarParametros = function recuperarParametros(stringParametro) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        variaveisDaUrl = sPageURL.split('&'),
        nomeParametro, i;
    for (i = 0; i < variaveisDaUrl.length; i++) {
        nomeParametro = variaveisDaUrl[i].split('=');
        if (nomeParametro[0] === stringParametro) {
            return nomeParametro[1] === undefined ? true : nomeParametro[1];
        }
    }
};

$(document).ready(function() {
    $('#menuLateral > li > a[href="' + window.location.pathname + '"]').parent().addClass('ativo');
    
    $("#abrirNavegacao").on('click',function(){
       $("#menuDeNavegacao").toggleClass("ativa");
    });
    
    $("#abrirDetalhesUsuario").on('click',function(){
       $("#detalhesUsuario").toggleClass("ativo");
    });

    $('.campoDeTexto input, .caixaDeTexto textarea').each(function(){
        if( $(this).val().length > 0){
            $(this).addClass('preenchida');
        }
    });
 
    $('body').on('blur','.campoDeTexto input, .caixaDeTexto textarea',function(){
        if($(this).val()){
            $(this).addClass('preenchida');
        }else{
            $(this).removeClass('preenchida');
        }
        
    }).on('keydown','.campoDeTexto input[type="email"]',function(){
        if(validarEmail($(this).val()) === true){
            $(this).parent().addClass("campoValido");
        }else{
            $(this).parent().removeClass("campoValido");
        }
        
    }).on('click', '.botaoPadrao a', function(e) {
        if (e.target !== this) {
            return;
        }else {
            $(".onda").remove();
            var posicaoX = $(this).offset().left,
                posicaoY = $(this).offset().top,
                larguraBotao = $(this).width(),
                alturaBotao = $(this).height();
            $(this).prepend("<span class='onda'></span>");
            if (larguraBotao >= alturaBotao) {
                alturaBotao = larguraBotao;
            } else {
                larguraBotao = alturaBotao;
            }
            var x = e.pageX - posicaoX - larguraBotao / 2;
            var y = e.pageY - posicaoY - alturaBotao / 2;
            $(".onda").css({
                width: larguraBotao,
                height: alturaBotao,
                top: y + 'px',
                left: x + 'px'
            }).addClass("efeitoOnda");
        }
        
    }).on('click', '.dropdownPadrao', function() {
        $(this).toggleClass('mostrar');
        
    }).on('click', '.dropdownPadrao ul li', function() {
        $('.dropdownPadrao ul li').removeClass('selecionado');
        $(this).addClass('selecionado').parent().toggleClass('mostrar');;
        var cId = $('.selecionado').parents('.dropdownPadrao').attr('id');
        $('#' + cId + ' input').attr('value', $(this).attr('value'));
        $('#' + cId + ' .dropdownPadraoLegenda').html($(this).html());
        
    }).bind('click', function(e) {
        if ($(e.target).closest('#abrirDetalhesUsuario').length === 0 && $(e.target).closest('#detalhesUsuario').length === 0) {
            $('#detalhesUsuario').removeClass('ativo');
        }
        if ($(e.target).closest('#abrirNavegacao').length === 0 && $(e.target).closest('#menuDeNavegacao').length === 0) {
            $('#menuDeNavegacao').removeClass('ativa');
        }
        if ($(e.target).closest('.dropdownPadrao').length === 0) {
            $('.dropdownPadrao').removeClass('mostrar');
        }
        if($(e.target).closest('.dropdownNavegacao .dropdown').length === 0){
            $('.dropdownNavegacao .dropdown').removeClass('mostrar');
        }
        
    }).on('click','.fecharDialogo',function(){
        /* CAIXA DE DIALOGO */
       $(this).closest(".dialogo").toggleClass("mostrar");
       
    }).on('click','.deslogar',function(evento){
        evento.preventDefault();
        var botoes = [
            {
                link:$(this).attr("href"),
                txtBotao:"Sair"
            }
        ];
        mostrarCaixaDialogoAbrirLink(botoes,"Cancelar","Fazer Logoff","Tem certeza de que deseja sair?");
        
    }).on('click','.executarFuncao',function(){
       eval(Base64.decode($(this).attr("data-funcao")));
       $(this).closest(".dialogo").toggleClass("mostrar");
    }).on("click",".confirmarAlteracao",function(){
        confirmarAlteracaoDialogo($(this));
    }).on("click",".entradaTextoDialogo",function(){
        mostrarCaixaDialogoEntrada("OK","Cancelar",$(this).attr("data-titulo-dialogo"),$(this).attr("data-label-dialogo"),$(this).attr("id"));
    }).on("keypress",".dialogoEntradaTexto",function(elemento){
        if(elemento.keyCode == 13){
            $(this).parents(".dialogoJanela").children(".botaoPadrao").children(".confirmarAlteracao").click();
        }
    });
    
    /* DROPDOWN PADRAO */
    $('.dropdownPadrao ul li').each(function() {
        if ($(this).hasClass('selecionado')) {
            var cId = $('.selecionado').parents('.dropdownPadrao').attr('id');
            $('#' + cId + ' input').attr('value', $(this).attr('value'));
            $('#' + cId + ' .select-box-caption').html($(this).html());
        }
    });
    
    /* DROPDOWN COM NAVEGACAO */
    $(".dropdownNavegacao").on("click",".esquerda,.direita",function(){
        var elemento = $(this).parent(),
        id = elemento.children(".dropdown").children("button").attr("value"),
        proxItem = $("#"+id).next().attr("id"),
        itemAnterior = $("#"+id).prev().attr("id"),
        proximoBtn = elemento.children(".dropdownSetas.direita"),
        btnAnterior = elemento.children(".dropdownSetas.esquerda");
        if($("#"+proxItem).next().attr("id") === undefined){
            proximoBtn.prop("disabled",true);	
        }else{
            proximoBtn.prop("disabled",false);
        }
        if($("#"+itemAnterior).prev().attr("id") === undefined){
            btnAnterior.prop("disabled",true);	
        }else{
            btnAnterior.prop("disabled",false);
        }
        if(proxItem !== undefined && $(this).hasClass("direita")){
            atualizarDropdown($("#"+proxItem));
            btnAnterior.prop("disabled",false);
        }else{
            if(itemAnterior !== undefined && $(this).hasClass("esquerda")){
                atualizarDropdown($("#"+itemAnterior));
                proximoBtn.prop("disabled",false);
            }
        }
    });
    $(".dropdownNavegacao .dropdown").on("click","button",function(){
        var elem = $(this).parent();
        if(elem.hasClass("mostrar")){
            elem.removeClass("mostrar");
        }else{
            elem.addClass("mostrar");
        }
    }).on("click","ul li",function(){
        atualizarDropdown($(this));
        var elem = $(this).parent();
        if(elem.children("li").length !== 1){
            var elemPai = elem.parent().parent().parent(),
                proximoBtn = elemPai.children(".dropdownSetas.direita"),
                btnAnterior = elemPai.children(".dropdownSetas.esquerda");	
            if($(this).attr("id") === $("#"+elem.attr("id")+" li:last-child").attr("id")){
                proximoBtn.prop("disabled",true);
                btnAnterior.prop("disabled",false);
            }else{
                if($(this).attr("id") === $("#"+elem.attr("id")+" li:first-child").attr("id")){
                    btnAnterior.prop("disabled",true);
                    proximoBtn.prop("disabled",false);
                }else{
                    btnAnterior.prop("disabled",false);
                    proximoBtn.prop("disabled",false);
                }
            }
        }
    });
});

