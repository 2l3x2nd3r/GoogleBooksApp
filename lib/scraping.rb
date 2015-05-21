module Scraping
  require 'mechanize'

  def self.scrap
    bot = Mechanize.new { |a| a.ssl_version, a.verify_mode = 'TLSv1', OpenSSL::SSL::VERIFY_NONE }

    page = 'https://play.google.com/store/books/collection/topselling_paid'
    response = bot.get(page).parser
    links = response.css('div.card-content a:nth-child(1)')
    images = response.css('div.card-content img')
    names = response.css('div.details h2')
    info = {}
    
    (0..9).each do |i|
      title = names[i].text.split("#{i + 1}.")[1].split(' ').join(' ')
      link = "https://play.google.com#{links[i * 5][:href]}"
      info[i] = {title: title, link: link, image: images[i][:src]}
    end

    info
  end

end