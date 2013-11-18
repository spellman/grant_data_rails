require "forwardable"
require "set"

class ErrorAggregator
  attr_reader :full_messages
  def initialize
    @full_messages = Set.new
  end

  def aggregate_errors_from models
    full_messages.clear
    models.each do |model|
      full_messages.merge model.errors.full_messages
    end
    self
  end

  def add_full_error_message message
    full_messages.add message
  end
end
