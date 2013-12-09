$(document).ready ->
  # page is now ready, initialize the calendar...
  $("#calendar").fullCalendar
    events: $.parseJSON($("#calendar").attr("data-events")),
    eventClick: (calEvent, jsEvent, view) ->
      $("#myModal .modal-body").html("<h2>" + calEvent.title + "</h2><p>" + calEvent.description + "</p><br /><a class='btn btn-primary' href='" + calEvent.url + "' target='_blank'>More information</a>")
      $("#myModal").modal()
      false # Don't follow the event link.