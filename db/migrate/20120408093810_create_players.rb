class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :nickname
      t.integer :user_id

      t.timestamps
    end
  end
end
