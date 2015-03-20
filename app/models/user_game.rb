class UserGame < ActiveRecord::Base
  belongs_to :users
  belongs_to :games
end
