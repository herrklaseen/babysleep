$(document).ready(function(){
  var timeZoneField = $("input[name='user_tz_offset']");
  if (timeZoneField.length) {
    var browserDate = new Date();
    var timeZoneOffsetSeconds = (browserDate.getTimezoneOffset() * 60) * -1;
    $(timeZoneField).val(timeZoneOffsetSeconds);
  }
});
