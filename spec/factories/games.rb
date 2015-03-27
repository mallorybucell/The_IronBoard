FactoryGirl.define do
  factory :game do
    name  { ["Splendor", "Race for the Galaxy"].sample }
    game_data "none"
    game_summary "placeholder text"
    sequence(:date_played) { |n| DateTime.new(2015, 3, n, 22, 49, 31) }
  end

end
