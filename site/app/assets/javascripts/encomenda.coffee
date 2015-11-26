`
var base_url_primavera = 'http://localhost:49526/api';

$(document).ready(function () {

	var encomenda_id = $("#encomenda-id").attr("data-id-encomenda");

	var url_encomendas = base_url_primavera + '/DocVenda/'+encomenda_id;	
	console.log(url_encomendas);	
	var table = $("#compras"); 
	$("#loading").html(botao_load);

	$.ajax({
		url: url_encomendas,
		error: function(err) {
			console.log("error fetching order");
		},
		dataType: 'json',
		success: function(data) {
	            //console.log("success.");
	            //console.log(data);
	            $("#loading").html("");

	            var title=$("#title");
	            var entidade=$("#entidade");
	            var date=$("#data");
	            var factura=$("#factura");
	            var total=$("#total");

	            title.append(encomenda_id);
	            entidade.append(data['Entidade']);
	            var data_array=(""+data['Data']).split("-");
	            date.append(data_array[0]+"-"+data_array[1]+"-"+data_array[2].split("T")[0]);
	            factura.append(data['IdFactura']);
	            total.append(data['TotalMerc']+"€");





	            for(var i in data['LinhasDoc'])
	            {
	            	var obj = data['LinhasDoc'][i];
	            	var tr = $('<tr></tr>');
	            	tr.append('<td><a href="/product/'+obj['CodArtigo']+'">'+obj['CodArtigo']+'</a></td>');
	            	tr.append('<td>'+obj['DescArtigo']+'</td>');
	            	tr.append('<td>'+obj['PrecoUnitario']+'€ </td>');
	            	tr.append('<td>'+obj['Desconto']+'</td>');
	            	tr.append('<td>'+obj['Quantidade']+'</td>');
	            	tr.append('<td>'+obj['TotalLiquido']+'€ </td>');
	            	tr.append('<td>'+obj['TotalILiquido']+'€ </td>');
	            	table.append(tr);


	            }

	            console.log(data);
	            
	            
	        },
	        type: 'GET'
	    });




});

`