# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

`
var base_url_primavera = 'http://localhost:49526/api';
//var url_produto = 'http://localhost:3000/product/'
var artigos = [];

$(document).ready(function () {
	getProdutosCliente($('#user-id').html());
});

function getProdutosCliente(id_cliente){
	var url_prods_cliente = base_url_primavera + '/clientes/'+ id_cliente + '/encomendas';
	
    var re = /-?\d+/;
 
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

            $('#compras-container').html('<table class="table" style="width: 50%; align:left"><tr><th>Data</th><th> Nº produtos</th> <th>Total </th></tr></table>');
            for(var  i in artigos_temp){
                artigos[artigos_temp[i].CodArtigo] = artigos_temp[i];
              

                var m = re.exec(artigos_temp[i].Data);
                var d = new Date(parseInt(m[0]));

                var top_element = 
                    '<tr>'+
                          '<td>'+ d.format("dd/mm/yyyy") +'</td>'+
                            '<td>'+ artigos_temp[i].NumDoc +'</td>'+
                          '<td>'+artigos_temp[i].TotalMerc+'€</td>'+

                        //  '<td> href="'+url_produto+artigos_temp[i].CodArtigo+'" class="btn btn-primary">Buy Now!</td>'+ 
                    '</tr>';
                $('#compras-container table').append(top_element);
            }

        },
        type: 'GET'
	});
}




`