class ContactMailer < ActionMailer::Base
  default from: "feedback@biomodelos.humboldt.org.co"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.contact_us.subject
  #
  def contact_us(message)
    @message = message
    @datetime = DateTime.now
    mail to: "biomodelos@humboldt.org.co",  subject: "Feedback desde BioModelos"
  end
end
