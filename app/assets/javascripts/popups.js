
//= require jquery
//= require twitter/bootstrap
//= require bootstrap-wysihtml5
//  require spin.min.js   
//= require jquery.raty.js
//= require letsrate.js

$('document').ready(function() {
  $('.wysihtml5').each(function(i, elem) {
    $(elem).wysihtml5();
  });  
})