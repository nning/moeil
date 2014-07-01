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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140701123952) do

  create_table "aliases", :force => true do |t|
    t.string   "username"
    t.integer  "domain_id",                     :null => false
    t.text     "goto",                          :null => false
    t.boolean  "active",      :default => true
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "description"
  end

  add_index "aliases", ["domain_id"], :name => "index_aliases_on_domain_id"
  add_index "aliases", ["username", "domain_id"], :name => "index_aliases_on_username_and_domain_id", :unique => true

  create_table "domains", :force => true do |t|
    t.string   "name",                            :null => false
    t.string   "description"
    t.boolean  "backupmx",     :default => false
    t.boolean  "active",       :default => true
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "quick_access", :default => true
    t.boolean  "mx_set",       :default => true
  end

  add_index "domains", ["name"], :name => "index_domains_on_name", :unique => true

  create_table "mailboxes", :force => true do |t|
    t.string   "username",                              :null => false
    t.string   "encrypted_password",                    :null => false
    t.string   "name"
    t.string   "mail_location"
    t.integer  "quota",              :default => 0
    t.boolean  "active",             :default => true
    t.integer  "domain_id",                             :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "admin",              :default => false
    t.integer  "relocation_id"
  end

  add_index "mailboxes", ["domain_id"], :name => "index_mailboxes_on_domain_id"
  add_index "mailboxes", ["username", "domain_id"], :name => "index_mailboxes_on_username_and_domain_id", :unique => true
  add_index "mailboxes", ["username"], :name => "index_mailboxes_on_username"

  create_table "permissions", :force => true do |t|
    t.integer  "subject_id",                         :null => false
    t.string   "subject_type",                       :null => false
    t.integer  "item_id",                            :null => false
    t.string   "item_type",                          :null => false
    t.integer  "creator_id"
    t.string   "role",         :default => "editor", :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "permissions", ["creator_id"], :name => "index_permissions_on_creator_id"
  add_index "permissions", ["item_id", "item_type", "subject_id", "subject_type"], :name => "index_permissions_on_item_and_subject", :unique => true
  add_index "permissions", ["subject_id", "subject_type"], :name => "index_permissions_on_subject_id_and_subject_type"

  create_table "relocations", :force => true do |t|
    t.string   "old_username", :null => false
    t.string   "old_domain",   :null => false
    t.integer  "mailbox_id",   :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "relocations", ["mailbox_id"], :name => "index_relocations_on_mailbox_id", :unique => true
  add_index "relocations", ["old_username", "old_domain", "mailbox_id"], :name => "index_relocations_on_old_username_and_old_domain_and_mailbox_id", :unique => true
  add_index "relocations", ["old_username", "old_domain"], :name => "index_relocations_on_old_username_and_old_domain", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",      :null => false
    t.integer  "item_id",        :null => false
    t.string   "event",          :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.text     "object_changes"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
