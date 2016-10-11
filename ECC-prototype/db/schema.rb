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

ActiveRecord::Schema.define(version: 20161010001003) do

  create_table "access", primary_key: "aid", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "mask",             default: "", null: false
    t.string  "type",             default: "", null: false
    t.integer "status", limit: 1, default: 0,  null: false
  end

  create_table "actions", primary_key: "aid", id: :string, default: "0", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "type",       limit: 32,         default: "",  null: false
    t.string "callback",                      default: "",  null: false
    t.binary "parameters", limit: 4294967295,               null: false, comment: "Parameters to be passed to the callback function."
    t.string "label",                         default: "0", null: false
  end

  create_table "advanced_help_index", primary_key: "sid", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Stores search index correlations for advanced help topics." do |t|
    t.string "module",              default: "", null: false, comment: "The module that owns this topic."
    t.string "topic",               default: "", null: false, comment: "The topic id."
    t.string "language", limit: 12, default: "", null: false, comment: "The language this search index relates to."
    t.index ["language"], name: "language", using: :btree
  end

  create_table "apachesolr_environment", primary_key: "env_id", id: :string, limit: 64, comment: "Unique identifier for the environment", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "The Solr search environment table." do |t|
    t.string "name",                       default: "", null: false, comment: "Human-readable name for the server"
    t.string "url",           limit: 1000,              null: false, comment: "Full url for the server"
    t.string "service_class",              default: "", null: false, comment: "Optional class name to use for connection"
  end

  create_table "apachesolr_environment_variable", primary_key: ["env_id", "name"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Variable values for each Solr search environment." do |t|
    t.string "env_id", limit: 64,                      null: false, comment: "Unique identifier for the environment"
    t.string "name",   limit: 128,        default: "", null: false, comment: "The name of the variable."
    t.binary "value",  limit: 4294967295,              null: false, comment: "The value of the variable."
  end

  create_table "apachesolr_index_bundles", primary_key: ["env_id", "entity_type", "bundle"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Records what bundles we should be indexing for a given..." do |t|
    t.string "env_id",      limit: 64,  null: false, comment: "The name of the environment."
    t.string "entity_type", limit: 32,  null: false, comment: "The type of entity."
    t.string "bundle",      limit: 128, null: false, comment: "The bundle to index."
  end

  create_table "apachesolr_index_entities", primary_key: ["entity_id", "entity_type"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Stores a record of when an entity changed to determine if..." do |t|
    t.string  "entity_type", limit: 32,              null: false, comment: "The type of entity."
    t.integer "entity_id",                           null: false, comment: "The primary identifier for an entity.",                         unsigned: true
    t.string  "bundle",      limit: 128,             null: false, comment: "The bundle to which this entity belongs."
    t.integer "status",                  default: 1, null: false, comment: "Boolean indicating whether the entity should be in the index."
    t.integer "changed",                 default: 0, null: false, comment: "The Unix timestamp when an entity was changed."
    t.index ["bundle", "changed"], name: "bundle_changed", using: :btree
  end

  create_table "apachesolr_index_entities_node", primary_key: "entity_id", id: :integer, comment: "The primary identifier for an entity.", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Stores a record of when an entity changed to determine if..." do |t|
    t.string  "entity_type", limit: 32,              null: false, comment: "The type of entity."
    t.string  "bundle",      limit: 128,             null: false, comment: "The bundle to which this entity belongs."
    t.integer "status",                  default: 1, null: false, comment: "Boolean indicating whether the entity should be in the index."
    t.integer "changed",                 default: 0, null: false, comment: "The Unix timestamp when an entity was changed."
    t.index ["bundle", "changed"], name: "bundle_changed", using: :btree
  end

  create_table "apachesolr_search_page", primary_key: "page_id", id: :string, limit: 32, default: "", comment: "The machine readable name of the search page.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Apache Solr Search search page settings." do |t|
    t.string "label",       limit: 32,    default: "", null: false, comment: "The human readable name of the search page."
    t.string "description",               default: "", null: false, comment: "The description of the search page."
    t.string "search_path",               default: "", null: false, comment: "The path to the search page."
    t.string "page_title",                default: "", null: false, comment: "The title of the search page."
    t.string "env_id",      limit: 64,    default: "", null: false, comment: "The machine name of the search environment."
    t.text   "settings",    limit: 65535,                           comment: "Serialized storage of general settings."
    t.index ["env_id"], name: "env_id", using: :btree
  end

  create_table "authmap", primary_key: "aid", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "uid",                  default: 0,  null: false
    t.string  "authname", limit: 128, default: "", null: false
    t.string  "module",   limit: 128, default: "", null: false
    t.index ["authname"], name: "authname", unique: true, using: :btree
  end

  create_table "batch", primary_key: "bid", id: :integer, comment: "Primary Key: Unique batch ID.", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "token",     limit: 64,         null: false
    t.integer "timestamp",                    null: false
    t.binary  "batch",     limit: 4294967295,              comment: "A serialized array containing the processing data for the batch."
    t.index ["token"], name: "token", using: :btree
  end

  create_table "block", primary_key: "bid", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "module",     limit: 64,    default: "",  null: false
    t.string  "delta",      limit: 32,    default: "0", null: false
    t.string  "theme",      limit: 64,    default: "",  null: false
    t.integer "status",     limit: 1,     default: 0,   null: false
    t.integer "weight",                   default: 0,   null: false, comment: "Block weight within region."
    t.string  "region",     limit: 64,    default: "",  null: false
    t.integer "custom",     limit: 1,     default: 0,   null: false
    t.integer "visibility", limit: 1,     default: 0,   null: false
    t.text    "pages",      limit: 65535,               null: false
    t.string  "title",                    default: "",  null: false, comment: "Custom title for the block. (Empty string will use block default title, <none> will remove the title, text will cause block to use specified title.)"
    t.integer "cache",      limit: 1,     default: 1,   null: false
    t.index ["theme", "module", "delta"], name: "tmd", unique: true, using: :btree
    t.index ["theme", "status", "region", "weight", "module"], name: "list", using: :btree
  end

  create_table "block_current_search", primary_key: "delta", id: :string, limit: 32, comment: "The block’s unique delta within module, from block.delta.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Sets up display criteria for blocks based on searcher" do |t|
    t.string "searcher", limit: 128, null: false, comment: "The machine-readable name of the searcher."
    t.index ["searcher"], name: "searcher", using: :btree
  end

  create_table "block_custom", primary_key: "bid", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text   "body",   limit: 4294967295
    t.string "info",   limit: 128,        default: "", null: false
    t.string "format",                                              comment: "The filter_format.format of the block body."
    t.index ["info"], name: "info", unique: true, using: :btree
  end

  create_table "block_node_type", primary_key: ["module", "delta", "type"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Sets up display criteria for blocks based on content types" do |t|
    t.string "module", limit: 64, null: false, comment: "The block’s origin module, from block.module."
    t.string "delta",  limit: 32, null: false, comment: "The block’s unique delta within module, from block.delta."
    t.string "type",   limit: 32, null: false, comment: "The machine-readable name of this type from node_type.type."
    t.index ["type"], name: "type", using: :btree
  end

  create_table "block_role", primary_key: ["module", "delta", "rid"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "module", limit: 64, null: false
    t.string  "delta",  limit: 32, null: false
    t.integer "rid",               null: false, unsigned: true
    t.index ["rid"], name: "rid", using: :btree
  end

  create_table "blocked_ips", primary_key: "iid", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Stores blocked IP addresses." do |t|
    t.string "ip", limit: 40, default: "", null: false, comment: "IP address"
    t.index ["ip"], name: "blocked_ip", using: :btree
  end

  create_table "cache", primary_key: "cid", id: :string, default: "", comment: "Primary Key: Unique cache ID.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Generic cache table for caching things not separated out..." do |t|
    t.binary  "data",       limit: 4294967295,                          comment: "A collection of data to cache."
    t.integer "expire",                        default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry should expire, or 0 for never."
    t.integer "created",                       default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry was created."
    t.integer "serialized", limit: 2,          default: 0, null: false, comment: "A flag to indicate whether content is serialized (1) or not (0)."
    t.index ["expire"], name: "expire", using: :btree
  end

  create_table "cache_admin_menu", primary_key: "cid", id: :string, default: "", comment: "Primary Key: Unique cache ID.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Generic cache table for caching things not separated out..." do |t|
    t.binary  "data",       limit: 4294967295,                          comment: "A collection of data to cache."
    t.integer "expire",                        default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry should expire, or 0 for never."
    t.integer "created",                       default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry was created."
    t.integer "serialized", limit: 2,          default: 0, null: false, comment: "A flag to indicate whether content is serialized (1) or not (0)."
    t.index ["expire"], name: "expire", using: :btree
  end

  create_table "cache_apachesolr", primary_key: "cid", id: :string, default: "", comment: "Primary Key: Unique cache ID.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Cache table for apachesolr to store Luke data and..." do |t|
    t.binary  "data",       limit: 4294967295,                          comment: "A collection of data to cache."
    t.integer "expire",                        default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry should expire, or 0 for never."
    t.integer "created",                       default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry was created."
    t.integer "serialized", limit: 2,          default: 0, null: false, comment: "A flag to indicate whether content is serialized (1) or not (0)."
    t.index ["expire"], name: "expire", using: :btree
  end

  create_table "cache_block", primary_key: "cid", id: :string, default: "", comment: "Primary Key: Unique cache ID.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Generic cache table for caching things not separated out..." do |t|
    t.binary  "data",       limit: 4294967295,                          comment: "A collection of data to cache."
    t.integer "expire",                        default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry should expire, or 0 for never."
    t.integer "created",                       default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry was created."
    t.integer "serialized", limit: 2,          default: 0, null: false, comment: "A flag to indicate whether content is serialized (1) or not (0)."
    t.index ["expire"], name: "expire", using: :btree
  end

  create_table "cache_bootstrap", primary_key: "cid", id: :string, default: "", comment: "Primary Key: Unique cache ID.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Cache table for data required to bootstrap Drupal, may be..." do |t|
    t.binary  "data",       limit: 4294967295,                          comment: "A collection of data to cache."
    t.integer "expire",                        default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry should expire, or 0 for never."
    t.integer "created",                       default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry was created."
    t.integer "serialized", limit: 2,          default: 0, null: false, comment: "A flag to indicate whether content is serialized (1) or not (0)."
    t.index ["expire"], name: "expire", using: :btree
  end

  create_table "cache_content", primary_key: "cid", id: :string, default: "", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.binary  "data",       limit: 4294967295
    t.integer "expire",                        default: 0, null: false
    t.integer "created",                       default: 0, null: false
    t.text    "headers",    limit: 65535
    t.integer "serialized", limit: 2,          default: 0, null: false
    t.index ["expire"], name: "expire", using: :btree
  end

  create_table "cache_field", primary_key: "cid", id: :string, default: "", comment: "Primary Key: Unique cache ID.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Generic cache table for caching things not separated out..." do |t|
    t.binary  "data",       limit: 4294967295,                          comment: "A collection of data to cache."
    t.integer "expire",                        default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry should expire, or 0 for never."
    t.integer "created",                       default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry was created."
    t.integer "serialized", limit: 2,          default: 0, null: false, comment: "A flag to indicate whether content is serialized (1) or not (0)."
    t.index ["expire"], name: "expire", using: :btree
  end

  create_table "cache_filter", primary_key: "cid", id: :string, default: "", comment: "Primary Key: Unique cache ID.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Generic cache table for caching things not separated out..." do |t|
    t.binary  "data",       limit: 4294967295,                          comment: "A collection of data to cache."
    t.integer "expire",                        default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry should expire, or 0 for never."
    t.integer "created",                       default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry was created."
    t.integer "serialized", limit: 2,          default: 0, null: false, comment: "A flag to indicate whether content is serialized (1) or not (0)."
    t.index ["expire"], name: "expire", using: :btree
  end

  create_table "cache_form", primary_key: "cid", id: :string, default: "", comment: "Primary Key: Unique cache ID.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Cache table for the form system to store recently built..." do |t|
    t.binary  "data",       limit: 4294967295,                          comment: "A collection of data to cache."
    t.integer "expire",                        default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry should expire, or 0 for never."
    t.integer "created",                       default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry was created."
    t.integer "serialized", limit: 2,          default: 0, null: false, comment: "A flag to indicate whether content is serialized (1) or not (0)."
    t.index ["expire"], name: "expire", using: :btree
  end

  create_table "cache_htmlpurifier", primary_key: "cid", id: :string, default: "", comment: "Primary Key: Unique cache ID.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Cache table for the HTML Purifier module just like cache..." do |t|
    t.binary  "data",       limit: 4294967295,                          comment: "A collection of data to cache."
    t.integer "expire",                        default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry should expire, or 0 for never."
    t.integer "created",                       default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry was created."
    t.integer "serialized", limit: 2,          default: 0, null: false, comment: "A flag to indicate whether content is serialized (1) or not (0)."
    t.index ["expire"], name: "expire", using: :btree
  end

  create_table "cache_libraries", primary_key: "cid", id: :string, default: "", comment: "Primary Key: Unique cache ID.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Cache table to store library information." do |t|
    t.binary  "data",       limit: 4294967295,                          comment: "A collection of data to cache."
    t.integer "expire",                        default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry should expire, or 0 for never."
    t.integer "created",                       default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry was created."
    t.integer "serialized", limit: 2,          default: 0, null: false, comment: "A flag to indicate whether content is serialized (1) or not (0)."
    t.index ["expire"], name: "expire", using: :btree
  end

  create_table "cache_menu", primary_key: "cid", id: :string, default: "", comment: "Primary Key: Unique cache ID.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Cache table for the menu system to store router..." do |t|
    t.binary  "data",       limit: 4294967295,                          comment: "A collection of data to cache."
    t.integer "expire",                        default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry should expire, or 0 for never."
    t.integer "created",                       default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry was created."
    t.integer "serialized", limit: 2,          default: 0, null: false, comment: "A flag to indicate whether content is serialized (1) or not (0)."
    t.index ["expire"], name: "expire", using: :btree
  end

  create_table "cache_page", primary_key: "cid", id: :string, default: "", comment: "Primary Key: Unique cache ID.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Cache table used to store compressed pages for anonymous..." do |t|
    t.binary  "data",       limit: 4294967295,                          comment: "A collection of data to cache."
    t.integer "expire",                        default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry should expire, or 0 for never."
    t.integer "created",                       default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry was created."
    t.integer "serialized", limit: 2,          default: 0, null: false, comment: "A flag to indicate whether content is serialized (1) or not (0)."
    t.index ["expire"], name: "expire", using: :btree
  end

  create_table "cache_path", primary_key: "cid", id: :string, default: "", comment: "Primary Key: Unique cache ID.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Cache table used for path alias lookups." do |t|
    t.binary  "data",       limit: 4294967295,                          comment: "A collection of data to cache."
    t.integer "expire",                        default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry should expire, or 0 for never."
    t.integer "created",                       default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry was created."
    t.integer "serialized", limit: 2,          default: 0, null: false, comment: "A flag to indicate whether content is serialized (1) or not (0)."
    t.index ["expire"], name: "expire", using: :btree
  end

  create_table "cache_token", primary_key: "cid", id: :string, default: "", comment: "Primary Key: Unique cache ID.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Cache table for token information." do |t|
    t.binary  "data",       limit: 4294967295,                          comment: "A collection of data to cache."
    t.integer "expire",                        default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry should expire, or 0 for never."
    t.integer "created",                       default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry was created."
    t.integer "serialized", limit: 2,          default: 0, null: false, comment: "A flag to indicate whether content is serialized (1) or not (0)."
    t.index ["expire"], name: "expire", using: :btree
  end

  create_table "cache_update", primary_key: "cid", id: :string, default: "", comment: "Primary Key: Unique cache ID.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Cache table for the Update module to store information..." do |t|
    t.binary  "data",       limit: 4294967295,                          comment: "A collection of data to cache."
    t.integer "expire",                        default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry should expire, or 0 for never."
    t.integer "created",                       default: 0, null: false, comment: "A Unix timestamp indicating when the cache entry was created."
    t.integer "serialized", limit: 2,          default: 0, null: false, comment: "A flag to indicate whether content is serialized (1) or not (0)."
    t.index ["expire"], name: "expire", using: :btree
  end

  create_table "cache_views", primary_key: "cid", id: :string, default: "", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.binary  "data",       limit: 4294967295
    t.integer "expire",                        default: 0, null: false
    t.integer "created",                       default: 0, null: false
    t.integer "serialized", limit: 2,          default: 0, null: false
    t.index ["expire"], name: "expire", using: :btree
  end

  create_table "cache_views_data", primary_key: "cid", id: :string, default: "", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.binary  "data",       limit: 4294967295
    t.integer "expire",                        default: 0, null: false
    t.integer "created",                       default: 0, null: false
    t.integer "serialized", limit: 2,          default: 1, null: false
    t.index ["expire"], name: "expire", using: :btree
  end

  create_table "cama_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "author"
    t.string   "author_email"
    t.string   "author_url"
    t.string   "author_IP"
    t.text     "content",        limit: 65535
    t.string   "approved",                     default: "pending"
    t.string   "agent"
    t.string   "typee"
    t.integer  "comment_parent"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.index ["approved"], name: "index_cama_comments_on_approved", using: :btree
    t.index ["comment_parent"], name: "index_cama_comments_on_comment_parent", using: :btree
    t.index ["post_id"], name: "index_cama_comments_on_post_id", using: :btree
    t.index ["user_id"], name: "index_cama_comments_on_user_id", using: :btree
  end

  create_table "cama_custom_fields", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string  "object_class"
    t.string  "name"
    t.string  "slug"
    t.integer "objectid"
    t.integer "parent_id"
    t.integer "field_order"
    t.integer "count",                      default: 0
    t.boolean "is_repeat",                  default: false
    t.text    "description",  limit: 65535
    t.string  "status"
    t.index ["object_class"], name: "index_cama_custom_fields_on_object_class", using: :btree
    t.index ["objectid"], name: "index_cama_custom_fields_on_objectid", using: :btree
    t.index ["parent_id"], name: "index_cama_custom_fields_on_parent_id", using: :btree
    t.index ["slug"], name: "index_cama_custom_fields_on_slug", using: :btree
  end

  create_table "cama_custom_fields_relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "objectid"
    t.integer "custom_field_id"
    t.integer "term_order"
    t.string  "object_class"
    t.text    "value",             limit: 4294967295
    t.string  "custom_field_slug"
    t.integer "group_number",                         default: 0
    t.index ["custom_field_id"], name: "index_cama_custom_fields_relationships_on_custom_field_id", using: :btree
    t.index ["custom_field_slug"], name: "index_cama_custom_fields_relationships_on_custom_field_slug", using: :btree
    t.index ["object_class"], name: "index_cama_custom_fields_relationships_on_object_class", using: :btree
    t.index ["objectid"], name: "index_cama_custom_fields_relationships_on_objectid", using: :btree
  end

  create_table "cama_metas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string  "key"
    t.text    "value",        limit: 4294967295
    t.integer "objectid"
    t.string  "object_class"
    t.index ["key"], name: "index_cama_metas_on_key", using: :btree
    t.index ["object_class"], name: "index_cama_metas_on_object_class", using: :btree
    t.index ["objectid"], name: "index_cama_metas_on_objectid", using: :btree
  end

  create_table "cama_posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "content",          limit: 4294967295
    t.text     "content_filtered", limit: 4294967295
    t.string   "status",                              default: "published"
    t.datetime "published_at"
    t.integer  "post_parent"
    t.string   "visibility",                          default: "public"
    t.text     "visibility_value", limit: 16777215
    t.string   "post_class",                          default: "Post"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.integer  "user_id"
    t.integer  "post_order",                          default: 0
    t.integer  "taxonomy_id"
    t.boolean  "is_feature",                          default: false
    t.index ["post_class"], name: "index_cama_posts_on_post_class", using: :btree
    t.index ["post_parent"], name: "index_cama_posts_on_post_parent", using: :btree
    t.index ["slug"], name: "index_cama_posts_on_slug", using: :btree
    t.index ["status"], name: "index_cama_posts_on_status", using: :btree
    t.index ["user_id"], name: "index_cama_posts_on_user_id", using: :btree
  end

  create_table "cama_term_relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "objectid"
    t.integer "term_order"
    t.integer "term_taxonomy_id"
    t.index ["objectid"], name: "index_cama_term_relationships_on_objectid", using: :btree
    t.index ["term_order"], name: "index_cama_term_relationships_on_term_order", using: :btree
    t.index ["term_taxonomy_id"], name: "index_cama_term_relationships_on_term_taxonomy_id", using: :btree
  end

  create_table "cama_term_taxonomy", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "taxonomy"
    t.text     "description", limit: 4294967295
    t.integer  "parent_id"
    t.integer  "count"
    t.string   "name"
    t.string   "slug"
    t.integer  "term_group"
    t.integer  "term_order"
    t.string   "status"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "user_id"
    t.index ["parent_id"], name: "index_cama_term_taxonomy_on_parent_id", using: :btree
    t.index ["slug"], name: "index_cama_term_taxonomy_on_slug", using: :btree
    t.index ["taxonomy"], name: "index_cama_term_taxonomy_on_taxonomy", using: :btree
    t.index ["term_order"], name: "index_cama_term_taxonomy_on_term_order", using: :btree
    t.index ["user_id"], name: "index_cama_term_taxonomy_on_user_id", using: :btree
  end

  create_table "cama_user_relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "term_order"
    t.integer "active",           default: 1
    t.integer "term_taxonomy_id"
    t.integer "user_id"
    t.index ["term_taxonomy_id"], name: "index_cama_user_relationships_on_term_taxonomy_id", using: :btree
    t.index ["user_id"], name: "index_cama_user_relationships_on_user_id", using: :btree
  end

  create_table "cama_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "username"
    t.string   "role",                   default: "client"
    t.string   "email"
    t.string   "slug"
    t.string   "password_digest"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.integer  "parent_id"
    t.datetime "password_reset_sent_at"
    t.datetime "last_login_at"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "site_id",                default: -1
    t.string   "confirm_email_token"
    t.datetime "confirm_email_sent_at"
    t.boolean  "is_valid_email",         default: true
    t.string   "first_name"
    t.string   "last_name"
    t.index ["email"], name: "index_cama_users_on_email", using: :btree
    t.index ["role"], name: "index_cama_users_on_role", using: :btree
    t.index ["site_id"], name: "index_cama_users_on_site_id", using: :btree
    t.index ["username"], name: "index_cama_users_on_username", using: :btree
  end

  create_table "cck_field_settings", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "field_name",     limit: 32,                    null: false, comment: "The name of the field."
    t.string "entity_type",    limit: 32,       default: "", null: false, comment: "The name of the entity type, NULL for field settings."
    t.string "bundle",         limit: 32,                                 comment: "The name of the bundle, NULL for field settings."
    t.string "language",       limit: 32,                                 comment: "The name of the language, NULL for field settings."
    t.string "setting_type",   limit: 32,                    null: false, comment: "The type of setting that CCK is managing (field, instance, widget, display)."
    t.string "setting",        limit: 128,                   null: false, comment: "The name of the setting that CCK is managing (default_value_php, allowed_values_php, etc)."
    t.text   "setting_option", limit: 16777215,                           comment: "The custom value for this setting."
  end

  create_table "comment", primary_key: "cid", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "pid",                  default: 0,  null: false
    t.integer "nid",                  default: 0,  null: false
    t.integer "uid",                  default: 0,  null: false
    t.string  "subject",  limit: 64,  default: "", null: false
    t.string  "hostname", limit: 128, default: "", null: false
    t.integer "changed",              default: 0,  null: false
    t.integer "status",   limit: 1,   default: 1,  null: false,                                                unsigned: true
    t.string  "thread",                            null: false
    t.string  "name",     limit: 60
    t.string  "mail",     limit: 64
    t.string  "homepage"
    t.string  "language", limit: 12,  default: "", null: false
    t.integer "created",              default: 0,  null: false
    t.string  "uuid",     limit: 36,  default: "", null: false, comment: "The Universally Unique Identifier."
    t.index ["created"], name: "comment_created", using: :btree
    t.index ["nid", "language"], name: "comment_nid_language", using: :btree
    t.index ["nid", "status", "created", "cid", "thread"], name: "comment_num_new", using: :btree
    t.index ["pid", "status"], name: "comment_status_pid", using: :btree
    t.index ["uid"], name: "comment_uid", using: :btree
    t.index ["uuid"], name: "uuid", using: :btree
  end

  create_table "contact", primary_key: "cid", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string  "category",                      default: "", null: false
    t.text    "recipients", limit: 4294967295,              null: false
    t.text    "reply",      limit: 4294967295,              null: false
    t.integer "weight",                        default: 0,  null: false, comment: "The category’s weight."
    t.integer "selected",   limit: 1,          default: 0,  null: false
    t.index ["category"], name: "category", unique: true, using: :btree
    t.index ["weight", "category"], name: "list", using: :btree
  end

  create_table "content_field_organization", primary_key: ["vid", "delta"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "vid",                    default: 0, null: false, unsigned: true
    t.integer "nid",                    default: 0, null: false, unsigned: true
    t.integer "delta",                  default: 0, null: false, unsigned: true
    t.integer "field_organization_nid",                          unsigned: true
    t.index ["field_organization_nid"], name: "field_organization_nid", using: :btree
    t.index ["nid"], name: "nid", using: :btree
  end

  create_table "content_field_other_ver", primary_key: ["vid", "delta"], force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer "vid",                 default: 0, null: false, unsigned: true
    t.integer "nid",                 default: 0, null: false, unsigned: true
    t.integer "delta",               default: 0, null: false, unsigned: true
    t.integer "field_other_ver_nid",                          unsigned: true
    t.index ["field_other_ver_nid"], name: "field_other_ver_nid", using: :btree
    t.index ["nid"], name: "nid", using: :btree
  end

  create_table "content_group", primary_key: ["type_name", "group_name"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "group_type", limit: 32,       default: "standard", null: false
    t.string  "type_name",  limit: 32,       default: "",         null: false
    t.string  "group_name", limit: 32,       default: "",         null: false
    t.string  "label",                       default: "",         null: false
    t.text    "settings",   limit: 16777215,                      null: false
    t.integer "weight",                      default: 0,          null: false
  end

  create_table "content_group_fields", primary_key: ["type_name", "group_name", "field_name"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "type_name",  limit: 32, default: "", null: false
    t.string "group_name", limit: 32, default: "", null: false
    t.string "field_name", limit: 32, default: "", null: false
  end

  create_table "content_node_field", primary_key: "field_name", id: :string, limit: 32, default: "", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "type",            limit: 127,      default: "", null: false
    t.text    "global_settings", limit: 16777215,              null: false
    t.integer "required",        limit: 1,        default: 0,  null: false
    t.integer "multiple",        limit: 1,        default: 0,  null: false
    t.integer "db_storage",      limit: 1,        default: 1,  null: false
    t.string  "module",          limit: 127,      default: "", null: false
    t.text    "db_columns",      limit: 16777215,              null: false
    t.integer "active",          limit: 1,        default: 0,  null: false
    t.integer "locked",          limit: 1,        default: 0,  null: false
  end

  create_table "content_node_field_instance", primary_key: ["field_name", "type_name"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "field_name",       limit: 32,       default: "", null: false
    t.string  "type_name",        limit: 32,       default: "", null: false
    t.integer "weight",                            default: 0,  null: false
    t.string  "label",                             default: "", null: false
    t.string  "widget_type",      limit: 32,       default: "", null: false
    t.text    "widget_settings",  limit: 16777215,              null: false
    t.text    "display_settings", limit: 16777215,              null: false
    t.text    "description",      limit: 16777215,              null: false
    t.string  "widget_module",    limit: 127,      default: "", null: false
    t.integer "widget_active",    limit: 1,        default: 0,  null: false
  end

  create_table "content_type_ethics_code", primary_key: "vid", id: :integer, default: 0, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "nid",                                              default: 0, null: false, unsigned: true
    t.text    "field_code_id_value",           limit: 4294967295
    t.text    "field_source_value",            limit: 4294967295
    t.text    "field_date_approved_value",     limit: 4294967295
    t.text    "field_disclaimer_value",        limit: 4294967295
    t.text    "field_code_description_value",  limit: 4294967295
    t.text    "field_contents_value",          limit: 4294967295
    t.text    "field_source_url_value",        limit: 4294967295
    t.text    "field_org_url_value",           limit: 4294967295
    t.integer "field_disclaimer_format",                                                   unsigned: true
    t.integer "field_contents_format",                                                     unsigned: true
    t.integer "field_code_description_format",                                             unsigned: true
    t.index ["nid"], name: "nid", using: :btree
  end

  create_table "content_type_organization", primary_key: "vid", id: :integer, default: 0, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "nid",                                     default: 0, null: false, unsigned: true
    t.text    "field_assoc_id_value", limit: 4294967295
    t.index ["nid"], name: "nid", using: :btree
  end

  create_table "ctools_css_cache", primary_key: "cid", id: :string, limit: 128, comment: "The CSS ID this cache object belongs to.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "A special cache used to store CSS that must be non-volatile." do |t|
    t.string  "filename",                    comment: "The filename this CSS is stored in."
    t.text    "css",      limit: 4294967295, comment: "CSS being stored."
    t.integer "filter",   limit: 1,          comment: "Whether or not this CSS needs to be filtered."
  end

  create_table "ctools_custom_content", primary_key: "cid", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Contains exportable customized content for this site." do |t|
    t.string "name",                                 comment: "Unique ID for this content. Used to identify it programmatically."
    t.string "admin_title",                          comment: "Administrative title for this content."
    t.text   "admin_description", limit: 4294967295, comment: "Administrative description for this content."
    t.string "category",                             comment: "Administrative category for this content."
    t.text   "settings",          limit: 4294967295, comment: "Serialized settings for the actual content to be used"
  end

  create_table "ctools_object_cache", primary_key: ["sid", "obj", "name"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "A special cache used to store objects that are being..." do |t|
    t.string  "sid",     limit: 64,                     null: false, comment: "The session ID this cache object belongs to."
    t.string  "name",    limit: 128,                    null: false, comment: "The name of the object this cache is attached to."
    t.string  "obj",     limit: 128,                    null: false, comment: "The type of the object this cache is attached to; this essentially represents the owner so that several sub-systems can use this cache."
    t.integer "updated",                    default: 0, null: false, comment: "The time this cache was created or updated.",                                                                                             unsigned: true
    t.binary  "data",    limit: 4294967295,                          comment: "Serialized data being stored."
    t.index ["updated"], name: "updated", using: :btree
  end

  create_table "current_search", primary_key: "name", id: :string, default: "", comment: "The machine readable name of the configuration.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Current search block configurations." do |t|
    t.string "label",                  default: "", null: false, comment: "The human readable name of the configuration."
    t.text   "settings", limit: 65535,                           comment: "Serialized storage of general settings."
  end

  create_table "d6_upgrade_filter", primary_key: "fid", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "format",            default: 0,  null: false
    t.string  "module", limit: 64, default: "", null: false
    t.integer "delta",  limit: 1,  default: 0,  null: false
    t.integer "weight", limit: 1,  default: 0,  null: false
    t.index ["format", "module", "delta"], name: "fmd", unique: true, using: :btree
    t.index ["format", "weight", "module", "delta"], name: "list", using: :btree
  end

  create_table "date_format_locale", primary_key: ["type", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Stores configured date formats for each locale." do |t|
    t.string "format",   limit: 100, null: false, collation: "utf8_bin", comment: "The date format string."
    t.string "type",     limit: 64,  null: false,                        comment: "The date format type, e.g. medium."
    t.string "language", limit: 12,  null: false,                        comment: "A languages.language for this format to be used with."
  end

  create_table "date_format_type", primary_key: "type", id: :string, limit: 64, comment: "The date format type, e.g. medium.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Stores configured date format types." do |t|
    t.string  "title",                        null: false, comment: "The human readable name of the format type."
    t.integer "locked", limit: 1, default: 0, null: false, comment: "Whether or not this is a system provided format."
    t.index ["title"], name: "title", using: :btree
  end

  create_table "date_formats", primary_key: "dfid", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Stores configured date formats." do |t|
    t.string  "format", limit: 100,             null: false, collation: "utf8_bin", comment: "The date format string."
    t.string  "type",   limit: 64,              null: false,                        comment: "The date format type, e.g. medium."
    t.integer "locked", limit: 1,   default: 0, null: false,                        comment: "Whether or not this format can be modified."
    t.index ["format", "type"], name: "formats", unique: true, using: :btree
  end

  create_table "ds_field_settings", id: :string, default: "", comment: "The unique id this setting.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "The table that holds Display Suite field settings per..." do |t|
    t.string "entity_type", limit: 32,         default: "", null: false, comment: "The name of the entity."
    t.string "bundle",      limit: 64,         default: "", null: false, comment: "The name of the entity."
    t.string "view_mode",   limit: 64,         default: "", null: false, comment: "The name of the view_mode."
    t.binary "settings",    limit: 4294967295,                           comment: "The Display Suite field settings for this layout."
    t.index ["bundle"], name: "ds_bundle", using: :btree
    t.index ["entity_type"], name: "ds_entity", using: :btree
    t.index ["view_mode"], name: "ds_view_mode", using: :btree
  end

  create_table "ds_fields", primary_key: "field", id: :string, limit: 32, default: "", comment: "The machine name of the field.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "The table that holds custom fields managed by Display Suite." do |t|
    t.string  "label",      limit: 128,        default: "", null: false, comment: "The label of the field."
    t.integer "field_type", limit: 2,          default: 0,  null: false, comment: "The type of of the field"
    t.binary  "entities",   limit: 4294967295,                           comment: "The entities for this field."
    t.binary  "ui_limit",   limit: 4294967295,                           comment: "The UI limit for this field."
    t.binary  "properties", limit: 4294967295,                           comment: "The properties for this field."
  end

  create_table "ds_layout_settings", id: :string, default: "", comment: "The unique id the layout.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "The table that holds the layouts configuration." do |t|
    t.string "entity_type", limit: 32,         default: "", null: false, comment: "The name of the entity."
    t.string "bundle",      limit: 64,         default: "", null: false, comment: "The name of the entity."
    t.string "view_mode",   limit: 64,         default: "", null: false, comment: "The name of the view_mode."
    t.string "layout",      limit: 64,         default: "", null: false, comment: "The name of the layout."
    t.binary "settings",    limit: 4294967295,                           comment: "The settings for this layout."
    t.index ["bundle"], name: "ds_bundle", using: :btree
    t.index ["entity_type"], name: "ds_entity", using: :btree
    t.index ["view_mode"], name: "ds_view_mode", using: :btree
  end

  create_table "ds_vd", primary_key: "vd", id: :string, limit: 128, default: "", comment: "The primary identifier for the views display.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "The base table for views displays." do |t|
    t.string "label", limit: 132, default: "", null: false, comment: "The label for the views display."
  end

  create_table "ds_view_modes", primary_key: "view_mode", id: :string, limit: 64, default: "", comment: "The machine name of the view mode.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "The table that holds custom view modes managed by Display..." do |t|
    t.string "label",    limit: 32,         default: "", null: false, comment: "The label of the view mode."
    t.binary "entities", limit: 4294967295,                           comment: "The entities for this view mode."
  end

  create_table "facetapi", primary_key: "name", id: :string, default: "", comment: "The machine readable name of the configuration.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Facet configurations." do |t|
    t.string  "searcher", limit: 64,    default: "", null: false, comment: "The machine readable name of the searcher."
    t.string  "realm",    limit: 64,    default: "", null: false, comment: "The machine readable name of the realm."
    t.string  "facet",                  default: "", null: false, comment: "The machine readable name of the facet."
    t.integer "enabled",  limit: 1,     default: 0,  null: false, comment: "Whether the facet is enabled."
    t.binary  "settings", limit: 65535,                           comment: "Serialized storage of general settings."
  end

  create_table "faceted_search_env", primary_key: "env_id", unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "name",        limit: 32,         default: "", null: false
    t.string "description",                    default: ""
    t.text   "settings",    limit: 4294967295
  end

  create_table "faceted_search_filters", primary_key: ["env_id", "filter_key", "filter_id"], force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer "env_id",                    default: 0,  null: false, unsigned: true
    t.string  "filter_key",     limit: 32, default: "", null: false
    t.string  "filter_id",      limit: 32, default: "", null: false
    t.integer "status",                    default: 0,  null: false
    t.integer "weight",                    default: 0,  null: false
    t.string  "sort",           limit: 32, default: "", null: false
    t.integer "max_categories",            default: 0,  null: false
    t.index ["status"], name: "status", using: :btree
  end

  create_table "field_config", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "field_name",     limit: 32,                      null: false, comment: "The name of this field. Non-deleted field names are unique, but multiple deleted fields can have the same name."
    t.string  "type",           limit: 128,                     null: false, comment: "The type of this field."
    t.string  "module",         limit: 128,        default: "", null: false, comment: "The module that implements the field type."
    t.integer "active",         limit: 1,          default: 0,  null: false, comment: "Boolean indicating whether the module that implements the field type is enabled."
    t.string  "storage_type",   limit: 128,                     null: false, comment: "The storage backend for the field."
    t.string  "storage_module", limit: 128,        default: "", null: false, comment: "The module that implements the storage backend."
    t.integer "storage_active", limit: 1,          default: 0,  null: false, comment: "Boolean indicating whether the module that implements the storage backend is enabled."
    t.integer "locked",         limit: 1,          default: 0,  null: false, comment: "@TODO"
    t.binary  "data",           limit: 4294967295,              null: false, comment: "Serialized data containing the field properties that do not warrant a dedicated column."
    t.integer "cardinality",    limit: 1,          default: 0,  null: false
    t.integer "translatable",   limit: 1,          default: 0,  null: false
    t.integer "deleted",        limit: 1,          default: 0,  null: false
    t.index ["active"], name: "active", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["field_name"], name: "field_name", using: :btree
    t.index ["module"], name: "module", using: :btree
    t.index ["storage_active"], name: "storage_active", using: :btree
    t.index ["storage_module"], name: "storage_module", using: :btree
    t.index ["storage_type"], name: "storage_type", using: :btree
    t.index ["type"], name: "type", using: :btree
  end

  create_table "field_config_instance", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "field_id",                                    null: false, comment: "The identifier of the field attached by this instance"
    t.string  "field_name",  limit: 32,         default: "", null: false
    t.string  "entity_type", limit: 32,         default: "", null: false
    t.string  "bundle",      limit: 128,        default: "", null: false
    t.binary  "data",        limit: 4294967295,              null: false
    t.integer "deleted",     limit: 1,          default: 0,  null: false
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["field_name", "entity_type", "bundle"], name: "field_name_bundle", using: :btree
  end

  create_table "field_data_body", primary_key: ["entity_type", "entity_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Data storage for field 4 (body)" do |t|
    t.string  "entity_type",  limit: 128,        default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",       limit: 128,        default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",      limit: 1,          default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                    null: false, comment: "The entity id this data is attached to",                                                       unsigned: true
    t.integer "revision_id",                                               comment: "The entity revision id this data is attached to, or NULL if the entity type is not versioned", unsigned: true
    t.string  "language",     limit: 32,         default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                        null: false, comment: "The sequence number for this data item, used for multi-value fields",                          unsigned: true
    t.text    "body_value",   limit: 4294967295
    t.text    "body_summary", limit: 4294967295
    t.string  "body_format"
    t.index ["body_format"], name: "body_format", using: :btree
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_data_comment_body", primary_key: ["entity_type", "entity_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Data storage for field 5 (comment_body)" do |t|
    t.string  "entity_type",         limit: 128,        default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",              limit: 128,        default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",             limit: 1,          default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                           null: false, comment: "The entity id this data is attached to",                                                       unsigned: true
    t.integer "revision_id",                                                      comment: "The entity revision id this data is attached to, or NULL if the entity type is not versioned", unsigned: true
    t.string  "language",            limit: 32,         default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                               null: false, comment: "The sequence number for this data item, used for multi-value fields",                          unsigned: true
    t.text    "comment_body_value",  limit: 4294967295
    t.string  "comment_body_format"
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["comment_body_format"], name: "comment_body_format", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_data_field_assoc_id", primary_key: ["entity_type", "entity_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Data storage for field 17 (field_assoc_id)" do |t|
    t.string  "entity_type",           limit: 128, default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",                limit: 128, default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",               limit: 1,   default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                      null: false, comment: "The entity id this data is attached to",                                                       unsigned: true
    t.integer "revision_id",                                                 comment: "The entity revision id this data is attached to, or NULL if the entity type is not versioned", unsigned: true
    t.string  "language",              limit: 32,  default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                          null: false, comment: "The sequence number for this data item, used for multi-value fields",                          unsigned: true
    t.string  "field_assoc_id_value"
    t.string  "field_assoc_id_format"
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["field_assoc_id_format"], name: "field_assoc_id_format", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_data_field_code_description", primary_key: ["entity_type", "entity_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Data storage for field 7 (field_code_description)" do |t|
    t.string  "entity_type",                   limit: 128,        default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",                        limit: 128,        default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",                       limit: 1,          default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                                     null: false, comment: "The entity id this data is attached to",                                                       unsigned: true
    t.integer "revision_id",                                                                comment: "The entity revision id this data is attached to, or NULL if the entity type is not versioned", unsigned: true
    t.string  "language",                      limit: 32,         default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                                         null: false, comment: "The sequence number for this data item, used for multi-value fields",                          unsigned: true
    t.text    "field_code_description_value",  limit: 4294967295
    t.string  "field_code_description_format"
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["field_code_description_format"], name: "field_code_description_format", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_data_field_code_id", primary_key: ["entity_type", "entity_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Data storage for field 8 (field_code_id)" do |t|
    t.string  "entity_type",          limit: 128, default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",               limit: 128, default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",              limit: 1,   default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                     null: false, comment: "The entity id this data is attached to",                                                       unsigned: true
    t.integer "revision_id",                                                comment: "The entity revision id this data is attached to, or NULL if the entity type is not versioned", unsigned: true
    t.string  "language",             limit: 32,  default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                         null: false, comment: "The sequence number for this data item, used for multi-value fields",                          unsigned: true
    t.string  "field_code_id_value"
    t.string  "field_code_id_format"
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["field_code_id_format"], name: "field_code_id_format", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_data_field_contents", primary_key: ["entity_type", "entity_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Data storage for field 9 (field_contents)" do |t|
    t.string  "entity_type",           limit: 128,        default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",                limit: 128,        default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",               limit: 1,          default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                             null: false, comment: "The entity id this data is attached to",                                                       unsigned: true
    t.integer "revision_id",                                                        comment: "The entity revision id this data is attached to, or NULL if the entity type is not versioned", unsigned: true
    t.string  "language",              limit: 32,         default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                                 null: false, comment: "The sequence number for this data item, used for multi-value fields",                          unsigned: true
    t.text    "field_contents_value",  limit: 4294967295
    t.string  "field_contents_format"
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["field_contents_format"], name: "field_contents_format", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_data_field_date_approved", primary_key: ["entity_type", "entity_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Data storage for field 10 (field_date_approved)" do |t|
    t.string  "entity_type",                limit: 128, default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",                     limit: 128, default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",                    limit: 1,   default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                           null: false, comment: "The entity id this data is attached to",                                                       unsigned: true
    t.integer "revision_id",                                                      comment: "The entity revision id this data is attached to, or NULL if the entity type is not versioned", unsigned: true
    t.string  "language",                   limit: 32,  default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                               null: false, comment: "The sequence number for this data item, used for multi-value fields",                          unsigned: true
    t.string  "field_date_approved_value"
    t.string  "field_date_approved_format"
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["field_date_approved_format"], name: "field_date_approved_format", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_data_field_disclaimer", primary_key: ["entity_type", "entity_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Data storage for field 11 (field_disclaimer)" do |t|
    t.string  "entity_type",             limit: 128,        default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",                  limit: 128,        default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",                 limit: 1,          default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                               null: false, comment: "The entity id this data is attached to",                                                       unsigned: true
    t.integer "revision_id",                                                          comment: "The entity revision id this data is attached to, or NULL if the entity type is not versioned", unsigned: true
    t.string  "language",                limit: 32,         default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                                   null: false, comment: "The sequence number for this data item, used for multi-value fields",                          unsigned: true
    t.text    "field_disclaimer_value",  limit: 4294967295
    t.string  "field_disclaimer_format"
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["field_disclaimer_format"], name: "field_disclaimer_format", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_data_field_organization", primary_key: ["entity_type", "entity_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Data storage for field 12 (field_organization)" do |t|
    t.string  "entity_type",            limit: 128, default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",                 limit: 128, default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",                limit: 1,   default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                       null: false, comment: "The entity id this data is attached to",                                                       unsigned: true
    t.integer "revision_id",                                                  comment: "The entity revision id this data is attached to, or NULL if the entity type is not versioned", unsigned: true
    t.string  "language",               limit: 32,  default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                           null: false, comment: "The sequence number for this data item, used for multi-value fields",                          unsigned: true
    t.integer "field_organization_nid",                                                                                                                                                unsigned: true
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["field_organization_nid"], name: "field_organization_nid", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_data_field_organization_url", primary_key: ["entity_type", "entity_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Data storage for field 19 (field_organization_url)" do |t|
    t.string  "entity_type",                       limit: 128,      default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",                            limit: 128,      default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",                           limit: 1,        default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                                       null: false, comment: "The entity id this data is attached to",                                                       unsigned: true
    t.integer "revision_id",                                                                  comment: "The entity revision id this data is attached to, or NULL if the entity type is not versioned", unsigned: true
    t.string  "language",                          limit: 32,       default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                                           null: false, comment: "The sequence number for this data item, used for multi-value fields",                          unsigned: true
    t.string  "field_organization_url_url",        limit: 2048
    t.string  "field_organization_url_title"
    t.text    "field_organization_url_attributes", limit: 16777215
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_data_field_other_ver", primary_key: ["entity_type", "entity_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Data storage for field 14 (field_other_ver)" do |t|
    t.string  "entity_type",         limit: 128, default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",              limit: 128, default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",             limit: 1,   default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                    null: false, comment: "The entity id this data is attached to",                                                       unsigned: true
    t.integer "revision_id",                                               comment: "The entity revision id this data is attached to, or NULL if the entity type is not versioned", unsigned: true
    t.string  "language",            limit: 32,  default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                        null: false, comment: "The sequence number for this data item, used for multi-value fields",                          unsigned: true
    t.integer "field_other_ver_nid",                                                                                                                                                unsigned: true
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["field_other_ver_nid"], name: "field_other_ver_nid", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_data_field_source", primary_key: ["entity_type", "entity_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Data storage for field 15 (field_source)" do |t|
    t.string  "entity_type",         limit: 128, default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",              limit: 128, default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",             limit: 1,   default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                    null: false, comment: "The entity id this data is attached to",                                                       unsigned: true
    t.integer "revision_id",                                               comment: "The entity revision id this data is attached to, or NULL if the entity type is not versioned", unsigned: true
    t.string  "language",            limit: 32,  default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                        null: false, comment: "The sequence number for this data item, used for multi-value fields",                          unsigned: true
    t.string  "field_source_value"
    t.string  "field_source_format"
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["field_source_format"], name: "field_source_format", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_data_field_sr_url", primary_key: ["entity_type", "entity_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Data storage for field 20 (field_sr_url)" do |t|
    t.string  "entity_type",             limit: 128,      default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",                  limit: 128,      default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",                 limit: 1,        default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                             null: false, comment: "The entity id this data is attached to",                                                       unsigned: true
    t.integer "revision_id",                                                        comment: "The entity revision id this data is attached to, or NULL if the entity type is not versioned", unsigned: true
    t.string  "language",                limit: 32,       default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                                 null: false, comment: "The sequence number for this data item, used for multi-value fields",                          unsigned: true
    t.string  "field_sr_url_url",        limit: 2048
    t.string  "field_sr_url_title"
    t.text    "field_sr_url_attributes", limit: 16777215
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_data_taxonomy_forums", primary_key: ["entity_type", "entity_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Data storage for field 18 (taxonomy_forums)" do |t|
    t.string  "entity_type",         limit: 128, default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",              limit: 128, default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",             limit: 1,   default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                    null: false, comment: "The entity id this data is attached to",                                                       unsigned: true
    t.integer "revision_id",                                               comment: "The entity revision id this data is attached to, or NULL if the entity type is not versioned", unsigned: true
    t.string  "language",            limit: 32,  default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                        null: false, comment: "The sequence number for this data item, used for multi-value fields",                          unsigned: true
    t.integer "taxonomy_forums_tid",                                                                                                                                                unsigned: true
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
    t.index ["taxonomy_forums_tid"], name: "taxonomy_forums_tid", using: :btree
  end

  create_table "field_data_taxonomy_vocabulary_1", primary_key: ["entity_type", "entity_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Data storage for field 1 (taxonomy_vocabulary_1)" do |t|
    t.string  "entity_type",               limit: 128, default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",                    limit: 128, default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",                   limit: 1,   default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                          null: false, comment: "The entity id this data is attached to",                                                       unsigned: true
    t.integer "revision_id",                                                     comment: "The entity revision id this data is attached to, or NULL if the entity type is not versioned", unsigned: true
    t.string  "language",                  limit: 32,  default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                              null: false, comment: "The sequence number for this data item, used for multi-value fields",                          unsigned: true
    t.integer "taxonomy_vocabulary_1_tid",                                                                                                                                                unsigned: true
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
    t.index ["taxonomy_vocabulary_1_tid"], name: "taxonomy_vocabulary_1_tid", using: :btree
  end

  create_table "field_data_taxonomy_vocabulary_2", primary_key: ["entity_type", "entity_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Data storage for field 2 (taxonomy_vocabulary_2)" do |t|
    t.string  "entity_type",               limit: 128, default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",                    limit: 128, default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",                   limit: 1,   default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                          null: false, comment: "The entity id this data is attached to",                                                       unsigned: true
    t.integer "revision_id",                                                     comment: "The entity revision id this data is attached to, or NULL if the entity type is not versioned", unsigned: true
    t.string  "language",                  limit: 32,  default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                              null: false, comment: "The sequence number for this data item, used for multi-value fields",                          unsigned: true
    t.integer "taxonomy_vocabulary_2_tid",                                                                                                                                                unsigned: true
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
    t.index ["taxonomy_vocabulary_2_tid"], name: "taxonomy_vocabulary_2_tid", using: :btree
  end

  create_table "field_data_upload", primary_key: ["entity_type", "entity_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Data storage for field 6 (upload)" do |t|
    t.string  "entity_type",        limit: 128,   default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",             limit: 128,   default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",            limit: 1,     default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                     null: false, comment: "The entity id this data is attached to",                                                       unsigned: true
    t.integer "revision_id",                                                comment: "The entity revision id this data is attached to, or NULL if the entity type is not versioned", unsigned: true
    t.string  "language",           limit: 32,    default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                         null: false, comment: "The sequence number for this data item, used for multi-value fields",                          unsigned: true
    t.integer "upload_fid",                                                 comment: "The file_managed.fid being referenced in this field.",                                         unsigned: true
    t.integer "upload_display",     limit: 1,     default: 1,  null: false, comment: "Flag to control whether this file should be displayed when viewing content.",                  unsigned: true
    t.text    "upload_description", limit: 65535,                           comment: "A description of the file."
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
    t.index ["upload_fid"], name: "upload_fid", using: :btree
  end

  create_table "field_deleted_data_13", primary_key: ["entity_type", "entity_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Data storage for field 13 (field_org_url)" do |t|
    t.string  "entity_type",          limit: 128, default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",               limit: 128, default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",              limit: 1,   default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                     null: false, comment: "The entity id this data is attached to",                                                       unsigned: true
    t.integer "revision_id",                                                comment: "The entity revision id this data is attached to, or NULL if the entity type is not versioned", unsigned: true
    t.string  "language",             limit: 32,  default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                         null: false, comment: "The sequence number for this data item, used for multi-value fields",                          unsigned: true
    t.string  "field_org_url_value"
    t.string  "field_org_url_format"
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["field_org_url_format"], name: "field_org_url_format", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_deleted_data_16", primary_key: ["entity_type", "entity_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Data storage for field 16 (field_source_url)" do |t|
    t.string  "entity_type",             limit: 128, default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",                  limit: 128, default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",                 limit: 1,   default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                        null: false, comment: "The entity id this data is attached to",                                                       unsigned: true
    t.integer "revision_id",                                                   comment: "The entity revision id this data is attached to, or NULL if the entity type is not versioned", unsigned: true
    t.string  "language",                limit: 32,  default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                            null: false, comment: "The sequence number for this data item, used for multi-value fields",                          unsigned: true
    t.string  "field_source_url_value"
    t.string  "field_source_url_format"
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["field_source_url_format"], name: "field_source_url_format", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_deleted_revision_13", primary_key: ["entity_type", "entity_id", "revision_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Revision archive storage for field 13 (field_org_url)" do |t|
    t.string  "entity_type",          limit: 128, default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",               limit: 128, default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",              limit: 1,   default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                     null: false, comment: "The entity id this data is attached to",                                                   unsigned: true
    t.integer "revision_id",                                   null: false, comment: "The entity revision id this data is attached to",                                          unsigned: true
    t.string  "language",             limit: 32,  default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                         null: false, comment: "The sequence number for this data item, used for multi-value fields",                      unsigned: true
    t.string  "field_org_url_value"
    t.string  "field_org_url_format"
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["field_org_url_format"], name: "field_org_url_format", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_deleted_revision_16", primary_key: ["entity_type", "entity_id", "revision_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Revision archive storage for field 16 (field_source_url)" do |t|
    t.string  "entity_type",             limit: 128, default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",                  limit: 128, default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",                 limit: 1,   default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                        null: false, comment: "The entity id this data is attached to",                                                   unsigned: true
    t.integer "revision_id",                                      null: false, comment: "The entity revision id this data is attached to",                                          unsigned: true
    t.string  "language",                limit: 32,  default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                            null: false, comment: "The sequence number for this data item, used for multi-value fields",                      unsigned: true
    t.string  "field_source_url_value"
    t.string  "field_source_url_format"
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["field_source_url_format"], name: "field_source_url_format", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_revision_body", primary_key: ["entity_type", "entity_id", "revision_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Revision archive storage for field 4 (body)" do |t|
    t.string  "entity_type",  limit: 128,        default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",       limit: 128,        default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",      limit: 1,          default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                    null: false, comment: "The entity id this data is attached to",                                                   unsigned: true
    t.integer "revision_id",                                  null: false, comment: "The entity revision id this data is attached to",                                          unsigned: true
    t.string  "language",     limit: 32,         default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                        null: false, comment: "The sequence number for this data item, used for multi-value fields",                      unsigned: true
    t.text    "body_value",   limit: 4294967295
    t.text    "body_summary", limit: 4294967295
    t.string  "body_format"
    t.index ["body_format"], name: "body_format", using: :btree
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_revision_comment_body", primary_key: ["entity_type", "entity_id", "revision_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Revision archive storage for field 5 (comment_body)" do |t|
    t.string  "entity_type",         limit: 128,        default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",              limit: 128,        default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",             limit: 1,          default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                           null: false, comment: "The entity id this data is attached to",                                                   unsigned: true
    t.integer "revision_id",                                         null: false, comment: "The entity revision id this data is attached to",                                          unsigned: true
    t.string  "language",            limit: 32,         default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                               null: false, comment: "The sequence number for this data item, used for multi-value fields",                      unsigned: true
    t.text    "comment_body_value",  limit: 4294967295
    t.string  "comment_body_format"
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["comment_body_format"], name: "comment_body_format", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_revision_field_assoc_id", primary_key: ["entity_type", "entity_id", "revision_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Revision archive storage for field 17 (field_assoc_id)" do |t|
    t.string  "entity_type",           limit: 128, default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",                limit: 128, default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",               limit: 1,   default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                      null: false, comment: "The entity id this data is attached to",                                                   unsigned: true
    t.integer "revision_id",                                    null: false, comment: "The entity revision id this data is attached to",                                          unsigned: true
    t.string  "language",              limit: 32,  default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                          null: false, comment: "The sequence number for this data item, used for multi-value fields",                      unsigned: true
    t.string  "field_assoc_id_value"
    t.string  "field_assoc_id_format"
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["field_assoc_id_format"], name: "field_assoc_id_format", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_revision_field_code_description", primary_key: ["entity_type", "entity_id", "revision_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Revision archive storage for field 7 (field_code..." do |t|
    t.string  "entity_type",                   limit: 128,        default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",                        limit: 128,        default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",                       limit: 1,          default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                                     null: false, comment: "The entity id this data is attached to",                                                   unsigned: true
    t.integer "revision_id",                                                   null: false, comment: "The entity revision id this data is attached to",                                          unsigned: true
    t.string  "language",                      limit: 32,         default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                                         null: false, comment: "The sequence number for this data item, used for multi-value fields",                      unsigned: true
    t.text    "field_code_description_value",  limit: 4294967295
    t.string  "field_code_description_format"
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["field_code_description_format"], name: "field_code_description_format", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_revision_field_code_id", primary_key: ["entity_type", "entity_id", "revision_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Revision archive storage for field 8 (field_code_id)" do |t|
    t.string  "entity_type",          limit: 128, default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",               limit: 128, default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",              limit: 1,   default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                     null: false, comment: "The entity id this data is attached to",                                                   unsigned: true
    t.integer "revision_id",                                   null: false, comment: "The entity revision id this data is attached to",                                          unsigned: true
    t.string  "language",             limit: 32,  default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                         null: false, comment: "The sequence number for this data item, used for multi-value fields",                      unsigned: true
    t.string  "field_code_id_value"
    t.string  "field_code_id_format"
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["field_code_id_format"], name: "field_code_id_format", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_revision_field_contents", primary_key: ["entity_type", "entity_id", "revision_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Revision archive storage for field 9 (field_contents)" do |t|
    t.string  "entity_type",           limit: 128,        default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",                limit: 128,        default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",               limit: 1,          default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                             null: false, comment: "The entity id this data is attached to",                                                   unsigned: true
    t.integer "revision_id",                                           null: false, comment: "The entity revision id this data is attached to",                                          unsigned: true
    t.string  "language",              limit: 32,         default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                                 null: false, comment: "The sequence number for this data item, used for multi-value fields",                      unsigned: true
    t.text    "field_contents_value",  limit: 4294967295
    t.string  "field_contents_format"
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["field_contents_format"], name: "field_contents_format", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_revision_field_date_approved", primary_key: ["entity_type", "entity_id", "revision_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Revision archive storage for field 10 (field_date_approved)" do |t|
    t.string  "entity_type",                limit: 128, default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",                     limit: 128, default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",                    limit: 1,   default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                           null: false, comment: "The entity id this data is attached to",                                                   unsigned: true
    t.integer "revision_id",                                         null: false, comment: "The entity revision id this data is attached to",                                          unsigned: true
    t.string  "language",                   limit: 32,  default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                               null: false, comment: "The sequence number for this data item, used for multi-value fields",                      unsigned: true
    t.string  "field_date_approved_value"
    t.string  "field_date_approved_format"
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["field_date_approved_format"], name: "field_date_approved_format", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_revision_field_disclaimer", primary_key: ["entity_type", "entity_id", "revision_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Revision archive storage for field 11 (field_disclaimer)" do |t|
    t.string  "entity_type",             limit: 128,        default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",                  limit: 128,        default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",                 limit: 1,          default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                               null: false, comment: "The entity id this data is attached to",                                                   unsigned: true
    t.integer "revision_id",                                             null: false, comment: "The entity revision id this data is attached to",                                          unsigned: true
    t.string  "language",                limit: 32,         default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                                   null: false, comment: "The sequence number for this data item, used for multi-value fields",                      unsigned: true
    t.text    "field_disclaimer_value",  limit: 4294967295
    t.string  "field_disclaimer_format"
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["field_disclaimer_format"], name: "field_disclaimer_format", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_revision_field_organization", primary_key: ["entity_type", "entity_id", "revision_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Revision archive storage for field 12 (field_organization)" do |t|
    t.string  "entity_type",            limit: 128, default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",                 limit: 128, default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",                limit: 1,   default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                       null: false, comment: "The entity id this data is attached to",                                                   unsigned: true
    t.integer "revision_id",                                     null: false, comment: "The entity revision id this data is attached to",                                          unsigned: true
    t.string  "language",               limit: 32,  default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                           null: false, comment: "The sequence number for this data item, used for multi-value fields",                      unsigned: true
    t.integer "field_organization_nid",                                                                                                                                            unsigned: true
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["field_organization_nid"], name: "field_organization_nid", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_revision_field_organization_url", primary_key: ["entity_type", "entity_id", "revision_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Revision archive storage for field 19 (field_organization..." do |t|
    t.string  "entity_type",                       limit: 128,      default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",                            limit: 128,      default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",                           limit: 1,        default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                                       null: false, comment: "The entity id this data is attached to",                                                   unsigned: true
    t.integer "revision_id",                                                     null: false, comment: "The entity revision id this data is attached to",                                          unsigned: true
    t.string  "language",                          limit: 32,       default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                                           null: false, comment: "The sequence number for this data item, used for multi-value fields",                      unsigned: true
    t.string  "field_organization_url_url",        limit: 2048
    t.string  "field_organization_url_title"
    t.text    "field_organization_url_attributes", limit: 16777215
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_revision_field_other_ver", primary_key: ["entity_type", "entity_id", "revision_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Revision archive storage for field 14 (field_other_ver)" do |t|
    t.string  "entity_type",         limit: 128, default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",              limit: 128, default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",             limit: 1,   default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                    null: false, comment: "The entity id this data is attached to",                                                   unsigned: true
    t.integer "revision_id",                                  null: false, comment: "The entity revision id this data is attached to",                                          unsigned: true
    t.string  "language",            limit: 32,  default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                        null: false, comment: "The sequence number for this data item, used for multi-value fields",                      unsigned: true
    t.integer "field_other_ver_nid",                                                                                                                                            unsigned: true
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["field_other_ver_nid"], name: "field_other_ver_nid", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_revision_field_source", primary_key: ["entity_type", "entity_id", "revision_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Revision archive storage for field 15 (field_source)" do |t|
    t.string  "entity_type",         limit: 128, default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",              limit: 128, default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",             limit: 1,   default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                    null: false, comment: "The entity id this data is attached to",                                                   unsigned: true
    t.integer "revision_id",                                  null: false, comment: "The entity revision id this data is attached to",                                          unsigned: true
    t.string  "language",            limit: 32,  default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                        null: false, comment: "The sequence number for this data item, used for multi-value fields",                      unsigned: true
    t.string  "field_source_value"
    t.string  "field_source_format"
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["field_source_format"], name: "field_source_format", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_revision_field_sr_url", primary_key: ["entity_type", "entity_id", "revision_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Revision archive storage for field 20 (field_sr_url)" do |t|
    t.string  "entity_type",             limit: 128,      default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",                  limit: 128,      default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",                 limit: 1,        default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                             null: false, comment: "The entity id this data is attached to",                                                   unsigned: true
    t.integer "revision_id",                                           null: false, comment: "The entity revision id this data is attached to",                                          unsigned: true
    t.string  "language",                limit: 32,       default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                                 null: false, comment: "The sequence number for this data item, used for multi-value fields",                      unsigned: true
    t.string  "field_sr_url_url",        limit: 2048
    t.string  "field_sr_url_title"
    t.text    "field_sr_url_attributes", limit: 16777215
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
  end

  create_table "field_revision_taxonomy_forums", primary_key: ["entity_type", "entity_id", "revision_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Revision archive storage for field 18 (taxonomy_forums)" do |t|
    t.string  "entity_type",         limit: 128, default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",              limit: 128, default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",             limit: 1,   default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                    null: false, comment: "The entity id this data is attached to",                                                   unsigned: true
    t.integer "revision_id",                                  null: false, comment: "The entity revision id this data is attached to",                                          unsigned: true
    t.string  "language",            limit: 32,  default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                        null: false, comment: "The sequence number for this data item, used for multi-value fields",                      unsigned: true
    t.integer "taxonomy_forums_tid",                                                                                                                                            unsigned: true
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
    t.index ["taxonomy_forums_tid"], name: "taxonomy_forums_tid", using: :btree
  end

  create_table "field_revision_taxonomy_vocabulary_1", primary_key: ["entity_type", "entity_id", "revision_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Revision archive storage for field 1 (taxonomy_vocabulary_1)" do |t|
    t.string  "entity_type",               limit: 128, default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",                    limit: 128, default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",                   limit: 1,   default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                          null: false, comment: "The entity id this data is attached to",                                                   unsigned: true
    t.integer "revision_id",                                        null: false, comment: "The entity revision id this data is attached to",                                          unsigned: true
    t.string  "language",                  limit: 32,  default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                              null: false, comment: "The sequence number for this data item, used for multi-value fields",                      unsigned: true
    t.integer "taxonomy_vocabulary_1_tid",                                                                                                                                            unsigned: true
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
    t.index ["taxonomy_vocabulary_1_tid"], name: "taxonomy_vocabulary_1_tid", using: :btree
  end

  create_table "field_revision_taxonomy_vocabulary_2", primary_key: ["entity_type", "entity_id", "revision_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Revision archive storage for field 2 (taxonomy_vocabulary_2)" do |t|
    t.string  "entity_type",               limit: 128, default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",                    limit: 128, default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",                   limit: 1,   default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                          null: false, comment: "The entity id this data is attached to",                                                   unsigned: true
    t.integer "revision_id",                                        null: false, comment: "The entity revision id this data is attached to",                                          unsigned: true
    t.string  "language",                  limit: 32,  default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                              null: false, comment: "The sequence number for this data item, used for multi-value fields",                      unsigned: true
    t.integer "taxonomy_vocabulary_2_tid",                                                                                                                                            unsigned: true
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
    t.index ["taxonomy_vocabulary_2_tid"], name: "taxonomy_vocabulary_2_tid", using: :btree
  end

  create_table "field_revision_upload", primary_key: ["entity_type", "entity_id", "revision_id", "deleted", "delta", "language"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Revision archive storage for field 6 (upload)" do |t|
    t.string  "entity_type",        limit: 128,   default: "", null: false, comment: "The entity type this data is attached to"
    t.string  "bundle",             limit: 128,   default: "", null: false, comment: "The field instance bundle to which this row belongs, used when deleting a field instance"
    t.integer "deleted",            limit: 1,     default: 0,  null: false, comment: "A boolean indicating whether this data item has been deleted"
    t.integer "entity_id",                                     null: false, comment: "The entity id this data is attached to",                                                   unsigned: true
    t.integer "revision_id",                                   null: false, comment: "The entity revision id this data is attached to",                                          unsigned: true
    t.string  "language",           limit: 32,    default: "", null: false, comment: "The language for this data item."
    t.integer "delta",                                         null: false, comment: "The sequence number for this data item, used for multi-value fields",                      unsigned: true
    t.integer "upload_fid",                                                 comment: "The file_managed.fid being referenced in this field.",                                     unsigned: true
    t.integer "upload_display",     limit: 1,     default: 1,  null: false, comment: "Flag to control whether this file should be displayed when viewing content.",              unsigned: true
    t.text    "upload_description", limit: 65535,                           comment: "A description of the file."
    t.index ["bundle"], name: "bundle", using: :btree
    t.index ["deleted"], name: "deleted", using: :btree
    t.index ["entity_id"], name: "entity_id", using: :btree
    t.index ["entity_type"], name: "entity_type", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["revision_id"], name: "revision_id", using: :btree
    t.index ["upload_fid"], name: "upload_fid", using: :btree
  end

  create_table "file_managed", primary_key: "fid", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Stores information for uploaded files." do |t|
    t.integer "uid",                  default: 0,  null: false,                        comment: "The user.uid of the user who is associated with the file.",                                                                                                                                              unsigned: true
    t.string  "filename",             default: "", null: false,                        comment: "Name of the file with no path components. This may differ from the basename of the URI if the file is renamed to avoid overwriting an existing file."
    t.string  "uri",                  default: "", null: false, collation: "utf8_bin", comment: "The URI to access the file (either local or remote)."
    t.string  "filemime",             default: "", null: false,                        comment: "The file’s MIME type."
    t.bigint  "filesize",             default: 0,  null: false,                        comment: "The size of the file in bytes.",                                                                                                                                                                         unsigned: true
    t.integer "status",    limit: 1,  default: 0,  null: false,                        comment: "A field indicating the status of the file. Two status are defined in core: temporary (0) and permanent (1). Temporary files older than DRUPAL_MAXIMUM_TEMP_FILE_AGE will be removed during a cron run."
    t.integer "timestamp",            default: 0,  null: false,                        comment: "UNIX timestamp for when the file was added.",                                                                                                                                                            unsigned: true
    t.string  "uuid",      limit: 36, default: "", null: false,                        comment: "The Universally Unique Identifier."
    t.index ["status"], name: "status", using: :btree
    t.index ["timestamp"], name: "timestamp", using: :btree
    t.index ["uid"], name: "uid", using: :btree
    t.index ["uri"], name: "uri", unique: true, using: :btree
    t.index ["uuid"], name: "uuid", using: :btree
  end

  create_table "file_usage", primary_key: ["fid", "type", "id", "module"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Track where a file is used." do |t|
    t.integer "fid",                            null: false, comment: "File ID.",                                               unsigned: true
    t.string  "module",            default: "", null: false, comment: "The name of the module that is using the file."
    t.string  "type",   limit: 64, default: "", null: false, comment: "The name of the object type in which the file is used."
    t.integer "id",                default: 0,  null: false, comment: "The primary key of the object using the file.",          unsigned: true
    t.integer "count",             default: 0,  null: false, comment: "The number of times this file is used by this object.",  unsigned: true
    t.index ["fid", "count"], name: "fid_count", using: :btree
    t.index ["fid", "module"], name: "fid_module", using: :btree
    t.index ["type", "id"], name: "type_id", using: :btree
  end

  create_table "files", primary_key: "fid", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "uid",       default: 0,  null: false, unsigned: true
    t.string  "filename",  default: "", null: false
    t.string  "filepath",  default: "", null: false
    t.string  "filemime",  default: "", null: false
    t.integer "filesize",  default: 0,  null: false, unsigned: true
    t.integer "status",    default: 0,  null: false
    t.integer "timestamp", default: 0,  null: false, unsigned: true
    t.index ["status"], name: "status", using: :btree
    t.index ["timestamp"], name: "timestamp", using: :btree
    t.index ["uid"], name: "uid", using: :btree
  end

  create_table "filter", primary_key: ["format", "name"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Table that maps filters (HTML corrector) to text formats ..." do |t|
    t.string  "format",                                   null: false, comment: "Foreign key: The filter_format.format to which this filter is assigned."
    t.string  "module",   limit: 64,         default: "", null: false, comment: "The origin module of the filter."
    t.string  "name",     limit: 32,         default: "", null: false, comment: "Name of the filter being referenced."
    t.integer "weight",                      default: 0,  null: false, comment: "Weight of filter within format."
    t.integer "status",                      default: 0,  null: false, comment: "Filter enabled status. (1 = enabled, 0 = disabled)"
    t.binary  "settings", limit: 4294967295,                           comment: "A serialized array of name value pairs that store the filter settings for the specific format."
    t.index ["weight", "module", "name"], name: "list", using: :btree
  end

  create_table "filter_format", primary_key: "format", id: :string, comment: "Primary Key: Unique machine name of the format.", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",             default: "", null: false
    t.integer "cache",  limit: 1, default: 0,  null: false
    t.integer "status", limit: 1, default: 1,  null: false, comment: "The status of the text format. (1 = enabled, 0 = disabled)", unsigned: true
    t.integer "weight",           default: 0,  null: false, comment: "Weight of text format to use when listing."
    t.index ["name"], name: "name", unique: true, using: :btree
    t.index ["status", "weight"], name: "status_weight", using: :btree
  end

  create_table "flood", primary_key: "fid", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "event",      limit: 64,  default: "", null: false
    t.string  "identifier", limit: 128, default: "", null: false
    t.integer "timestamp",              default: 0,  null: false
    t.integer "expiration",             default: 0,  null: false, comment: "Expiration timestamp. Expired events are purged on cron run."
    t.index ["event", "identifier", "timestamp"], name: "allow", using: :btree
    t.index ["expiration"], name: "purge", using: :btree
  end

  create_table "forum", primary_key: "vid", id: :integer, default: 0, comment: "Primary Key: The node.vid of the node.", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Stores the relationship of nodes to forum terms." do |t|
    t.integer "nid", default: 0, null: false, comment: "The node.nid of the node.",                                          unsigned: true
    t.integer "tid", default: 0, null: false, comment: "The taxonomy_term_data.tid of the forum term assigned to the node.", unsigned: true
    t.index ["nid", "tid"], name: "forum_topic", using: :btree
    t.index ["tid"], name: "tid", using: :btree
  end

  create_table "forum_index", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Maintains denormalized information about node/term..." do |t|
    t.integer "nid",                              default: 0,  null: false, comment: "The node.nid this record tracks.",                                                                 unsigned: true
    t.string  "title",                            default: "", null: false, comment: "The title of this node, always treated as non-markup plain text."
    t.integer "tid",                              default: 0,  null: false, comment: "The term ID.",                                                                                     unsigned: true
    t.integer "sticky",                 limit: 1, default: 0,               comment: "Boolean indicating whether the node is sticky."
    t.integer "created",                          default: 0,  null: false, comment: "The Unix timestamp when the node was created.",                                                    unsigned: true
    t.integer "last_comment_timestamp",           default: 0,  null: false, comment: "The Unix timestamp of the last comment that was posted within this node, from comment.timestamp."
    t.integer "comment_count",                    default: 0,  null: false, comment: "The total number of comments on this node.",                                                       unsigned: true
    t.index ["created"], name: "created", using: :btree
    t.index ["last_comment_timestamp"], name: "last_comment_timestamp", using: :btree
    t.index ["nid", "tid", "sticky", "last_comment_timestamp"], name: "forum_topics", using: :btree
  end

  create_table "history", primary_key: ["uid", "nid"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "uid",       default: 0, null: false
    t.integer "nid",       default: 0, null: false
    t.integer "timestamp", default: 0, null: false
    t.index ["nid"], name: "nid", using: :btree
  end

  create_table "linkchecker_block_custom", primary_key: ["bid", "lid"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Stores all link references for custom blocks." do |t|
    t.integer "bid", null: false, comment: "Primary Key: Unique block_custom.bid."
    t.integer "lid", null: false, comment: "Primary Key: Unique linkchecker_link.lid."
    t.index ["lid"], name: "lid", using: :btree
  end

  create_table "linkchecker_comment", primary_key: ["cid", "lid"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Stores all link references for comments." do |t|
    t.integer "cid", null: false, comment: "Primary Key: Unique comment.cid."
    t.integer "lid", null: false, comment: "Primary Key: Unique linkchecker_link.lid."
    t.index ["lid"], name: "lid", using: :btree
  end

  create_table "linkchecker_link", primary_key: "lid", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Stores all links." do |t|
    t.string  "urlhash",      limit: 64,                     null: false, comment: "The indexable hash of the linkchecker_link.url."
    t.text    "url",          limit: 65535,                  null: false, comment: "The full qualified link."
    t.string  "method",       limit: 4,     default: "HEAD", null: false, comment: "The method for checking links (HEAD, GET, POST)."
    t.integer "code",                       default: -1,     null: false, comment: "HTTP status code from link checking."
    t.text    "error",        limit: 65535,                               comment: "The error message received from the remote server while doing link checking."
    t.integer "fail_count",                 default: 0,      null: false, comment: "Fail count of unsuccessful link checks. No flapping detection. (Successful = 0, Unsuccessful = fail_count+1)."
    t.integer "last_checked",               default: 0,      null: false, comment: "Timestamp of the last link check."
    t.integer "status",                     default: 1,      null: false, comment: "Boolean indicating if a link should be checked or not."
    t.index ["code"], name: "code", using: :btree
    t.index ["fail_count"], name: "fail_count", using: :btree
    t.index ["last_checked"], name: "last_checked", using: :btree
    t.index ["method"], name: "method", using: :btree
    t.index ["status"], name: "status", using: :btree
    t.index ["urlhash"], name: "urlhash", unique: true, using: :btree
  end

  create_table "linkchecker_node", primary_key: ["nid", "lid"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Stores all link references for nodes." do |t|
    t.integer "nid", null: false, comment: "Primary Key: Unique node.nid."
    t.integer "lid", null: false, comment: "Primary Key: Unique linkchecker_link.lid."
    t.index ["lid"], name: "lid", using: :btree
  end

  create_table "menu_custom", primary_key: "menu_name", id: :string, limit: 32, default: "", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title",                     default: "", null: false
    t.text   "description", limit: 65535
  end

  create_table "menu_links", primary_key: "mlid", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "menu_name",    limit: 32,    default: "",       null: false
    t.integer "plid",                       default: 0,        null: false,                                                                                                                                 unsigned: true
    t.string  "link_path",                  default: "",       null: false
    t.string  "router_path",                default: "",       null: false
    t.string  "link_title",                 default: "",       null: false
    t.binary  "options",      limit: 65535,                                 comment: "A serialized array of options to be passed to the url() or l() function, such as a query string or HTML attributes."
    t.string  "module",                     default: "system", null: false
    t.integer "hidden",       limit: 2,     default: 0,        null: false
    t.integer "external",     limit: 2,     default: 0,        null: false
    t.integer "has_children", limit: 2,     default: 0,        null: false
    t.integer "expanded",     limit: 2,     default: 0,        null: false
    t.integer "weight",                     default: 0,        null: false
    t.integer "depth",        limit: 2,     default: 0,        null: false
    t.integer "customized",   limit: 2,     default: 0,        null: false
    t.integer "p1",                         default: 0,        null: false,                                                                                                                                 unsigned: true
    t.integer "p2",                         default: 0,        null: false,                                                                                                                                 unsigned: true
    t.integer "p3",                         default: 0,        null: false,                                                                                                                                 unsigned: true
    t.integer "p4",                         default: 0,        null: false,                                                                                                                                 unsigned: true
    t.integer "p5",                         default: 0,        null: false,                                                                                                                                 unsigned: true
    t.integer "p6",                         default: 0,        null: false,                                                                                                                                 unsigned: true
    t.integer "p7",                         default: 0,        null: false,                                                                                                                                 unsigned: true
    t.integer "p8",                         default: 0,        null: false,                                                                                                                                 unsigned: true
    t.integer "p9",                         default: 0,        null: false,                                                                                                                                 unsigned: true
    t.integer "updated",      limit: 2,     default: 0,        null: false
    t.index ["link_path", "menu_name"], name: "path_menu", length: {"link_path"=>128, "menu_name"=>nil}, using: :btree
    t.index ["menu_name", "p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9"], name: "menu_parents", using: :btree
    t.index ["menu_name", "plid", "expanded", "has_children"], name: "menu_plid_expand_child", using: :btree
    t.index ["router_path"], name: "router_path", length: {"router_path"=>128}, using: :btree
  end

  create_table "menu_router", primary_key: "path", id: :string, default: "", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.binary  "load_functions",    limit: 65535,                 null: false, comment: "A serialized array of function names (like node_load) to be called to load an object corresponding to a part of the current path."
    t.binary  "to_arg_functions",  limit: 65535,                 null: false, comment: "A serialized array of function names (like user_uid_optional_to_arg) to be called to replace a part of the router path with another string."
    t.string  "access_callback",                    default: "", null: false
    t.binary  "access_arguments",  limit: 65535,                              comment: "A serialized array of arguments for the access callback."
    t.string  "page_callback",                      default: "", null: false
    t.binary  "page_arguments",    limit: 65535,                              comment: "A serialized array of arguments for the page callback."
    t.integer "fit",                                default: 0,  null: false
    t.integer "number_parts",      limit: 2,        default: 0,  null: false
    t.string  "tab_parent",                         default: "", null: false
    t.string  "tab_root",                           default: "", null: false
    t.string  "title",                              default: "", null: false
    t.string  "title_callback",                     default: "", null: false
    t.string  "title_arguments",                    default: "", null: false
    t.integer "type",                               default: 0,  null: false
    t.text    "description",       limit: 65535,                 null: false
    t.string  "position",                           default: "", null: false
    t.integer "weight",                             default: 0,  null: false
    t.text    "include_file",      limit: 16777215
    t.string  "delivery_callback",                  default: "", null: false
    t.integer "context",                            default: 0,  null: false, comment: "Only for local tasks (tabs) - the context of a local task to control its placement."
    t.string  "theme_callback",                     default: "", null: false
    t.string  "theme_arguments",                    default: "", null: false
    t.index ["fit"], name: "fit", using: :btree
    t.index ["tab_parent", "weight", "title"], name: "tab_parent", length: {"tab_parent"=>64, "weight"=>nil, "title"=>nil}, using: :btree
    t.index ["tab_root", "weight", "title"], name: "tab_root_weight_title", length: {"tab_root"=>64, "weight"=>nil, "title"=>nil}, using: :btree
  end

  create_table "node", primary_key: "nid", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "vid",                                            comment: "The current node_revision.vid version identifier.", unsigned: true
    t.string  "type",      limit: 32, default: "", null: false
    t.string  "language",  limit: 12, default: "", null: false
    t.string  "title",                default: "", null: false
    t.integer "uid",                  default: 0,  null: false
    t.integer "status",               default: 1,  null: false
    t.integer "created",              default: 0,  null: false
    t.integer "changed",              default: 0,  null: false
    t.integer "comment",              default: 0,  null: false
    t.integer "promote",              default: 0,  null: false
    t.integer "sticky",               default: 0,  null: false
    t.integer "tnid",                 default: 0,  null: false,                                                               unsigned: true
    t.integer "translate",            default: 0,  null: false
    t.string  "uuid",      limit: 36, default: "", null: false, comment: "The Universally Unique Identifier."
    t.index ["changed"], name: "node_changed", using: :btree
    t.index ["created"], name: "node_created", using: :btree
    t.index ["language"], name: "language", using: :btree
    t.index ["promote", "status", "sticky", "created"], name: "node_frontpage", using: :btree
    t.index ["status", "type", "nid"], name: "node_status_type", using: :btree
    t.index ["title", "type"], name: "node_title_type", length: {"title"=>nil, "type"=>4}, using: :btree
    t.index ["tnid"], name: "tnid", using: :btree
    t.index ["translate"], name: "translate", using: :btree
    t.index ["type"], name: "node_type", length: {"type"=>4}, using: :btree
    t.index ["uid"], name: "uid", using: :btree
    t.index ["uuid"], name: "uuid", using: :btree
    t.index ["vid"], name: "vid", unique: true, using: :btree
  end

  create_table "node_access", primary_key: ["nid", "gid", "realm"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "nid",                    default: 0,  null: false, unsigned: true
    t.integer "gid",                    default: 0,  null: false, unsigned: true
    t.string  "realm",                  default: "", null: false
    t.integer "grant_view",   limit: 1, default: 0,  null: false, unsigned: true
    t.integer "grant_update", limit: 1, default: 0,  null: false, unsigned: true
    t.integer "grant_delete", limit: 1, default: 0,  null: false, unsigned: true
  end

  create_table "node_comment_statistics", primary_key: "nid", id: :integer, default: 0, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "last_comment_timestamp",            default: 0, null: false, comment: "The Unix timestamp of the last comment that was posted within this node, from comment.changed."
    t.string  "last_comment_name",      limit: 60
    t.integer "last_comment_uid",                  default: 0, null: false
    t.integer "comment_count",                     default: 0, null: false,                                                                                                            unsigned: true
    t.integer "cid",                               default: 0, null: false, comment: "The comment.cid of the last comment."
    t.index ["cid"], name: "cid", using: :btree
    t.index ["comment_count"], name: "comment_count", using: :btree
    t.index ["last_comment_timestamp"], name: "node_comment_timestamp", using: :btree
    t.index ["last_comment_uid"], name: "last_comment_uid", using: :btree
  end

  create_table "node_revision", primary_key: "vid", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "nid",                          default: 0,  null: false,                                                unsigned: true
    t.integer "uid",                          default: 0,  null: false
    t.string  "title",                        default: "", null: false
    t.text    "log",       limit: 4294967295,              null: false
    t.integer "timestamp",                    default: 0,  null: false
    t.integer "status",                       default: 1,  null: false
    t.integer "comment",                      default: 0,  null: false
    t.integer "promote",                      default: 0,  null: false
    t.integer "sticky",                       default: 0,  null: false
    t.string  "vuuid",     limit: 36,         default: "", null: false, comment: "The Universally Unique Identifier."
    t.string  "ds_switch",                    default: "", null: false
    t.index ["nid"], name: "nid", using: :btree
    t.index ["uid"], name: "uid", using: :btree
    t.index ["vuuid"], name: "vuuid", using: :btree
  end

  create_table "node_type", primary_key: "type", id: :string, limit: 32, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",                         default: "", null: false
    t.string  "base",                                      null: false
    t.text    "description", limit: 16777215,              null: false
    t.text    "help",        limit: 16777215,              null: false
    t.integer "has_title",   limit: 1,                     null: false,                                                                     unsigned: true
    t.string  "title_label",                  default: "", null: false
    t.integer "custom",      limit: 1,        default: 0,  null: false
    t.integer "modified",    limit: 1,        default: 0,  null: false
    t.integer "locked",      limit: 1,        default: 0,  null: false
    t.string  "orig_type",                    default: "", null: false
    t.string  "module",                                    null: false
    t.integer "disabled",    limit: 1,        default: 0,  null: false, comment: "A boolean indicating whether the node type is disabled."
  end

  create_table "plugins_attacks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "path"
    t.string   "browser_key"
    t.integer  "site_id"
    t.datetime "created_at"
    t.index ["browser_key"], name: "index_plugins_attacks_on_browser_key", using: :btree
    t.index ["path"], name: "index_plugins_attacks_on_path", using: :btree
    t.index ["site_id"], name: "index_plugins_attacks_on_site_id", using: :btree
  end

  create_table "plugins_contact_forms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "site_id"
    t.integer  "count"
    t.integer  "parent_id"
    t.string   "name"
    t.string   "slug"
    t.text     "description", limit: 65535
    t.text     "value",       limit: 65535
    t.text     "settings",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "popup_onload", primary_key: "popup_id", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "The base table for popup entities." do |t|
    t.string  "bundle_type",                               null: false, comment: "The type of the popup."
    t.string  "language",       limit: 32,    default: "", null: false, comment: "The language of the popup."
    t.string  "name",                         default: "", null: false, comment: "The name of the popup - a human-readable identifier."
    t.text    "body",           limit: 65535,                           comment: "The body of the popup."
    t.string  "format",                                                 comment: "Format of the popup’s body."
    t.integer "width",                        default: 0,  null: false, comment: "The width of the popup."
    t.integer "height",                       default: 0,  null: false, comment: "The height of the popup."
    t.integer "fixed_position", limit: 1,     default: 0,  null: false, comment: "Indicate whether the popup position is fixed in the browser."
    t.index ["bundle_type"], name: "bundle_type", using: :btree
  end

  create_table "queue", primary_key: "item_id", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Stores items in queues." do |t|
    t.string  "name",                       default: "", null: false, comment: "The queue name."
    t.binary  "data",    limit: 4294967295,                           comment: "The arbitrary data for the item."
    t.integer "expire",                     default: 0,  null: false, comment: "Timestamp when the claim lease expires on the item."
    t.integer "created",                    default: 0,  null: false, comment: "Timestamp when the item was created."
    t.index ["expire"], name: "expire", using: :btree
    t.index ["name", "created"], name: "name_created", using: :btree
  end

  create_table "registry", primary_key: ["name", "type"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",               default: "", null: false
    t.string  "type",     limit: 9, default: "", null: false
    t.string  "filename",                        null: false
    t.string  "module",             default: "", null: false
    t.integer "weight",             default: 0,  null: false
    t.index ["type", "weight", "module"], name: "hook", using: :btree
  end

  create_table "registry_file", primary_key: "filename", id: :string, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "hash", limit: 64, null: false
  end

  create_table "role", primary_key: "rid", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",   limit: 64, default: "", null: false
    t.integer "weight",            default: 0,  null: false
    t.index ["name", "weight"], name: "name_weight", using: :btree
    t.index ["name"], name: "name", unique: true, using: :btree
  end

  create_table "role_permission", primary_key: ["rid", "permission"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "rid",                                 null: false,                                                  unsigned: true
    t.string  "permission", limit: 128, default: "", null: false
    t.string  "module",                 default: "", null: false, comment: "The module declaring the permission."
    t.index ["permission"], name: "permission", using: :btree
  end

  create_table "search_api_index", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Stores all search indexes on a search_api_server." do |t|
    t.string  "name",         limit: 50,                   null: false, comment: "A name to be displayed for the index."
    t.string  "machine_name", limit: 50,                   null: false, comment: "The machine name of the index."
    t.text    "description",  limit: 65535,                             comment: "A string describing the index’ use to users."
    t.string  "server",       limit: 50,                                comment: "The search_api_server.machine_name with which data should be indexed."
    t.string  "item_type",    limit: 50,                   null: false, comment: "The type of items stored in this index."
    t.text    "options",      limit: 16777215,             null: false, comment: "An array of additional arguments configuring this index."
    t.integer "enabled",      limit: 1,        default: 1, null: false, comment: "A flag indicating whether this index is enabled."
    t.integer "read_only",    limit: 1,        default: 0, null: false, comment: "A flag indicating whether to write to this index."
    t.integer "status",       limit: 1,        default: 1, null: false, comment: "The exportable status of the entity."
    t.string  "module",                                                 comment: "The name of the providing module if the entity has been defined in code."
    t.index ["enabled"], name: "enabled", using: :btree
    t.index ["item_type"], name: "item_type", using: :btree
    t.index ["machine_name"], name: "machine_name", unique: true, using: :btree
    t.index ["server"], name: "server", using: :btree
  end

  create_table "search_api_item", primary_key: ["item_id", "index_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Stores the items which should be indexed for each index,..." do |t|
    t.integer "item_id",              null: false, comment: "The item’s entity id (e.g. node.nid for nodes).",                                                     unsigned: true
    t.integer "index_id",             null: false, comment: "The search_api_index.id this item belongs to.",                                                       unsigned: true
    t.bigint  "changed",  default: 1, null: false, comment: "Either a flag or a timestamp to indicate if or when the item was changed since it was last indexed."
    t.index ["index_id", "changed"], name: "indexing", using: :btree
  end

  create_table "search_api_item_string_id", primary_key: ["item_id", "index_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Stores the items which should be indexed for each index,..." do |t|
    t.string  "item_id",  limit: 64,             null: false, comment: "The item’s ID."
    t.integer "index_id",                        null: false, comment: "The search_api_index.id this item belongs to.",                                                       unsigned: true
    t.bigint  "changed",             default: 1, null: false, comment: "Either a flag or a timestamp to indicate if or when the item was changed since it was last indexed."
    t.index ["index_id", "changed"], name: "indexing", using: :btree
  end

  create_table "search_api_server", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Stores all search servers created through the Search API." do |t|
    t.string  "name",         limit: 50,                   null: false, comment: "The displayed name for a server."
    t.string  "machine_name", limit: 50,                   null: false, comment: "The machine name for a server."
    t.text    "description",  limit: 65535,                             comment: "The displayed description for a server."
    t.string  "class",        limit: 50,                   null: false, comment: "The id of the service class to use for this server."
    t.text    "options",      limit: 16777215,             null: false, comment: "The options used to configure the service object."
    t.integer "enabled",      limit: 1,        default: 1, null: false, comment: "A flag indicating whether the server is enabled."
    t.integer "status",       limit: 1,        default: 1, null: false, comment: "The exportable status of the entity."
    t.string  "module",                                                 comment: "The name of the providing module if the entity has been defined in code."
    t.index ["enabled"], name: "enabled", using: :btree
    t.index ["machine_name"], name: "machine_name", unique: true, using: :btree
  end

  create_table "search_api_task", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Stores pending tasks for servers." do |t|
    t.string "server_id", limit: 50,       null: false, comment: "The search_api_server.machine_name for which this task should be executed."
    t.string "type",      limit: 50,       null: false, comment: "A keyword identifying the type of task that should be executed."
    t.string "index_id",  limit: 50,                    comment: "The search_api_index.machine_name to which this task pertains, if applicable for this type."
    t.text   "data",      limit: 16777215,              comment: "Some data needed for the task, might be optional depending on the type."
    t.index ["server_id"], name: "server", using: :btree
  end

  create_table "search_config_exclude", primary_key: ["entity_id", "entity_type"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Provides a way to exclude specific entities from the..." do |t|
    t.integer "entity_id",               default: 0,  null: false, comment: "The node.nid to exclude.",                                 unsigned: true
    t.string  "entity_type", limit: 128, default: "", null: false, comment: "The entity type to exclude."
    t.integer "exclude",     limit: 1,   default: 1,  null: false, comment: "Exclusion flag. Default 1: exclude from public searches.", unsigned: true
  end

  create_table "search_dataset", primary_key: ["sid", "type"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "sid",                        default: 0, null: false,                                      unsigned: true
    t.string  "type",    limit: 16,                     null: false, comment: "Type of item, e.g. node."
    t.text    "data",    limit: 4294967295,             null: false
    t.integer "reindex",                    default: 0, null: false,                                      unsigned: true
  end

  create_table "search_index", primary_key: ["word", "sid", "type"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "word",  limit: 50, default: "", null: false
    t.integer "sid",              default: 0,  null: false,                                                                                       unsigned: true
    t.string  "type",  limit: 16,              null: false, comment: "The search_dataset.type of the searchable item to which the word belongs."
    t.float   "score", limit: 24
    t.index ["sid", "type"], name: "sid_type", using: :btree
  end

  create_table "search_node_links", primary_key: ["sid", "type", "nid"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "sid",                        default: 0,  null: false, unsigned: true
    t.string  "type",    limit: 16,         default: "", null: false
    t.integer "nid",                        default: 0,  null: false, unsigned: true
    t.text    "caption", limit: 4294967295
    t.index ["nid"], name: "nid", using: :btree
  end

  create_table "search_total", primary_key: "word", id: :string, limit: 50, default: "", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float "count", limit: 24
  end

  create_table "semaphore", primary_key: "name", id: :string, default: "", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "value",             default: "", null: false
    t.float  "expire", limit: 53,              null: false
    t.index ["expire"], name: "expire", using: :btree
    t.index ["value"], name: "value", using: :btree
  end

  create_table "sequences", primary_key: "value", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Stores IDs." do |t|
  end

  create_table "sessions", primary_key: ["sid", "ssid"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "uid",                                       null: false,                                                                                                                                                                                                                              unsigned: true
    t.string  "sid",       limit: 128,                     null: false, comment: "A session ID. The value is generated by Drupal’s session handlers."
    t.string  "hostname",  limit: 128,        default: "", null: false
    t.integer "timestamp",                    default: 0,  null: false
    t.integer "cache",                        default: 0,  null: false
    t.binary  "session",   limit: 4294967295,                           comment: "The serialized contents of $_SESSION, an array of name/value pairs that persists across page requests by this session ID. Drupal loads $_SESSION from here at the start of each request and saves it at the end."
    t.string  "ssid",      limit: 128,        default: "", null: false, comment: "Secure session ID. The value is generated by Drupal’s session handlers."
    t.index ["ssid"], name: "ssid", using: :btree
    t.index ["timestamp"], name: "timestamp", using: :btree
    t.index ["uid"], name: "uid", using: :btree
  end

  create_table "spina_accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.string   "address"
    t.string   "postal_code"
    t.string   "city"
    t.string   "phone"
    t.string   "email"
    t.text     "preferences",    limit: 65535
    t.string   "logo"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "kvk_identifier"
    t.string   "vat_identifier"
    t.boolean  "robots_allowed",               default: false
  end

  create_table "spina_attachment_collections", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_attachment_collections_attachments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "attachment_collection_id"
    t.integer "attachment_id"
  end

  create_table "spina_attachments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_colors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.text     "content",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spina_inquiries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.text     "message",    limit: 65535
    t.boolean  "archived",                 default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "spam"
  end

  create_table "spina_layout_parts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "title"
    t.string   "name"
    t.integer  "layout_partable_id"
    t.string   "layout_partable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
  end

  create_table "spina_lines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spina_page_parts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "title"
    t.string   "name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "page_id"
    t.integer  "page_partable_id"
    t.string   "page_partable_type"
  end

  create_table "spina_pages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "title"
    t.string   "menu_title"
    t.string   "description"
    t.boolean  "show_in_menu",        default: true
    t.string   "slug"
    t.boolean  "deletable",           default: true
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "seo_title"
    t.boolean  "skip_to_first_child", default: false
    t.string   "view_template"
    t.string   "layout_template"
    t.boolean  "draft",               default: false
    t.string   "link_url"
    t.string   "ancestry"
    t.integer  "position"
    t.string   "materialized_path"
    t.boolean  "active",              default: true
  end

  create_table "spina_photo_collections", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_photo_collections_photos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "photo_collection_id"
    t.integer "photo_id"
    t.integer "position"
  end

  create_table "spina_photos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spina_rewrite_rules", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "old_path"
    t.string   "new_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spina_structure_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "structure_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["structure_id"], name: "index_spina_structure_items_on_structure_id", using: :btree
  end

  create_table "spina_structure_parts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "structure_item_id"
    t.integer  "structure_partable_id"
    t.string   "structure_partable_type"
    t.string   "name"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["structure_item_id"], name: "index_spina_structure_parts_on_structure_item_id", using: :btree
    t.index ["structure_partable_id"], name: "index_spina_structure_parts_on_structure_partable_id", using: :btree
  end

  create_table "spina_structures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spina_texts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.text     "content",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spina_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.datetime "last_logged_in"
  end

  create_table "system", primary_key: "filename", id: :string, default: "", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",                         default: "", null: false
    t.string  "type",           limit: 12,    default: "", null: false
    t.string  "owner",                        default: "", null: false
    t.integer "status",                       default: 0,  null: false
    t.integer "bootstrap",                    default: 0,  null: false
    t.integer "schema_version", limit: 2,     default: -1, null: false
    t.integer "weight",                       default: 0,  null: false
    t.binary  "info",           limit: 65535,                           comment: "A serialized array containing information from the module’s .info file; keys can include name, description, package, version, core, dependencies, and php."
    t.index ["status", "bootstrap", "type", "weight", "name"], name: "system_list", using: :btree
    t.index ["type", "name"], name: "type_name", using: :btree
  end

  create_table "taxonomy_facets_node", primary_key: "nid", id: :integer, default: 0, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer "changed", default: 0, null: false, unsigned: true
  end

  create_table "taxonomy_facets_term_node", primary_key: ["tid", "nid"], force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer "nid", default: 0, null: false, unsigned: true
    t.integer "tid", default: 0, null: false, unsigned: true
    t.index ["nid"], name: "nid", using: :btree
    t.index ["tid"], name: "tid", using: :btree
  end

  create_table "taxonomy_index", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Maintains denormalized information about node/term..." do |t|
    t.integer "nid",               default: 0, null: false, comment: "The node.nid this record tracks.",               unsigned: true
    t.integer "tid",               default: 0, null: false, comment: "The term ID.",                                   unsigned: true
    t.integer "sticky",  limit: 1, default: 0,              comment: "Boolean indicating whether the node is sticky."
    t.integer "created",           default: 0, null: false, comment: "The Unix timestamp when the node was created."
    t.index ["nid"], name: "nid", using: :btree
    t.index ["tid", "sticky", "created"], name: "term_node", using: :btree
  end

  create_table "taxonomy_term_data", primary_key: "tid", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "vid",                            default: 0,  null: false,                                                                 unsigned: true
    t.string  "name",                           default: "", null: false
    t.text    "description", limit: 4294967295
    t.integer "weight",                         default: 0,  null: false, comment: "The weight of this term in relation to other terms."
    t.string  "format",                                                   comment: "The filter_format.format of the description."
    t.string  "uuid",        limit: 36,         default: "", null: false, comment: "The Universally Unique Identifier."
    t.index ["name"], name: "name", using: :btree
    t.index ["uuid"], name: "uuid", using: :btree
    t.index ["vid", "name"], name: "vid_name", using: :btree
    t.index ["vid", "weight", "name"], name: "taxonomy_tree", using: :btree
  end

  create_table "taxonomy_term_hierarchy", primary_key: ["tid", "parent"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "tid",    default: 0, null: false, unsigned: true
    t.integer "parent", default: 0, null: false, unsigned: true
    t.index ["parent"], name: "parent", using: :btree
  end

  create_table "taxonomy_term_relation", primary_key: "trid", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "tid1", default: 0, null: false, unsigned: true
    t.integer "tid2", default: 0, null: false, unsigned: true
    t.index ["tid1", "tid2"], name: "tid1_tid2", unique: true, using: :btree
    t.index ["tid2"], name: "tid2", using: :btree
  end

  create_table "taxonomy_term_synonym", primary_key: "tsid", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "tid",  default: 0,  null: false, unsigned: true
    t.string  "name", default: "", null: false
    t.index ["name", "tid"], name: "name_tid", using: :btree
    t.index ["tid"], name: "tid", using: :btree
  end

  create_table "taxonomy_vocabulary", primary_key: "vid", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",                            default: "", null: false
    t.text    "description",  limit: 4294967295
    t.integer "hierarchy",    limit: 1,          default: 0,  null: false,                                                                              unsigned: true
    t.string  "module",                          default: "", null: false
    t.integer "weight",                          default: 0,  null: false, comment: "The weight of this vocabulary in relation to other vocabularies."
    t.string  "machine_name",                    default: "", null: false, comment: "The vocabulary machine name."
    t.index ["machine_name"], name: "machine_name", unique: true, using: :btree
    t.index ["weight", "name"], name: "list", using: :btree
  end

  create_table "url_alias", primary_key: "pid", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "source",              default: "", null: false
    t.string "alias",               default: "", null: false
    t.string "language", limit: 12, default: "", null: false, comment: "The language this alias is for; if ’und’, the alias will be used for unknown languages. Each Drupal path can have an alias for each supported language."
    t.index ["alias", "language", "pid"], name: "alias_language_pid", using: :btree
    t.index ["source", "language", "pid"], name: "source_language_pid", using: :btree
  end

  create_table "users", primary_key: "uid", id: :integer, default: 0, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",             limit: 60,         default: "", null: false
    t.string  "pass",             limit: 128,        default: "", null: false
    t.string  "mail",             limit: 254,        default: "",              comment: "User’s e-mail address."
    t.string  "theme",                               default: "", null: false
    t.string  "signature",                           default: "", null: false
    t.string  "signature_format",                                              comment: "The filter_format.format of the signature."
    t.integer "created",                             default: 0,  null: false
    t.integer "access",                              default: 0,  null: false
    t.integer "login",                               default: 0,  null: false
    t.integer "status",           limit: 1,          default: 0,  null: false
    t.string  "timezone",         limit: 32
    t.string  "language",         limit: 12,         default: "", null: false
    t.string  "init",             limit: 254,        default: "",              comment: "E-mail address used for initial account creation."
    t.binary  "data",             limit: 4294967295,                           comment: "A serialized array of name value pairs that are related to the user. Any form values posted during user edit are stored and are loaded into the $user object during user_load(). Use of this field is discouraged and it will likely disappear in a future..."
    t.integer "picture",                             default: 0,  null: false, comment: "Foreign key: file_managed.fid of user’s picture."
    t.string  "uuid",             limit: 36,         default: "", null: false, comment: "The Universally Unique Identifier."
    t.index ["access"], name: "access", using: :btree
    t.index ["created"], name: "created", using: :btree
    t.index ["mail"], name: "mail", using: :btree
    t.index ["name"], name: "name", unique: true, using: :btree
    t.index ["picture"], name: "picture", using: :btree
    t.index ["uuid"], name: "uuid", using: :btree
  end

  create_table "users_roles", primary_key: ["uid", "rid"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "uid", default: 0, null: false, unsigned: true
    t.integer "rid", default: 0, null: false, unsigned: true
    t.index ["rid"], name: "rid", using: :btree
  end

  create_table "variable", primary_key: "name", id: :string, limit: 128, default: "", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.binary "value", limit: 4294967295, null: false, comment: "The value of the variable."
  end

  create_table "views_display", primary_key: ["vid", "id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "vid",                                default: 0,  null: false, unsigned: true
    t.string  "id",              limit: 64,         default: "", null: false
    t.string  "display_title",   limit: 64,         default: "", null: false
    t.string  "display_plugin",  limit: 64,         default: "", null: false
    t.integer "position",                           default: 0
    t.text    "display_options", limit: 4294967295
    t.index ["vid", "position"], name: "vid", using: :btree
  end

  create_table "views_view", primary_key: "vid", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",        limit: 128, default: "", null: false, comment: "The unique name of the view. This is the primary field views are loaded from, and is used so that views may be internal and not necessarily in the database. May only be alphanumeric characters plus underscores."
    t.string  "description",             default: ""
    t.string  "tag",                     default: ""
    t.string  "base_table",  limit: 64,  default: "", null: false
    t.string  "human_name",              default: "",              comment: "A human readable name used to be displayed in the admin interface"
    t.integer "core",                    default: 0,               comment: "Stores the drupal core version of the view."
    t.index ["name"], name: "name", unique: true, using: :btree
  end

  create_table "watchdog", primary_key: "wid", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "uid",                          default: 0,  null: false
    t.string  "type",      limit: 64,         default: "", null: false, comment: "Type of log message, for example \"user\" or \"page not found.\""
    t.text    "message",   limit: 4294967295,              null: false
    t.binary  "variables", limit: 4294967295,              null: false, comment: "Serialized array of variables that match the message string and that is passed into the t() function."
    t.integer "severity",  limit: 1,          default: 0,  null: false,                                                                                                                   unsigned: true
    t.string  "link",                         default: "",              comment: "Link to view the result of the event."
    t.text    "location",  limit: 65535,                   null: false
    t.text    "referer",   limit: 65535
    t.string  "hostname",  limit: 128,        default: "", null: false
    t.integer "timestamp",                    default: 0,  null: false
    t.index ["severity"], name: "severity", using: :btree
    t.index ["type"], name: "type", using: :btree
    t.index ["uid"], name: "uid", using: :btree
  end

  create_table "webform", primary_key: "nid", id: :integer, comment: "The node identifier of a webform.", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Table for storing additional properties for webform nodes." do |t|
    t.integer "next_serial",                                    default: 1,                null: false, comment: "The serial number to give to the next submission to this webform.",                                              unsigned: true
    t.text    "confirmation",                     limit: 65535,                            null: false, comment: "The confirmation message or URL displayed to the user after submitting a form."
    t.string  "confirmation_format",                                                                    comment: "The filter_format.format of the confirmation message."
    t.string  "redirect_url",                     limit: 2048,  default: "<confirmation>",              comment: "The URL a user is redirected to after submitting a form."
    t.integer "status",                           limit: 1,     default: 1,                null: false, comment: "Boolean value of a webform for open (1) or closed (0)."
    t.integer "block",                            limit: 1,     default: 0,                null: false, comment: "Boolean value for whether this form be available as a block."
    t.integer "allow_draft",                      limit: 1,     default: 0,                null: false, comment: "Boolean value for whether submissions to this form be saved as a draft."
    t.integer "auto_save",                        limit: 1,     default: 0,                null: false, comment: "Boolean value for whether submissions to this form should be auto-saved between pages."
    t.integer "submit_notice",                    limit: 1,     default: 1,                null: false, comment: "Boolean value for whether to show or hide the previous submissions notification."
    t.string  "submit_text",                                                                            comment: "The title of the submit button on the form."
    t.integer "submit_limit",                     limit: 1,     default: -1,               null: false, comment: "The number of submissions a single user is allowed to submit within an interval. -1 is unlimited."
    t.integer "submit_interval",                                default: -1,               null: false, comment: "The amount of time in seconds that must pass before a user can submit another submission within the set limit."
    t.integer "total_submit_limit",                             default: -1,               null: false, comment: "The total number of submissions allowed within an interval. -1 is unlimited."
    t.integer "total_submit_interval",                          default: -1,               null: false, comment: "The amount of time in seconds that must pass before another submission can be submitted within the set limit."
    t.integer "progressbar_bar",                  limit: 1,     default: 0,                null: false, comment: "Boolean value indicating if the bar should be shown as part of the progress bar."
    t.integer "progressbar_page_number",          limit: 1,     default: 0,                null: false, comment: "Boolean value indicating if the page number should be shown as part of the progress bar."
    t.integer "progressbar_percent",              limit: 1,     default: 0,                null: false, comment: "Boolean value indicating if the percentage complete should be shown as part of the progress bar."
    t.integer "progressbar_pagebreak_labels",     limit: 1,     default: 0,                null: false, comment: "Boolean value indicating if the pagebreak labels should be included as part of the progress bar."
    t.integer "progressbar_include_confirmation", limit: 1,     default: 0,                null: false, comment: "Boolean value indicating if the confirmation page should count as a page in the progress bar."
    t.string  "progressbar_label_first",                                                                comment: "Label for the first page of the progress bar."
    t.string  "progressbar_label_confirmation",                                                         comment: "Label for the last page of the progress bar."
    t.integer "preview",                          limit: 1,     default: 0,                null: false, comment: "Boolean value indicating if this form includes a page for previewing the submission."
    t.string  "preview_next_button_label",                                                              comment: "The text for the button that will proceed to the preview page."
    t.string  "preview_prev_button_label",                                                              comment: "The text for the button to go backwards from the preview page."
    t.string  "preview_title",                                                                          comment: "The title of the preview page, as used by the progress bar."
    t.text    "preview_message",                  limit: 65535,                            null: false, comment: "Text shown on the preview page of the form."
    t.string  "preview_message_format",                                                                 comment: "The filter_format.format of the preview page message."
    t.text    "preview_excluded_components",      limit: 65535,                            null: false, comment: "Comma-separated list of component IDs that should not be included in this form’s confirmation page."
    t.integer "confidential",                     limit: 1,     default: 0,                null: false, comment: "Boolean value for whether to anonymize submissions."
  end

  create_table "webform_component", primary_key: ["nid", "cid"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Stores information about components for webform nodes." do |t|
    t.integer "nid",                    default: 0, null: false, comment: "The node identifier of a webform.",                                                        unsigned: true
    t.integer "cid",      limit: 2,     default: 0, null: false, comment: "The identifier for this component within this node, starts at 0 for each node.",           unsigned: true
    t.integer "pid",      limit: 2,     default: 0, null: false, comment: "If this component has a parent fieldset, the cid of that component.",                      unsigned: true
    t.string  "form_key", limit: 128,                            comment: "When the form is displayed and processed, this key can be used to reference the results."
    t.text    "name",     limit: 65535,             null: false, comment: "The label for this component."
    t.string  "type",     limit: 16,                             comment: "The field type of this component (textfield, select, hidden, etc.)."
    t.text    "value",    limit: 65535,             null: false, comment: "The default value of the component when displayed to the end-user."
    t.text    "extra",    limit: 65535,             null: false, comment: "Additional information unique to the display or processing of this component."
    t.integer "required", limit: 1,     default: 0, null: false, comment: "Boolean flag for if this component is required."
    t.integer "weight",   limit: 2,     default: 0, null: false, comment: "Determines the position of this component in the form."
  end

  create_table "webform_conditional", primary_key: ["nid", "rgid"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Holds information about conditional logic." do |t|
    t.integer "nid",                default: 0, null: false, comment: "The node identifier of a webform.",                                                                                  unsigned: true
    t.integer "rgid",   limit: 2,   default: 0, null: false, comment: "The rule group identifier for this group of rules.",                                                                 unsigned: true
    t.string  "andor",  limit: 128,                          comment: "Whether to AND or OR the actions in this group. All actions within the same crid should have the same andor value."
    t.integer "weight", limit: 2,   default: 0, null: false, comment: "Determines the position of this conditional compared to others."
  end

  create_table "webform_conditional_actions", primary_key: ["nid", "rgid", "aid"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Holds information about conditional actions." do |t|
    t.integer "nid",                       default: 0, null: false, comment: "The node identifier of a webform.",                                                                                            unsigned: true
    t.integer "rgid",        limit: 2,     default: 0, null: false, comment: "The rule group identifier for this group of rules.",                                                                           unsigned: true
    t.integer "aid",         limit: 2,     default: 0, null: false, comment: "The rule identifier for this conditional action.",                                                                             unsigned: true
    t.string  "target_type", limit: 128,                            comment: "The type of target to be affected. Currently always \"component\". Indicates what type of ID the \"target\" column contains."
    t.string  "target",      limit: 128,                            comment: "The ID of the target to be affected. Typically a component ID."
    t.integer "invert",      limit: 2,     default: 0, null: false, comment: "If inverted, execute when rule(s) are false.",                                                                                 unsigned: true
    t.string  "action",      limit: 128,                            comment: "The action to be performed on the target."
    t.text    "argument",    limit: 65535,                          comment: "Optional argument for action."
  end

  create_table "webform_conditional_rules", primary_key: ["nid", "rgid", "rid"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Holds information about conditional logic." do |t|
    t.integer "nid",                       default: 0, null: false, comment: "The node identifier of a webform.",                                                                                                               unsigned: true
    t.integer "rgid",        limit: 2,     default: 0, null: false, comment: "The rule group identifier for this group of rules.",                                                                                              unsigned: true
    t.integer "rid",         limit: 2,     default: 0, null: false, comment: "The rule identifier for this conditional rule.",                                                                                                  unsigned: true
    t.string  "source_type", limit: 128,                            comment: "The type of source on which the conditional is based. Currently always \"component\". Indicates what type of ID the \"source\" column contains."
    t.integer "source",      limit: 2,     default: 0, null: false, comment: "The component ID being used in this condition.",                                                                                                  unsigned: true
    t.string  "operator",    limit: 128,                            comment: "Which operator (equal, contains, starts with, etc.) should be used for this comparison between the source and value?"
    t.text    "value",       limit: 65535,                          comment: "The value to be compared with source."
  end

  create_table "webform_emails", primary_key: ["nid", "eid"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Holds information regarding e-mails that should be sent..." do |t|
    t.integer "nid",                               default: 0, null: false, comment: "The node identifier of a webform.",                                                                                                                                                                                               unsigned: true
    t.integer "eid",                 limit: 2,     default: 0, null: false, comment: "The e-mail identifier for this row’s settings.",                                                                                                                                                                                  unsigned: true
    t.text    "email",               limit: 65535,                          comment: "The e-mail address that will be sent to upon submission. This may be an e-mail address, the special key \"default\" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission."
    t.text    "subject",             limit: 65535,                          comment: "The e-mail subject that will be used. This may be a string, the special key \"default\" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission."
    t.text    "from_name",           limit: 65535,                          comment: "The e-mail \"from\" name that will be used. This may be a string, the special key \"default\" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission."
    t.text    "from_address",        limit: 65535,                          comment: "The e-mail \"from\" e-mail address that will be used. This may be a string, the special key \"default\" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission."
    t.text    "template",            limit: 65535,                          comment: "A template that will be used for the sent e-mail. This may be a string or the special key \"default\", which will use the template provided by the theming layer."
    t.text    "excluded_components", limit: 65535,             null: false, comment: "A list of components that will not be included in the [submission:values] token. A list of CIDs separated by commas."
    t.integer "html",                limit: 1,     default: 0, null: false, comment: "Determines if the e-mail will be sent in an HTML format. Requires Mime Mail module.",                                                                                                                                             unsigned: true
    t.integer "attachments",         limit: 1,     default: 0, null: false, comment: "Determines if the e-mail will include file attachments. Requires Mime Mail module.",                                                                                                                                              unsigned: true
    t.text    "extra",               limit: 65535,             null: false, comment: "A serialized array of additional options for the e-mail configuration, including excluded components and value mapping for the TO and FROM addresses for select lists."
    t.integer "exclude_empty",       limit: 1,     default: 0, null: false, comment: "Determines if the e-mail will include component with an empty value.",                                                                                                                                                            unsigned: true
    t.integer "status",              limit: 1,     default: 1, null: false, comment: "Whether this email is enabled.",                                                                                                                                                                                                  unsigned: true
  end

  create_table "webform_last_download", primary_key: ["nid", "uid"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Stores last submission number per user download." do |t|
    t.integer "nid",       default: 0, null: false, comment: "The node identifier of a webform.",      unsigned: true
    t.integer "uid",       default: 0, null: false, comment: "The user identifier.",                   unsigned: true
    t.integer "sid",       default: 0, null: false, comment: "The last downloaded submission number.", unsigned: true
    t.integer "requested", default: 0, null: false, comment: "Timestamp of last download request.",    unsigned: true
  end

  create_table "webform_roles", primary_key: ["nid", "rid"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Holds access information regarding which roles are..." do |t|
    t.integer "nid", default: 0, null: false, comment: "The node identifier of a webform.", unsigned: true
    t.integer "rid", default: 0, null: false, comment: "The role identifier.",              unsigned: true
  end

  create_table "webform_submissions", primary_key: "sid", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Holds general information about submissions outside of..." do |t|
    t.integer "nid",                            default: 0, null: false, comment: "The node identifier of a webform.",                              unsigned: true
    t.integer "serial",                                     null: false, comment: "The serial number of this submission.",                          unsigned: true
    t.integer "uid",                            default: 0, null: false, comment: "The id of the user that completed this submission.",             unsigned: true
    t.integer "is_draft",           limit: 1,   default: 0, null: false, comment: "Is this a draft of the submission?"
    t.integer "submitted",                      default: 0, null: false, comment: "Timestamp of when the form was submitted."
    t.string  "remote_addr",        limit: 128,                          comment: "The IP address of the user that submitted the form."
    t.integer "completed",                      default: 0, null: false, comment: "Timestamp when the form was submitted as complete (not draft)."
    t.integer "modified",                       default: 0, null: false, comment: "Timestamp when the form was last saved (complete or draft)."
    t.integer "highest_valid_page", limit: 2,   default: 0, null: false, comment: "For drafts, the highest validated page number."
    t.index ["nid", "serial"], name: "nid_serial", unique: true, using: :btree
    t.index ["nid", "sid"], name: "nid_sid", using: :btree
    t.index ["nid", "uid", "sid"], name: "nid_uid_sid", using: :btree
    t.index ["sid", "nid"], name: "sid_nid", unique: true, using: :btree
  end

  create_table "webform_submitted_data", primary_key: ["nid", "sid", "cid", "no"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Stores all submitted field data for webform submissions." do |t|
    t.integer "nid",                   default: 0,   null: false, comment: "The node identifier of a webform.",                                                                                                   unsigned: true
    t.integer "sid",                   default: 0,   null: false, comment: "The unique identifier for this submission.",                                                                                          unsigned: true
    t.integer "cid",  limit: 2,        default: 0,   null: false, comment: "The identifier for this component within this node, starts at 0 for each node.",                                                      unsigned: true
    t.string  "no",   limit: 128,      default: "0", null: false, comment: "Usually this value is 0, but if a field has multiple values (such as a time or date), it may require multiple rows in the database."
    t.text    "data", limit: 16777215,               null: false, comment: "The submitted value of this field, may be serialized for some components."
    t.index ["data"], name: "data", length: {"data"=>64}, using: :btree
    t.index ["nid"], name: "nid", using: :btree
    t.index ["sid", "nid"], name: "sid_nid", using: :btree
  end

  create_table "wysiwyg", primary_key: "format", id: :string, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "editor",   limit: 128,   default: "", null: false
    t.text   "settings", limit: 65535
  end

  create_table "wysiwyg_user", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.integer "uid",              default: 0, null: false,                                                          unsigned: true
    t.string  "format",                                    comment: "The filter_format.format of the text format."
    t.integer "status", limit: 1, default: 0, null: false,                                                          unsigned: true
    t.index ["format"], name: "format", using: :btree
    t.index ["uid"], name: "uid", using: :btree
  end

end
