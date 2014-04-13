#!/usr/bin/env ruby
require './initializer.rb'

first_page = "http://class.ruten.com.tw/user/index00.php?s=club5271&p=2"

client = Crawler.new first_page
client.fetch

total_page = client.total_page

# Import first page
Item.batch_import(client.items)

#(1..total_page.to_i-1).each do |page|
  #url = "#{first_page}&p=#{page}"
  #puts "Fetching page #{url}"
  #client = Crawler.new url
  #client.fetch

  #Item.batch_import(client.items)
#end
