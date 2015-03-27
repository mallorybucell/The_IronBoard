FactoryGirl.define do
  factory :game do
    name  { ["Splendor", "Race for the Galaxy"].sample }
    game_data "none"
    game_summary "placeholder text"
    sequence(:date_played) { |n| Datetime.new(2015, 3, n, Time.now) }
  end

end
