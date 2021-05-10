require 'open-uri'
require 'json'


class GamesController < ApplicationController
  def new
    set_grid
  end

  def score
    @word = params[:word].upcase
    @grid = params[:grid].split(" ")

    @notingrid = @word.chars.all? do |letter|
      @grid.count(letter) < @word.count(letter)
    end

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    validate_word = JSON.parse(open(url).read)
    @englishword = validate_word['found']

    @onepoint = ['A', 'E', 'I', 'L', 'N', 'O', 'R', 'S', 'T', 'U']
    @twopoints = ['D', 'G']
    @threepoints = ['B', 'C', 'M', 'P']
    @fourpoints = ['F', 'H', 'K', 'V', 'W', 'Y']
    @fivepoints = ['J', 'Q', 'X', 'Z']
    @sum = 0
    if !@notingrid && @englishword
      @word.chars.all? do |letter|
        if @onepoint.include?(letter)
          @sum += 1
        elsif @twopoints.include?(letter)
          @sum += 2
        elsif @threepoints.include?(letter)
          @sum += 3
        elsif @fourpoints.include?(letter)
          @sum += 4
        elsif @fivepoints.include?(letter)
          @sum += 5
      end
    end
    @sum
    session[:score] =  session[:score] ?  session[:score] + @sum : @sum

    end
  end

  def reset
    session[:score] = 0
    redirect_to new_path
  end

  private




  def set_grid
    @letters = ('A'..'Z').to_a
    @grid = 10.times.map { @letters.sample }
  end
end
