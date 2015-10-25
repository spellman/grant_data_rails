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

ActiveRecord::Schema.define(version: 20140310040020) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "a1cs", force: :cascade do |t|
    t.integer  "patient_id", null: false
    t.date     "date",       null: false
    t.decimal  "a1c"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "a1cs", ["patient_id", "date"], name: "a1cs_unique_patient_id_date", unique: true, using: :btree
  add_index "a1cs", ["patient_id"], name: "index_a1cs_on_patient_id", using: :btree

  create_table "acrs", force: :cascade do |t|
    t.integer  "patient_id",               null: false
    t.date     "date",                     null: false
    t.integer  "acr_in_mcg_alb_per_mg_cr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "acrs", ["patient_id", "date"], name: "acrs_unique_patient_id_date", unique: true, using: :btree
  add_index "acrs", ["patient_id"], name: "index_acrs_on_patient_id", using: :btree

  create_table "blood_pressures", force: :cascade do |t|
    t.integer "patient_id"
    t.date    "date",              null: false
    t.integer "systolic_in_mmhg",  null: false
    t.integer "diastolic_in_mmhg", null: false
  end

  add_index "blood_pressures", ["patient_id", "date"], name: "blood_pressures_unique_patient_id_date", unique: true, using: :btree
  add_index "blood_pressures", ["patient_id"], name: "index_blood_pressures_on_patient_id", using: :btree

  create_table "bmis", force: :cascade do |t|
    t.integer  "patient_id", null: false
    t.date     "date",       null: false
    t.decimal  "bmi"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bmis", ["patient_id", "date"], name: "bmis_unique_patient_id_date", unique: true, using: :btree
  add_index "bmis", ["patient_id"], name: "index_bmis_on_patient_id", using: :btree

  create_table "bun_and_creatinines", force: :cascade do |t|
    t.integer  "patient_id",              null: false
    t.date     "date",                    null: false
    t.integer  "bun_in_mg_per_dl"
    t.integer  "creatinine_in_mg_per_dl"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bun_and_creatinines", ["patient_id", "date"], name: "renals_unique_patient_id_date", unique: true, using: :btree
  add_index "bun_and_creatinines", ["patient_id"], name: "index_bun_and_creatinines_on_patient_id", using: :btree

  create_table "cholesterols", force: :cascade do |t|
    t.integer  "patient_id",                     null: false
    t.date     "date",                           null: false
    t.integer  "total_cholesterol_in_mg_per_dl"
    t.integer  "triglycerides_in_mg_per_dl"
    t.integer  "hdl_in_mg_per_dl"
    t.integer  "ldl_in_mg_per_dl"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cholesterols", ["patient_id", "date"], name: "cholesterols_unique_patient_id_date", unique: true, using: :btree
  add_index "cholesterols", ["patient_id"], name: "index_cholesterols_on_patient_id", using: :btree

  create_table "ckd_stages", force: :cascade do |t|
    t.integer  "patient_id", null: false
    t.date     "date",       null: false
    t.integer  "ckd_stage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckd_stages", ["patient_id", "date"], name: "ckd_stages_unique_patient_id_date", unique: true, using: :btree
  add_index "ckd_stages", ["patient_id"], name: "index_ckd_stages_on_patient_id", using: :btree

  create_table "eye_exams", force: :cascade do |t|
    t.integer  "patient_id", null: false
    t.date     "date",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "eye_exams", ["patient_id", "date"], name: "eye_exams_unique_patient_id_date", unique: true, using: :btree
  add_index "eye_exams", ["patient_id"], name: "index_eye_exams_on_patient_id", using: :btree

  create_table "flus", force: :cascade do |t|
    t.integer  "patient_id", null: false
    t.date     "date",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flus", ["patient_id", "date"], name: "flus_unique_patient_id_date", unique: true, using: :btree
  add_index "flus", ["patient_id"], name: "index_flus_on_patient_id", using: :btree

  create_table "foot_exams", force: :cascade do |t|
    t.integer  "patient_id", null: false
    t.date     "date",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "foot_exams", ["patient_id", "date"], name: "foot_exams_unique_patient_id_date", unique: true, using: :btree
  add_index "foot_exams", ["patient_id"], name: "index_foot_exams_on_patient_id", using: :btree

  create_table "livers", force: :cascade do |t|
    t.integer  "patient_id", null: false
    t.date     "date",       null: false
    t.integer  "ast"
    t.integer  "alt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "livers", ["patient_id", "date"], name: "livers_unique_patient_id_date", unique: true, using: :btree
  add_index "livers", ["patient_id"], name: "index_livers_on_patient_id", using: :btree

  create_table "measurements", force: :cascade do |t|
    t.integer "patient_id"
    t.date    "date",                                                  null: false
    t.decimal "weight_in_pounds",              precision: 5, scale: 2
    t.decimal "height_in_inches",              precision: 5, scale: 2
    t.decimal "waist_circumference_in_inches", precision: 5, scale: 2
  end

  add_index "measurements", ["patient_id", "date"], name: "measurements_unique_patient_id_date", unique: true, using: :btree
  add_index "measurements", ["patient_id"], name: "index_measurements_on_patient_id", using: :btree

  create_table "patients", force: :cascade do |t|
    t.integer "study_assigned_id", null: false
    t.date    "birthdate"
    t.boolean "smoker"
    t.boolean "etoh"
  end

  add_index "patients", ["study_assigned_id"], name: "patients_study_assigned_id_unique", unique: true, using: :btree

  create_table "pneumonias", force: :cascade do |t|
    t.integer  "patient_id", null: false
    t.date     "date",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pneumonias", ["patient_id", "date"], name: "pneumonias_unique_patient_id_date", unique: true, using: :btree
  add_index "pneumonias", ["patient_id"], name: "index_pneumonias_on_patient_id", using: :btree

  create_table "testosterones", force: :cascade do |t|
    t.integer "patient_id"
    t.date    "date",                      null: false
    t.integer "testosterone_in_ng_per_dl", null: false
  end

  add_index "testosterones", ["patient_id", "date"], name: "testosterones_unique_patient_id_date", unique: true, using: :btree
  add_index "testosterones", ["patient_id"], name: "index_testosterones_on_patient_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",           default: "",    null: false
    t.string   "password_digest", default: "",    null: false
    t.boolean  "admin",           default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "a1cs", "patients", name: "a1cs_patient_id_fkey", on_delete: :cascade
  add_foreign_key "acrs", "patients", name: "acrs_patient_id_fkey", on_delete: :cascade
  add_foreign_key "blood_pressures", "patients", name: "blood_pressures_patient_id_fkey", on_delete: :cascade
  add_foreign_key "bmis", "patients", name: "bmis_patient_id_fkey", on_delete: :cascade
  add_foreign_key "bun_and_creatinines", "patients", name: "renals_patient_id_fkey", on_delete: :cascade
  add_foreign_key "cholesterols", "patients", name: "cholesterols_patient_id_fkey", on_delete: :cascade
  add_foreign_key "ckd_stages", "patients", name: "ckd_stages_patient_id_fkey", on_delete: :cascade
  add_foreign_key "eye_exams", "patients", name: "eye_exams_patient_id_fkey", on_delete: :cascade
  add_foreign_key "flus", "patients", name: "flus_patient_id_fkey", on_delete: :cascade
  add_foreign_key "foot_exams", "patients", name: "foot_exams_patient_id_fkey", on_delete: :cascade
  add_foreign_key "livers", "patients", name: "livers_patient_id_fkey", on_delete: :cascade
  add_foreign_key "measurements", "patients", name: "measurements_patient_id_fkey", on_delete: :cascade
  add_foreign_key "pneumonias", "patients", name: "pneumonias_patient_id_fkey", on_delete: :cascade
  add_foreign_key "testosterones", "patients", name: "testosterones_patient_id_fkey", on_delete: :cascade
end
