# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_08_26_124635) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chat_rooms", force: :cascade do |t|
    t.bigint "user_one_id"
    t.bigint "user_two_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_one_id", "user_two_id"], name: "index_chat_rooms_on_user_one_id_and_user_two_id", unique: true
    t.index ["user_one_id"], name: "index_chat_rooms_on_user_one_id"
    t.index ["user_two_id"], name: "index_chat_rooms_on_user_two_id"
  end

  create_table "friend_invitations", force: :cascade do |t|
    t.boolean "accepted"
    t.bigint "friend_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friend_invitations_on_friend_id"
    t.index ["user_id"], name: "index_friend_invitations_on_user_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.bigint "friend_one_id"
    t.bigint "friend_two_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "friend_invitation_id"
    t.index ["friend_invitation_id"], name: "index_friendships_on_friend_invitation_id"
    t.index ["friend_one_id", "friend_two_id"], name: "index_friendships_on_friend_one_id_and_friend_two_id", unique: true
    t.index ["friend_one_id"], name: "index_friendships_on_friend_one_id"
    t.index ["friend_two_id"], name: "index_friendships_on_friend_two_id"
  end

  create_table "matches", force: :cascade do |t|
    t.boolean "match_one_accepted"
    t.boolean "match_two_accepted"
    t.bigint "helper_id"
    t.bigint "match_one_id"
    t.bigint "match_two_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "intro_message"
    t.bigint "pseudo_match_id"
    t.index ["helper_id"], name: "index_matches_on_helper_id"
    t.index ["match_one_id"], name: "index_matches_on_match_one_id"
    t.index ["match_two_id"], name: "index_matches_on_match_two_id"
    t.index ["pseudo_match_id"], name: "index_matches_on_pseudo_match_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "user_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "chat_room_id"
    t.index ["chat_room_id"], name: "index_messages_on_chat_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "pseudo_matches", force: :cascade do |t|
    t.bigint "helper_id"
    t.bigint "match_one_id"
    t.text "intro_message"
    t.string "match_two_email"
    t.string "match_two_first_name"
    t.string "match_two_picture"
    t.boolean "match_one_accepted"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "converted"
    t.string "match_two_facebook"
    t.string "match_two_linkedin"
    t.string "match_two_last_name"
    t.index ["helper_id"], name: "index_pseudo_matches_on_helper_id"
    t.index ["match_one_id"], name: "index_pseudo_matches_on_match_one_id"
  end

  create_table "referrals", force: :cascade do |t|
    t.bigint "user_id"
    t.string "friend_email"
    t.date "date"
    t.boolean "accepted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_email"], name: "index_referrals_on_friend_email"
    t.index ["user_id"], name: "index_referrals_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "location"
    t.date "date_of_birth"
    t.string "picture"
    t.string "facebook_profile"
    t.string "twitter_profile"
    t.string "linkedin_profile"
    t.boolean "available"
    t.string "instagram_profile"
    t.string "provider"
    t.string "uid"
    t.string "facebook_picture_url"
    t.string "token"
    t.datetime "token_expiry"
    t.boolean "admin", default: false
    t.boolean "male"
    t.boolean "male_search"
    t.boolean "female_search"
    t.string "adjective_1"
    t.string "adjective_2"
    t.string "adjective_3"
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "chat_rooms", "users", column: "user_one_id"
  add_foreign_key "chat_rooms", "users", column: "user_two_id"
  add_foreign_key "friend_invitations", "users"
  add_foreign_key "friend_invitations", "users", column: "friend_id"
  add_foreign_key "friendships", "friend_invitations"
  add_foreign_key "friendships", "users", column: "friend_one_id"
  add_foreign_key "friendships", "users", column: "friend_two_id"
  add_foreign_key "matches", "users", column: "helper_id"
  add_foreign_key "matches", "users", column: "match_one_id"
  add_foreign_key "matches", "users", column: "match_two_id"
  add_foreign_key "messages", "chat_rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "pseudo_matches", "users", column: "helper_id"
  add_foreign_key "pseudo_matches", "users", column: "match_one_id"
  add_foreign_key "referrals", "users"
end
