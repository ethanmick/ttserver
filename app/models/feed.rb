require 'open-uri'

class Feed < ActiveRecord::Base
  has_many :links
  has_many :entries



# Update the feed
  def update_feed
    #
    # Go get the feed
    # 
    puts "Getting the Feed update"

    #get the actual feed
    doc = Nokogiri::XML(open(self.links[1].href)) #hacking

#    puts "The doc: #{doc}"

    #parse the xml feed into something we can use

    doc.xpath('entry').each do |entry|
#      puts entry.content
      puts "Title: #{entry.at_xpath('title')}"

      #build the entry object if it's updated date is later

    end

    #for each entry... do something

    # For each entry, if the updated date is later than our current updated date, create the new
    # entry and insert it. If the updated date is not, we are up to date, stop iterating

    #save

  end

end
