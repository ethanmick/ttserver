class FixColumnNameInEntry < ActiveRecord::Migration
  def change
    rename_column :entries, :feed_id, :feeds_id
  end
end
