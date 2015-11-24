`
var base_url_primavera = 'http://localhost:49526/api'
var url_produto = 'http://localhost:3000/product/'
$(document).ready(function () {
	var url_categorias = base_url_primavera + '/categorias';
	$.ajax({
        url: url_categorias,
        dataType: 'json',
        type: 'POST',
        error: function(err) {
            console.log("error fetching categories");
            console.log(err);
        },
        success: function(data) {
            var categorias = $.parseJSON(data);
            $('#dropdown-ul').html('');
            for(var  i in categorias){
                var cat_link_id = "nav-categoria-" + categorias[i].CodCategoria;
                var class_cat = (categorias[i].SubCategorias == null)? "" : 'class="dropdown-submenu"';

                $('#dropdown-ul').append('<li '+class_cat+'id="'+cat_link_id+'"><a href="/categoria/'+
                    categorias[i].CodCategoria+'">'+categorias[i].DescCategoria+'</a></li>')
                if(categorias[i].SubCategorias != 'null'){
                    $('#'+cat_link_id).append('<ul class="dropdown-menu"></ul>');
                    for(var j in categorias[i].SubCategorias)
                        $('#'+cat_link_id+' ul').append('<li><a href="/categoria/'+
                            categorias[i].CodCategoria+'/'+
                        categorias[i].SubCategorias[j].CodCategoria+'">'+categorias[i].SubCategorias[j].DescCategoria+'</a></li>');
                }
            }
        }
	});
});

`