require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @answer = params[:answer].downcase
    @letters = params[:letters].gsub(/[ ]/, ', ')
    @response = ''
    @url = ''

    if @answer.chars.all? { |letter| @letters.include? letter }
      @response = english_word(@answer)
    else
      @response = "Sorry, it is not possible to build #{@answer} from #{@letters}."
    end
  end

  private

  def english_word(word)
    if JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{word}.json").read)['found']
      "You win! #{word.capitalize} is an English word!"
    else
      "Sorry! #{word.capitalize} is not an english word"
    end
  end
end
