# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

`
$(document).ready(function () {
	$('#btn-submit-description').click(function() {
		var id_produto = $("#prod-title").attr('data-id-product');
		desc = $('#description-input').val();
		changeDescProduct(desc,id_produto);
	});
});

function changeDescProduct(desc,productId) {
  $('#botao-loading').html(botao_load);

  var formData = new FormData();
  formData.append('product_description[description]',desc);
  formData.append('product_description[idProduto]',productId);
  $.ajax({
    url: '/product_description',
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

/*function deleteOldDesc() {
  $.ajax({
    url: '/image/'+imgId,
    type: 'DELETE',
    success: function () {
      location.reload();
    }
  });
}*/

`