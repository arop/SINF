# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

`
$(document).ready(function(){

	var lista = new Array();
	var lista2 = ["A0001"];

	$(".codigo-artigo-cart").each(function(){
		lista.push($(this).html());

	});

	console.log(lista);
	var json_string = JSON.stringify(lista);
	console.log(json_string);

	var json_string2 = JSON.stringify(lista2);

	/*var values = {"1,","2","3"};
	var theIds = JSON.stringify(values);
    contentType: "application/json; charset=utf-8",
	data: {ids: theIds },*/


    $.ajax({
        type: "POST",
        url: 'http://localhost:49526/api/carrinho',
        dataType: 'json',
        //contentType: 'text/json; charset=utf-8',
        crossDomain: true,
        data: lista,
        error: function (xhr, status, error) {
            console.log("Error: " + xhr);
            console.log(xhr);
            console.log("Error: " + status);
            console.log("Error: " + error);
        },
        success: function (msg) {
            if (msg) {           
            	console.log(msg);     
                /*var responseDocVenda = $.parseJSON(msg);
                console.log(responseDocVenda);*/
            }
            else {
                console.log("msg not good in send docVenda");
            }
        }
    });
});
`
