# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160927141850) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id",   limit: 4
    t.string   "trackable_type", limit: 255
    t.integer  "owner_id",       limit: 4
    t.string   "owner_type",     limit: 255
    t.string   "key",            limit: 255
    t.text     "parameters",     limit: 65535
    t.integer  "recipient_id",   limit: 4
    t.string   "recipient_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["key"], name: "index_activities_on_key", using: :btree
  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "application_tokens", force: :cascade do |t|
    t.string  "application", limit: 255, null: false
    t.string  "token_hash",  limit: 255, null: false
    t.string  "token_salt",  limit: 255, null: false
    t.integer "user_id",     limit: 4,   null: false
  end

  add_index "application_tokens", ["user_id"], name: "index_application_tokens_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "body",          limit: 65535
    t.integer  "repository_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "user_id",       limit: 4
  end

  add_index "comments", ["repository_id"], name: "index_comments_on_repository_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "crono_jobs", force: :cascade do |t|
    t.string   "job_id",            limit: 255, null: false
    t.datetime "last_performed_at"
    t.boolean  "healthy"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "crono_jobs", ["job_id"], name: "index_crono_jobs_on_job_id", unique: true, using: :btree

  create_table "namespaces", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "team_id",     limit: 4
    t.integer  "registry_id", limit: 4,                     null: false
    t.boolean  "global",                    default: false
    t.text     "description", limit: 65535
    t.integer  "visibility",  limit: 4
  end

  add_index "namespaces", ["name", "registry_id"], name: "index_namespaces_on_name_and_registry_id", unique: true, using: :btree
  add_index "namespaces", ["name"], name: "fulltext_index_namespaces_on_name", type: :fulltext
  add_index "namespaces", ["registry_id"], name: "index_namespaces_on_registry_id", using: :btree
  add_index "namespaces", ["team_id"], name: "index_namespaces_on_team_id", using: :btree

  create_table "registries", force: :cascade do |t|
    t.string   "name",              limit: 255, null: false
    t.string   "hostname",          limit: 255, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "use_ssl"
    t.string   "external_hostname", limit: 255
  end

  add_index "registries", ["hostname"], name: "index_registries_on_hostname", unique: true, using: :btree
  add_index "registries", ["name"], name: "index_registries_on_name", unique: true, using: :btree

  create_table "registry_events", force: :cascade do |t|
    t.string   "event_id",   limit: 255, default: ""
    t.string   "repository", limit: 255, default: ""
    t.string   "tag",        limit: 255, default: ""
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "repositories", force: :cascade do |t|
    t.string   "name",         limit: 255, default: "",    null: false
    t.integer  "namespace_id", limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "marked",                   default: false
  end

  add_index "repositories", ["name", "namespace_id"], name: "index_repositories_on_name_and_namespace_id", unique: true, using: :btree
  add_index "repositories", ["name"], name: "fulltext_index_repositories_on_name", type: :fulltext
  add_index "repositories", ["namespace_id"], name: "index_repositories_on_namespace_id", using: :btree

  create_table "stars", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "repository_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "stars", ["repository_id"], name: "index_stars_on_repository_id", using: :btree
  add_index "stars", ["user_id"], name: "index_stars_on_user_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",          limit: 255, default: "latest", null: false
    t.integer  "repository_id", limit: 4,                      null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "user_id",       limit: 4
    t.string   "digest",        limit: 255
    t.string   "image_id",      limit: 255, default: ""
    t.boolean  "marked",                    default: false
    t.string   "username",      limit: 255
  end

  add_index "tags", ["name", "repository_id"], name: "index_tags_on_name_and_repository_id", unique: true, using: :btree
  add_index "tags", ["repository_id"], name: "index_tags_on_repository_id", using: :btree
  add_index "tags", ["user_id"], name: "index_tags_on_user_id", using: :btree

  create_table "team_users", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "team_id",    limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "role",       limit: 4, default: 0
  end

  add_index "team_users", ["team_id"], name: "index_team_users_on_team_id", using: :btree
  add_index "team_users", ["user_id"], name: "index_team_users_on_user_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "hidden",                    default: false
    t.text     "description", limit: 65535
  end

  add_index "teams", ["name"], name: "index_teams_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",               limit: 255, default: "",    null: false
    t.string   "email",                  limit: 255, default: ""
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                              default: false
    t.boolean  "enabled",                            default: true
    t.string   "ldap_name",              limit: 255
    t.integer  "failed_attempts",        limit: 4,   default: 0
    t.datetime "locked_at"
    t.integer  "namespace_id",           limit: 4
    t.string   "display_name",           limit: 255
  end

  add_index "users", ["display_name"], name: "index_users_on_display_name", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["namespace_id"], name: "index_users_on_namespace_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "webhook_deliveries", force: :cascade do |t|
    t.integer  "webhook_id",      limit: 4
    t.string   "uuid",            limit: 255
    t.integer  "status",          limit: 4
    t.text     "request_header",  limit: 65535
    t.text     "request_body",    limit: 65535
    t.text     "response_header", limit: 65535
    t.text     "response_body",   limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "webhook_deliveries", ["webhook_id", "uuid"], name: "index_webhook_deliveries_on_webhook_id_and_uuid", unique: true, using: :btree
  add_index "webhook_deliveries", ["webhook_id"], name: "index_webhook_deliveries_on_webhook_id", using: :btree

  create_table "webhook_headers", force: :cascade do |t|
    t.integer  "webhook_id", limit: 4
    t.string   "name",       limit: 255
    t.string   "value",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "webhook_headers", ["webhook_id", "name"], name: "index_webhook_headers_on_webhook_id_and_name", unique: true, using: :btree
  add_index "webhook_headers", ["webhook_id"], name: "index_webhook_headers_on_webhook_id", using: :btree

  create_table "webhooks", force: :cascade do |t|
    t.integer  "namespace_id",   limit: 4
    t.string   "url",            limit: 255
    t.string   "username",       limit: 255
    t.string   "password",       limit: 255
    t.integer  "request_method", limit: 4
    t.integer  "content_type",   limit: 4
    t.boolean  "enabled",                    default: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "webhooks", ["namespace_id"], name: "index_webhooks_on_namespace_id", using: :btree

  add_foreign_key "comments", "repositories"
  add_foreign_key "stars", "repositories"
  add_foreign_key "stars", "users"
  add_foreign_key "users", "namespaces"
  add_foreign_key "webhook_deliveries", "webhooks"
  add_foreign_key "webhook_headers", "webhooks"
  add_foreign_key "webhooks", "namespaces"
end
