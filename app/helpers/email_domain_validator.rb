class EmailDomainValidator < ActiveModel::Validator

  DISPOSABLE_DOMAINS =
    JSON.parse(File.read("#{Rails.root}/config/disposable-email-domains.json")) rescue []

  def validate(user)
    error_message = I18n.t 'devise.registrations.messages.invalid_email'

    begin
      domain_name = Mail::Address.new(user.email).domain
    rescue
      user.errors[:email] << error_message
    end

    if DISPOSABLE_DOMAINS.include?(domain_name)
      user.errors[:email] << error_message
    end
  end
end