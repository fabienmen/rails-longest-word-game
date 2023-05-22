require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def included?(attempt, letters)
    attempt.chars.all? { |char| attempt.count(char) <= letters.count(char) }
  end

  def english?(attempt)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{attempt}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def score
    @attempt = params[:attempt].upcase
    @letters = params[:letters]
    @included = included?(@attempt, @letters)
    @english = english?(@attempt)
  end
end




# => #<ActionController::Parameters {"attempt"=>"dj", "authenticity_token"=>"LWxJIGOjteqJTUvqdB0nCw2Q3wcZHX88sYt1P9lXDxlKDcuvqTRIny6u8FXuKXPzRDfrSc-M-sKL-8ManNLkow", "controller"=>"games", "action"=>"score"} permitted: false>
