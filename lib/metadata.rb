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
    return response
  end

end