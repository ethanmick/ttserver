class AddSourceTypeToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :source_type, :string
  end
end
