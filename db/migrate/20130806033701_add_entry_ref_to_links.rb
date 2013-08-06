class AddEntryRefToLinks < ActiveRecord::Migration
  def change
    add_reference :links, :entry, index: true
  end
end
