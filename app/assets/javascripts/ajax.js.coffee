class @Ajax
  constructor: (@method, @url, @params) ->

  call: (callbacks = {}) ->
    $.ajax
      type: @method
      url: @url
      data: @params
      cache: false

      # see http://stackoverflow.com/questions/7203304/warning-cant-verify-csrf-token-authenticity-rails
      beforeSend: (xhr) ->
        token = $('meta[name="csrf-token"]').attr('content')
        xhr.setRequestHeader('X-CSRF-Token', token)

      success: (data, textStatus, jqXHR) =>
        callbacks.success(data, textStatus, jqXHR) if callbacks.success

      error: (jqXHR, textStatus, errorThrown) =>
        try
          response = JSON.parse(jqXHR.responseText)
          console.log("error: " + response.message, response)
        catch error # if we can't parse the response
          console.log("#{textStatus} #{@url} #{errorThrown}", jqXHR)
          console.log(JSON.stringify(jqXHR))

        # todo: two types of error callback (one where the server returns a well-formed JSON packet)
        # (and maybe if it's a catastrophe we don't even call the callback)
        callbacks.error(jqXHR, textStatus, errorThrown) if callbacks.error

