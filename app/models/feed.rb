require 'open-uri'

class Feed < ActiveRecord::Base
  include AtomFeed
  has_many :links
  has_many :entries


  def update_feed
    
  end


end
