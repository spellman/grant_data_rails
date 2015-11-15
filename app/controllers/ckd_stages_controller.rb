class CkdStagesController < ApplicationController
  include PatientDataEditingAndDeleting
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def model_name
    CkdStage
  end

  def display_name
    "CKD stage"
  end

  def singular_underscored_name
    "ckd_stage"
  end

  def plural_underscored_name
    "ckd_stages"
  end

  def data_params
    params.require(:ckd_stage).permit(
      :ckd_stage,
      :date
    )
  end
end
