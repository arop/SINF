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
	            var entidade=$("#entidade-user");
	            var date=$("#data");
	            var total=$("#total");
	            var total_iva = data['TotalMerc'] + data['TotalIva'];
	            title.append(encomenda_id);
	            entidade.append(data['Entidade']);
	            var data_array=(""+data['Data']).split("-");
	            date.append(data_array[0]+"-"+data_array[1]+"-"+data_array[2].split("T")[0]);
	            total.append(total_iva+"€");

	            for(var i in data['LinhasDoc'])
	            {
	            	var obj = data['LinhasDoc'][i];
	            	var iva = obj['IVA'];
	            	var preco_iva = obj['PrecoUnitario']*(1+iva/100.0);
	            	var tr = $('<tr></tr>');
	            	tr.append('<td><a href="/product/'+obj['CodArtigo']+'">'+obj['CodArtigo']+'</a></td>');
	            	tr.append('<td>'+obj['DescArtigo']+'</td>');
	            	tr.append('<td>'+preco_iva.toFixed(2)+'€ </td>');
	            	tr.append('<td>'+obj['Desconto']+'</td>');
	            	tr.append('<td>'+obj['Quantidade']+'</td>');
	            	tr.append('<td>'+(preco_iva*obj['Quantidade']).toFixed(2)+'€ </td>');
	            	table.append(tr);
	            }
	            fetchUser();            
	        },
	        type: 'GET'
	    });






});

function fetchUser(){
	$.ajax({
	    type: 'GET',
		url: '/encomendas/user/'+$("#entidade-user").html(),
		error: function(err) {
			console.log("error fetching order");
		},
		success: function(data) {
			console.log(data);
	        if(data.success == true){
	        	console.log(data.user);
	        	var content = '<h4>Nome: '+data.user.nome+'</h4>\n'+'<h4>NIF: '+ data.user.nif +'</h4>';
	        	$("#entidade").after(content);
	        }
	        else console.log('user não existe');
	                    
	    }
	});
}

`