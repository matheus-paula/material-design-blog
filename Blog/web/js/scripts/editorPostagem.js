/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function validarCampos(){
    if($("#linkPermanente").length){
        if($("#tituloPost").val().length > 0
            && $("#linkPermanente").val().length > 0
            && $("#editorDeTexto").val().length > 0){
            return true;
        }else{
            return false;
        }
    }else{
        if($("#tituloPost").val().length > 0
            && $("#editorDeTexto").val().length > 0){
            return true;
        }else{
            return false;
        }
    }
}

function obterArrayDeTags(id){
    var tagsPost = document.getElementById(id);
    var tags = tagsPost.value;
    tags = tags.substring(0,tags.lastIndexOf(","));
    var listaTags = tags.split(",");
    for(var i = 0; i < listaTags.length;i++){
        listaTags[i] = listaTags[i].trim();
    }
    return listaTags; 
}

function filtrarTextoURL(texto){
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

/* CORRIGE FORMATAÇÃO SEPARADA POR VIRGULAS DAS TAGS*/
function ajustarTags(tags){
    var temp = tags.split(","),
        temp2 = new Array();
    for(var i = 0;i < temp.length;i++){
        if(temp[i].trim().length !== 0){
            temp2.push(temp[i]);
        }
    }
    return temp2.join(",") + ", ";
}

function adicionarImagemDestacada(){
    if (this.files && this.files[0]) {
        var entrada = new FileReader(),
            imagemAlvo = document.getElementById("imagemDestaque"),
            removerImagem = document.getElementById("removerImagemDestaque");
        removerImagem.disabled = false;
        entrada.addEventListener("load", function(e) {
            imagemAlvo.classList.remove('semImagem');
            imagemAlvo.src = e.target.result;
        });
        entrada.readAsDataURL( this.files[0] );
        var arquivoNome = this.files[0].name;
        $("#imagemDestaqueExtensao").val(arquivoNome.substr(arquivoNome.lastIndexOf('\\') + 1).split('.')[1]);
    }
}

window.onload = function(){    
    var tagsPost = document.getElementById("tagsPost"),
        usarLinkPersonalizado = document.getElementById("linkPermanentePersonalizado"),
        linkPermanente = document.getElementById("linkPermanente"),
        titulo = document.getElementById("tituloPost"),
        removerImagem = document.getElementById("removerImagemDestaque"),
        botaoImagemDestaque = document.getElementById("botaoImagemDestaque");

    /* ADICIONA IMAGEM DESTACADA NA PAGINA */
    botaoImagemDestaque.addEventListener("change",adicionarImagemDestacada);
    
    /* REMOVE IMAGEM DESTACADA ADICIONADA */
    removerImagem.addEventListener("click",function(){
        var botaoImagem = document.getElementById("botaoImagemDestaque"),
        imagemDestaque = document.getElementById("imagemDestaque"),
        removerAnterior = document.getElementById("removerImgDestaqueAnterior");
        if(removerAnterior !== null){
            removerAnterior.value="S";
        }
        this.disabled = true;
        botaoImagem.value = "";
        imagemDestaque.src = "";
        imagemDestaque.className = 'semImagem';
    });
    
    /* ADICIONA TITULO DIGITADO COMO LINK PERMANENTE DA POSTAGEM */
    if(usarLinkPersonalizado !== null){
        titulo.addEventListener("keyup", function() {
            if (usarLinkPersonalizado.checked === false) {
                if(titulo.value.length > 0){
                    linkPermanente.className = 'preenchida desabilitado';
                    linkPermanente.value = filtrarTextoURL(titulo.value);
                }else{
                    linkPermanente.classList.remove('preenchida');
                    linkPermanente.value = "";
                }     
            }
        });
        linkPermanente.addEventListener("keyup", function() {
            if (usarLinkPersonalizado.checked === true) {
                linkPermanente.value = filtrarTextoURL(linkPermanente.value);  
            }
        });
    }
    
    /* ADICIONA VÍRGULA PARA CADA ENTER PRESSIONADO, SEPARANDO TAGS INSERIDAS */
    tagsPost.addEventListener("keydown", function(evento) {
        if (evento.keyCode === 13) {
            tagsPost.value = tagsPost.value + ", ";
            evento.preventDefault();
        }
    });
    
    tagsPost.addEventListener("keyup", function(evento) {
        if (evento.keyCode === 13) {
            tagsPost.value = ajustarTags(tagsPost.value);
            evento.preventDefault();
        }
    });
    /* HABILITA/DESABILITA USO DO LINK PERMANENTE PERSONALIZADO */
    if(usarLinkPersonalizado !== null){
        usarLinkPersonalizado.addEventListener("change", function() {
            if (usarLinkPersonalizado.checked) {
                linkPermanente.classList.remove("desabilitado");
                linkPermanente.focus();
            }else{
                linkPermanente.className = "desabilitado";
            }
            if(linkPermanente.value.length > 0){
                linkPermanente.className = 'preenchida';
            }else{
                linkPermanente.classList.remove("preenchida");
            }
        });
    }
    
    $("body").on("click",".publicar button",function() {
        /* SUBMETER RASCUNHO VIA AJAX */
        if(validarCampos() === true){
            var acao = $(this).val();
            if(acao === "S"){
                $("#botaoRascunho").prop("disabled",true);
                $(this).text("Publicando...").prop("disabled",true);
            }else{
                $("#botaoPublicar").prop("disabled",true);
                $(this).text("Salvando...").prop("disabled",true);
            }
            $("#statusPublicacao").val(acao);
            var formulario = $("#publicarPost")[0]; 
            var dados = new FormData(formulario);
            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                processData: false,
                contentType: false,
                cache: false,
                url: window.location.href,
                data: dados,
                success: function(){
                    window.open("/painel/postagens?tipo=todas","_self");
                },
                error: function(x){
                    $(".publicar button").prop("disabled",false);
                    $("#botaoPublicar").text("Publicar");
                    $("#botaoRascunho").text("Salvar como rascunho");
                    var botoes = [];
                    mostrarCaixaDialogoExcutarFuncao(botoes,"OK","Erro na publicação","Um erro inesperado ocorreu durante a publicação da postagem, tente novamente mais tarde!");
                }
            });
        }else{
            var botoes = [];
            mostrarCaixaDialogoExcutarFuncao(botoes,"OK","Postagem incompleta","São necessários ao menos um título e algum texto para ser possível salvar ou publicar a postagem!");
        }
        return false;
        
    }).on("click",".mostrarOpcao",function(){
        $(this).next().css("height",$(this).next().children().outerHeight());
        $("#configuracoesDaPostagem .opcao").addClass("opcaoOculta");
        $(this).next().toggleClass("opcaoOculta");
    }).on("click","#navegacaoVoltar",function(){
        window.history.back();
    });
};
