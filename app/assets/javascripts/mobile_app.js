var views = { "forms" : 
							{ "inputBabyId" : 
									"<form><label for=baby_id_field>Input baby id " +
									"<input type=text id=baby_id_field name=baby_id /></label>" +
									"<button type=submit id=baby_id_submit name=baby_id_submit>" + 
									"Get baby sleeptime</button>" }
};

$(document).ready(function(){
 	$("body").html(views.forms.inputBabyId);

	 $("#baby_id_submit").click(function(event) {
	 	event.preventDefault();
	 	var baby_id = $("#baby_id_field").val();
		$.ajax(
		{
			type: "GET",
			url: "http://" + window.location.host + "/babies/" + baby_id + "/sleeptimes.json",
			dataType: "json"
		})
	    	.done(function(dataResponse) { 
	    		duration = dataResponse.duration;
	    		alert("the first duration: " + duration); 
	    		})
	    	.fail(function() { alert("error"); });
		});
 });