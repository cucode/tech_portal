$(document).ready ->
  # page is now ready, initialize the calendar...
  $("#calendar").fullCalendar
    events: $.parseJSON($("#calendar").attr("data-events"))
