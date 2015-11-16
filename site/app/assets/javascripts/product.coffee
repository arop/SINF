# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
`
var base_url_primavera = 'http://localhost:49526/api';
var url_categoria = 'http://localhost:3000/categoria/';
var url_subcategoria = 'http://localhost:3000/subcategoria/';

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
            $('#prod-title').html(data.DescArtigo);
            var price = data.PVP;
            if(data.Moeda == 'EUR') price+='€'; 
            else price+='$';
            $('#prod-price').html(price);
            $('#prod-categoria em').html(data.CategoriaDesc);
            $('#prod-categoria').attr('href',url_categoria + data.Categoria);
            if(data.SubCategoriaDesc != null) {
            	$('#prod-subcategoria').before(' / ');
            	$('#prod-subcategoria em').html(data.SubCategoriaDesc);
            	$('#prod-subcategoria').attr('href',url_subcategoria + data.SubCategoria);
            }
        }
	});
}
`