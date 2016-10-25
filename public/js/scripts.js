//var not_accessible_images = ["not_accessible.jpg", "not_accessible2.jpg", "not_accessible3.jpg", "not_accessible4.jpg"]
var current_image = 0;

$(function() {
	$('#rotate_right').on('click', function (e) {
			$('#not_accessible_image').attr('src', '../../public/img/'+not_accessible_images[(++current_image)%4])
	});
	$('#rotate_left').on('click', function (e) {
			if (current_image == 0)
				current_image = not_accessible_images.length;
			$('#not_accessible_image').attr('src', '../../public/img/'+not_accessible_images[(--current_image)%4])
	});

	$('#search_bar').on('focus', function (e) {
			//$('#search_bar').addClass('on_searching');
			$('#search_bar').animate({width: "250px"}, 500);
	});

	$('#search_bar').on('blur', function (e) {
			//$('#search_bar').removeClass('on_searching');
			$('#search_bar').animate({width: "173px"}, 500);
	});

	$.each($('.delete-form'), function (idx) {
		$(this).submit(function (e) {return confirm('Delete?');});
	});
});
