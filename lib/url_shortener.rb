require 'net/http'
require 'uri'

class UrlShortener
  HOST = "http://is.gd/api.php?longurl="

  class << self
    def shorten(long_url)
      shortened_url = get(long_url)
      shortened_url.body
    end
  end

  private

  class << self
    def gen_url(long_url)
      api_url = HOST + long_url
      api_url
    end

    def http()
      Net::HTTP
    end

    # executes a HTTP GET request
    def get(long_url)
      http.get_response(URI.parse(gen_url(long_url)))
    end
  end
end