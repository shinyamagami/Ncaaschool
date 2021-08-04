# frozen_string_literal: true
require 'json'
require 'nokogiri'
require 'open-uri'
require './lib/game'

class Fb
  attr_accessor :website, :twitter, :facebook, :schedule, :roster

  def initialize(website)
    # schdule is an array of games
    @schedule = []
    # some college redirects football webpage to athletic webpage
    # when they don't have football teams
    @schedule_page = website + "/sports/football/schedule"
    @roster_page   = website + "/sports/football/roster"
    begin
      Nokogiri::HTML(URI.open(@schedule_page))
    
    # not having schedule page means, a school doesn't have a team
    rescue NoMethodError => e
    rescue => e
    end    

    
    scrape_schedule
    # @roster   = scrape_roster
    puts @schedule
  end



  def scrape_schedule
    begin
      doc = Nokogiri::HTML(URI.open(@schedule_page)) 
      puts @schedule_page
    rescue NoMethodError => e
    rescue => e
    end  
    # temps = doc.css('.sidearm-schedule-games-container').at('.sidearm-schedule-game-row flex flex-wrap flex-align-center row')
    # temps = @doc.css('.sidearm-schedule-game-row flex flex-wrap flex-align-center row')
    # temps = doc.at('.sidearm-schedule-game-row flex flex-wrap flex-align-center row')

    # puts temps = doc.at_css('[id="sidearm-m-roster"]').css('.sidearm-list-card-item')
    temps = doc.css('.sidearm-schedule-games-container').css('.sidearm-schedule-game-row')
    # puts temps[0]
    scrape_game(temps)
  end


  def scrape_game(games)

    games.each do |game|
      date_time = game.css('.sidearm-schedule-game-opponent-date').css('span')
      begin 
        puts date = date_time[0].text.strip
        puts time = date_time[1].text.strip
      rescue NoMethodError => e
      rescue => e
      end
      puts opponent = game.css('.sidearm-schedule-game-opponent-name').css('a').text.strip
      puts location = game.css('.sidearm-schedule-game-location').css('span')[0].text.strip
      @schedule.push(Game.new(date, time, opponent, location))
    end
  end



  
  def scrape_roster
    
    begin
      doc = Nokogiri::HTML(URI.open(@roster_page)) 
      puts @roster_page
    rescue NoMethodError => e
    rescue => e
    end  

    # works
    puts temps = doc.at_css('[id="sidearm-m-roster"]').at('.sidearm-list-card-item')


    # temps.each do |temp|
    #   puts temp
    # end
  end


end