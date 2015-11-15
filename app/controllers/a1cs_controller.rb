class A1csController < ApplicationController
  include PatientDataEditingAndDeleting
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def model
    A1c
  end

  def data_params
    params.require(:a1c).permit(
      :a1c,
      :date
    )
  end
end
