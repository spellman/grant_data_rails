class ErrorAggregator
  attr_reader :models, :errors

  def initialize models = {}
    @models = models
    @errors = AggregatedErrors.new
  end

  def aggregate_errors
    models.each do |model_name, model|
      errors.add_model_messages model_name:      model_name.to_sym,
                                model_messages:  model.errors.messages
    end
    self
  end

  class AggregatedErrors
    attr_reader :messages

    def initialize
      @messages      = {}
      @full_messages = []
    end

    def add_model_messages model_name: nil, model_messages: {}
      messages[model_name] ||= {}
      model_messages.each do |msg_name, msgs|
        add_attr_messages attr_name:     msg_name,
                          attr_messages: msgs,
                          to_hash:       messages[model_name]
      end
    end

    def full_messages
      messages.map do |model_name, model_messages|
        full_messages_for_model model_name:     model_name,
                                model_messages: model_messages
      end.uniq.flatten
    end

    # private
    def add_attr_messages attr_name: nil, attr_messages: [], to_hash: {}
      to_hash[attr_name] ||= []
      attr_messages.each do |message|
        to_hash[attr_name] << message
      end
    end

    def full_messages_for_model model_name: nil, model_messages: {}
      model_messages.map do |attr_name, attr_messages|
        full_messages_for_attr model_name:    model_name,
                               attr_name:     attr_name,
                               attr_messages: attr_messages
      end
    end

    def full_messages_for_attr model_name: nil, attr_name: nil, attr_messages: []
      attr_messages.map do |attr_message|
        full_message_for_attr model_name:   model_name,
                              attr_name:    attr_name,
                              attr_message: attr_message
      end
    end

    def full_message_for_attr model_name: nil, attr_name: nil, attr_message: nil
      name_for(model_name: model_name, attr_name: attr_name) + attr_message
    end

    def name_for model_name: nil, attr_name: nil
      model = model_name.to_s.humanize.titlecase
      attr  = attr_name.to_s.humanize.titlecase
      name = ""
      name.prepend "#{attr} " unless attr.downcase == "base"
      name.prepend "#{model} " unless model == attr
      name
    end
  end
end
