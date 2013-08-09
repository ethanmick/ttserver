#
# Gets an Atom Feed and parses it into Entries for the given feed
#

module Feeders

  def update_entries_atom(feed)
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

        if not feed.provides_full_content
#WARNING FIX, what is the source???

          new_entry.get_full_content()
        end
      end
    end
  end

# rvm pkg install openssl; rvm reinstall all --with-open-ssl-dir=$rvm_path/usr --force
  def update_entries_hackernews(feed)

    base_url = "https://news.ycombinator.com/"

    if not feed.source_url.nil?
      doc = Nokogiri::HTML(open(feed.source_url))
    else
      puts "Error - Source URL is nil!"
      return
    end

    if doc.nil?
      puts "Error: Failure to get doc at #{feed.source_url}"
      return
    end

    last_entry = feed.entries.order("updated").last

    doc.xpath('/html/body/center/table/tr[3]/td/table/tr').to_a.each_slice(3) do |rows|

      first_row = rows[0]
      second_row = rows[1]

      if first_row.nil? or first_row.children.empty? then return end

      #
      # If this story is newer than our last
      #

#      puts "Time ago: #{second_row.css("td[class='subtext']").text.match(/\d+ (hour|hours|day|days|minute|minutes) ago/)}"

      make_new_entry = false
      posted_date = nil

      second_row.css("td[class='subtext']").text.match(/\d+ (hour|hours|day|days|minute|minutes) ago/) do |m|
        time_string = m[0]
        posted_date = (time_string.split(" ")[0].to_i.send time_string.split(" ")[1]).ago
        make_new_entry = last_entry.nil? or posted_date > last_entry.updated
      end

      
      if make_new_entry
        new_entry = feed.entries.new
        new_entry.title = first_row.css("td[class='title'] a").first.text
        new_entry.entry_id = remove_alpha first_row.children[0].text
        new_entry.published = posted_date
        new_entry.updated = posted_date

        unless second_row.css("td a").first.nil?
          new_entry.author_name = second_row.css("td a").first.text
        end

        source_link = new_entry.links.new
        source_link.href = first_row.css("td[class='title'] a").first['href']
        source_link.rel = "source"
        source_link.save

        unless second_row.css("td a").last.nil?
          comments_link = new_entry.links.new
          comments_link.href = base_url + second_row.css("td a").last['href']
          comments_link.rel = "comments"
          comments_link.save
        end

        new_entry.save



#        new_entry.entry_id = entry.at_css('id').text


# If this is not a link, we will need to get the content...
# Do that next
#        new_entry.content = entry.at_css('content').text


      end
    end

    feed.updated = DateTime.now
    feed.save

#      puts "First_row: #{first_row}"

#      puts "Rank :\n#{remove_alpha first_row.children[0].text}" #works
#      puts "Link: #{first_row.css("td[class='title'] a").first['href']}" #works
#      puts "Name: #{first_row.css("td[class='title'] a").first.text}" #works
#      puts "Source: #{first_row.css("td[class='title'] span").first.text.strip}" #works
#      puts "test #{second_row}"
#
#      unless second_row.css("td span").first.nil?
#        puts "Points: #{remove_alpha second_row.css("td span").first.text}" 
#      end
#
#      unless second_row.css("td a").first.nil?
#        puts "Poster: #{second_row.css("td a").first.text}"
#      end
#
#      unless second_row.css("td a").last.nil?
#        puts "Number of Comments: #{remove_alpha second_row.css("td a").last.text}"
#        puts "Link to Comments: #{second_row.css("td a").last['href']}"
#      end
#
#      puts "Time ago: #{second_row.css("td[class='subtext']").text.match(/\d+ (hour|hours|day|days|minute|minutes) ago/)}"
#
#
      # rows to get is NumberRecord 0 = (0 1), 1 = (3 4) 2 = (6 7)
      # first_row = targetEntry * 3
      # second_row = first_row + 1

#      puts "Rank: #{first_row.xpath("//td//tr")}"


      


#
#
#     entry_updated_time = DateTime.parse entry.at_css('updated').text
#
#     # this is the first entry ever, or the entry is newer than the last one      
#     if last_entry.nil? or entry_updated_time > last_entry.updated
#       
#       new_entry = feed.entries.new
#       new_entry.title = entry.at_css('title').text
#       new_entry.entry_id = entry.at_css('id').text
#       new_entry.published = DateTime.parse entry.at_css('published').text
#       new_entry.updated = entry_updated_time
#       new_entry.author_name = entry.at_css('author name').text
#       new_entry.content = entry.at_css('content').text
#
#       # Links
#       entry.css('link').each do |link|
#         new_link = new_entry.links.new
#         new_link.href = link['href']
#         new_link.rel = link['rel']
#         new_link.url_type = link['type']
#         new_link.hreflang = link['hreflang']
#         new_link.title = link['title']
#         new_link.length = link['length'].to_i
#
#          new_link.save
#       end
#
#        new_entry.save
#     end
#   end

  end

  private

  def remove_alpha(str)
    str.gsub(/[^0-9]/, "")
  end

  def can_update

    
  end

end
