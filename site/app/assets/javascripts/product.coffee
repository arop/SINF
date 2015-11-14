# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
`
var base_url_primavera = 'http://localhost:49526/api';

$(document).ready(function () {
	var id_produto = $("#prod-title").attr('data-id-product');

	getProduto(id_produto);
});


function getProduto(id){
	var url_prod = base_url_primavera + '/artigos/' + id;

	$.ajax({
        url: url_prod,
        dataType: 'json',
        type: 'GET',
        error: function(err) {
	        $("#prod-title").html('<h2>Problema ao obter produto, ou produto inexistente...</h2>');
            console.log("error fetching product");
            console.log(err);
        },
        success: function(data) {
            //var artigo_temp = $.parseJSON(data);
            //console.log(artigo_temp);

            $('#prod-title').html(data.DescArtigo);
            $('#prod-price').html(data.PVP+'€');
        }
	});
}
`