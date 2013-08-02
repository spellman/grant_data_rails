class Record
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_reader :name

  def initialize params = {}
    @name = params[:name]
  end

  validates_presence_of :name

  def persisted?
    false
  end
end
