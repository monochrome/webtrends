require "uri"
require 'net/http'
require 'net/https'
require 'json'

class WtGateway
    
  def initialize(uname, pword)
    @username = uname
    @password = pword
  end
  
  def do_request(url)
    url = URI.parse(url)
    req = Net::HTTP::Get.new("#{url.path}?#{url.query}")
    req.basic_auth @username, @password 

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    response = http.start do |http| 
      http.request(req)
    end
    
    response
  end
 
end