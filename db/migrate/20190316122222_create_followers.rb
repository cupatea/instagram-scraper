class CreateFollowers < ActiveRecord::Migration[6.0]
  def change
    create_table :followers do |t|
      t.integer :count
      t.datetime :scrape_time
      t.timestamps
    end
  end
end
