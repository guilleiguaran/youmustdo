require 'open-uri'
require 'nokogiri'

class Metadata

  def self.get(url)
    doc = Nokogiri::HTML(open(url, "User-Agent" => "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US)"))
    baseuri = URI.parse(url)
    response = Array.new(2,'')
    response[0] = doc.at('title').text
    des_data = doc.at("meta[name=description]")
    response[1] = des_data.get_attribute('content') if des_data
    images = []
    doc.search('img').each do | img |
      if img['src'] =~ /(png|jpg|jpeg|gif)/
        begin
          iuri = baseuri + URI.parse(img['src']) 
          images << iuri
        rescue Exception => err
          #ignore this
        end
      end
    end
    response[2] = images
    response[3] = Metadata.video_process(url)
    response[4] = Metadata.embed_link(url,response[3])
    return response
  end
  
  def self.video_process(url)
    if url =~ /(youtube.com)/
      return 'youtube'
    end
    if url =~ /(vimeo.com)/
      return 'vimeo'
    end
    if url =~ /(dailymotion.com)/
      return 'dailymotion'
    end
    return ""
  end 

  def self.embed_link(url,type)
    case type
    when "youtube" then
      vid_id = url.match(/=(.+)$/)[1]
      return "http://www.youtube.com/v/#{vid_id}&hl=en&fs=1&"
    when "vimeo" then
      vid_id = url.match(/vimeo.com(.+)$/)[1]
      puts vid_id
      return "http://player.vimeo.com/video#{vid_id}?title=0&amp;byline=0&amp;portrait=0"
    when "dailymotion" then
      vid_id = url.match(/video(.+)$/)[1]
       puts vid_id
      sp = vid_id.split("_")
      return "http://www.dailymotion.com/swf/video#{sp[0]}?additionalInfos=0"
    else
      return ""
    end
  end
end