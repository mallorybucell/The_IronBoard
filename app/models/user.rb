class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_games
  has_many :games, through: :user_games

  after_initialize :defaults

  def defaults
    case self.sex
    when "male"
      self.avatar_url = 'http://icons.iconarchive.com/icons/aha-soft/iron-man/256/Tony-Stark-icon.png'
    when "female"
      self.avatar_url = 'http://icons.iconarchive.com/icons/aha-soft/iron-man/256/Pepper-Potts-icon.png'
    else
      self.avatar_url = 'http://www.medgadget.com/wp-content/uploads/2013/05/Iron-Yard.png'
    end
  end

  def self.generate_users number
    number.times do |u|
      u = User.new
      u.email = Faker::Internet.email
      u.password = Faker::Internet.password(8)
      u.username = Faker::Internet.user_name
      u.sex = ["male", "female"].sample
      u.save!
    end
  end
end
