#  Top level redirects for all traffic
#  enforce ssl, www, and no trailing /
#  to redirect to api or mobile web for mobile devices

module Rack
  class TopRedirects
    def initialize(app)
      @app = app
    end
 
    def call(env)
      request = Rack::Request.new env
      url = request.url
      url.sub!('//www.', '//') if request.host =~ /^www\./
      url.chomp!('/') if request.path_info =~ %r{^/(.*)/$}
 
      if url != request.url
        [301, { 'Location' => url, 'Content-Type' => 'text/html' }, []]
      else
        @app.call(env)
      end
    end
  end
end