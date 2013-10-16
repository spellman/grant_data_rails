class AddDemoFieldsToRecord < ActiveRecord::Migration
  def change
    add_column :records, :diagnosis,           :string,  null: false
    add_column :records, :bmi,                 :decimal
    add_column :records, :bmi_date,            :datetime
    add_column :records, :eye_exam_date,       :datetime
    add_column :records, :foot_exam_date,      :datetime
    add_column :records, :a1c,                 :decimal
    add_column :records, :a1c_date,            :datetime
    add_column :records, :tc,                  :integer
    add_column :records, :tg,                  :integer
    add_column :records, :hdl,                 :integer
    add_column :records, :ldl,                 :integer
    add_column :records, :cholesterol_date,    :datetime
    add_column :records, :acr,                 :integer
    add_column :records, :acr_date,            :datetime
    add_column :records, :bun,                 :integer
    add_column :records, :creatinine,          :integer
    add_column :records, :bun_creatinine_date, :datetime
    add_column :records, :ckd_stage,           :integer
    add_column :records, :ckd_stage_date,      :datetime
    add_column :records, :ast,                 :integer
    add_column :records, :alt,                 :integer
    add_column :records, :ast_alt_date,        :datetime
    add_column :records, :flu_date,            :datetime
    add_column :records, :pneumonia_date,      :datetime
  end
end
