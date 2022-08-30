class TeamMailer < ApplicationMailer
  default from: 'from@example.com'

  def team_mail(team_name, email)
    @team_name = team_name
    @email = email
    mail to: @email, subject: I18n.t('views.messages.complete_transferring')
  end
end
