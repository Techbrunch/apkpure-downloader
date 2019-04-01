require 'nokogiri'
require 'open-uri'

user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36'
url = ARGV[0]

html = open(url, 'User-Agent' => user_agent)

doc = Nokogiri::HTML(html)
links = doc.css('.ver-wrap > li > a[href]')

links.each do |link|
  puts link['href']
  html2 = open('https://apkpure.com' + link['href'], 'User-Agent' => user_agent)
  doc2  = Nokogiri::HTML(html2)
  download_link = doc2.css('a#download_link')
  puts download_link[0]['href']
  Kernel.system("wget \"#{download_link[0]['href']}\" --content-disposition")
end
