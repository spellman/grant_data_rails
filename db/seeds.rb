# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Users
pw = "homer-simpson"
User.create email: "admin@test.com",
            password: pw,
            password_confirmation: pw,
            admin: true
User.create email: "user@test.com",
            password: pw,
            password_confirmation: pw,
            admin: false

# Patients
Patient.create! study_assigned_id: 5446,
                birthdate: "1900-01-01",
                smoker: false,
                etoh: true

# Records
id = Patient.find_by(study_assigned_id: 5446).id
height = 72
weight = 240
waist = 50
day = 20
(0...10).each do |i|
  A1c.create!(
    patient_id: id,
    date: "2015-10-#{day - i}",
    a1c: 15 - i
  )
  Acr.create!(
    patient_id: id,
    date: "2015-10-#{day - i}",
    acr_in_mcg_alb_per_mg_cr: 20 - i
  )
  BloodPressure.create!(
    patient_id: id,
    date: "2015-10-#{day - i}",
    systolic_in_mmhg: 200 - (i * 5),
    diastolic_in_mmhg: 100 - (i * 5)
  )
  Bmi.create!(
    patient_id: id,
    date: "2015-10-#{day - i}",
    bmi: 35 - i
  )
  BunAndCreatinine.create!(
    patient_id: id,
    date: "2015-10-#{day - i}",
    bun_in_mg_per_dl: 25 - i,
    creatinine_in_mg_per_dl: 30 - (2 * i)
  )
  Cholesterol.create!(
    patient_id: id,
    date: "2015-10-#{day - i}",
    total_cholesterol_in_mg_per_dl: 200 - (6 * i),
    triglycerides_in_mg_per_dl: 60 - (2 * i),
    hdl_in_mg_per_dl: 100 - (2 * i),
    ldl_in_mg_per_dl: 40 - (2 * i)
  )
  CkdStage.create!(
    patient_id: id,
    date: "2015-10-#{day - i}",
    ckd_stage: 12 - i
  )
  EyeExam.create!(
    patient_id: id,
    date: "2015-10-#{day - i}"
  )
  Flu.create!(
    patient_id: id,
    date: "2015-10-#{day - i}"
  )
  FootExam.create!(
    patient_id: id,
    date: "2015-10-#{day - i}"
  )
  Liver.create!(
    patient_id: id,
    date: "2015-10-#{day - i}",
    ast: 20 - i,
    alt: 15 - i
  )
  Measurements.create!(
    patient_id: id,
    date: "2015-10-#{day - i}",
    weight_in_pounds: weight - i,
    height_in_inches: height - i,
    waist_circumference_in_inches: waist - i
  )
  Pneumonia.create!(
    patient_id: id,
    date: "2015-10-#{day - i}"
  )
  Testosterone.create!(
    patient_id: id,
    date: "2015-10-#{day - i}",
    testosterone_in_ng_per_dl: 100 - (3 * i)
  )
end
