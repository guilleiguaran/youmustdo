class MustShare

  class << self
    def post_to_facebook(access_token, content, d_url=nil)
      d_url = "http://youmustdo.com/" if d_url.nil?
      Typhoeus::Request.post("#{FACEBOOK['site']}/me/feed", :params => {
        :message => content,
        :access_token => access_token,
        :actions => {:name => "You Must See This", :link => d_url}.to_json
      })
    end

    def post_to_twitter(client, content)
      client.update(content)
    end
  end
end