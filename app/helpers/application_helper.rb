# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def header(page_header)
    content_for(:header) { page_header }
  end
  
  def submit_or_cancel(form, name='Cancel')
    form.submit + " or " + link_to(name, 'javascript:history.go(-1);', :class => 'cancel')
  end
  
  def gravatar_for(user, pic = "avatar.png", options = {})
    RAILS_ENV == 'development' ? default = "http://youmustdo.local/images/#{pic}" : default = "#{request.protocol}#{request.host}/images/#{pic}"
    subdomain = (request.protocol == "https://") ? "secure" : "www"
    return link_to image_tag("#{request.protocol}#{subdomain}.gravatar.com/avatar.php?default=#{default}&gravatar_id=#{Digest::MD5.hexdigest(user.email)}", :alt => user.username, :height => 48), 'http://en.gravatar.com/site/login'
  end
  
end
