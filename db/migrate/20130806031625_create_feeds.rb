class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title
      t.string :subtitle
      t.string :feed_id
      t.datetime :updated
      t.string :rights

      t.timestamps
    end
  end
end
