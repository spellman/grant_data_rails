class Record
  include ActiveModel::Validations

  attr_reader :name

  def initialize params
    @name = params[:name]
  end

  validates_presence_of :name

end
