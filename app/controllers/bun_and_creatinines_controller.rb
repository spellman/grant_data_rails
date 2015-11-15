class BunAndCreatininesController < ApplicationController
  include PatientDataEditingAndDeleting
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def model_name
    BunAndCreatinine
  end

  def display_name
    "BUN and creatinine"
  end

  def singular_underscored_name
    "bun_and_creatinine"
  end

  def plural_underscored_name
    "bun_and_creatinines"
  end

  def data_params
    params.require(:bun_and_creatinine).permit(
      :bun_in_mg_per_dl,
      :creatinine_in_mg_per_dl,
      :date
    )
  end
end
