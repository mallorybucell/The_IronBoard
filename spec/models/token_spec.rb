require 'rails_helper'

RSpec.describe Token, type: :model do
  
  it 'can be created' do 
    a = FactoryGirl.create :admin

    token = a.generate_api_token!("This is a test token.")

    expect(token.key.chars.count).to eq 48
    expect(token.disabled?).to be false
    expect(a.tokens).to include token
  end

  it 'can be deactivated' do
    a = FactoryGirl.create :admin

    token = a.generate_api_token!("This is a test token.")

    expect(token.disabled?).to eq false

    token.disable!
    expect(token.disabled?).to eq true
  end

  it 'has a unique key' do
    a = FactoryGirl.create :admin

    t1 = a.generate_api_token!("This is a test token.")
    t2 = a.generate_api_token!("This is a 2nd token.")
#FIXME
#Sbinding.pry
    expect do
      t2.update!(key: t1.key)
    end.to raise_error ActiveRecord::RecordInvalid
#FIXME
    expect(a.tokens.count).to eq 2
    expect(t2.key_changed?).to be false
    expect(t2.key).not_to eq t1.key
  end

end
