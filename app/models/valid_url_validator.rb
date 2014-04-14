class ValidUrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless UrlTest.new(value).valid?
      record.errors.add(attribute, "The url doesn't appear to be valid")
    end
  end
end
