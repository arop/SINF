# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

`
var base_url_primavera = 'http://localhost:49526/api';
//var url_produto = 'http://localhost:3000/product/'
var artigos = [];

$(document).ready(function () {
	window.alert($('#user-id').html());
	getProdutosCliente($('#user-id').html());
});

function getProdutosCliente(id_cliente){
	var url_prods_cliente = base_url_primavera + '/clientes/'+ id_cliente + '/encomendas';
	
	window.alert(url_prods_cliente);

	$.ajax({
        url: url_prods_cliente,
        error: function(err) {
            console.log("error fetching products of client");
            console.log(err);
        },
        dataType: 'json',
        success: function(data) {
            //console.log("success.");
            //console.log(data);
            var artigos_temp = $.parseJSON(data);
            $('#compras-container').html('<table style="width: 60%"><tr><th> Data </th> <th> Total </th></tr>');
            for(var  i in artigos_temp){
                artigos[artigos_temp[i].CodArtigo] = artigos_temp[i];       
                var top_element = 
                    '<tr>'+
                          '<td>'+artigos_temp[i].Data+'</td>'+
                          '<td>'+artigos_temp[i].TotalMerc+'€</td>'+
                        //  '<td> href="'+url_produto+artigos_temp[i].CodArtigo+'" class="btn btn-primary">Buy Now!</td>'+ 
                    '</tr>';
                $('#compras-container').append(top_element);
            }

           $('#compras-container').append('</table>');

        },
        type: 'GET'
	});
}

`