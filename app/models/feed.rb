require 'open-uri'
require 'feeders'

class Feed < ActiveRecord::Base
  include Feeders
  has_many :links
  has_many :entries

  validates :title, :source_url, presence: true


  def update_feed
    self.send "update_entries_#{self.source_type}", self
  end  

end
