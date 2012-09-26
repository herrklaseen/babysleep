 $(document).ready(function(){
	 $("#button1").click(function() {
	 	console.log('klick');
		$.ajax(
		{
			type: "GET",
			url: "http://" + window.location.host + "/users.json",
			dataType: "json"
		})
	    	.done(function() { alert("success"); })
	    	.fail(function() { alert("error"); });
		});
 });