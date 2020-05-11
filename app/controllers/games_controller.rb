class GamesController < ApplicationController
  require 'json'
  require 'open-uri'

  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    letters_array = params[:letters].split(' ')
    url = "https://wagon-dictionary.herokuapp.com/#{params[:answer]}"
    answer_array = params[:answer].split('')

    word_hash = open(url).read
    word_parse = JSON.parse(word_hash)
    word_check = word_parse['found']

    @play_game =
      if word_check == true && (answer_array - letters_array).empty?
        "Congratulations! '#{params[:answer].capitalize}' is a valid English word!"
      elsif word_check == false && (answer_array - letters_array).empty?
        "Sorry but '#{params[:answer]}' does not seem to be a valid Enlgish word."
      elsif (answer_array - letters_array).empty? == false
        "Sorry but '#{params[:answer]}' can't be built out of #{letters_array}"
      end
  end
end
