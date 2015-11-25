# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

`
var base_url_primavera = 'http://localhost:49526/api';
var url_produto = 'http://localhost:3000/product/'
var artigos = [];
var is_subcategoria = false;
$(document).ready(function () {

	$('#artigos-container').html(botao_load);

	var id_categoria = $("#titulo-categoria").attr('data-id-categoria');
	var url_categoria = base_url_primavera + '/categorias/'+id_categoria;

	var id_subcategoria = null;
	var url_subcategoria = null;
	var subcategoria = $("#titulo-subcategoria");
	if(subcategoria.length){
		is_subcategoria = true;
		id_subcategoria = subcategoria.attr('data-id-subcategoria');
		url_subcategoria = base_url_primavera + '/categorias/subcategoria/' + id_subcategoria;
	}
	
	$.ajax({
		type: 'GET',
        url: url_categoria,
        error: function(err) {
            console.log("error fetching category");
            $("#titulo-categoria").html('erro');
        },
        dataType: 'json',
        success: function(data) {
            var categoria_temp = $.parseJSON(data);
            var desc_categoria = categoria_temp.DescCategoria;
            $("#titulo-categoria").html(desc_categoria);
            if (!is_subcategoria)
                getProdutosCategoria(id_categoria);
            
        }
	});

	if(is_subcategoria){
		$.ajax({
			type: 'GET',
	        url: url_subcategoria,
	        error: function(err) {
	            console.log("error fetching subcategory");
	            $("#titulo-subcategoria").html('erro');
	        },
	        dataType: 'json',
	        success: function(data) {
	            var categoria_temp = $.parseJSON(data);
	            var desc_categoria = categoria_temp.DescCategoria;
	            $("#titulo-subcategoria").html(desc_categoria);
	            getProdutosCategoria(id_subcategoria);
	        }
		});
	}	

});

function getProdutosCategoria(id_cat){
	var url_prods_categoria = null;
	if(is_subcategoria)
		url_prods_categoria = base_url_primavera + '/artigos/subcategoria/'+id_cat;
	else url_prods_categoria = base_url_primavera + '/artigos/categoria/'+id_cat;
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
            if(artigos_temp.length == 0)
            	$('#artigos-container').append('<i>Não existem artigos nesta categoria...</i>');
            else
	            for(var  i in artigos_temp){
	                artigos[artigos_temp[i].CodArtigo] = artigos_temp[i];       
	                var top_element = getProductContainer2(artigos_temp[i], null);//utilities.coffee
	                $('#artigos-container').append(top_element);
	                
	                getImageFromProduct(artigos_temp[i].CodArtigo);
	            }
        },
        type: 'POST'
	});
}

`