# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

`
var base_url_primavera = 'http://localhost:49526/api';
var url_produto = 'http://localhost:3000/product/'
var artigos = [];
console.log(encodeURIComponent('http://localhost:49526/api/categorias/subcategoria/H01.001'));
$(document).ready(function () {
		var id_categoria = $("#titulo-categoria").attr('data-id-categoria');
		
		var url_categoria = base_url_primavera + '/categorias/'+id_categoria;		

		$.ajax({
	        url: url_categoria,
	        error: function(err) {
	            console.log("error fetching category");
	            //console.log(err);
	            $("#titulo-categoria").html('<h2>Problema ao obter categoria, ou categoria inexistente...</h2>');
	        },
	        dataType: 'json',
	        success: function(data) {
	            //console.log("success.");
	            //console.log(data);
	            var categoria_temp = $.parseJSON(data);
	            var desc_categoria = categoria_temp.DescCategoria;
	            $("#titulo-categoria").html(desc_categoria);
	            getProdutosCategoria(id_categoria);
	            $('#artigos-container').html(botao_load);
	        },
	        type: 'GET'
		});
});

function getProdutosCategoria(id_cat){
	var url_prods_categoria = base_url_primavera + '/artigos/categoria/'+id_cat;
	$.ajax({
        url: url_prods_categoria,
        error: function(err) {
            console.log("error fetching products of categorie");
            console.log(err);
        },
        dataType: 'json',
        success: function(data) {
            //console.log("success.");
            //console.log(data);
            var artigos_temp = $.parseJSON(data);
            $('#artigos-container').html('');
            for(var  i in artigos_temp){
                artigos[artigos_temp[i].CodArtigo] = artigos_temp[i];       
                var top_element = 
                    '<div class="col-md-3 col-sm-6 hero-feature">'+
                      '<div class="thumbnail">'+
                        '<img src="http://placehold.it/800x500" alt="">'+
                        '<div class="caption">'+
                          '<h4>'+artigos_temp[i].DescArtigo+'</h4>'+
                          '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>'+
                          '<h4>'+artigos_temp[i].PVP+'€</h4>'+
                          '<p>'+
                            '<a href="'+url_produto+artigos_temp[i].CodArtigo+'" class="btn btn-primary">Buy Now!</a>'+ 
                            '<a href="'+url_produto+artigos_temp[i].CodArtigo+'" class="btn btn-default">More Info</a>'+
                          '</p>'+
                        '</div>'+
                      '</div>'+
                    '</div>';
                $('#artigos-container').append(top_element);
            }
        },
        type: 'POST'
	});
}

`