# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
`
var base_url_primavera = 'http://localhost:49526/api'
var url_produto = 'http://localhost:3000/product/'
$(document).ready(function () {

	var search_query = $("#search-input").val();

	if(search_query){
	    var url_search = base_url_primavera + '/pesquisa/artigos/'+search_query;
	    $('#artigos-container').html(botao_load);
	    $.ajax({
		    type: 'GET',
		    url: url_search,
		    error: function(err) {
		        console.log("error in search.");
		        console.log(err);
		    },
		    dataType: 'json',
		    success: function(data) {
		        //console.log(data);
		        var result = $.parseJSON(data);
		        $('#artigos-container').html('');
		        if (result.length == 0){
					$('#artigos-container').html('A pesquisa não retornou quaisquer resultados...');
		        }
			    else
			        for(var  i in result){
			            var prod = getProductContainer2(result[i], null);
			            $('#artigos-container').append(prod);
			            getImageFromProduct(result[i].CodArtigo);
			        }
		    }
		});
	}
	else $('#artigos-container').html('Para pesquisar utilize o campo na barra superior.');
    

});



`