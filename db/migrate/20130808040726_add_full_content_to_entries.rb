class AddFullContentToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :full_content, :text
  end
end
