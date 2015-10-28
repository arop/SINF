var categorias = [];
var artigos = [];
var carrinho = [];
var clientes = [];
var cliente;

$(document).ready(function () {
    
    $('#formNovoArtigo').submit(submitNewProduct);
    
});

function newProduct(artigo) {
    //get products of category

    var url = 'http://localhost:49526/api/artigos/novo';

    $.ajax({
        type: "POST",
        url: url,
        data: artigo,
        dataType: "json",
        crossDomain: true,

        error: function (xhr, status, error) {
            console.log("Error: " + error);
            //artigos = "erro";
        },

        success: function (msg) {
            if (msg) {
                console.log(msg);
            }
        }
    });
}

function submitNewProduct(e) {
    e.preventDefault();

    var artigo = {};
    artigo.id = 'hardcoded';
    artigo.description = $("#formNovoArtigo input[name='descArtigo']").val();
    artigo.pvp = $("#formNovoArtigo input[name='pvpArtigo']").val();
    artigo.marca = $("#formNovoArtigo input[name='marcaArtigo']").val();
    artigo.modelo = $("#formNovoArtigo input[name='modeloArtigo']").val();
    artigo.peso = $("#formNovoArtigo input[name='pesoArtigo']").val();
    artigo.unidade = 'UNIDADE';

    newProduct(artigo);
}