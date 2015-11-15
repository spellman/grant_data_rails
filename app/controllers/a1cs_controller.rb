class A1csController < ApplicationController
  include PatientDataEditingAndDeleting
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def model_name
    A1c
  end

  def display_name
    "A1c"
  end

  def singular_underscored_name
    "a1c"
  end

  def plural_underscored_name
    "a1cs"
  end

  def data_params
    params.require(:a1c).permit(
      :a1c,
      :date
    )
  end
end
