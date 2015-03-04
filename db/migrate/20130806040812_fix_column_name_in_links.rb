class FixColumnNameInLinks < ActiveRecord::Migration
  def change
    rename_column :links, :feeds_id, :feed_id
  end
end
