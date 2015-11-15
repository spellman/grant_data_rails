class FootExamsController < ApplicationController
  include PatientDataEditingAndDeleting
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def model
    FootExam
  end

  def data_params
    params.require(:foot_exam).permit(
      :date
    )
  end
end
