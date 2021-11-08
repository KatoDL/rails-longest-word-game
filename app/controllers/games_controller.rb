require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    url = open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    dictionary = JSON.parse(url.read)
    @word = params[:word].chars
    @grid = params[:letters]
    word_included_in_letters = @word.all? {|letter| @word.count(letter) <= @grid.count(letter)}

    if word_included_in_letters == false
      @answer = "sorry but #{params[:word]} cannot be built out of #{@grid}"
    elsif dictionary['found']
      @answer = "Congratulation! #{params[:word]} is a valid English word!"
    else
      @answer = "Sorry but #{params[:word]} does not seem to be a valid English word"
    end
  end
end
