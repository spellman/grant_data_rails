class AcrsController < ApplicationController
  include PatientDataEditingAndDeleting
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def model_name
    Acr
  end

  def display_name
    "ACR"
  end

  def singular_underscored_name
    "acr"
  end

  def plural_underscored_name
    "acrs"
  end

  def data_params
    params.require(:acr).permit(
      :acr_in_mcg_alb_per_mg_cr,
      :date
    )
  end
end
