require 'rails_helper'

RSpec.describe UserGame, type: :model do
  it 'can not have the same user more than once per game' do
    u1 = FactoryGirl.create :user
    u2 = FactoryGirl.create :user
    g1 = FactoryGirl.create :game
    
    g2 = FactoryGirl.create :game

    UserGame.create!(user_id: u1.id, game_id: g1.id)
    UserGame.create!(user_id: u2.id, game_id: g1.id)

    expect(UserGame.count).to eq 2

    UserGame.create!(user_id: u1.id, game_id: g2.id)
    expect(UserGame.count).to eq 3
    expect(u1.games.count).to eq 2

    expect do
      UserGame.create!(user_id: u1.id, game_id: g1.id)
    end.to raise_error 
  end
end
