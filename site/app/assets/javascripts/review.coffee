# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
`
	$(document).ready(function () {
		$('#leave-review-btn').click(showReviewModal);
		$('#rating-system').rating('update', 3);

		$("#btn-submit-review").click(function() {
			var id_produto = $("#prod-title").attr('data-id-product');
			var comment = $("#review-input").val();
			var rating = $('#rating-system').val();
			submitReview(comment,id_produto,rating);
		});
	});

	function showReviewModal() {
		$('#review-modal').modal('show');
	}

	function submitReview(comment,id_produto,rating) {
	  var formData = new FormData();
	  formData.append('review[comment]',comment);
	  formData.append('review[produto_id]',id_produto);
	  formData.append('review[rating]',rating);
	  $.ajax({
	    url: '/reviews',
	    data: formData,
	    cache: false,
	    contentType: false,
	    processData: false,
	    type: 'POST',
	    success: function (data) {
	      	location.reload();
	    }
	  });
	}
`