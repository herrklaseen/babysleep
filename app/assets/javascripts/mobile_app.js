var staticViews = { "forms" : { 
								"inputBabyId" : 
									"<form><label for=baby_id_field>Input baby id " +
									"<input type=text id=baby_id_field name=baby_id /></label>" +
									"<button type=submit id=baby_id_submit name=baby_id_submit>" + 
									"Get baby sleeptime</button>",
								"login" : 
									"<form><label for=user_email_field>Your email " +
									"<input type=text id=user_email_field name=email /></label>" +
									"<label for=user_password_field>Your password " +
									"<input type=text id=user_password_field name=password /></label>" +
									"<button type=submit id=login_submit name=login_submit>" + 
									"Log in</button>" }
						 };

var dynamicViews = { "babySelector" : function(babies){
		var selectorString = "<select>";
}}

var actions = {
	"start" : function(element){
		element.html(staticViews.forms.login)
	},

	"login" : function(element){
		$('#login_submit').bind('touchend click', function(event) {
			event.preventDefault();
			var	submittedEmail = $('#user_email_field').val();
			var	submittedPassword = $('#user_password_field').val();		
		$.ajax(
		{
			type: 'POST',
			url: 'http://' + window.location.host + 
						'/login.json',
			data: { 'email' : submittedEmail, 'password': submittedPassword },
			dataType: 'json'
		})
	    .done(function(responseData) { 
	    	actions.getBabies(responseData.parent_id, element); 
	    	})
	   .fail(function(jqXHR, textStatus) { alert('error: ' + textStatus); });
		});

	},

	"getBabies": function(parentId, element) {
		$.ajax(
			{
				type: 'GET',
				url: 'http://' + window.location.host + 
							'/parents/' + parentId + '/babies.json',
				dataType: 'json'
			})
		    .done(function(responseData) { 
		    	element.html(dynamicViews.babySelector(responseData)); 
		    	})
		   .fail(function(jqXHR, textStatus) { alert('error: ' + textStatus); });
	}, 

	"getBaby24hSleeptime" : function() {
		$('#baby_id_submit').bind('touchend click', function(event) {
			event.preventDefault();
			var	baby_id = $('#baby_id_field').val();
		$.ajax(
		{
			type: 'GET',
			url: 'http://' + window.location.host + 
						'/babies/' + baby_id + '/last_24h_sleeptime.json',
			dataType: 'json'
		})
	    .done(function(dataResponse) { 
	    	duration = dataResponse.for_humans;
	    	contentDiv.html('your baby slept ' + duration + ' during the last 24 h'); 
	    	})
	   .fail(function(jqXHR, textStatus) { alert('error: ' + textStatus); });
		});
		}
	}

$(document).ready(function(){
	var contentDiv = $("#content");
 	actions.start(contentDiv);
 	actions.login(contentDiv);


	 
 });

