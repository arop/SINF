# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

`
var base_url_primavera = 'http://localhost:49526/api'
var url_produto = 'http://localhost:3000/product/'
$(document).ready(function () {

		//fetch do Top
        var url_top = base_url_primavera + '/artigos/top/8';
        $('#top-container').html(botao_load);
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
            $('#top-container').html('');
            for(var  i in top){
                                
                var top_element = 
                    '<div class="col-md-3 col-sm-6 hero-feature">'+
                      '<div class="thumbnail">'+
                        '<img src="http://placehold.it/800x500" alt="">'+
                        '<div class="caption">'+
                          '<h4>'+top[i].DescArtigo+'</h4>'+
                          //'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>'+
                          '<h5>'+top[i].PVP+'€</h5>'+
                          '<p>'+
                            '<a href="'+url_produto+top[i].CodArtigo+'" class="btn btn-primary">Buy Now!</a>' + 
                            '<a href="'+url_produto+top[i].CodArtigo+'" class="btn btn-default">More Info</a>'+
                          '</p>'+
                        '</div>'+
                      '</div>'+
                    '</div>';
                $('#top-container').append(top_element);
            }
        },
        type: 'GET'
        });

});


`