# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



`
var base_url_primavera = 'http://localhost:49526/api';
var encomendas_pendentes = [];

$(document).ready(function () {

	encomendas();
	produtos();

	$("#data-encomendas-botao").click(encomendas);
});

function encomendas () {
	$("#encomendas tbody").html(botao_load);

	var mes = $("#data-encomendas-mes option:selected").val();
	var ano = parseInt($("#data-encomendas-ano").val());
	if (ano < 1950 || ano > 2100 || mes < 1 || mes > 12){
		$("#encomendas tbody").html("Mês ou ano inválidos...");
		return;
	}

	var url_encomendas = base_url_primavera + '/docvenda/'+ano+'/'+mes;	
	$.ajax({
		url: url_encomendas,
		error: function(err) {
			console.log("error fetching category");
			$("#encomendas tbody").html('');
		},
		dataType: 'json',
		success: function(data) {
        	$("#loading_1").remove();
        	var table = $("#encomendas tbody"); 
        	table.html('');
            var arrayProdutos=[];
            try{   
            	if(data.length == 0)
            		table.html('<tr><td /><td><i>Não existem encomendas para o período selecionado...</i></td></tr>');
            	else
	            	for(var i in data){
	            		var data_array=(""+data[i]['Data']).split("-");

	            		var tr = $('<tr></tr>');
	            		tr.append('<td>'+data[i]['Entidade']+'</td>');
	            		tr.append('<td><a href="encomenda/'+data[i]['NumDoc']+'">'+data[i]['NumDoc']+'</a></td>');
	            		tr.append('<td>'+data_array[0]+"-"+data_array[1]+"-"+data_array[2].split("T")[0]+'</td>');
	            		tr.append('<td>'+'Estado'+'</td>');
	            		tr.append('<td>'+data[i]['TotalMerc']+' €</td>');
	            		//tr.append('<td>'+'<button data-id-doc="'+data[i]['NumDoc']+'" class="btn btn-success btn-facturar">Facturar</button>'+'</td>');
	            		table.append(tr);
	            	}
            }
            catch(e){
            	console.log(e);
            }
        },
	    type: 'GET'
	});
}

function produtos () {

	var url_encomendas = base_url_primavera + '/artigos/top/10';	
	$("#loading_2").html(botao_load);	

	$.ajax({
		url: url_encomendas,
		error: function(err) {
			console.log("error fetching product");
			$("#loading_2").remove();
		},
		dataType: 'json',
		success: function(data) {
			$("#loading_2").remove();
            //console.log(data);
            data=$.parseJSON(data);
            console.log(data);
            var table = $("#produto_tabela tbody"); 
             try{    
            	for(var i in data){
            		var tr = $('<tr></tr>');
            		tr.append('<td><a href="product/'+data[i]['CodArtigo']+'">'+data[i]['CodArtigo']+'</a></td>');
	            	tr.append('<td>'+data[i]['DescArtigo']+'</td>');
	            	tr.append('<td>'+data[i]['Marca']+'</td>');
	            	tr.append('<td>'+data[i]['PVP']+' €</td>');
            		table.append(tr);
            	}
            }
            catch(e){
            	console.log(e);
            }
        },
	    type: 'GET'
	});
}


`