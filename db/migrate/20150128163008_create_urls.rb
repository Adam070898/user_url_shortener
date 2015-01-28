class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.belongs_to :user, index:true
      t.string :long_url, null: false
      t.string :short_url
      t.integer :clicks
      t.timestamps null: false
    end
  end
end
