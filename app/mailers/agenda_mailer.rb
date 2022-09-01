class AgendaMailer < ApplicationMailer
  default from: 'from@example.com'
  
  def agenda_delete_mail(agenda_title, email)
    @agenda_title = agenda_title
    @email = email
    mail to: @email, subject: I18n.t('views.messages.complete_agenda_deletion')
  end
end
