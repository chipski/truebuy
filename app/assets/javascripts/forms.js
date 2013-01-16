
search = function() {
  
  // === Handle site search
  $('.advanced_search').find('form').submit(function(e) {
    var form = $(this);
    window.location = form.attr('action') + "?" + form.serialize();
    return false;
  });
  
  function init_autocomplete() {
    var opts = { minChars:1, matchSubset:true, matchContains:true, width:184, cacheLength:10, selectOnly:1, maxItemsToShow:10, loadingClass:null, expandToWidth: true };
    var data_url = '/products/autocomplete.js';
    $('.advanced_search #u').autocomplete(data_url, opts);
  }
  
  // == Initialization
  init_autocomplete();
  
}