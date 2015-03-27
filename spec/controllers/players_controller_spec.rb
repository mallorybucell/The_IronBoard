require 'rails_helper'

RSpec.describe V1::PlayersController do
  render_views
  #FIXME Specs fail b/c Time weirdness, NOT return vals on manual check.
  it "can get specific users recent games with no limit" do
    
    u1 = FactoryGirl.create :user
    n = 1

    #15 games in March
    1.upto 15 do |i|  
      FactoryGirl.create :game do |g|
        g.update! date_played: (Date.new(2015, 3, n) + Time.new(22, 49, 31)) 
        n += 1
        UserGame.create(user_id: u1.id, game_id: g.id)
      end
    end
    
    #5 games in April
    1.upto 7 do |i|  
      FactoryGirl.create :game do |g|
        g.update! date_played: (Date.new(2015, 3, n) + Time.new(22, 49, 31))
        n += 1
        UserGame.create(user_id: u1.id, game_id: g.id)
      end
    end

    id = u1.id
    get(:recent_games, { id: id })
    expect(response.code.to_i).to eq 200

    json = response_json
    expect(json.class).to eq Array
    expect(json.count).to eq 20
    expect(json.first["date_played"]).to be > json.last["date_played"]
    #FIXME this last assertion seems wonky
  end

  it "can get specific users recent games with limit" do
    u1 = FactoryGirl.create :user
    n = 0
    n += 1

    #10 games in March
    1.upto 10 do |i|  
      FactoryGirl.create :game do |g|
        g.update! date_played: (DateTime.new(2015, 3, n, 00, 49, 21))
        n += 1
        UserGame.create(user_id: u1.id, game_id: g.id)
      end
    end
    
    #15 games in February
    1.upto 15 do |i|  
      FactoryGirl.create :game do |g|
        g.update! date_played: (DateTime.new(2015, 2, n, 00, 49, 21))
        n += 1
        UserGame.create(user_id: u1.id, game_id: g.id)
      end
    end

    id = u1.id
    get(:recent_games, { id: id, limit: 15 })
    expect(response.code.to_i).to eq 200

    json = response_json
    expect(json.class).to eq Array
    expect(json.count).to eq 15
    expect(json.first["date_played"]).to be > json.last["date_played"]
    #FIXME this last assertion seems wonky
  end

  # it 'requires a valid token before performing actions' do

  #   key = "d89f8712eb03c0b0b1077480d46f9cb8e7724359afe7ae6c"
  #   token = Token.create!(admin_id: 1, key: key, description: "test")

  #   get :index, { token: token.key }
  #   expect(response.code.to_i).to eq 200

  #   token.update!(active: false)

  #   get :index, { token: token.key }
  #   expect(response.code.to_i).to eq 404

  # end

  # it 'handles errors gracefully' do
  # end

end