module ApplicationHelper
  def conjugate_be(object_count)
    case object_count
    when 1 then "is"
    else "are"
    end
  end
end
