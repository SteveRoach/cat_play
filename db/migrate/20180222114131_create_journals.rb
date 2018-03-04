class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.string :title
      t.date :posted_date
      t.string :url
      t.references :section, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
