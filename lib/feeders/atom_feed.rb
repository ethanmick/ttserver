#
# Gets an Atom Feed and parses it into Entries for the given feed
#

module AtomFeed

  def update_entries(feed)
    #
    # Go get the feed
    # 
    puts "Getting Atom Feed"

    if not feed.source_url.nil?
      doc = Nokogiri::XML(open(feed.source_url)) 
    else
      puts "Error - Source URL is nil!"
      return
    end

    last_entry = feed.entries.order("updated").last

    doc.xpath('//xmlns:entry').each do |entry|

      entry_updated_time = DateTime.parse entry.at_css('updated').text

      # this is the first entry ever, or the entry is newer than the last one      
      if last_entry.nil? or entry_updated_time > last_entry.updated
        
        new_entry = feed.entries.new
        new_entry.title = entry.at_css('title').text
        new_entry.entry_id = entry.at_css('id').text
        new_entry.published = DateTime.parse entry.at_css('published').text
        new_entry.updated = entry_updated_time
        new_entry.author_name = entry.at_css('author name').text
        new_entry.content = entry.at_css('content').text

        # Links
        entry.css('link').each do |link|
          new_link = new_entry.links.new
          new_link.href = link['href']
          new_link.rel = link['rel']
          new_link.url_type = link['type']
          new_link.hreflang = link['hreflang']
          new_link.title = link['title']
          new_link.length = link['length'].to_i

          new_link.save
        end

        new_entry.save
      end
    end
  end
end
