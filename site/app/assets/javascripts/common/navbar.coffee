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

            //verificar se está na pagina da categoria, para fazer highligh da categoria actual
            var id_categoria = null;
            var id_subcategoria = null;
            if($("#titulo-categoria").length){
                id_categoria = $("#titulo-categoria").attr("data-id-categoria");
                if($("#titulo-subcategoria").length){
                    id_subcategoria = $("#titulo-subcategoria").attr("data-id-subcategoria");
                }
            }

            //inserir categorias no html
            var categorias = $.parseJSON(data);
            $('#dropdown-ul').html('');
            for(var  i in categorias){
                var cat_link_id = "nav-categoria-" + categorias[i].CodCategoria;
                var collapse_id = "collapse-" + categorias[i].CodCategoria.replace(/\./g, '_');
                var class_cat = (categorias[i].SubCategorias == null)? "" : 'class="dropdown-submenu"';

                var collapse_open = false;
                if(id_categoria != null && id_categoria == categorias[i].CodCategoria)
                    collapse_open = true;

                var has_subcategorias = false;
                if(categorias[i].SubCategorias != null && categorias[i].SubCategorias.length > 0)
                    has_subcategorias = true

                $("#accordion-container").append(
                    '<div class="panel-heading">'
                        +'<h4 class="panel-title">'
                            +'<a href="/categoria/'+ categorias[i].CodCategoria+'">'+categorias[i].DescCategoria+'</a>'
                            +'<a class="pull-right" data-toggle="collapse" data-parent="#accordion-sidebar" href="#'+collapse_id+'" >'
                            +(has_subcategorias? '<span class="glyphicon glyphicon-plus"></span>' : '')
                            +'</a>'
                        +'</h4>'
                    +'</div>');

                //inserir subcategorias, caso existam
                if(has_subcategorias){

                    var collapsed_content = 
                            '<div id="'+collapse_id+'" class="panel-collapse collapse'+(collapse_open? " in " : "")+'">'+
                                '<div class="panel-body">'+
                                    '<table class="table">';

                    /*$('#'+cat_link_id).append('<ul class="dropdown-menu"></ul>');*/
                    for(var j in categorias[i].SubCategorias){
                        //verificar se subcategoria actual, para fazer highlight (strong)
                        var subcat_actual = false;
                        if(id_subcategoria != null && id_subcategoria == categorias[i].SubCategorias[j].CodCategoria)
                            subcat_actual = true;

                        collapsed_content = collapsed_content + '<tr><td>'+
                            '<a href="/categoria/'+categorias[i].CodCategoria+'/'+categorias[i].SubCategorias[j].CodCategoria+'">'+
                            (collapse_open && subcat_actual? '<strong>' : '') + categorias[i].SubCategorias[j].DescCategoria+(collapse_open && subcat_actual? '</strong>' : '')+'</a></td></tr>';
                    }
                    collapsed_content = collapsed_content + '</table></div></div>';
                    $("#accordion-container").append(collapsed_content);
                }
            }
        }
	});
});

`