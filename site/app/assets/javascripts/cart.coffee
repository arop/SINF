# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

`
var artigos_carrinho = [];
$(document).ready(function(){
    var carrinho = {};
    var lista = new Array();

    $(".remove-from-carrinho").click(function() {
        removeFromCarrinho($(this).attr('id').split('-')[1]);
    });

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
                        artigos_carrinho[artigos_temp[i].CodArtigo] = artigos_temp[i];
                        var parent_selector = "#artigo-"+artigos_temp[i].CodArtigo;
                        parent_selector = parent_selector.replace(/\./g, '_'); //pontos nos ids não funcionam...
                        console.log(parent_selector);
                        
                        var preco_iva = artigos_temp[i].PVP*(1+artigos_temp[i].IVA/100.0);

                        console.log(artigos_temp[i]);
                        $(parent_selector+" .descricao").html(artigos_temp[i].DescArtigo);
                        $(parent_selector+" .pvp").html(preco_iva.toFixed(2)+'€');
                        var quantidade = parseInt($(parent_selector+" .quantidade input").val());
                        $(parent_selector+" .total").html((preco_iva*quantidade).toFixed(2)+'€');
                        $(parent_selector+' input[name="preco[]"]').val(artigos_temp[i].PVP);
                    }

                    var total = 0;
                    $(".total").each(function(){
                        var string_temp = $(this).html();
                        console.log(string_temp);
                        string_temp = string_temp.substring(0, string_temp.length - 1);
                        //console.log(string_temp);
                        total += parseFloat(string_temp);
                    })
                    $("#total-carrinho").html(total.toFixed(2)+"€"); 
                    $("#finazalizar-btn").removeAttr("disabled");
                    //sendDocVenda();
                }
                else {
                    console.log("msg not good in send docVenda");
                }
            }
        });
    }

    $("#finazalizar-btn").click(function(e){
        e.preventDefault();
        $(this).attr("disabled", "disabled");
        $("#form-carrinho").submit();
    });

    $("#clear-cart").click(function(){
        $.ajax({
            type: "GET",
            url: '/carrinho/limpar',
            crossDomain: true,
            error: function (err) {
                console.log(err);
            },
            success: function (msg) {
                if (msg) {           
                    console.log(msg);
                    location.reload();
                }
                else {
                    console.log("msg not good in clear cart");
                }
            }
        });
    });
    /*$('#form-carrinho').submit(function() {
        $("#form-carrinho tbody tr").each(function(){
            //console.log(a);
        });
        return true;
    });*/

    

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

function removeFromCarrinho(id) {
    $.ajax({
        type: "DELETE",
        url: '/carrinho/single/'+id,
        error: function (xhr, status, error) {
            console.log("Error: " + xhr);
            console.log(xhr);
            console.log(xhr.responseText);
            console.log("Error: " + status);
            console.log("Error: " + error);
        },
        success: function (data) {
            if(data.success == "true")
                $("tr#artigo-"+id).remove();
        }
    });
}

`
