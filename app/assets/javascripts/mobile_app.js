$(document).ready(function(){

var staticViews = { 
"forms" : { 
  "inputBabyId" : 
    "<form id=input_baby_id_form><label for=baby_id_field>Input baby id " +
    "<input type=text id=baby_id_field name=baby_id /></label>" +
    "<button type=submit id=baby_id_submit name=baby_id_submit>" + 
    "Get baby sleeptime</button>",
  "login" : 
    "<form id=loginForm><label for=user_email_field>Your email " +
    "<input type=text id=user_email_field name=email /></label>" +
    "<label for=user_password_field>Your password " +
    "<input type=text id=user_password_field name=password /></label>" +
    "<button type=submit id=login_submit name=login_submit>" + 
    "Log in</button>",
  "inputBabySleeptime" : 
    "<form id=baby_sleeptime_form><label for=baby_start_sleeptime_field>Start " +
    "<input type=text id=baby_start_sleeptime_field name=start /></label>" +
    "<label for=baby_end_sleeptime_field>End " +
    "<input type=text id=baby_end_sleeptime_field name=end /></label>" +
    "<button type=submit id=baby_sleeptime_submit name=baby_sleeptime_submit>" + 
    "Save</button>" }, 

"containers" : {
  "sleeptimeChart" :
    "<div id=sleeptime_chart_div></div>" }
};

var elementHandles = {
"forms" : {
  "inputBabyId" : "",
  "loginForm" : "",
  "inputBabySleeptime" : "" },
"containers" : {
  "sleeptimeChart" : "" }
}

var user = {
  "userId" : undefined,
  "parentId" : undefined,
  "activeBaby" : { 
    "name" : "",
    "id" : undefined }
}

var actions = {
  "bindEvents" : function(){
    $("#baby_sleeptime_submit").bind("touchend click", function(event) {
      event.preventDefault();
      actions.saveNewSleeptime();
    });
  },

  "start" : function(element){
    element.html("");
    element.append(staticViews.forms.login);
    element.append(staticViews.forms.inputBabyId);
    element.append(staticViews.containers.sleeptimeChart);
    element.append(staticViews.forms.inputBabySleeptime);

    elementHandles.forms.inputBabyId = $('#input_baby_id_form');
    elementHandles.forms.loginForm = $('#loginForm');
    elementHandles.forms.inputBabySleeptime = $('#baby_sleeptime_form');
    elementHandles.containers.sleeptimeChart = $('#sleeptime_chart_div');

    elementHandles.forms.inputBabyId.hide();
    elementHandles.forms.loginForm.hide();
    elementHandles.forms.inputBabySleeptime.hide();

    actions.bindEvents();
  },

  "login" : function(element){
    elementHandles.forms.loginForm.show();
    $("#login_submit").bind("touchend click", function(event) {
      event.preventDefault();
      var submittedEmail = $('#user_email_field').val();
      var submittedPassword = $('#user_password_field').val();    
      $.ajax(
      {
        type: 'POST',
        url: 'http://' + window.location.host + 
              '/login.json',
        data: { 'email' : submittedEmail, 'password': submittedPassword },
        dataType: 'json'
      })
      .done(function(responseData) {
        user.userId = responseData.user_id;
        user.parentId = responseData.parent_id;
        actions.getBabies(user.parentId); 
        elementHandles.forms.loginForm.hide();
        })
     .fail(function(jqXHR, textStatus) { alert('error: ' + textStatus); });
    });
  },

  "getBabies": function(parentId) {
    $.ajax(
      {
        type: 'GET',
        url: 'http://' + window.location.host + 
              '/parents/' + parentId + '/babies.json',
        dataType: 'json'
      })
        .done(function(responseData) {
          user.activeBaby.id = responseData[0].id;
          user.activeBaby.name = responseData[0].name;
         actions.showBaby24hSleeptime(user.activeBaby.id)
          })
       .fail(function(jqXHR, textStatus) { alert('error: ' + textStatus); });
  }, 

  "showBaby24hSleeptime" : function(babyId) {
    elementHandles.forms.inputBabySleeptime.hide();
    elementHandles.containers.sleeptimeChart.hide();
    elementHandles.containers.sleeptimeChart.html("");

    $.ajax(
    {
      type: 'GET',
      url: 'http://' + window.location.host + 
            '/babies/' + babyId + '/last_24h_sleeptime.json',
      dataType: 'json'
    })
      .done(function(dataResponse) { 
        duration = dataResponse.for_humans;

        actions.generateBaby24hSleeptimeChart([ dataResponse.percentage ]);

        elementHandles.containers.sleeptimeChart.append(
          "<p>" + user.activeBaby.name + ' slept ' + duration + ' during the last 24 h</p>');
        elementHandles.containers.sleeptimeChart.show();
        elementHandles.forms.inputBabySleeptime.show();

        })
     .fail(function(jqXHR, textStatus) { alert('error: ' + textStatus); });
    },

    "generateBaby24hSleeptimeChart" : function(data){
      var m = 10,
          r = 100,
          z = d3.scale.category20c();

      var chart = d3.select("#sleeptime_chart_div").selectAll("svg")
        .data(data)
      .enter().append("svg:svg")
        .attr("width", (r + m) * 2)
        .attr("height", (r + m) * 2)
      .append("svg:g")
        .attr("transform", "translate(" + (r + m) + "," + (r + m) + ")");

      chart.selectAll("path")
        .data(d3.layout.pie())
      .enter().append("svg:path")
        .attr("d", d3.svg.arc()
        .innerRadius(r / 2)
        .outerRadius(r))
        .style("fill", function(d, i) { return z(i); });
    },

    "saveNewSleeptime" : function(){
      var start = $('#baby_start_sleeptime_field').val();
      var end = $('#baby_end_sleeptime_field').val();    

      $.ajax(
      {
        type: 'POST',
        url: 'http://' + window.location.host + 
              '/babies/' + user.activeBaby.id + '/sleeptimes.json',
        data: { "start" : start, "end" : end, "baby_id": user.activeBaby.id },
        dataType: 'json'
      })
      .done(function(dataResponse) { 
        actions.showBaby24hSleeptime(user.activeBaby.id);
        })
     .fail(function(jqXHR, textStatus) { alert('error: ' + textStatus); });
    }
  }
  
  var contentDiv = $("#content");
  actions.start(contentDiv);
  actions.login();

 });

