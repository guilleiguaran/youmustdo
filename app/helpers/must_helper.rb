module MustHelper
  
  def show_content(must)
    unless must.url_video.nil?
      return video(must.url_video)
    end
    unless must.url_image.nil?
      return '<img src="'+must.url_image+'" class="most_image" alt="'+must.name+'" />' 
    end
    unless must.longitude.blank? or must.latitude.blank?
      return return_map(must)
    end
    return image_tag('YouMustDoTwitter watermark.jpg')
  end
    
  def show_big_content(must)
    unless must.url_video.nil?
      return bgvideo(must.url_video)
    end
    unless must.url_image.nil?
      return '<img src="'+must.url_image+'" id="bg_most_image" alt="'+must.name+'" />' 
    end
    unless must.longitude.blank? or must.latitude.blank?
      return bgreturn_map(must)
    end
    puts image_tag('YouMustDoTwitter watermark.jpg')
    return image_tag('YouMustDoTwitter watermark.jpg')
  end

  def video(url)
    if url =~ /(youtube.com)/
      return '  <object width="150" height="100"><param name="movie" value="'+url+'"></param><param name="allowFullScreen"     value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="'+url+'" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="150" height="100"></embed></object>'
    end
    if url =~ /(vimeo.com)/
      return '<iframe src="'+url+'" width="150" height="100" frameborder="0"></iframe>'
    end
    if url =~ /(dailymotion.com)/
      return '<object width="150" height="100"><param name="movie" value="'+url+'"></param><param name="allowFullScreen" value="true"></param><param name="allowScriptAccess" value="always"></param><embed type="application/x-shockwave-flash" src="'+url+'" width="480" height="270" allowfullscreen="true" allowscriptaccess="always"></embed></object>'
    end
  end
  
  def bgvideo(url)
    if url =~ /(youtube.com)/
      return '  <object width="300" height="208"><param name="movie" value="'+url+'"></param><param name="allowFullScreen"     value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="'+url+'" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="300" height="208"></embed></object>'
    end
    if url =~ /(vimeo.com)/
      return '<iframe src="'+url+'" width="300" height="208" frameborder="0"></iframe>'
    end
    if url =~ /(dailymotion.com)/
      return '<object width="300" height="208"><param name="movie" value="'+url+'"></param><param name="allowFullScreen" value="true"></param><param name="allowScriptAccess" value="always"></param><embed type="application/x-shockwave-flash" src="'+url+'" width="300" height="208" allowfullscreen="true" allowscriptaccess="always"></embed></object>'
    end
  end
  
  def return_map(must)
    return '<img src="http://maps.google.com/maps/api/staticmap?center='+must.latitude+', '+must.longitude+'&amp;zoom=11&amp;size=150x100&amp;maptype=roadmap&amp;sensor=false&amp;markers=color:blue|label:1|'+must.latitude+','+must.longitude+'" alt="Location">'
  end
  
  def bgreturn_map(must)
    return '<img src="http://maps.google.com/maps/api/staticmap?center='+must.latitude+', '+must.longitude+'&amp;zoom=11&amp;size=150x100&amp;maptype=roadmap&amp;sensor=false&amp;markers=color:blue|label:1|'+must.latitude+','+must.longitude+'" alt="Location">'
  end

end