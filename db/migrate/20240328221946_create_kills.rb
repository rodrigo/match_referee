class CreateKills < ActiveRecord::Migration[7.1]
  def change
    create_table :kills do |t|
      t.string :author
      t.string :victim
      t.string :weapon
      t.integer :match_id
      t.time :time

      t.timestamps
    end
  end
end
