class Link < ActiveRecord::Base
  belongs_to :feed
  belongs_to :entry
end
