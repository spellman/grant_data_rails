class EyeExamsController < ApplicationController
  include PatientDataEditingAndDeleting

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
