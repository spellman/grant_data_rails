class PatientsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

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
    if @patient.save
      redirect_to(patients_path)
    else
      paginate_patients
      render("index")
    end
  end

  def show
    p = Patient.find(params[:id])
    respond_to do |format|
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
    if @patient.update_attributes(patient_params)
      redirect_to(patients_path)
    else
      paginate_patients
      render("edit")
    end
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

    patient = Patient.find(params[:id])
    model_names.each do |model_name| patient.send(model_name).destroy end
    patient.destroy
    redirect_to(:patients)
  end

  private
  def patient_params
    convert_true_false_strings_to_values(params.require(:patient).permit(
      :study_assigned_id,
      :birthdate,
      :smoker,
      :etoh
    ))
  end

  def record_not_found
    flash[:warning] = "The requested patient could not be found. Has the patient been created? Has the patient been deleted? (Another user may have deleted the patient or the browser's \"back\" button may have been used to display a patient who had already been deleted.)"
    redirect_to(patients_path) and return
  end

  def convert_true_false_strings_to_values(params)
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
