# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090401134756) do

  create_table "alerts", :force => true do |t|
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "genre_id"
  end

  create_table "alerts_movies", :id => false, :force => true do |t|
    t.integer  "alert_id",   :null => false
    t.integer  "movie_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres_movies", :id => false, :force => true do |t|
    t.integer  "genre_id",   :null => false
    t.integer  "movie_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movies", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "year"
    t.float    "rating"
    t.integer  "votes"
    t.integer  "imdb_id"
    t.string   "genre"
    t.date     "release_date"
    t.string   "directors"
    t.string   "writers"
    t.text     "tagline"
    t.text     "plot"
    t.integer  "torrents_count"
    t.string   "poster"
    t.string   "official_site"
  end

  create_table "sorts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "torrents", :force => true do |t|
    t.string   "title"
    t.string   "about"
    t.string   "url"
    t.integer  "size"
    t.integer  "seeders"
    t.integer  "leechers"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.string   "persistence_token"
    t.string   "password_salt"
    t.string   "crypted_password"
    t.string   "email"
    t.string   "perishable_token"
    t.string   "language"
  end

end
