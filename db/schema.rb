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

ActiveRecord::Schema.define(version: 20131120201509) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "a1cs", force: true do |t|
    t.integer  "patient_id"
    t.date     "date",       null: false
    t.decimal  "a1c"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "a1cs", ["patient_id"], name: "index_a1cs_on_patient_id", using: :btree

  create_table "acrs", force: true do |t|
    t.integer  "patient_id"
    t.date     "date",       null: false
    t.integer  "acr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "acrs", ["patient_id"], name: "index_acrs_on_patient_id", using: :btree

  create_table "bmis", force: true do |t|
    t.integer  "patient_id"
    t.date     "date",       null: false
    t.decimal  "bmi"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bmis", ["patient_id"], name: "index_bmis_on_patient_id", using: :btree

  create_table "cholesterols", force: true do |t|
    t.integer  "patient_id"
    t.date     "date",       null: false
    t.integer  "tc"
    t.integer  "tg"
    t.integer  "hdl"
    t.integer  "ldl"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cholesterols", ["patient_id"], name: "index_cholesterols_on_patient_id", using: :btree

  create_table "ckd_stages", force: true do |t|
    t.integer  "patient_id"
    t.date     "date",       null: false
    t.integer  "ckd_stage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckd_stages", ["patient_id"], name: "index_ckd_stages_on_patient_id", using: :btree

  create_table "eye_exams", force: true do |t|
    t.integer  "patient_id"
    t.date     "date",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "eye_exams", ["patient_id"], name: "index_eye_exams_on_patient_id", using: :btree

  create_table "flus", force: true do |t|
    t.integer  "patient_id"
    t.date     "date",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flus", ["patient_id"], name: "index_flus_on_patient_id", using: :btree

  create_table "foot_exams", force: true do |t|
    t.integer  "patient_id"
    t.date     "date",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "foot_exams", ["patient_id"], name: "index_foot_exams_on_patient_id", using: :btree

  create_table "livers", force: true do |t|
    t.integer  "patient_id"
    t.date     "date",       null: false
    t.integer  "ast"
    t.integer  "alt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "livers", ["patient_id"], name: "index_livers_on_patient_id", using: :btree

  create_table "patients", force: true do |t|
    t.string "name",      null: false
    t.string "diagnosis", null: false
  end

  create_table "pneumonias", force: true do |t|
    t.integer  "patient_id"
    t.date     "date",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pneumonias", ["patient_id"], name: "index_pneumonias_on_patient_id", using: :btree

  create_table "renals", force: true do |t|
    t.integer  "patient_id"
    t.date     "date",       null: false
    t.integer  "bun"
    t.integer  "creatinine"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "renals", ["patient_id"], name: "index_renals_on_patient_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",           default: "",    null: false
    t.string   "password_digest", default: "",    null: false
    t.boolean  "admin",           default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
