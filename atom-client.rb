require 'net/http'
#require 'open-uri'
require 'rubygems'
require 'nokogiri'
require 'json'
	url="http://localhost:3000/products/6/who_bought"
	#url_p = URI.parse(url.gsub(/\s/,'%20'))
	#get = Net::HTTP::Get.new(url_p.path)
	#response = Net::HTTP.new(url_p.host, url_p.port).start do |http| 
	#	http.request(get)
	#end
	
	#latestFeed = Nokogiri::XML.parse(response.body)
	resp = Net::HTTP.get_response(URI.parse(url))
  	 data = resp.body



puts "XML repsonse:\n" + Nokogiri::XML.parse(data)

json_response=JSON.parse(data)

puts "JSON repsonse:\n", json_response