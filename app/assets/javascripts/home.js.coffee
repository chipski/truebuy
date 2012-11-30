# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#// load social sharing scripts if the page includes a Twitter "share" button
#function loadSocial() {
#    
#    //Twitter
#    if (typeof (twttr) != 'undefined') {
#      twttr.widgets.load();
#    } else {
#      $.getScript('http://platform.twitter.com/widgets.js');
#    }
#
#    //Facebook
#    if (typeof (FB) != 'undefined') {
#      FB.init({ status: true, cookie: true, xfbml: true });
#    } else {
#      $.getScript("http://connect.facebook.net/en_US/all.js#xfbml=1", function () {
#        FB.init({ status: true, cookie: true, xfbml: true });
#      });
#    }
#
#    //Google+
#    if (typeof (gapi) != 'undefined') {
#      $(".g-plusone").each(function () {
#        gapi.plusone.render($(this).get(0));
#      });
#    } else {
#      $.getScript('https://apis.google.com/js/plusone.js');
#    }
#}
#