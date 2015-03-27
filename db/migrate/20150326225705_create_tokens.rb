class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string      :description
      t.string      :key
      t.boolean     :active, default: true
      t.belongs_to  :admin

      t.timestamps null: false
    end
  end
end
