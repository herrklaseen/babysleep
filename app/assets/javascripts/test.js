 $(document).ready(function(){
	 $("#button1").click(function() {
	 	console.log('klick');
		$.ajax(
		{
			type: "GET",
			url: "http://" + window.location.host + "/users.json",
			dataType: "json"
		})
	    	.done(function(dataResponse) { 
	    		email = dataResponse[0].email;
	    		alert('the first users email is: ' + email); })
	    	.fail(function() { alert("error"); });
		});
 });