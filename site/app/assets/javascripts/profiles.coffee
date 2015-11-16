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

            $('#compras-container').html('<table id="tabela-principal" class="table table-condensed" style="border-collapse:collapse; width: 50%">'+
                '<tr><th>Data</th><th>Total </th></tr></table>');
            for(var  i in artigos_temp){
                artigos[artigos_temp[i].CodArtigo] = artigos_temp[i];

                var m = re.exec(artigos_temp[i].Data);
                var d = new Date(parseInt(m[0]));
                var top_element = 
                '<tr data-toggle="collapse" data-target="#hidden-' + i + '" class="accordion-toggle show-order" id="' +  artigos_temp[i].id + '">'+
                '<td  bgcolor="#8c8c8c">'+ d.format("dd/mm/yyyy") +'</td>'+
                '<td  bgcolor="#8c8c8c">'+artigos_temp[i].TotalMerc+' €</td>'+
                '</tr>'+
                '<tr>'+
                '<td colspan="2" class="hiddenRow"><div class="accordian-body collapse" id="hidden-' +
                i + '">' +
                '<table id="tabela-produtos-' + artigos_temp[i].id.slice(1,-1) + '" class="table">' + 
                '<tr> <th bgcolor="#d3d3d3"> Nome </th> <th bgcolor="#d3d3d3"> Preço </th> <th bgcolor="#d3d3d3"> Quantidade </th> </tr></table> </div> </td></tr>';

                $('#tabela-principal').append(top_element);
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
                                '<td>'+artigos_temp[i].DescArtigo+'</td>'+
                                '<td>'+artigos_temp[i].PrecoUnitario+'</td>'+
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