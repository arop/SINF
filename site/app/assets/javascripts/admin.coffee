# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



`
var base_url_primavera = 'http://localhost:49526/api';
var encomendas_pendentes = [];

function number_products(arr) {
    var a = [], b = [], prev;

    arr.sort();
    for ( var i = 0; i < arr.length; i++ ) {
        if ( arr[i] !== prev ) {
            a.push(arr[i]);
            b.push(1);
        } else {
            b[b.length-1]++;
        }
        prev = arr[i];
    }

    return [a, b];
}

$(document).ready(function () {

	encomendas();
	produtos();



});


function encomendas () {

	var url_encomendas = base_url_primavera + '/DocVenda';	
	$("#loading_1").html(botao_load);

	$.ajax({
		url: url_encomendas,
		error: function(err) {
			console.log("error fetching category");
			$("#loading_1").html("");
		},
		dataType: 'json',
		success: function(data) {
	            //console.log("success.");
	            //console.log(data);
	            // console.log(data);
	            var table = $("#encomendas_pendentes"); 
	           $("#loading_1").html("");

	            var arrayProdutos=[];

	            try{    
	            	for(var i in data){

	            		var data_array=(""+data[i]['Data']).split("-");

	            		var tr = $('<tr></tr>');
	            		tr.append('<td>'+data[i]['Entidade']+'</td>');
	            		tr.append('<td><a href="encomenda/'+data[i]['NumDoc']+'">'+data[i]['NumDoc']+'</a></td>');
	            		tr.append('<td>'+data_array[0]+"-"+data_array[1]+"-"+data_array[2].split("T")[0]+'</td>');
	            		tr.append('<td>'+'Estado'+'</td>');
	            		tr.append('<td>'+data[i]['TotalMerc']+' €</td>');
	            		table.append(tr);


	            		//adicionar elementos


	            		//console.log(i);
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
			$("#loading_2").html("");
		},
		dataType: 'json',
		success: function(data) {
			$("#loading_2").html("");
	            //console.log("success.");
	            //console.log(data);
	            data=$.parseJSON(data);
	            console.log(data);
	            var table = $("#produto_tabela"); 
	           //table.html(botao_load);


	             try{    
	            	for(var i in data){


	            		var tr = $('<tr></tr>');
	            		tr.append('<td><a href="product/'+data[i]['CodArtigo']+'">'+data[i]['CodArtigo']+'</a></td>');
		            	tr.append('<td>'+data[i]['DescArtigo']+'</td>');
		            	tr.append('<td>'+data[i]['Marca']+'</td>');
		            	tr.append('<td>'+data[i]['PVP']+' €</td>');
	            		table.append(tr);


	            		//adicionar elementos


	            		//console.log(i);
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