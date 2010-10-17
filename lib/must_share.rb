class MustShare

  class << self
    def post_to_facebook(access_token, content)
      Typhoeus::Request.post("#{FACEBOOK['site']}/me/feed", :params => {
        :message => content,
        :access_token => access_token,
        :actions => {:name => "You Must See This", :link => "http://youmustdo.com"}.to_json
      })
    end

    def post_to_twitter(client, content)
      client.update(content)
    end
  end
end