class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :entry_id
      t.datetime :published
      t.datetime :updated
      t.string :title
      t.text :content
      t.string :author_name

      t.timestamps
    end
  end
end
