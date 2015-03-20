class Game < ActiveRecord::Base
  has_one :user, through: :user_games

  def word
    @word = "peeve"
  end

  def self.new_game user
    g = Game.create(word: @word, guesses_left: 6, guesses: "", wrong_guesses: "")
    ug = UserGame.create(game_id: g.id, user_id: user.id)
    return g 
  end

  def self.check_guess word, guess, game
    #g = Game.find(UserGame.find_by(user_id: user.id).game_id)#find_by(user_id: user.id)#
    # why doesn't self refer to the specific game
    # the method is being called on, even when i call
    # check_guess on a variable/instance variable?
    # would prefer to do self.update to passing in
    # game as an argument.
    # also:
    # why can't i find a game by the user_id on the join table?
 
    if word.include? guess
      placeholder = game.guesses || ""
      all_guesses = placeholder << guess
      game.update(guesses: "#{all_guesses}")
    else
      placeholder = game.wrong_guesses || ""
      all_wrong_guesses = placeholder << guess
      game.update(wrong_guesses: "#{all_wrong_guesses}")
      take_turn game
    end
 
  end

  def self.won game
    if game.guesses
      game.word.each_char do |letter|
        unless game.guesses.include? letter
          return false
        end
      end
    end
  end


  def self.take_turn game
    g = game.guesses_left - 1
    game.update(guesses_left: g)
  end

  def self.repeat? game, guess
    total = game.guesses + game.wrong_guesses
    total.include? guess
  end

  def self.long_guess? game, guess
    guess.length > 1
  end  

end
