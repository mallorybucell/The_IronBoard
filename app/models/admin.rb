class Admin < ActiveRecord::Base
  devise :database_authenticatable, :timeoutable, :registerable

  has_many :tokens

  def generate_api_token!(description)
    begin
      key = SecureRandom.hex 24 # TODO: what if this collides?
    end while Token.exists?(key: key)
    
    tokens.create!(key: key, description: description)
  end

end
