class AcrsController < ApplicationController
  include PatientDataEditingAndDeleting
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def model
    Acr
  end

  def data_params
    params.require(:acr).permit(
      :acr_in_mcg_alb_per_mg_cr,
      :date
    )
  end
end
