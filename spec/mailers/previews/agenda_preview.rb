# Preview all emails at http://localhost:3000/rails/mailers/agenda
class AgendaPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/agenda/agenda_delete_mail
  def agenda_delete_mail
    AgendaMailer.agenda_delete_mail
  end

end
