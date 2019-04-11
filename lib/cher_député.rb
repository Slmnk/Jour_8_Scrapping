require 'rubygems'
require 'nokogiri'
require 'open-uri'

def deputy_list
    page = Nokogiri::HTML(open("https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=577"))
    @deputy_names = []
    page.xpath('//h2').each do |x|
        if x.to_s.include?('class="titre_normal"')
            @deputy_names << x.text.gsub('Mme ', '').gsub('M ', '')
        end
    end
    return @deputy_names
end


def deputy_email
    page = Nokogiri::HTML(open("https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=577"))
    @deputy_emails = []
    page.xpath('//a').each do |x|
        if x.to_s.include?("@assemblee-nationale.fr") && x.text.to_s.include?('secretariat-blanchet') == false
            @deputy_emails << x.text
        end
    end
    return @deputy_emails
end

nom = deputy_list
email = deputy_email
i = 0
tab = []
deputy_email.each do
    tab << { "name" => nom[i], "email" => email[i] }
    i += 1
end

puts tab
