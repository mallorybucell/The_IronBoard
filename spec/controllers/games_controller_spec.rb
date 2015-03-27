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




end