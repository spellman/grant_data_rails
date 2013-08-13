class RecordsController < ApplicationController

  def index
    @record  = Record.new
    @records = Record.all
    respond_to do |format|
      format.html { paginate_records }
      format.csv  { csv_download }
    end
  end

  def create
    @record = Record.new record_params
    @record.save ? save_succeeded : save_failed
  end

  def show
    @record = Record.find params[:id]
  end

  # private
  def record_params
    params.require(:record).permit(:name)
  end

  def save_succeeded
    flash[:success] = "Saved #{@record.name}"
    redirect_to records_path
  end

  def save_failed
    paginate_records
    render "index"
  end

  def paginate_records
    @records = Record.paginate(page: params[:page]).order("created_at DESC")
  end

  def csv_download
    send_data @records.to_csv, filename: csv_filename, type: "text/csv"
  end

  def csv_filename
    "records-#{DateTime.now.to_s}"
  end

end
