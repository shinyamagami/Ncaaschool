# frozen_string_literal: true
require "json"
require "./lib/college"

class Team < College
  attr_accessor :website, :fb, :mbb, :wbb

  def initialize

    @fb       = Fb.new
  end

end