class PatientsController < ApplicationController
  def index
    @patient = Patient.new
    respond_to do |format|
      format.html {
        patient_search? ? paginate_search_results : paginate_patients
      }
      format.js
      format.csv  { csv_download(Patient.all, "all-patients-records") }
    end
  end

  def create
    @patient = Patient.new(patient_params)
    @patient.save ? save_succeeded : create_failed
  end

  def show
    respond_to do |format|
      p = Patient.find(params[:id])
      format.csv { csv_download([p], "patient-#{p.study_assigned_id}-records") }
    end
  end

  def edit
    @patient = Patient.find(params[:id])
    respond_to do |format|
      format.html { paginate_patients }
      format.js
    end
  end

  def update
    @patient = Patient.find(params[:id])
    @patient.update_attributes(patient_params) ? save_succeeded : update_failed
  end

  def destroy
    model_names = [
      :a1cs,
      :acrs,
      :blood_pressures,
      :bun_and_creatinines,
      :cholesterols,
      :ckd_stages,
      :eye_exams,
      :foot_exams,
      :measurements,
      :testosterones
    ]

    begin
      patient = Patient.find(params[:id])
      model_names.each do |model_name| patient.send(model_name).destroy end
      patient.destroy
    rescue ActiveRecord::RecordNotFound
      delete_failed
    end
    redirect_to :patients
  end

  # private
  def patient_params
    try_convert_true_false_strings_to_values_in(params.require(:patient).permit(
      :study_assigned_id,
      :birthdate,
      :smoker,
      :etoh
    ))
  end

  def try_convert_true_false_strings_to_values_in(params)
    {
      study_assigned_id: params[:study_assigned_id],
      birthdate: params[:birthdate],
      smoker: as_true_false(params[:smoker]),
      etoh: as_true_false(params[:etoh])
    }
  end

  def as_true_false(s)
    case s
    when "true"
      true
    when "false"
      false
    else
      s
    end
  end

  def patient_search?
    params[:search]
  end

  def save_succeeded
    redirect_to patients_path
  end

  def create_failed
    paginate_patients
    render "index"
  end

  def update_failed
    paginate_patients
    render "edit"
  end

  def delete_failed
    flash[:warning] = "The patient to be deleted did not exist. The browser's \"back\" button may have been used to display a patient that had already been deleted."
  end

  def paginate_search_results
    @patients = Patient.where(study_assigned_id: params[:search]["study_assigned_id"])
                       .page(params[:page])
                       .per(13)
                       .order("study_assigned_id ASC")

  end

  def paginate_patients
    @patients = Patient.page(params[:page])
                       .per(13)
                       .order("study_assigned_id ASC")
  end

  def csv_download(patients, file_name)
    send_data(Patient.to_csv(patients),
              filename: "#{file_name}-#{Time.zone.now}.csv",
              type: "text/csv")
  end
end
