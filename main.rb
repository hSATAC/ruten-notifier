#!/usr/bin/env ruby
require './initializer.rb'
require 'pry'

first_page = "http://class.ruten.com.tw/user/index00.php?s=club5271"

client = Crawler.new first_page
client.fetch

total_page = client.total_page
all_items = []

# Import first page
data = client.items
Item.batch_import(data)
all_items += data

# Import rest of the pages
(1..total_page.to_i-1).each do |page|
  url = "#{first_page}&p=#{page}"
  client = Crawler.new url
  client.fetch

  data = client.items
  Item.batch_import(data)
  all_items += data
end

grouped_items = all_items.group_by { |hash| hash[:status] }

output = ""
if grouped_items[Item::STATUS_REFILL]
  output << "========== 有補貨到了喔！ ==========\n"
  grouped_items[Item::STATUS_REFILL].each do |item|
    output << "#{item[:url]} #{item[:name]}\n"
  end
end

if grouped_items[Item::STATUS_NEW]
  output << "========== 有新貨上架了喔！ ===========\n"
  grouped_items[Item::STATUS_NEW].each do |item|
    output << "#{item[:url]} #{item[:name]}\n"
  end
end

if output.length > 0
  email = YAML.load_file('config/email.yml')
  message = <<MESSAGE_END
From: 好大一把斧 <#{email["gmail"]["account"]}>
To: #{email["recipients"].join(",")}
Subject: 團子屋貼心訂閱

#{output}
MESSAGE_END
  smtp = Net::SMTP.new 'smtp.gmail.com', 587
  smtp.enable_starttls
  smtp.start('gmail.com', email["gmail"]["account"], email["gmail"]["password"], :login)
  smtp.send_message message, email["gmail"]["account"], email["recipients"]
  smtp.finish
  puts "Email sent."
else
  puts "Nothing new, do nothing."
end
