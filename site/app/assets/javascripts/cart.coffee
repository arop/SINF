# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

`
$(document).ready(function(){
    var carrinho = {};
    var lista = new Array();

    $(".codigo-artigo-cart").each(function(){
        lista.push($(this).html());
    });

    carrinho.Produtos_id = lista;

    $.ajax({
        type: "POST",
        url: 'http://localhost:49526/api/carrinho',
        crossDomain: true,
        data: carrinho,
        error: function (xhr, status, error) {
            console.log("Error: " + xhr);
            console.log(xhr);
            console.log("Error: " + status);
            console.log("Error: " + error);
        },
        success: function (msg) {
            if (msg) {           
            	console.log(msg);
            }
            else {
                console.log("msg not good in send docVenda");
            }
        }
    });
});
`
