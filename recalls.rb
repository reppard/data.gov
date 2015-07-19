# encoding: UTF-8
require 'nokogiri'
require 'open-uri'

url = 'http://www.cpsc.gov/en/Newsroom/CPSC-RSS-Feed/Recalls-RSS/'

doc = Nokogiri::HTML(open(url))

doc.xpath("//item").each do |item|
  puts "+----------------------------------"
  puts "|#{item.css("title").text.upcase}"
  puts "|#{item.css("guid").text}"
  puts "|#{item.css("description").text}"
  puts "|#{item.css("pubdate").text}"
  puts "+------------------------------------------"
end
