class LanguageValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    characters = value.gsub(/\d+/, "").squeeze(" ").strip
    if record.language.present? && value.present? && record.language != characters.language.to_s
      message = I18n.t('activerecord.errors.messages.language', language: I18n.t(record.language))
      record.errors.add(attribute, message)
    end
  end
end

