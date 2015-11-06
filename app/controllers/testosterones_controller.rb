class TestosteronesController < ApplicationController
  include PatientDataEditingAndDeleting

  def model_name
    Testosterone
  end

  def display_name
    "testosterone"
  end

  def singular_underscored_name
    "testosterone"
  end

  def plural_underscored_name
    "testosterones"
  end

  def data_params
    params.require(:testosterone).permit(
      :testosterone_in_ng_per_dl,
      :date
    )
  end
end
