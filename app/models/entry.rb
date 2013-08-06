class Entry < ActiveRecord::Base
  has_many :links
  belongs_to :feed
end
