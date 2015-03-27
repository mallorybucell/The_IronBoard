class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable, omniauth_providers: [:github]

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

  def self.from_omniauth(auth)
    binding.pry
    User.where(email: auth.info.email).first_or_create! do |u|
      u.email              = auth.info.email
      u.username           = auth.info.nickname

      u.password           = Devise.friendly_token[0,20]
      u.github_data        = auth.to_h
    end
  end

  def generate_invite_email params
    {
      :subject => "Join the IronBoard",
      :from_name => "The IronBoard",
      :text => "Hello fellow IronYarder!\n\nI love playing games and would like to keep track of our game history. Visit our website so we can log our plays.\n\nFrom #{username},\n\nThanks, The IronBoard.",
      :to => [
        {
          :email=> "#{params['email']}",
          :name => "#{params['name']}"
        }
      ],
      :from_email=>"donotreply@theironboard.com"
    }
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
