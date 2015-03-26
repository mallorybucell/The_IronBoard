class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name, null: false
      t.text :game_data, null: false
      t.text :game_summary
      t.datetime :date_played, null: false

      t.timestamps null: false
    end
  end
end
