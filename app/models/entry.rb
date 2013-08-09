class Entry < ActiveRecord::Base
  has_many :links
  belongs_to :feed

  READABILITY_PARSER_API_KEY = '38b40404f6cbf16d9a5684bf548bbef0fec7124f'

  def get_full_content(link)
    
    response = HTTParty.get("https://readability.com/api/content/v1/parser?url=#{link.href}&token=#{READABILITY_PARSER_API_KEY}")

    if response.code == 200
      self.full_content = parsed_article['content']
    end
  end



end
