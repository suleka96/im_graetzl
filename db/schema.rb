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

ActiveRecord::Schema.define(version: 20171217234824) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body"
    t.string   "resource_id",   limit: 255, null: false
    t.string   "resource_type", limit: 255, null: false
    t.integer  "author_id"
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type", limit: 255
    t.integer  "owner_id"
    t.string   "owner_type",     limit: 255
    t.string   "key",            limit: 255
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree
  end

  create_table "addresses", force: :cascade do |t|
    t.string   "street_name",      limit: 255
    t.string   "street_number",    limit: 255
    t.string   "zip",              limit: 255
    t.string   "city",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.geometry "coordinates",      limit: {:srid=>0, :type=>"point"}
    t.integer  "addressable_id"
    t.string   "addressable_type", limit: 255
    t.string   "description",      limit: 255
    t.index ["addressable_id", "addressable_type"], name: "index_addresses_on_addressable_id_and_addressable_type", using: :btree
  end

  create_table "api_accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "api_key"
    t.boolean  "enabled",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "billing_addresses", force: :cascade do |t|
    t.integer  "location_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company"
    t.string   "street"
    t.string   "zip"
    t.string   "city"
    t.string   "country",     default: "Austria"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["location_id"], name: "index_billing_addresses_on_location_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "context",                default: 0
    t.string   "icon"
  end

  create_table "categorizations", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "categorizable_id"
    t.string   "categorizable_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["categorizable_type", "categorizable_id"], name: "idx_categorizations_on_categorizable", using: :btree
    t.index ["category_id"], name: "index_categorizations_on_category_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "website"
    t.string   "email"
    t.string   "phone"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "hours"
    t.index ["location_id"], name: "index_contacts_on_location_id", using: :btree
  end

  create_table "curators", force: :cascade do |t|
    t.integer  "graetzl_id"
    t.integer  "user_id"
    t.string   "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.index ["graetzl_id"], name: "index_curators_on_graetzl_id", using: :btree
    t.index ["user_id"], name: "index_curators_on_user_id", using: :btree
  end

  create_table "district_graetzls", force: :cascade do |t|
    t.integer "district_id"
    t.integer "graetzl_id"
    t.index ["district_id"], name: "index_district_graetzls_on_district_id", using: :btree
    t.index ["graetzl_id"], name: "index_district_graetzls_on_graetzl_id", using: :btree
  end

  create_table "districts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "zip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.geometry "area",       limit: {:srid=>0, :type=>"polygon"}
    t.string   "slug",       limit: 255
    t.index ["slug"], name: "index_districts_on_slug", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",               null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "going_tos", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "meeting_id"
    t.integer  "role",       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["meeting_id"], name: "index_going_tos_on_meeting_id", using: :btree
    t.index ["user_id"], name: "index_going_tos_on_user_id", using: :btree
  end

  create_table "graetzls", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.geometry "area",        limit: {:srid=>0, :type=>"polygon"}
    t.string   "slug",        limit: 255
    t.integer  "users_count",                                      default: 0
    t.index ["slug"], name: "index_graetzls_on_slug", using: :btree
  end

  create_table "images", force: :cascade do |t|
    t.string   "file_id"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_content_type"
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id", using: :btree
  end

  create_table "initiatives", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image_id"
    t.string   "image_content_type"
    t.string   "website"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "location_ownerships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "location_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "state",       default: 0
    t.index ["location_id"], name: "index_location_ownerships_on_location_id", using: :btree
    t.index ["user_id"], name: "index_location_ownerships_on_user_id", using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "slogan"
    t.text     "description"
    t.string   "avatar_id"
    t.string   "cover_photo_id"
    t.string   "slug"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "graetzl_id"
    t.string   "avatar_content_type"
    t.string   "cover_photo_content_type"
    t.integer  "state",                    default: 0
    t.integer  "meeting_permission",       default: 0, null: false
    t.integer  "category_id"
    t.datetime "last_activity_at"
    t.index ["created_at"], name: "index_locations_on_created_at", using: :btree
    t.index ["graetzl_id"], name: "index_locations_on_graetzl_id", using: :btree
    t.index ["last_activity_at"], name: "index_locations_on_last_activity_at", using: :btree
    t.index ["slug"], name: "index_locations_on_slug", using: :btree
  end

  create_table "meetings", force: :cascade do |t|
    t.string   "name",                     limit: 255
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",                     limit: 255
    t.date     "starts_at_date"
    t.date     "ends_at_date"
    t.time     "starts_at_time"
    t.time     "ends_at_time"
    t.integer  "graetzl_id"
    t.string   "cover_photo_id"
    t.string   "cover_photo_content_type"
    t.integer  "location_id"
    t.integer  "state",                                default: 0
    t.boolean  "approved_for_api",                     default: false
    t.index ["created_at"], name: "index_meetings_on_created_at", using: :btree
    t.index ["graetzl_id"], name: "index_meetings_on_graetzl_id", using: :btree
    t.index ["location_id"], name: "index_meetings_on_location_id", using: :btree
    t.index ["slug"], name: "index_meetings_on_slug", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.integer  "bitmask",                            null: false
    t.boolean  "seen",               default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "sent",               default: false
    t.boolean  "display_on_website", default: false
    t.string   "type"
  end

  create_table "operating_ranges", force: :cascade do |t|
    t.integer  "graetzl_id"
    t.integer  "operator_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "operator_type"
    t.index ["graetzl_id"], name: "index_operating_ranges_on_graetzl_id", using: :btree
    t.index ["operator_id", "operator_type"], name: "index_operating_ranges_on_operator_id_and_operator_type", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.text     "content"
    t.integer  "graetzl_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "title"
    t.integer  "author_id"
    t.string   "author_type"
    t.string   "type"
    t.index ["author_type", "author_id"], name: "index_posts_on_author_type_and_author_id", using: :btree
    t.index ["created_at"], name: "index_posts_on_created_at", using: :btree
    t.index ["graetzl_id"], name: "index_posts_on_graetzl_id", using: :btree
    t.index ["slug"], name: "index_posts_on_slug", unique: true, using: :btree
  end

  create_table "room_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "room_demand_categories", force: :cascade do |t|
    t.integer "room_category_id"
    t.integer "room_demand_id"
    t.index ["room_category_id"], name: "index_room_demand_categories_on_room_category_id", using: :btree
    t.index ["room_demand_id"], name: "index_room_demand_categories_on_room_demand_id", using: :btree
  end

  create_table "room_demand_graetzls", force: :cascade do |t|
    t.integer "graetzl_id"
    t.integer "room_demand_id"
    t.index ["graetzl_id"], name: "index_room_demand_graetzls_on_graetzl_id", using: :btree
    t.index ["room_demand_id"], name: "index_room_demand_graetzls_on_room_demand_id", using: :btree
  end

  create_table "room_demands", force: :cascade do |t|
    t.string   "slogan"
    t.decimal  "needed_area",          precision: 10, scale: 2
    t.text     "demand_description"
    t.text     "personal_description"
    t.boolean  "wants_collaboration"
    t.string   "slug"
    t.integer  "user_id"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.integer  "demand_type",                                   default: 0
    t.string   "first_name"
    t.string   "last_name"
    t.string   "website"
    t.string   "email"
    t.string   "phone"
    t.integer  "location_id"
    t.string   "avatar_id"
    t.string   "avatar_content_type"
    t.index ["location_id"], name: "index_room_demands_on_location_id", using: :btree
    t.index ["user_id"], name: "index_room_demands_on_user_id", using: :btree
  end

  create_table "room_offer_categories", force: :cascade do |t|
    t.integer "room_category_id"
    t.integer "room_offer_id"
    t.index ["room_category_id"], name: "index_room_offer_categories_on_room_category_id", using: :btree
    t.index ["room_offer_id"], name: "index_room_offer_categories_on_room_offer_id", using: :btree
  end

  create_table "room_offer_prices", force: :cascade do |t|
    t.integer  "room_offer_id"
    t.string   "name"
    t.decimal  "amount",        precision: 10, scale: 2
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["room_offer_id"], name: "index_room_offer_prices_on_room_offer_id", using: :btree
  end

  create_table "room_offers", force: :cascade do |t|
    t.string   "slogan"
    t.text     "room_description"
    t.decimal  "total_area",               precision: 10, scale: 2
    t.decimal  "rented_area",              precision: 10, scale: 2
    t.text     "owner_description"
    t.text     "tenant_description"
    t.boolean  "wants_collaboration"
    t.string   "slug"
    t.integer  "user_id"
    t.integer  "location_id"
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.integer  "graetzl_id"
    t.integer  "district_id"
    t.string   "cover_photo_id"
    t.string   "cover_photo_content_type"
    t.integer  "offer_type",                                        default: 0
    t.string   "first_name"
    t.string   "last_name"
    t.string   "website"
    t.string   "email"
    t.string   "phone"
    t.string   "avatar_id"
    t.string   "avatar_content_type"
    t.index ["district_id"], name: "index_room_offers_on_district_id", using: :btree
    t.index ["graetzl_id"], name: "index_room_offers_on_graetzl_id", using: :btree
    t.index ["location_id"], name: "index_room_offers_on_location_id", using: :btree
    t.index ["user_id"], name: "index_room_offers_on_user_id", using: :btree
  end

  create_table "room_suggested_tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                         limit: 255, default: "",    null: false
    t.string   "encrypted_password",            limit: 255, default: "",    null: false
    t.string   "reset_password_token",          limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                             default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",            limit: 255
    t.string   "last_sign_in_ip",               limit: 255
    t.string   "confirmation_token",            limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",                      limit: 255
    t.string   "first_name",                    limit: 255
    t.string   "last_name",                     limit: 255
    t.integer  "graetzl_id"
    t.string   "avatar_id"
    t.integer  "role"
    t.string   "avatar_content_type"
    t.string   "slug"
    t.string   "cover_photo_id"
    t.string   "cover_photo_content_type"
    t.text     "bio"
    t.string   "website"
    t.integer  "weekly_mail_notifications",                 default: 0
    t.integer  "daily_mail_notifications",                  default: 0
    t.integer  "immediate_mail_notifications",              default: 0
    t.integer  "enabled_website_notifications",             default: 0
    t.boolean  "newsletter",                                default: false, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["graetzl_id"], name: "index_users_on_graetzl_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  end

  create_table "zuckerls", force: :cascade do |t|
    t.integer  "location_id"
    t.string   "title"
    t.text     "description"
    t.string   "image_id"
    t.string   "image_content_type"
    t.boolean  "flyer",              default: false
    t.string   "aasm_state"
    t.datetime "paid_at"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "initiative_id"
    t.string   "slug"
    t.index ["initiative_id"], name: "index_zuckerls_on_initiative_id", using: :btree
    t.index ["location_id"], name: "index_zuckerls_on_location_id", using: :btree
    t.index ["slug"], name: "index_zuckerls_on_slug", using: :btree
  end

  add_foreign_key "district_graetzls", "districts", on_delete: :cascade
  add_foreign_key "district_graetzls", "graetzls", on_delete: :cascade
  add_foreign_key "room_demand_categories", "room_categories", on_delete: :cascade
  add_foreign_key "room_demand_categories", "room_demands", on_delete: :cascade
  add_foreign_key "room_demand_graetzls", "graetzls", on_delete: :cascade
  add_foreign_key "room_demand_graetzls", "room_demands", on_delete: :cascade
  add_foreign_key "room_demands", "locations", on_delete: :nullify
  add_foreign_key "room_demands", "users", on_delete: :cascade
  add_foreign_key "room_offer_categories", "room_categories", on_delete: :cascade
  add_foreign_key "room_offer_categories", "room_offers", on_delete: :cascade
  add_foreign_key "room_offer_prices", "room_offers", on_delete: :cascade
  add_foreign_key "room_offers", "districts", on_delete: :nullify
  add_foreign_key "room_offers", "graetzls", on_delete: :nullify
  add_foreign_key "room_offers", "locations", on_delete: :nullify
  add_foreign_key "room_offers", "users", on_delete: :cascade
end
