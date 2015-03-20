class GamesController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @game = Game.new_game current_user
    render :new
  end

  def play
    @game = Game.find(UserGame.find_by(user_id: current_user.id).game_id)
    # what is going on here ^^
    if @game.guesses_left > 0
      guess = params[:guess]
      word = @game.word
      if Game.repeat? @game, guess
        @repeat = true
      else
        Game.check_guess word, guess, @game
      end
      @won = Game.won @game
     
      # check_guess is doing too much!
      # should be take_turn or some such.
      # also, this controller is doing far too much.
    end

    render :play
    #redirect_to games_play_path
  end


end