# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#// For fixed width containers
jQuery ->
  $('.datatable').dataTable({
    "sDom": "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
    "sPaginationType": "bootstrap"
    });

  #$('#invitation_button').live('click') ->
  #  email = $('form #user_email').val()
  #  if($('form #user_opt_in').is(':checked'))
  #      opt_in = true
  #  else
  #      opt_in = false
  #  dataString = 'user[email]='+ email + '&user[opt_in]=' + opt_in
  #  $.ajax '/',
  #    type: "POST",
  #    url: "/users"
  #    data: dataString
  #    error: (jqXHR, textStatus, errorThrown) ->    
  #      console.log("Ajax post error invite form is #{textStatus}")  
  #    success: (data, textStatus, jqXHR) ->    
  #      console.log("Ajax post of invite form")  
  #      $('#request-invite').html(data)  
  #      #loadSocial()
  #