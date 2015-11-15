class TestosteronesController < ApplicationController
  include PatientDataEditingAndDeleting
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def model
    Testosterone
  end

  def data_params
    params.require(:testosterone).permit(
      :testosterone_in_ng_per_dl,
      :date
    )
  end
end
