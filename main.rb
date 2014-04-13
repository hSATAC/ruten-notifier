#!/usr/bin/env ruby
require './initializer.rb'

first_page = "http://class.ruten.com.tw/user/index00.php?s=club5271"

page = Crawler.new first_page
page.fetch

total = page.total_page
item_data = page.items
puts item_data.inspect
Item.batch_import(item_data)
