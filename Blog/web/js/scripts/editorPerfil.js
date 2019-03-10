/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function atualizarCoordenadas(coordenadas){
    var botaoConfirmar = $("#confirmarCorteImagem button");
    if(botaoConfirmar.prop("disabled") === true){
        botaoConfirmar.prop("disabled",false);
    }
    $('#imagemPerfil_x').val(coordenadas.x);
    $('#imagemPerfil_y').val(coordenadas.y);
    $('#imagemPerfil_w').val(coordenadas.w);
    $('#imagemPerfil_h').val(coordenadas.h);
    mostrarPreview(coordenadas); 
};

function mostrarPreview(coordenadas){
    var imagem = document.getElementById("cortarImagemAlvo");
    var cx = 200 / coordenadas.w;
    var cy = 200 / coordenadas.h;
    $('#previewImagem').css({
        position: 'absolute',
        width: Math.round(cx * imagem.naturalWidth) + 'px',
        height: Math.round(cy * imagem.naturalHeight) + 'px',
        marginLeft: '-' + Math.round(cx * coordenadas.x) + 'px',
        marginTop: '-' + Math.round(cy * coordenadas.y) + 'px'
    });
};

function lerImagem(){
    if (this.files && this.files[0]) {
        $("#confirmarCorteImagem button").prop("disabled",true);
        var entrada = new FileReader();
        entrada.addEventListener("load", function(e) {
            
            var imagemAlvo = $('#cortarImagemAlvo');
            if (imagemAlvo.data('Jcrop')) {
                imagemAlvo.data('Jcrop').destroy();
            }
            $('#previewImagem').attr("src",e.target.result);
            $('#cortarImagem').addClass("mostrar");
            imagemAlvo.removeAttr('style')
                    .attr("src",e.target.result)
                    .Jcrop({
                aspectRatio: 1,
                boxWidth: 650,
                minSize: [200, 200],
                onChange: atualizarCoordenadas,
                onSelect: atualizarCoordenadas
            });
        });
        entrada.readAsDataURL( this.files[0] );
        var arquivoEntrada = document.getElementById('fotoUsuario');   
        var arquivoNome = arquivoEntrada.files[0].name;
        $("#imagemPerfil_extensao").val(arquivoNome.substr(arquivoNome.lastIndexOf('\\') + 1).split('.')[1]);
    }
};

function submeterFormulario(){
    document.getElementById("alterarPerfil").submit();
}

window.onload = function(){
    if($('#fotoUsuario')){
        $('#fotoUsuario').on('change',lerImagem);
        $('#confirmarCorteImagem').on('click',function(){
            $('#cortarImagem').removeClass("mostrar");
        });
    }
    $("body").on('click','#botaoAtualizarPerfil',function(evento){
        evento.preventDefault();
        var botoes = [
            {
                funcao:Base64.encode("submeterFormulario()"),
                txtBotao:"Atualizar Perfil"
            }
        ];
        mostrarCaixaDialogoExcutarFuncao(botoes,"Cancelar","Atualizar Perfil","Tem certeza de que deseja atualizar as informações do perfil?");
    });
};
