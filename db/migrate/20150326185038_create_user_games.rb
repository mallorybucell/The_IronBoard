class CreateUserGames < ActiveRecord::Migration
  def change
    create_table :user_games do |t|
      t.belongs_to :user, index: true
      t.belongs_to :game, index: true
      t.boolean :winner

      t.timestamps null: false
    end
    add_foreign_key :user_games, :users
    add_foreign_key :user_games, :games
  end
end
