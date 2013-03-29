class LanguageValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.language.present? && record.language != value.language.to_s
      message = I18n.t('activerecord.errors.messages.language', language: I18n.t(record.language))
      record.errors.add(attribute, message)
    end
  end
end

