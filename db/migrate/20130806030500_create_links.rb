class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :href
      t.string :rel
      t.string :type
      t.string :hreflang
      t.string :title
      t.integer :length

      t.timestamps
    end
  end
end
