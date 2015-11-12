`
var base_url_primavera = 'http://192.168.1.104:49526/api'
$(document).ready(function () {
		var url_categorias = base_url_primavera + '/categorias';
		$.ajax({
        url: url_categorias,
        error: function(err) {
            console.log("error");
            console.log(err);
        },
        dataType: 'json',
        success: function(data) {
            console.log("success. data:");
            console.log(data);
        },
        type: 'GET'
		});
});



`