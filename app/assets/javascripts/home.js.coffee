# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('.unit').keyup (event) ->
    conversion_flow = $(event.target).data("action")
    api_url = $(event.target).data("url")
    $.post(
      api_url
      {id: $("#measurement_type_id").val(),value: $(event.target).val()}
      (data, textStatus, jqXHR) ->
        if conversion_flow == "forward"
          $(".backward").val(data)
        else
          $(".forward").val(data)

    )

  $('#measurement_type_id').change (event) ->
    url = $(event.target).attr("action")
    $.post(
      url
      {id: $("#measurement_type_id").val()}
      (data, textStatus, jqXHR) ->
        $("#unit_name_forward").text(data.source_unit_name.name)
        $("#unit_name_backward").text(data.target_unit_name.name)

    )



