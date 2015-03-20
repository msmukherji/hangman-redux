class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :word
      t.string :guesses
      t.integer :guesses_left
      t.timestamps null: false
    end
  end
end
