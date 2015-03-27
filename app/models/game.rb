class Game < ActiveRecord::Base
  has_many :user_games
  has_many :users, through: :user_games

  def self.generate_games number
    number.times do |g|
      g = Game.new
      g.name = ["splendor", "race for the galaxy"].sample
      g.game_data = Faker::Lorem.words(4)
      g.game_summary = "#{Faker::Lorem.paragraph}\n#{Faker::Lorem.paragraph}"
      g.date_played = Faker::Time.between(2.days.ago, Time.now)
      g.save!
    end
  end

  def self.new_game data
    g = Game.new
    g.name = data[:game_name]
    g.game_data = data[:gamedata]
    g.game_summary = data[:game_summary]
    g.date_played = data[:date]
    g.winner = data[:winner]
    g.save!

    data[:gamedata].each do |x|
      user = User.where(username: x[:user_name]).first
      user.games << g
      UserGame.update_wins data[:winner]
    end
  end

  
end