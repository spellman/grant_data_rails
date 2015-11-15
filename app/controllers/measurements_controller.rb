class MeasurementsController < ApplicationController
  include PatientDataEditingAndDeleting
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def model
    Measurements
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
