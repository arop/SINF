# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



`
var base_url_primavera = 'http://localhost:49526/api';
var encomendas_pendentes = [];

$(document).ready(function () {

	var url_encomendas = base_url_primavera + '/DocVenda';		

	$.ajax({
		url: url_encomendas,
		error: function(err) {
			console.log("error fetching category");
		},
		dataType: 'json',
		success: function(data) {
	            //console.log("success.");
	            //console.log(data);
	            console.log(data);
	            var table = $("#encomendas_pendentes"); 
	            try{    
	            	for(var i in data){
	            		var tr = $('<tr></tr>');
	            		tr.append('<td>'+data[i]['Entidade']+'</td>');
	            		tr.append('<td>'+data[i]['NumDoc']+'</td>');
	            		tr.append('<td>'+data[i]['Data']+'</td>');
	            		tr.append('<td>'+'Estado'+'</td>');
	            		tr.append('<td>'+data[i]['TotalMerc']+' €</td>');
	            		table.append(tr);
	            		console.log(i);
	            	}
	            }
	            catch(e){
	            	console.log(e);
	            }
	            
	        },
	        type: 'GET'
	    });




});

`