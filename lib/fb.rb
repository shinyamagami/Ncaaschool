# frozen_string_literal: true
require 'json'
require "./lib/team"

class Fb < Team
  attr_accessor :url, :conference, :website, :twitter, :facebook,
                :schedule, :roster

  def initialize


  end
end