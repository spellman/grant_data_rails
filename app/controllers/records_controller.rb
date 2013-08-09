class RecordsController < ApplicationController

  def index
    @record  = Record.new
    paginate_records
  end

  def save
    @record = Record.new record_params
    @record.save ? save_succeeded : save_failed
  end

  # private
  def record_params
    params.require(:record).permit(:name)
  end

  def save_succeeded
    flash[:success] = "#{@record.name}: saved"
    redirect_to root_path
  end

  def save_failed
    paginate_records
    render "index"
  end

  def paginate_records
    @records = Record.paginate(page: params[:page]).order("created_at DESC")
  end

end
