require 'rails_helper'

describe V1::GamesController do
  render_views

  it "can list all games" do
    1.upto 5 do |i|  
      FactoryGirl.create :game, name: "Splendor"
    end
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
    FactoryGirl.create :game, name: "RtfG"
    FactoryGirl.create :game, name: "MtG"

    get(:show, {:id => '3'})
    expect(response.code.to_i).to eq 200

    json = response_json
    expect(json.class).to eq Hash
    expect(json["name"]).to eq "MtG"
    expect(json["id"]).to eq 3
  end
  # it "can list all instances of a specific game"
  # it "can list a number of recent games"
  # it "can list a number of a game's recent games"




end