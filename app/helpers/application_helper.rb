# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def header(page_header)
    content_for(:header) { page_header }
  end

  def submit_or_cancel(form, name='Cancel')
    form.submit + " or " + link_to(name, 'javascript:history.go(-1);', :class => 'cancel')
  end

  def avatar_for(user, size)
    case user.avatar_type
      when "1"
        facebook_avatar(user, size)
      when "2"
        twitter_avatar(user, size)
      when "3"
        gravatar_for(user, size)
      when "4"
        external_url_avatar(user, size)
      when "5"
        uploaded_avatar(user, size)
    end
  end

  def external_url_avatar(user, size)
    return image_tag(user.external_avatar_url, :height => size)
  end

  def gravatar_for(user, size)
    RAILS_ENV == 'development' ? default = "http://youmustdo.local/images/avatar.png" : default = "#{request.protocol}#{request.host}/images/avatar.png"
    subdomain = (request.protocol == "https://") ? "secure" : "www"
    return link_to image_tag("#{request.protocol}#{subdomain}.gravatar.com/avatar.php?default=#{default}&gravatar_id=#{Digest::MD5.hexdigest(user.email)}", :alt => user.username, :height => size), 'http://en.gravatar.com/site/login'
  end

  def facebook_avatar(user, size)
    image_tag("https://graph.facebook.com/me/picture?access_token=#{user.fb_access_token}&type=large",:height => size, :alt => 'user.username')
  end

  def link_active(category,text)
    unless category.nil?
      return "active" if category.name== text
    end
    return ""
  end
  
  def twitter_avatar(user, size)
    return image_tag(user.avatar_url, :alt => user.screen_name,:height => size)
  end
  
  def uploaded_avatar(user, size)
    image_tag(user.avatar.url,:height => size)
  end

end
