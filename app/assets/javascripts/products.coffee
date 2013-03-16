console.log("loaded product rating js")
note_txt = ''
note_changed = false

$(".rate_buttons .btn").click (e) ->
  console.log("you clicked")
  note_changed = true
  if e.keyCode == 13
    e.preventDefault()
  else
    $(this).html("<br>")
  

$(".popover-content .rate_buttons ").on "click", ".btn", (ev) ->
  console.log "Clicked button in product rating popup"
  formData = $("#rating_form form").serialize()
  $("#rating_form").toggleClass "post_active"
 
  