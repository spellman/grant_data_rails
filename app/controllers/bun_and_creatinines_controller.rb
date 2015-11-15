class BunAndCreatininesController < ApplicationController
  include PatientDataEditingAndDeleting
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def model
    BunAndCreatinine
  end

  def data_params
    params.require(:bun_and_creatinine).permit(
      :bun_in_mg_per_dl,
      :creatinine_in_mg_per_dl,
      :date
    )
  end
end
