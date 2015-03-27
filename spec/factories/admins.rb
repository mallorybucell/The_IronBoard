FactoryGirl.define do
  factory :admin do

    sequence(:email) { |n| "admin#{n}@example.com" }

    factory :admin_with_tokens do
      # posts_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      transient do
        tokens_count 1
      end

      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the post
      after(:create) do |admin, evaluator|
        create_list(:tokens, evaluator.tokens_count, admin: admin)
      end
    end

  end

end
