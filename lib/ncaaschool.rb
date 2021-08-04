# frozen_string_literal: true
require 'nokogiri'
require 'open-uri'
require 'csv'
require './lib/college'
require 'json'
#require './lib/export_csv.rb'
# require_relative "ncaaschool/version"

class Ncaaschool

  # get each college page url on NCAA website and put them in an array
  def initialize

    
    # for each college page on ncaa.com
    @college_pages = []
    # hash is better than array
    @schools = {}
    

    temps = []
    # for i in 0..23
    for i in 0..1
      doc = Nokogiri::HTML(URI.open('https://www.ncaa.com/schools-index/' + i.to_s))
      # .abc for class, abc for html tags

      temps = doc.css('.responsive-enabled').css('div').css('a')
      # puts temp

      temps.each do |temp|
        begin
          college_page_url = 'https://www.ncaa.com' + temp.attribute('href').value
          @college_pages.push(college_page_url)
          doc = Nokogiri::HTML(URI.open(college_page_url))
          
          
          division_and_location = doc.css('.school-header').css('.division-location').text.strip

          # some schools aren't in any divisions
          if division_and_location.start_with?("Divi")
            dv = division_and_location.strip.split('-')
            division = dv[0].strip
            location = dv[1].strip
          else
            division = ""
            location = division_and_location
          end

          name = doc.css('.school-header').css('h1').text.strip
          details = doc.css('.school-header').css('.school-details').css('dd')
          conference = details[0].text.gsub(/<.*?\/?>/, '')
          nickname = details[1].text.gsub(/<.*?\/?>/, '')
          colors = details[2].text.gsub(/<.*?\/?>/, '')

        rescue NoMethodError => e
        rescue => e
        end
        # puts name
        begin
          college_links = doc.css('.school-header').css('.school-links').css('a')
          website = college_links[0].attribute('href').value.insert(4, 's')
          twitter = college_links[1].attribute('href').value
          facebook = college_links[2].attribute('href').value
        rescue NoMethodError => e
        rescue => e
        end
        # puts details[0]

        s = College.new(name, division, location, conference, nickname, colors, website, twitter, facebook)


        # name => College object
        @schools[s.name] = s
        # puts @schools.to_json
        # puts @schools.to_json
        # puts JSON.pretty_generate(@schools)

      end
    end
  end




  # return a College object
  def find_by_name college_name
    @schools[college_name]
  end



  def how_many?
    puts "The number of schools in NCAA is " + @schools.length.to_s
  end



  def export_json
    dname = "./outputs"
    Dir.mkdir(dname) unless File.exists?(dname)
    f = File.open("./outputs/ncaa_schools.json", "w")
    # if filename.nil?
    #   File.open("./outputs/ncaa_schools.json", "w")
    # else
    #   filename = "./outputs/"+filename+".json"
    #   File.open(filename, "w")
    # end
    f.write(JSON.pretty_generate(@schools))      
  end



end