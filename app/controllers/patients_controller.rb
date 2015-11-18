class PatientsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @patient = Patient.new
    respond_to do |format|
      format.html {
        patients_source = patient_search? ? search_result : Patient
        @patients = paginate(patients_source)
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
      @patients = paginate(Patient)
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
      @patients = paginate(Patient)
      render("edit")
    end
  end

  def destroy
    Patient.find(params[:id]).destroy
    redirect_to(patients_url)
  end

  private
  def patient_params
    parse_values(params.require(:patient).permit(
      :study_assigned_id,
      :birthdate,
      :smoker,
      :etoh
    ))
  end

  def record_not_found
    flash[:warning] = "The requested patient was not found. Has the patient been created? Has the patient been deleted? (Another user may have deleted the patient or the browser's \"back\" button may have been used to display a patient who had already been deleted.)"
    redirect_to(patients_url) and return
  end

  def parse_values(params)
    Hash[params.map { |k, v| [k, parse_boolean_string(v)] }]
  end

  def parse_boolean_string(s)
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

  def search_result
    result = Patient.where(study_assigned_id: params[:search]["study_assigned_id"])
    raise(ActiveRecord::RecordNotFound) if result.empty?
    result
  end

  def paginate(patients)
    patients.page(params[:page])
      .per(13)
      .order("study_assigned_id ASC")
  end

  def csv_download(patients, file_name)
    send_data(Patient.to_csv(patients),
              filename: "#{file_name}-#{Time.zone.now}.csv",
              type: "text/csv")
  end
end
