class CholesterolsController < ApplicationController
  include PatientDataEditingAndDeleting
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def model
    Cholesterol
  end

  def data_params
    params.require(:cholesterol).permit(
      :ldl_in_mg_per_dl,
      :date
    )
  end
end
