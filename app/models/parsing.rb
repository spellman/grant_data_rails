class Parsing
  def initialize(date_attrs)
    @date_attrs = date_attrs
  end

  def after_initialize(record)
    @date_attrs.each do |date_attr|
      if record.attribute_present?(date_attr)
        record.send("#{date_attr}=",
                    parse_date(record.send("#{date_attr}_before_type_cast")))
      end
    end
  end

  def parse_date(d)
    return d unless d.is_a?(String)
    begin
      Date.strptime(d, "%Y-%m-%d")
    rescue ArgumentError
      begin
        Date.strptime(d, "%m/%d/%Y")
      rescue ArgumentError
        d
      end
    end
  end
end
