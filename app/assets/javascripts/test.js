 $(document).ready(function(){
	 $("#button1").click(function() {
		$.ajax(
		{
			type: "GET",
			url: "http://localhost:3000/users.json",
			dataType: "json"
		}
			).done(
				function(responseData){
					console.log(responseData);
				});

		alert("Nu är det klickat"); 
		});
 });


