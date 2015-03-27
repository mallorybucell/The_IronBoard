require 'rails_helper'

RSpec.describe ApiController, type: :controller do

  it 'requires a valid token before performing actions' do

    key = "d89f8712eb03c0b0b1077480d46f9cb8e7724359afe7ae6c"
    token = Token.create!(admin_id: 1, key: key, description: "test")

    get :test, { token: token.key }
    expect(response.code.to_i).to eq 200

    token.update!(active: false)

    get :test, { token: token.key }
    expect(response.code.to_i).to eq 404

  end

end