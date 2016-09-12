# Cards Mailer
class CardsMailer < ApplicationMailer
  default from: ENV["EMAIL"]

  def pending_cards_notification(user)
    @user = user
    @url = 'http://flashca.herokuapp.com'
    mail(to: @user.email, subject: 'Уведомление об отложенных картах')
  end
end
