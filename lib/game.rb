# frozen_string_literal: true
require 'json'
require 'nokogiri'
require 'open-uri'


class Game
  attr_accessor :date, :time, :opponent, :location

  def initialize(date, time, opponent, location)
    @date     = date.nil? ? "" : date
    @time     = time.nil? ? "" : time
    @opponent = opponent.nil? ? "" : opponent
    @location = location.nil? ? "" : location
  end


end