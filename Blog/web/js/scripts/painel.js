/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function verificarTela(){
    if($(window).width() < 800){
        $("#menuPainel").addClass("menuLateral");
        $(".menuPadrao").addClass("barraLateral");
    }else{
        $("#menuPainel").removeClass("menuLateral");
        $(".menuPadrao").removeClass("barraLateral");
        $("#menuPainel").show();
    }
}

$(document).ready(function() {
    if($(window).width() < 800){
        $("#menuPainel").hide();
    }
    verificarTela();
    $(window).resize(verificarTela);
        $("body").on("click",".mostrarSideNav,.menuPadrao li a",function(){
        $("#menuPainel").show().toggleClass("mostrar");
    });
    $("#menuPainel").bind('click', function(e) {
        if ($(e.target).closest('#menuLateral').length === 0){
            $(this).removeClass("mostrar");
        }
    });
    $(window).resize(verificarTela).scroll(function(){
        if(window.scrollY > 260){
            $(".cabecalhoEscondido").addClass("mostrar");
        }else{
            $(".cabecalhoEscondido").removeClass("mostrar");
        }
    });
});
