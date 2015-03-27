require 'rails_helper'

describe V1::PlayersController do
  render_views

  it "can get specific user's recent games with no limit" do
    
    user = FactoryGirl.create :user

    1.upto 15 do |i|  
      FactoryGirl.create :game do |g|
        binding.pry
        UserGame.create(user_id: user.id, game_id: g.id)
      end
    end
    1.upto 5 do |i|  
      FactoryGirl.create :game do |g|
        UserGame.create(user_id: user.id, game_id: g.id)
      end
    end

    get :recent_games
    expect(response.code.to_i).to eq 200

    json = response_json
    expect(json.class).to eq Array
    expect(json.count).to eq 20
    expect(json.first["date_played"]).to be > json.last["date_played"]
  end

  # it "can get specific user's recent games with limit" do
  # end

  # it 'handles errors gracefully' do
  # end

end