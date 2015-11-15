class BloodPressuresController < ApplicationController
  include PatientDataEditingAndDeleting
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def model
    BloodPressure
  end

  def data_params
    params.require(:blood_pressure).permit(
      :systolic_in_mmhg,
      :diastolic_in_mmhg,
      :date
    )
  end
end
