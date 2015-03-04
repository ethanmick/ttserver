class AddProvidesFullContentToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :provides_full_content, :boolean
  end
end
