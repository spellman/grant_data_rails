class EyeExamsController < ApplicationController
  include PatientDataEditingAndDeleting
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def model_name
    EyeExam
  end

  def display_name
    "eye exam"
  end

  def singular_underscored_name
    "eye_exam"
  end

  def plural_underscored_name
    "eye_exams"
  end

  def data_params
    params.require(:eye_exam).permit(
      :date
    )
  end
end
