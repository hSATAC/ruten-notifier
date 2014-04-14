ruten-notifier
==============

專抓露天團子屋的新增以及補貨商品

露天沒有補貨功能，所以用斧頭砍。

這個工具為[團子屋](http://class.ruten.com.tw/user/index00.php?s=club5271)限定，因為他們有習慣缺貨會把價格調到 999999 ，所以不用砍內頁。

## Install

* Run `bundle install`
* Copy `config/email.yml.example` to `config/email.yml` and setup values. 
* Run `rake db:migrate` to setup database (sqlite3 by default).

## Run

Run `./main.rb`

Comment out the email code when you run this the first time.

## Cronjob

* Edit `config/schedule.rb` with corresponding command.
* Run `whenever -i` to insert crontab

## Other

* `rake c` to enter console
* `rake db:drop` to drop the old database.
