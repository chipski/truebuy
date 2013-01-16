
#= require ajax
#= require paginator

$ =>
  @feed_page = new Paginator()
  console.log("git hash: ")
  #wizard = new Wizard if $('body').attr('data-show_wizard') == "true"
  #$('.help_link').click =>
  #    new Wizard