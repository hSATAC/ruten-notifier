require 'open-uri'
require './initializer.rb'

ITEM_REGEX = /\<a pchome=.+?href="(\S+?)">(.*)<\/a>\n.*\n.*\n.*\n.*\n.*\n.*\n.*\n.*目前出價：\n([0-9,]+)\s+元/

class Crawler
  attr_reader :url, :html
  def initialize(url)
    @url = url
  end

  def fetch
    @html = open(@url, {
      "User-Agent" => 'Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Firefox/24.0',
      "Referer" => @url,
      "Cookie" => '_ts_id=ruten-crawler'
    }).read.force_encoding('Big5').encode('UTF-8', :invalid => :replace, :replace => '')
  end

  def total_page
    /第(\d+) \/ (\d+) 頁/.match(@html)[2]
  end

  def current_page
    /第(\d+) \/ (\d+) 頁/.match(@html)[1]
  end

  def items
    @html.scan(ITEM_REGEX).map { |array| array << array[0][/\?(\d+)$/,1] }
  end
end
