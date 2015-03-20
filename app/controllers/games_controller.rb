class GamesController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @game = Game.new_game current_user
    #@guess = ""
    render :new
  end

  def play
    @game = Game.find(UserGame.find_by(user_id: current_user.id).game_id)
    if @game.guesses_left > 0
      binding.pry
      guess = params[:guess]
      word = @game.word
      Game.check_guess word, guess, @game
      # check_guess is doing too much!
      # should be take_turn or some such.
      @won = Game.won @game
      #won?
    end

    render :play
    #redirect_to games_play_path
  end

  # def won?
  #   @game = Game.find(UserGame.find_by(user_id: current_user.id).game_id)
  #   @won = Game.won @game
  # end

end