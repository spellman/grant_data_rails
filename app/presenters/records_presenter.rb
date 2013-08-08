class RecordsPresenter

  attr_reader :response_model

  def initialize response_model
    @response_model = response_model
  end

  def new
    {
      status: "saved",
      name:   response_model[:record][:name]
    }
  end

end
