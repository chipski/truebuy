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
//  require turbolinks
//= require bootstrap-sprockets
//  require bootstrap-ajax.js
//= require bootstrap-wysihtml5
// require jquery.ui.widget

//= require jquery.Jcrop
//=require jquery-fileupload/vendor/jquery.ui.widget
//=require jquery-fileupload/vendor/load-image
//=require jquery-fileupload/vendor/canvas-to-blob
// require jquery-fileupload/vendor/tmpl
//=require jquery-fileupload/jquery.iframe-transport
//=require jquery-fileupload/jquery.fileupload
//=require jquery-fileupload/jquery.fileupload-fp
//=require jquery-fileupload/jquery.fileupload-ui
//=require jquery-fileupload/locale
//= require photo_main  
//= require slimbox2         
//= require photo_local

//  require spin.min.js   
//= require jquery.raty.js
//= require letsrate.js
//= require select2
//= require products
//= require jquery.pnotify
//= require jquery_nested_form

//= require masonry/jquery.masonry    
// require masonry/jquery.imagesloaded.min
//= require masonry/jquery.infinitescroll.min

//= require jquery.royalslider.custom.min.js
// require jquery.royalslider.min.js
//  require /modules/jquery.rs.tabs.min.js
//  require /modules/jquery.rs.thumbnails.min.js
//  require /modules/jquery.rs.hover.min.js
//  require /modules/jquery.rs.deeplinking.min.js
//  require /modules/jquery.rs.auto-height.min.js
//  require /modules/jquery.rs.bullets.min.js
//  require /modules/jquery.rs.nav-auto-hide.min.js
//  require /modules/jquery.rs.global-caption.min.js
//  require /modules/jquery.rs.hover-nav.min.js
//  require /modules/jquery.rs.active-class.min.js
//  require /modules/jquery.rs.animated-blocks.min.js
   
//  require underscore
//  require jquery.remotipart
//  require ember
//  require ember/Rightby.me.js
//  require gritter    

// require_tree .

$('document').ready(function() {
  
  $.support.cors = true;
  
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
        //loadSocial();
      }
    });
    return false;
  });
  
  /* Called when an item is selected from the drop-down */
  function bind_selection_result(elem) {
    elem.result(function(event, data, slot_zero) {
      $('#site_search_form').submit();
    });    
  } /* bind_selection_result */
  
  $('.wysihtml5').each(function(i, elem) {
      $(elem).wysihtml5();
  });
  $('#full-width-slider').royalSlider( {
      arrowsNav: true,
      arrowsNavAutoHide: true,
      loop: true,
      keyboardNavEnabled: true,
      controlsInside: false,
      imageScaleMode: 'fill',
      autoScaleSlider: true, 
      autoScaleSliderWidth: 900,     
      autoScaleSliderHeight: 320,
      arrowsNavHideOnTouch: true,
      controlNavigation: 'bullets',
      thumbsFitInViewport: false,
      navigateByClick: true,
      startSlideId: 0,
      autoPlay: true,
      transitionType:'fade',
      controlsInside: true,
      globalCaption: false
  });  
  $('#content-slider-1').royalSlider({
      autoHeight: true,
      arrowsNav: false,
      fadeinLoadedSlide: false,
      controlNavigationSpacing: 0,
      controlNavigation: 'tabs',
      imageScaleMode: 'none',
      imageAlignCenter:false,
      loop: false,
      loopRewind: true,
      numImagesToPreload: 6,
      keyboardNavEnabled: true
  });
  $.pnotify.defaults.styling = "bootstrap";
  $.pnotify.defaults.history = false;
  $.pnotify.defaults.animate_speed = "slow";
  $.pnotify.defaults.shadow= true;
    
  $('.ajax').click(function (e) {
      var urlHref = $(this).attr('href');
      $('.tab-pane').removeClass('active');
      $(this).addClass('active');
      var urlTarget = $(this).data().target;
      var urlAction = urlHref.substring(1);
      console.log("clicked tab "+urlAction+" target "+urlTarget);
      
      var urlBase = $(this).parent().parent().attr("data-url");
      var url = urlBase+"/"+urlAction+".js";
      console.log(" url="+url);
      var thisTab = e.target; 
      $(urlTarget).load(url);

  });
    
  $('.ajax2').click(function (e) {
      var thisTab = e.target; 
      var pageTarget = $(thisTab).attr('href');
      console.log("clicked tab");
      $(thisTab).load(pageTarget);

  });
  
  $("a[data-target=#show_photo]").click(function(ev) {
      ev.preventDefault();
      $("#show_photo").modal(); 
      $("#show_photo .modal-body").find("img")[0].src=$(this).attr("href");
      console.log("Image loaded");
      $("#show_photo").modal(); 
  });
})

