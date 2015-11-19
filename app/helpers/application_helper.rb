module ApplicationHelper
  def pluralize_word(object_count, singular, plural)
    case object_count
    when 1 then singular
    else plural
    end
  end

  def form_error_message(error_count)
    "There #{pluralize_word(error_count, "is", "are")} #{pluralize(error_count, "error")}; please fix #{pluralize_word(error_count, "it", "them")} and re-submit."
  end

  def record_form_error_message(form_builder, record_errors)
    if record_errors.messages.has_key?(:base)
      form_builder.errors_on(:base)
    else
      form_builder.alert_message(form_error_message(record_errors.count),
                                 error_summary: false)
    end
  end
end
