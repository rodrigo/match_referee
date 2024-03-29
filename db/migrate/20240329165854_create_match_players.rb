class CreateMatchPlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :match_players do |t|
      t.integer :match_id
      t.integer :game_id
      t.string :name

      t.timestamps
    end
  end
end
