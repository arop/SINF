# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

`
var base_url_primavera = 'http://localhost:49526/api';
//var url_produto = 'http://localhost:3000/product/'
var artigos = [];

$(document).ready(function () {
	getProdutosCliente($('#user-id').html());
});

function getProdutosCliente(id_cliente){
	var url_prods_cliente = base_url_primavera + '/clientes/'+ id_cliente + '/encomendas';
	
    var re = /-?\d+/;

    $.ajax({
        url: url_prods_cliente,
        error: function(err) {
            console.log("error fetching products of client");
            console.log(err);
        },
        dataType: 'json',
        success: function(data) {
            console.log(data);
            var artigos_temp = $.parseJSON(data);

            for(var  i in artigos_temp){
                artigos[artigos_temp[i].CodArtigo] = artigos_temp[i];
                var m = re.exec(artigos_temp[i].Data);
                var d = new Date(parseInt(m[0]));
                $('#compras-container').append(''+
                '<div class="panel panel-default">' +
              '<div class="panel-heading" style="background-color: rgb(255, 141, 52) !important; color: white" role="tab" id="heading-'+i + '">'+
                '<h4 class="panel-title">'+
                  '<a id="' +  artigos_temp[i].id + '" class="collapsed show-order" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse-' + i + '" aria-expanded="false" aria-controls="collapse-' + i + '">'+
                    '<div class="row">'+ 
                        '<div class="col-lg-4">' + artigos_temp[i].NumDoc + '/' + artigos_temp[i].Serie +'</div>'+
                        '<div class="col-lg-4">' + d.format("dd/mm/yyyy") + '</div>'+
                        '<div class="col-lg-4">' + artigos_temp[i].TotalMerc.toFixed(2) + ' €</div>'+
                    '</div>'+
                  '</a>'+
                '</h4>'+
              '</div>'+
              '<div id= "collapse-' + i + '" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading-' + i + '">'+
                '<div id="pergunta-'+i + '" class="panel-body">'+
                  '<table style="text-align: left" id="tabela-produtos-' + artigos_temp[i].id.slice(1,-1) + '" class="table table-hover table-striped">' +
                '<tr> <th class="col-xs-8"> Nome </th> <th class="col-xs-2"> Preço </th> <th class="col-xs-2"> Quantidade </th> </tr></table> </div> </td></tr>'+
                '</div>'+
              '</div>'+
            '</div></div>');

            }
 


            $('.show-order').on("click",function() {
                if(!$(this).hasClass('alreadyloaded')){
                    var idEncomenda = $(this).attr('id');
                    var idParentDiv = idEncomenda.slice(1, -1);

                    var this_element = $(this);
                    var url_prods_encomenda = base_url_primavera + '/clientes/'+ id_cliente + '/encomenda/' + idEncomenda;

                    $.ajax({
                        url: url_prods_encomenda,
                        error: function(err) {
                            console.log("error fetching products of this encomenda");
                            console.log(err);
                        },
                        dataType: 'json',
                        success: function(data) {
                            var artigos_temp = $.parseJSON(data).LinhasDoc;
                            var id_temp = "#"+idParentDiv;    

                            for(var  i in artigos_temp){
                                artigos[artigos_temp[i].CodArtigo] = artigos_temp[i];

                                var top_element = 
                                '<tr id="' +  artigos_temp[i].id + '">'+
                                '<td>'+ '<a href="/product/' + artigos_temp[i].CodArtigo + '"> ' + artigos_temp[i].DescArtigo+'</a></td>'+
                                '<td>'+artigos_temp[i].TotalLiquido.toFixed(2)+'€</td>'+
                                '<td>'+artigos_temp[i].Quantidade+'</td>'+
                                '</tr>';
                                $('#tabela-produtos-' + idParentDiv).append(top_element);
                                this_element.addClass('alreadyloaded');
                            }

                        },
                        type: 'GET'
                    });


                }
            });
            
    },
    type: 'GET'
});


}




`