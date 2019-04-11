require 'rubygems'
require 'nokogiri'
require 'open-uri'

def cours_crypto
	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
	@prix = []
	@nom = []
	page.xpath('//a').each do |x|
		if x.to_s.include?('class="currency-name-container link-secondary"')
			@nom << x.text
  		elsif x.to_s.include?('class="price"')
			@prix << x.text
		end
	end
  return @nom, @prix
end

cours_crypto
crypto_name_and_currency= Hash[@nom.zip(@prix)]
puts crypto_name_and_currency
