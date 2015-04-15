require 'url_test'

class ValidUrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if UrlTest.new(value).valid?
    record.errors.add(attribute, "The url doesn't appear to be valid")
  end
end
