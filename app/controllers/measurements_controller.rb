class MeasurementsController < ApplicationController
  include PatientDataEditingAndDeleting

  def model_name
    Measurements
  end

  def display_name
    "measurements"
  end

  def singular_underscored_name
    "measurements"
  end

  def plural_underscored_name
    "measurements"
  end

  def data_params
    params.require(:measurements).permit(
      :height_in_inches,
      :waist_circumference_in_inches,
      :weight_in_pounds,
      :date
    )
  end
end
