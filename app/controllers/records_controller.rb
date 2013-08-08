class RecordsController < ApplicationController

  def new
    @record = Record.new
  end

  def save
    @record = Record.new record_params
    if @record.save
      flash[:success] = "#{@record.name}: saved"
      redirect_to root_path and return
    end
    render "new"
  end

  # private
  def record_params
    params.require(:record).permit(:name)
  end

end
