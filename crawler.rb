require 'rubygems'
require 'mechanize'
require 'csv'

def extract_data(content,csv)
    
    info1=content.search('div.row')
	info2=content.search('div.listing_content div:last')
	
	name=info1[0].search('a').text.strip
	address=info1[1].search('div.left p').text
	phone=info2.search('p:last').text.split(':')[1]
	
    csv << [name, address, phone]
    print name+address+phone
end


agent = Mechanize.new
page=agent.get('http://www.veterinarians.com/city/Palo%20Alto_CA.html')
contents=page.search 'div.listing'

csv=CSV.open('data.csv','w')
csv << ["Name", " Address", " Phone"] 

if contents.respond_to?("each")
	contents.each do |content|
	   extract_data(content,csv)			
	end
end

