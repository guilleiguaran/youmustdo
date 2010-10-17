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

  def avatar_for(user)
    case user.avatar_type
      when "1"
        facebook_avatar(user)
      when "2"
        twitter_avatar(user)
      when "3"
        gravatar_for(user)
      when "4"
        external_url_avatar(user)
      when "5"
        uploaded_avatar(user)
    end
  end

  def external_url_avatar(user)
    return image_tag(user.external_avatar_url, :height => 48)
  end

  def gravatar_for(user, pic = "avatar.png", options = {})
    RAILS_ENV == 'development' ? default = "http://youmustdo.local/images/#{pic}" : default = "#{request.protocol}#{request.host}/images/#{pic}"
    subdomain = (request.protocol == "https://") ? "secure" : "www"
    return link_to image_tag("#{request.protocol}#{subdomain}.gravatar.com/avatar.php?default=#{default}&gravatar_id=#{Digest::MD5.hexdigest(user.email)}", :alt => user.username, :height => 48), 'http://en.gravatar.com/site/login'
  end

  def facebook_avatar(user)
    image_tag("https://graph.facebook.com/me/picture?access_token=#{user.fb_access_token}&type=large",:height => 48, :alt => 'user.username')
  end

  def link_active(category,text)
    unless category.nil?
      return "active" if category.name== text
    end
    return ""
  end
  
  def twitter_avatar(user)
    return image_tag(user.avatar_url, :alt => user.screen_name)
  end
  
  def uploaded_avatar(user)
    image_tag(user.avatar.url,:height => 48)
  end

end
