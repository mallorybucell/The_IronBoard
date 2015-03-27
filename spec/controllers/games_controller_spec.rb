require 'rails_helper'

describe V1::GamesController do
  render_views

  it "can list all games" do
    much_splendor
    FactoryGirl.create :game, name: "RftG"

    get :list
    expect(response.code.to_i).to eq 200

    json = response_json
    expect(json.class).to eq Array
    expect(json.count).to eq 6
    expect(json.first["name"]).to eq "Splendor"
    expect(json.last["name"]).to eq "RftG"
  end

  it "can show a specific game" do  
    FactoryGirl.create :game, name: "Splendor"
    FactoryGirl.create :game, name: "RftG"
    FactoryGirl.create :game, name: "MtG"

    get(:show, {:id => "3"})
    expect(response.code.to_i).to eq 200

    json = response_json
    expect(json.class).to eq Hash
    expect(json["name"]).to eq "MtG"
    expect(json["id"]).to eq 3
  end

  it "can list all instances of a specific game" do
    much_splendor
    FactoryGirl.create :game, name: "MtG"
    FactoryGirl.create :game, name: "MtG"

    get(:index, {:gamename => "Splendor"})
    expect(response.code.to_i).to eq 200

    json = response_json
    expect(json.class).to eq Array
    expect(json.count).to eq 5
    expect(json.first["name"]).to eq "Splendor"
    expect(json.last["name"]).to eq "Splendor"

    get(:index, {:gamename => "MtG"})
    expect(response.code.to_i).to eq 200

    json = response_json
    expect(json.class).to eq Array
    expect(json.count).to eq 2
    expect(json.first["name"]).to eq "MtG"
    expect(json.last["name"]).to eq "MtG"
  end

  it "can list a number of recent games" do
    2.times do
      much_splendor
    end
    FactoryGirl.create :game, name: "RftG"
    FactoryGirl.create :game, name: "MtG"

    get(:recent)
    expect(response.code.to_i).to eq 200

    json = response_json
    expect(json.class).to eq Array
    expect(json.count).to eq 12
    expect(json.first["name"]).to eq "MtG"
    expect(json[1]["name"]).to eq "RftG"
    expect(json.last["name"]).to eq "Splendor"  
  end

  it "can list a number of a game's recent games" do
    2.times do
      much_splendor
    end
    FactoryGirl.create :game, name: "RftG"
    FactoryGirl.create :game, name: "MtG"

    get(:recent_game, {:gamename => "Splendor"})
    expect(response.code.to_i).to eq 200

    json = response_json
    expect(json.class).to eq Array
    expect(json.count).to eq 5
    expect(json.first["name"]).to eq "Splendor"
    expect(json.last["name"]).to eq "Splendor"

    get(:recent_game, {:gamename => "MtG"})
    expect(response.code.to_i).to eq 200

    json = response_json
    expect(json.class).to eq Array
    expect(json.count).to eq 1
    expect(json.first["name"]).to eq "MtG"
  end

  it "can add a game instance to the database" do
    User.create(email:"fake@example.com", password: "password", username: "thomas1")
    User.create(email:"fake2@example.com", password: "password", username: "gina")
    
    post(:create, {:data => { :gamedata => [{"user_name":"thomas1","score":15},{"user_name":"gina","score":10}],:game_name => "Splendor", :winner => "thomas1", :date => "2015/3/15", :game_summary => "blahblahblahblah"} })
    expect(response.code.to_i).to eq 200

    expect(User.count).to eq 2
    expect(User.last.username).to eq "gina"
    expect(Game.count).to eq 1
    expect(Game.first.name).to eq "Splendor"
    expect(UserGame.count).to eq 2
    expect(UserGame.first.winner).to eq true

  end



end