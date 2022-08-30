class TeamMailer < ApplicationMailer
  default from: 'from@example.com'

  def team_mail(email)
    @email = email
    mail to: @email, subject: I18n.t('views.messages.complete_transferring')
  end
end