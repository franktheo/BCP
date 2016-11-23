# README

* Ruby version: 2.3.1

* Using Postgresql as a DB engine. Start your postgres before running the app.

* Put your production SECRET_KEY_BASE in 
  the file such as .profile or .bashrc

  source ~/.profile or source ~/.bashrc

* Pre-run steps: 
  bundle

* To run in development mode 

  createdb development_tagging_api

  createdb test_tagging_api

  rake db:migrate

  rake db:seed

  rails s 
       
* To run in production mode 

  source ~/.bashrc (source ~/.profile)

  createdb production_tagging_api

  rake db:migrate RAILS_ENV=production

  rake db:seed RAILS_ENV=production

  rails s -e production
 
* We use Route Globbing and Wildcard Segments to handle routing.
  (http://guides.rubyonrails.org/routing.html)

* To view all taggings output

  http://localhost:3000/

  http://localhost:3000/taggings curl -X GET http://localhost:3000/taggings

* To view a particular tagging

  ID based: http://localhost:3000/taggings/1

  http://localhost:3000/taggings/Product/1234 curl -X GET http://localhost:3000/taggings/Product/1234

* To view stats

  http://localhost:3000/stats
  curl -X GET http://localhost:3000/stats

* To view an individual stat

  http://localhost:3000/stats/Product/1234
  curl -X GET http://localhost:3000/stats/Product/1234

* To post a new tagging 

  curl -H "Accept: application/json" -H "Content-type: application/json" 
  -X POST -d '{"entity_type":"Article","entity_id":"1245","tags":"['sports', 'football']"}' http://localhost:3000/taggings

  curl -H "Accept: application/json" -H "Content-type: application/json" 
  -X POST -d '{"entity_type":"Article","entity_id":"1245","tags":"['sports', 'basketball']"}' http://localhost:3000/taggings

  Note: 

  Previous entry with the same entity_type and entity_id will be replaced.
 
  In this example tag "football"is replaced with tag "basketball"
    
* To update

  curl -H "Accept: application/json" -H "Content-type: application/json" 
  -X PUT -d '{"entity_type":"Article","entity_id":"1245","tags":"['sports', 'soccer']"}' http://localhost:3000/taggings/Article/1245

* To delete a particular tagging

  curl -H "Accept: application/json" -H "Content-type: application/json" 
  -X DELETE http://localhost:3000/taggings/Article/1245

* RSPEC test

  rake db:drop RAILS_ENV=test (if DB is corrupted for testing)

  createdb test_tagging_api

  rake db:migrate RAILS_ENV=test
 
  rake db:seed RAILS_ENV=test

  rspec

  All 9 tests passed.

* Earlier, I had an issue with using postgres array for tags. This is now handled
  internally by splitting tags and inserting/updating tags' elements in post and update.

