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
  Measurements.create! patient_id: id,
                       date: "2015-10-#{day - i}",
                       weight_in_pounds: weight - i,
                       height_in_inches: height - i,
                       waist_circumference_in_inches: waist - i
end
