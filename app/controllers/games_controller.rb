class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    @result = {}
    @word = params[:word]
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    serialized_response = open(url).read
    attempts = JSON.parse(serialized_response)
    arr_att = @word.upcase.split(//)
    if attempts["found"] != true
      @result = { score: 0, message: "not an english word" }
    elsif arr_att.all? { |e| @letters.include?(e) } && arr_att.all? { |e| arr_att.count(e) <= @letters.count(e) }
      @result = { score: 50, message: "well done" }
    else
      @result = { score: 0, message: "not in the grid" }
    end
  end
end


