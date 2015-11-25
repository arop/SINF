# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

`
var base_url_primavera = 'http://localhost:49526/api'
var url_produto = 'http://localhost:3000/product/'
$(document).ready(function () {

		//fetch do Top
        var url_top = base_url_primavera + '/artigos/top/9';
        $('#artigos-container').html(botao_load);
        $.ajax({
        url: url_top,
        error: function(err) {
            console.log("error fetching top.");
            console.log(err);
        },
        dataType: 'json',
        success: function(data) {
            //console.log("success.");
            //console.log(data);
            var top = $.parseJSON(data);
            $('#artigos-container').html('');
            for(var  i in top){
                var top_element = getProductContainer2(top[i], null);
                $('#artigos-container').append(top_element);

                getImageFromProduct(top[i].CodArtigo);
            }
        },
        type: 'GET'
        });

});

`