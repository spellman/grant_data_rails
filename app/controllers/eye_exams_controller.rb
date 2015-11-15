class EyeExamsController < ApplicationController
  include PatientDataEditingAndDeleting
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def model
    EyeExam
  end

  def data_params
    params.require(:eye_exam).permit(
      :date
    )
  end
end
