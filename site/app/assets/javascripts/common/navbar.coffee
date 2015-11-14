`
var base_url_primavera = 'http://localhost:49526/api'
var url_produto = 'http://localhost:3000/product/'
$(document).ready(function () {
		var url_categorias = base_url_primavera + '/categorias';
		$.ajax({
        url: url_categorias,
        error: function(err) {
            console.log("error fetching categories");
            console.log(err);
        },
        dataType: 'json',
        success: function(data) {
            //console.log("success.");
            //console.log(data);
            var categorias = $.parseJSON(data);
            $('#dropdown-ul').html('');
            for(var  i in categorias){
                $('#dropdown-ul').append('<li><a href="/categoria/'+
                    categorias[i].CodCategoria+'">'+categorias[i].DescCategoria+'</a></li>')
            }
        },
        type: 'POST'
		});


        var url_categorias = base_url_primavera + '/artigos/top/8';
        $('#top-container').html(botao_load);
        $.ajax({
        url: url_categorias,
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