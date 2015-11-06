module PatientDataEditingAndDeleting
  extend ActiveSupport::Concern

  # The including controller should:
  # 1. Define a model_name method that returns the model name (class name)
  #    Example:
  #      def model_name
  #        CkdStage
  #      end
  #
  # 2. Define a display_name method that returns a human-readable string,
  #    naming the model instance.
  #    Example:
  #      def display_name
  #        "CKD stage"
  #      end
  #
  # 3. Define a singular_underscored_name method that returns an underscored
  #    string, naming the model instance (singular).
  #    Example:
  #      def singular_underscored_name
  #        "ckd_stage"
  #      end
  #
  # 4. Define a plural_underscored_name method that returns an underscored
  #    string, naming the model instances (plural).
  #    Example:
  #      def plural_underscored_name
  #        "ckd_stages"
  #      end
  #
  # 5. Define a data_params method that whitelists params keys.
  #    Example:
  #      def data_params
  #        params.require(:ckd_stage).permit(
  #          :date
  #        )
  #      end

  def edit
    @data_point = model_name.find(params[:id])
    respond_to do |format|
      format.html {
        @patient = Patient.find(@data_point.patient_id)
        render_edit
      }
      format.js { render_edit }
    end
  end

  def update
    @data_point = model_name.find(params[:id])
    if @data_point.update_attributes(data_params)
      redirect_to patient_records_path(@data_point.patient_id)
    else
      @patient = Patient.find(@data_point.patient_id)
      render_edit
    end
  end

  def destroy
    begin
      data_point = model_name.find(params[:id])
      data_point.destroy
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = "The patient to be deleted did not exist. The browser's \"back\" button may have been used to display a patient that had already been deleted."
    end
    redirect_to patient_records_path(data.patient_id)
  end

  private
  def render_edit
    render(partial: "shared/edit_data_point",
           locals: {display_name: display_name,
                    singular_underscored_name: singular_underscored_name,
                    plural_underscored_name: plural_underscored_name})
  end
end
