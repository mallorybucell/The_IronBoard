FactoryGirl.define do
  factory :game do
    name  { ["Splendor", "Race for the Galaxy"].sample }
    game_data "none"
    game_summary ""
    date_played "2015-03-26 14:46:30"
  end

end
