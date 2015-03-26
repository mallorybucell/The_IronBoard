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
end