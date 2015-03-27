FactoryGirl.define do
  factory :token do
    key SecureRandom.hex 24

    admin
  
  end

end
