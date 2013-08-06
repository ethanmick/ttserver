class Feed < ActiveRecord::Base
  has_many :links, :entries


  def update_feed
    #
    # Go get the feed
    # 
    puts "Getting the Feed"
  end

end
