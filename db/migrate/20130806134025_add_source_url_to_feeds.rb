class AddSourceUrlToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :source_url, :string
  end
end
