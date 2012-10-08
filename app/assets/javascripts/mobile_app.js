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
			url: "http://" + window.location.host + "/babies/" + baby_id + "/last_24h_sleeptime.json",
			dataType: "json"
		})
	    	.done(function(dataResponse) { 
	    		duration = dataResponse.in_seconds;
	    		alert("your baby slept " + duration + " seconds during the last 24 h"); 
	    		})
	    	.fail(function() { alert("error"); });
		});
 });