require 'rails_helper'

RSpec.describe UserGame, type: :model do
  it 'can not have the same user more than once per game' do
    u1 = FactoryGirl.create :user
    u2 = FactoryGirl.create :user
    u3 = FactoryGirl.create :user
    g1 = FactoryGirl.create :game
  end
end
