class CreateKills < ActiveRecord::Migration[7.1]
  def change
    create_table :kills do |t|
      t.integer :author_game_id
      t.integer :victim_game_id
      t.string :weapon
      t.integer :match_id

      t.timestamps
    end
  end
end
