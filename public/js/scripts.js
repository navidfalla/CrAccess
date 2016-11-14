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

	// $.each($('.delete-form'), function (idx) {
	// 	$(this).submit(function (e) {return confirm('Delete?');});
	// });

	function deleteIssue(e){
		if (confirm("Are you sure you want to delete this issue?")){
			var myid = $(this).attr('id').split('-')[1];
			$.post(
			  baseURL+'/issues/delete/'+myid,
			  function(data) {
				if(data.status == 'success') {
					$('tr#issue-'+myid).remove();
				} else {
					if (data.status == "unauthorized"){
  					  alert("Please login to report!")
  				  	}
				}
			  },
			  "json"
			);
		}
	}

	function reportSolved(e){
		var myid = $(this).attr('id').split('-')[1];
		if ($(this).hasClass("reported")){
			$.post(
			  baseURL+'/issues/reportUnSolved/'+myid,
			  function(data) {
				if(data.status == 'success') {
					$('tr#issue-'+myid+" em.num-reports").text(data.solved);
					$('#solve-'+myid).removeClass('reported');
					$('#solve-'+myid).text("Report Solved")
				} else {
					if (data.status == "unauthorized"){
						alert("Please login to report!")
					}
				}
			  },
			  "json"
			);
		}else{
			$.post(
			  baseURL+'/issues/reportSolved/'+myid,
			  function(data) {
				if(data.status == 'success') {
					$('tr#issue-'+myid+" em.num-reports").text(data.solved);
					$('#solve-'+myid).addClass('reported');
					$('#solve-'+myid).text("Undo Report")
				} else {
					if (data.status == "unauthorized"){
					  alert("Please login to report!")
					}
				}
			  },
			  "json"
			);
		}
	}

	function editIssue(e){
		var myid = $(this).attr('id').split('-')[1];

		$.get(
			baseURL+'/issues/checkIssue',
	        { 'id': myid },
	        function(data) {
	          if(data.status == 'success') {
				  myhtml = "<b>Address</b>: <input name=\"address\" value=\""+data.address+"\"></input></br><b>Description</b>: <br><textarea name=\"description\">"+data.description+"</textarea></br><b>Summary</b>: <input name=\"summary\" value=\""+data.summary+"\"></input><br><button class=\"save-changes\" id=\"save-"+myid+"\">Save Changes</button>";
				  $("td#fields-"+myid).html(myhtml);
				  $("td.fields").delegate("button.save-changes","click",function(){
				  	var myid = $(this).attr('id').split('-')[1];
				  	$.post(
				  	  baseURL+'/issues/saveChanges/'+myid,
					  {"id":myid,"address":$("td#fields-"+myid+" input[name='address']").val(),"description":$("td#fields-"+myid+" textarea[name='description']").val(),"summary":$("td#fields-"+myid+" input[name='summary']").val()},
				  	  function(data) {
				  		if(data.status == 'success') {
				  			myhtml = "<b>Address</b>: <span>"+data.address+"</span> <br /><b>Summary</b>: <span>"+data.summary+"</span> <br /><b>Reporter</b>: <span>"+data.username+"</span> <br /><b>Date Added</b>: <span>"+data.date_added+"</span> <br /><a class=\"linkbutton\" href=" +baseURL+ "/issues/view/" + data.id + ">View</a><button class=\"report-solved\" id=\"solve-" +data.id+ "\">Report Solved</button><span class=\"note\"><em class=\"num-reports\">"+data.solved+"</em> reports solved</span><br/><button class=\"edit-issue\" id = \"edit-"+data.id+"\">Edit</button><button class = \"delete-issue\" id = \"delete-"+data.id+"\">Delete</button></td></tr>";
				  			$("td#fields-"+myid).html(myhtml);
							$("td").delegate('.delete-issue',"click",deleteIssue);
							$("td").delegate('.report-solved',"click",reportSolved);
							$("td").delegate('.edit-issue',"click",editIssue);
				  		} else {
							if (data.status == "unauthorized"){
								alert("Please login to report!")
							}
				  		}
				  	  },
				  	  "json"
				  	);
				  });
	          }else{
				  alert("no such record in database");
			  }
	        },
		  "json"
		);
	}

	function followUser(e){
			var button = $(this);
			var followeeId = $(button).parent().attr('id');
			$.post(
			  baseURL+'/user/follow',
				{'userId': followeeId},
					function(data) {
	        if(data.success == 'success') {
	          // Follow successful
	          // Already followed, so remove the button
	          $(button).html('Following');
	        } else if (data.error != '') {
	          alert(data.error); // show error as popup
	        }
	      },
	      'json'
			);
	}

	$('.delete-issue').on('click', deleteIssue);

	$('.report-solved').on('click',reportSolved);

	$('.edit-issue').on('click',editIssue);

	$('.follow-user').on('click', followUser)
});
