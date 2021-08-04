# frozen_string_literal: true
require "json"



class College
  attr_accessor :name, :division, :location, :conference, :nickname, :colors,
                :website, :twitter, :facebook, :team

  def initialize(name, division, location, conference, nickname, colors, website, twitter, facebook)
    @name       = name
    @division   = division
    @location   = location
    @conference = conference
    @nickname   = nickname
    @colors     = colors
    @website    = website.nil? ? "" : website
    @twitter    = twitter.nil? ? "" : twitter
    @facebook   = facebook.nil? ? "" : facebook
    # some colleges don't have websites
    unless @website.empty? || !@division.eql?("Division I")
    # unless @website.empty?
      puts @division
      @team = Team.new(@website)
    end
  end

  
  # to convert a college object into json
  def as_json(options={}){
    name:       @name,
    division:   @division,
    location:   @location,  
    conference: @conference,          
    nickname:   @nickname,
    colors:     @colors,
    website:    @website,
    twitter:    @twitter,
    facebook:   @facebook
  }
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end    



end


