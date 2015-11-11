module PatientRecordsPresenter
  def index(patient_records)
    record_display = {
      :a1c => [["A1c", :a1c],
               ["Date (mm/dd/yyyy)", :date]],
      :acr => [["ACR", :acr_in_mcg_alb_per_mg_cr],
               ["Date (mm/dd/yyyy)", :date]],
      :blood_pressure => [["Systolic (mmHg)", :systolic_in_mmhg],
                          ["Diastolic (mmHg)", :diastolic_in_mmhg],
                          ["Date (mm/dd/yyyy)", :date]],
      :bun_and_creatinine => [["BUN (mg/dL)", :bun_in_mg_per_dl],
                              ["Creatinine (mg/dL)", :creatinine_in_mg_per_dl],
                              ["Date (mm/dd/yyyy)", :date]],
      :cholesterol => [["LDL (mg/dL)", :ldl_in_mg_per_dl],
                       ["Date (mm/dd/yyyy)", :date]],
      :ckd_stage => [["CKD stage", :ckd_stage],
                     ["Date (mm/dd/yyyy)", :date]],
      :eye_exam => [["Eye exam date (mm/dd/yyyy)", :date]],
      :foot_exam => [["Foot exam date (mm/dd/yyyy)", :date]],
      :measurements => [["Height (in)", :height_in_inches],
                        ["Waist (in)", :waist_circumference_in_inches],
                        ["Weight (lb)", :weight_in_pounds],
                        ["Date (mm/dd/yyyy)", :date]],
      :testosterone => [["Testosterone (ng/dL)", :testosterone_in_ng_per_dl],
                        ["Date (mm/dd/yyyy)", :date]]
    }

    patient_records.map { |r|
      singular_name = r[:model_name].singular
      singular_name_sym = singular_name.to_sym
      {
        :record_type_id => "#{singular_name.dasherize}-records",
        :data_labels => record_display[singular_name_sym].map(&:first),
        :data_keys => record_display[singular_name_sym].map(&:last).reject { |k| k == :date },
        :data_points => r[:records].sort { |a, b| a.date <=> b.date },
        :data_point_path => "#{r[:model_name].singular_route_key}_path"
      }
    }
  end

  extend self
end
