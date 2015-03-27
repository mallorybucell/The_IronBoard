require 'rails_helper'

RSpec.describe TokensController, type: :controller do

  fit 'only allows admins to access its actions' do
    u1 = FactoryGirl.create :user
    login u1

    get :create

    expect(response.code.to_i).to eq 302
    #TODO  make redirect hidden

  end

  it 'can destroy tokens' do
  end

  it 'is only accessible to admins'

end
