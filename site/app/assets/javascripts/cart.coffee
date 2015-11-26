# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

`
$(document).ready(function(){
    var carrinho = {};
    var lista = new Array();

    if($(".codigo-artigo-cart").length){
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
                    var artigos_temp = $.parseJSON(msg);
                    for(var i in artigos_temp){
                        var parent_selector = "#artigo-"+artigos_temp[i].CodArtigo;
                        
                        $(parent_selector+" .descricao").html(artigos_temp[i].DescArtigo);
                        $(parent_selector+" .pvp").html(artigos_temp[i].PVP+'€');
                        var quantidade = parseInt($(parent_selector+" .quantidade").html());
                        $(parent_selector+" .total").html(parseFloat(artigos_temp[i].PVP)*quantidade+'€');
                    }

                    var total = 0;
                    $(".total").each(function(){
                        var string_temp = $(this).html();
                        console.log(string_temp);
                        string_temp = string_temp.substring(0, string_temp.length - 1);
                        console.log(string_temp);
                        total += parseFloat(string_temp);
                    })
                    $("#total-carrinho").html(total+"€"); 

                    //sendDocVenda();
                }
                else {
                    console.log("msg not good in send docVenda");
                }
            }
        });
    }

    

});

function sendDocVenda(){
	
	var linhasDocVenda = [];

	var docVenda = {};
    docVenda.LinhasDoc = linhasDocVenda;
    //docVenda.Entidade = cliente['CodCliente'];
    docVenda.Serie = "C";

	$.ajax({
	    type: "POST",
	    url: '/carrinho',
	    crossDomain: true,
	    data: docVenda,
	    error: function (xhr, status, error) {
	        console.log("Error: " + xhr);
	        console.log(xhr);
	        console.log(xhr.responseText);
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
}
`
