// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap                 
//= require bootstrap-modal
//= require bootstrap-dropdown
//= require bootstrap-tab
//= require bootstrap-tooltip
//= require bootstrap-popover
//= require bootstrap-alert
//= require bootstrap-button
//= require bootstrap-collapse
//= require bootstrap-carousel
//= require bootstrap-typeahead
//  require underscore
//= require gritter    
//= require jquery_nested_form

// require jquery.ui.widget
// require load-image.min
// require canvas-to-blob.min                        #These are old ones in vendor/assets/javascript
// require jquery.iframe-transport
// require jquery.fileupload
// require jquery.fileupload-ip
// require jquery.fileupload-ui         

//=require jquery-fileupload/vendor/jquery.ui.widget
//=require jquery-fileupload/vendor/load-image
//=require jquery-fileupload/vendor/canvas-to-blob
//=require jquery-fileupload/vendor/tmpl
//=require jquery-fileupload/jquery.iframe-transport
//=require jquery-fileupload/jquery.fileupload
//=require jquery-fileupload/jquery.fileupload-fp
//=require jquery-fileupload/jquery.fileupload-ui
//=require jquery-fileupload/locale

//= require jquery.Jcrop
//= require bootstrap-image-gallery.min 
//= require photo_main          
//= require photo_local

//  require jquery.remotipart
//  require ember
//  require ember/Rightby.me.js

// require masonry/jquery.masonry    
// require masonry/jquery.imagesloaded.min
// require masonry/jquery.infinitescroll.min
// require bootstrap-ajax.js

//= require bootstrap-wysihtml5
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require_tree .
$('document').ready(function() {
  
  // use AJAX to submit the "request invitation" form
  $('#invitation_button').live('click', function() {
    var email = $('form #user_email').val();
    if($('form #user_opt_in').is(':checked'))
        var opt_in = true;
    else
        var opt_in = false;
    var dataString = 'user[email]='+ email + '&user[opt_in]=' + opt_in;
    $.ajax({
      type: "POST",
      url: "/users",
      data: dataString,
      success: function(data) {
        $('#request-invite').html(data);
        loadSocial();
      }
    });
    return false;
  });
  $('.wysihtml5').each(function(i, elem) {
      $(elem).wysihtml5();
  });
    
})

