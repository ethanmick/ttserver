class AddFeedRefToLinks < ActiveRecord::Migration
  def change
    add_reference :links, :feeds, index: true
  end
end
