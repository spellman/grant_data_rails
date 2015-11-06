class BloodPressuresController < ApplicationController
  include PatientDataEditingAndDeleting

  def model_name
    BloodPressure
  end

  def display_name
    "blood pressure"
  end

  def singular_underscored_name
    "blood_pressure"
  end

  def plural_underscored_name
    "blood_pressures"
  end

  def data_params
    params.require(:blood_pressure).permit(
      :systolic_in_mmhg,
      :diastolic_in_mmhg,
      :date
    )
  end
end
