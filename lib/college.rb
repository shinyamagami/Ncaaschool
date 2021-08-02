# frozen_string_literal: true
require 'json'

module College
  class Error < StandardError; end


  class College
    attr_accessor :name, :url, :nickname, :conference, :division, :location,
                  :website, :twitter, :facebook

    def initialize(name, division, location, conference, nickname, website, twitter, facebook)
      @name = name
      @division = division
      @location = location
      @conference = conference
      @nickname = nickname
      @website = website
      @twitter = twitter
      @facebook = facebook



      # # for each college page on ncaa.com
      # @college_pages = []
      # # hash is better than array
      # @teams = {}
      

      # temps = []
      # for i in 0..23
      #   doc = Nokogiri::HTML(URI.open('https://www.ncaa.com/schools-index/' + i.to_s))
      #   # .abc for class, abc for html tags

      #   temps = doc.css('.responsive-enabled').css('div').css('a')
      #   # puts temp

      #   temps.each do |temp|
      #     begin
      #       college_page_url = 'https://www.ncaa.com' + temp.attribute('href').value
      #       @college_pages.push(college_page_url)
      #       doc = Nokogiri::HTML(URI.open(college_page_url))
            
      #       # some schools aren't in any divisions
      #       division_and_location = doc.css('.school-header').css('.division-location').text
      #       if division_and_location.start_with?("DIVI")
      #         dv = division_and_location.strip.split('-')
      #         division = dv[0].strip
      #         location = dv[1].strip
      #       else
      #         division = ""
      #         location = division_and_location
      #       end

      #       name = doc.css('.school-header').css('h1').text.strip
      #       details = doc.css('.school-header').css('.school-details').css('dd')
      #       conference = details[0].text.gsub(/<.*?\/?>/, '')
      #       nickname = details[1].text.gsub(/<.*?\/?>/, '')

      #     rescue NoMethodError => e
      #     rescue => e
      #     end
      #     # puts name
      #     begin
      #       college_links = doc.css('.school-header').css('.school-links').css('a')
      #       website = college_links[0].attribute('href').value
      #       twitter = college_links[1].attribute('href').value
      #       facebook = college_links[2].attribute('href').value
      #     rescue NoMethodError => e
      #     rescue => e
      #     end
      #     # puts details[0]

      #     s = College::College.new(name, division, location, conference, nickname, website, twitter, facebook)



      #     @schools[:s.name] = s
      #     puts @schools[:s.name].name
      #   end
      # end      
    end
    

    
    def to_builder
      Jbuilder.new do |college|
        college.(self, :name, :url, :nickname, :conference, :division, :location,
                       :website, :twitter, :facebook)
      end
    end
  



  end
end


