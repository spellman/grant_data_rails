class CholesterolsController < ApplicationController
  include PatientDataEditingAndDeleting

  def model_name
    Cholesterol
  end

  def display_name
    "cholesterol"
  end

  def singular_underscored_name
    "cholesterol"
  end

  def plural_underscored_name
    "cholesterols"
  end

  def data_params
    params.require(:cholesterol).permit(
      :ldl_in_mg_per_dl,
      :date
    )
  end
end
