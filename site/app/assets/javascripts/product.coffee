# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
`
var base_url_primavera = 'http://localhost:49526/api';
var url_categoria = 'http://localhost:3000/categoria/';

$(document).ready(function () {
	var id_produto = $("#prod-title").attr('data-id-product');

	getProduto(id_produto);

    $('.product-img').click(function(){
        $('#product-img-input').click(); 
    });

    $('#product-img-input').change(function() {
        addImgToProduct($('#product-img-input')[0].files[0],
            $('#product-img-input').attr('data-id-product'))
    });

    $('#product-del-img').click(deleteImg);
    
});


function getProduto(id){
	var url_prod = base_url_primavera + '/artigos/' + id;

	$.ajax({
        url: url_prod,
        dataType: 'json',
        type: 'GET',
        error: function(err) {
	        $("#prod-title").html('<h2>Problema ao obter produto, ou produto inexistente...</h2>');
            console.log("error fetching product");
            console.log(err);
        },
        success: function(data) {
            $('#prod-title').html(data.DescArtigo);
            var price = data.PVP;
            if(data.Moeda == 'EUR') price+='€'; 
            else price+='$';
            $('#prod-price').html(price);
            if(data.MarcaDesc != null) {
            	$('#prod-marca').html('Marca: ' + data.MarcaDesc);
            } else $('#prod-marca').remove();
            $('#prod-categoria em').html(data.CategoriaDesc);
            $('#prod-categoria').attr('href',url_categoria + data.Categoria);
            if(data.SubCategoriaDesc != null) {
            	$('#prod-subcategoria').before(' / ');
            	$('#prod-subcategoria em').html(data.SubCategoriaDesc);
            	$('#prod-subcategoria').attr('href',url_categoria + data.Categoria + '/' + data.SubCategoria);
            }
        }
	});
}

function addImgToProduct(img,productId) {
    var formData = new FormData();
    formData.append('imagem[image]',img);
    formData.append('imagem[idProduto]',productId);

    $.ajax({
      url: '/image',
      data: formData,
      cache: false,
      contentType: false,
      processData: false,
      type: 'PUT',
      success: function () {
        location.reload();
      }
    });
}

function deleteImg() {
    imgId = $('.product-img-div.active').attr('data-img-id');
    $.ajax({
      url: '/image/'+imgId,
      type: 'DELETE',
      success: function () {
        location.reload();
      }
    });
}

`