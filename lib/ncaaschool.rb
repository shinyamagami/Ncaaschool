# frozen_string_literal: true
require 'nokogiri'
require 'open-uri'
require 'csv'
require './lib/college'
require 'json'
require "active_support"
require 'carmen'


#require './lib/export_csv.rb'
# require_relative "ncaaschool/version"

class Ncaaschool
  include Carmen


  # get each college page url on NCAA website and put them in an array
  def initialize

    
    # for each college page on ncaa.com
    @college_pages = []
    # hash is better than array but decided to use an array
    @schools = []
    

    temps = []
    for i in 0..23
    # for i in 0..1
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
            dv = division_and_location.strip.split('-', 2)
            division = dv[0].strip
            location = dv[1].split(',')
            city = location[0].strip
            state = Country.coded('US').subregions.coded(location[1].strip).name

          else
            division = ""
            location = division_and_location.split(',')
            city = location[0].strip
            state = Country.coded('US').subregions.coded(location[1].strip).name
          end

          name = doc.css('.school-header').css('h1').text.strip
          details = doc.css('.school-header').css('.school-details').css('dd')
          conference = details[0].text.gsub(/<.*?\/?>/, '')
          nickname = details[1].text.gsub(/<.*?\/?>/, '')
          colors = details[2].text.gsub(/<.*?\/?>/, '')

        rescue NoMethodError => e
        rescue => e
        end

        begin
          college_links = doc.css('.school-header').css('.school-links').css('a')
          website = college_links[0].attribute('href').value.insert(4, 's')
          # website    = website.nil? ? "" : website
          twitter = college_links[1].attribute('href').value
          # twitter    = twitter.nil? ? "" : twitter
          facebook = college_links[2].attribute('href').value
          # facebook   = facebook.nil? ? "" : facebook
        rescue NoMethodError => e
        rescue => e
        end
        # puts details[0]


        college = {"name": name, "division": division, "city": city,
          "state": state, "conference": conference, "nickname": nickname,
          "colors": colors, "website": website,
          "twitter": twitter, "facebook": facebook}

        college.each do |key, value|
          if value.nil?
            college[key] = ""
          end
        end

        @schools.push(college)
        puts name



        # this puts college objects in a hash with names as keys and objects as values
        # s = College.new(name, division, city, state, conference, nickname, colors, website, twitter, facebook)
        # @schools[s.name] = s
        



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


  def export_csv
    def create(name_of_campus, time)
      file_name = "./outputs/" + name_of_campus + "_" + time + ".csv"
      @csv = CSV.new(file_name)
      @csv = CSV.open(file_name, "wb")
      column_names = ["name", "division", "city" ,"state", "conference", "nickname",
                      "colors", "website", "twitter", "facebook"]
      @csv << column_names
    end

    def write_row(row_values)
      @csv << row_values
    end    
    
  end


end