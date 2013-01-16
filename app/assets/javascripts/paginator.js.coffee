NEXT_WHICH = 0

class @Paginator

  constructor: (@receiver, @waypoint_selector, @version_store, @group_id = null, @page_size = 20 ) ->
    @more_pages = true
    @page = 1
    @stopped = false

    @which = NEXT_WHICH
    NEXT_WHICH++

  say: (msg) ->
    msg = "paginator " + @which + " (group " + @group_id + ") " + msg
    msg = "stopped " + msg if @stopped
    #console.log(msg)

  next_page: =>
    if @more_pages and !@stopped
      @say("loading page " + @page)
      fetched_page = @page
      options = {page: @page, page_size: @page_size, only_with_comments: true}
      if @group_id
        path = "/api/groups/" + @group_id + "/versions.json"
      else
        path = "/api/versions.json"
      @call_ajax("GET", path, options,
      success: (data, textStatus, jqXHR) =>
        @say("ajax returned")
        versions = data.versions
        @got_page(versions, fetched_page)
      )
      $("abbr.timeago").timeago()
      @page += 1

  got_page: (versions, page) ->
    return if @stopped
    @say("got page " + page + " " + versions.length)
    @version_store.put(versions)
    @receiver.show_versions(versions, page)
    @more_pages = (versions.length >= @page_size)
    @set_waypoint()

  call_ajax: (method, url, params, callbacks) ->
    new Ajax(method, url, params).call(callbacks)

  stop: ->
    @say("stopping")
    @stopped = true
    @remove_waypoint()
