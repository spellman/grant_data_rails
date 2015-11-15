class CkdStagesController < ApplicationController
  include PatientDataEditingAndDeleting
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def model
    CkdStage
  end

  def data_params
    params.require(:ckd_stage).permit(
      :ckd_stage,
      :date
    )
  end
end
