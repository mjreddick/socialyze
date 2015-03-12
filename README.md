# SOCIALYZE 


Twitter Analytics for the everyday user. Sign-up, authorize your twitter account, and we send you the results after our minions socialyze your data.

Created by [Long Huynh](http://www.longkhuynh.com), [Janet Ko
](http://www.janetko.com/), [Matthew Reddick](http://matthewreddick.com/), and [Mike Woo](http://wooworks.net/)
## Get Started

Requirements

* Ruby 2.1.3
* Rails 4.1.7
* PostgreSQL
* Sidekiq
* Twitter API key and secret
* Sendgrid username and password
* Redis

Run it

* Git clone https://github.com/mjreddick/socialyze
* Brew install Redis (if you dont already have it)
* In terminal run ```$ redis-server /usr/local/etc/redis.conf ```
* Bundle install
* In application.js add <br>
```//= require angular-resource```
<br>
```//= require angular-route```
<br>
```//= require angular-rails-templates```
<br>
```//= require d3```
<br>
```//= require bootstrap-sprockets
```
* In application.css.scss add <br>
```@import "bootstrap-sprockets";``` <br>
```@import "bootstrap"; ``` <br>
```@import "font-awesome-sprockets"; ``` <br>
```@import "font-awesome"; ``` <br>
```@import "variables";``` <br>

* rake db:create
* rake db:migrate
* figaro install
* Add your environment variables to application.yml
* rails s
* bundle exec sidekiq

Test

* In terminal run ```$ bundle exec rspec```


