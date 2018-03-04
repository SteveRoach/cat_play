class CreateJournalTags < ActiveRecord::Migration
  def change
    create_table :journal_tags do |t|
      t.references :journal, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
