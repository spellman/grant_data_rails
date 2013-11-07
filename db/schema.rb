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

ActiveRecord::Schema.define(version: 20131107220731) do

  create_table "patients", force: true do |t|
    t.string "name",      null: false
    t.string "diagnosis", null: false
  end

  create_table "records", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "diagnosis",           null: false
    t.decimal  "bmi"
    t.datetime "bmi_date"
    t.datetime "eye_exam_date"
    t.datetime "foot_exam_date"
    t.decimal  "a1c"
    t.datetime "a1c_date"
    t.integer  "tc"
    t.integer  "tg"
    t.integer  "hdl"
    t.integer  "ldl"
    t.datetime "cholesterol_date"
    t.integer  "acr"
    t.datetime "acr_date"
    t.integer  "bun"
    t.integer  "creatinine"
    t.datetime "bun_creatinine_date"
    t.integer  "ckd_stage"
    t.datetime "ckd_stage_date"
    t.integer  "ast"
    t.integer  "alt"
    t.datetime "ast_alt_date"
    t.datetime "flu_date"
    t.datetime "pneumonia_date"
  end

  create_table "users", force: true do |t|
    t.string   "email",           default: "",    null: false
    t.string   "password_digest", default: "",    null: false
    t.boolean  "admin",           default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
