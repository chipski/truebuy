# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  $('.dropdown-toggle').dropdown()
  #($ "a[data-toggle=dropdown]").button() 
  
  
  MasonryOptions = {itemSelector: '.card', columnWidth: 312, gutterWidth: 8, animationOptions: {duration: 400}}
  #$('#masonry').masonry(MasonryOptions)
  #$('#masonry').masonry("reload")
  console.log("Loaded masonry with #{MasonryOptions.columnWidth} from bootstrap.js")
  # below does not work right
  #$('.datatable').dataTable({
  #  "sDom": "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
  #  "sPaginationType": "bootstrap"
  #})
  
  #($ "a[data-target]").click (e) ->   
  #  e.preventDefault()
  #  target =  ($ @).attr('data-target')
  #  tab_name= ($ @).attr('data-act') || null
  #  url =     ($ @).attr('href')
  #  card =    ($ @).closest(target) 
  #  console.log("Found data-target of "+target+" tab_name of "+tab_name+" and url of "+url)
  #  card.addClass("card_focus") 
  #  if (tab_name == "inactive")  
  #    old_tab_name = "actived"
  #  else
  #    old_tab_name = "actived"                                
  #  ($ ".tab-content").find("##{old_tab_name}").removeClass('active')  
  #  #console.log(" removed active class on #{old_tab_name} ") 
  #  if tab_name == "list_only"  
  #      console.log("Found list only card")
  #      card.delete
  #  else
  #      ($ "a[href='##{tab_name}']").tab('show')           
  #      ($ ".tab-content").find("##{tab_name}").addClass('active')   
  #  console.log("Adding card to tab #{tab_name}")
  #  #($ ".tab-content").find("##{tab_name} #masonry .card:last").after(card)        
  #  ($ ".tab-content").find("##{tab_name} #masonry").masonry(MasonryOptions) 
  #  console.log("Loaded masonry with #{MasonryOptions.columnWidth} from click data-target ") 
  #  ($ ".tab-content").find("##{tab_name} #masonry").prepend(card).masonry('reload')      
     
  

  add_root_formsOFF = (e) ->
     console.log("submiting root forms")
     ($ ".form-row").submit()

  $ ->
    $(".form_rowsOFF .btn-primary").click(
      (e) ->
        e.preventDefault()
        e.stopPropagation()
        console.log("js is still trying to post form")
        #$(".form-row").submit()
    );
    $(".form-rows").focus()
     
  #($ ".tab-pane").show ->
  #  ($ @).find("#masonry").masonry({ itemSelector: '.card', columnWidth: 306, gutterWidth: 10 })
  #  console.log(" activated masonry on tab contents ")                                   
  #  
    

