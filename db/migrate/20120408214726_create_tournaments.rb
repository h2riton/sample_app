class CreateTournaments < ActiveRecord::Migration
  def self.up
    create_table :tournaments do |t|
      t.string :title
      t.integer :player_id

      t.timestamps
    end
    add_index :tournaments, [:player_id, :created_at]
  end

  def self.down
    drop_table :tournaments
  end
end
