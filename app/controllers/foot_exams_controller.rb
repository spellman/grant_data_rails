class FootExamsController < ApplicationController
  include PatientDataEditingAndDeleting
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def model_name
    FootExam
  end

  def display_name
    "foot exam"
  end

  def singular_underscored_name
    "foot_exam"
  end

  def plural_underscored_name
    "foot_exams"
  end

  def data_params
    params.require(:foot_exam).permit(
      :date
    )
  end
end
