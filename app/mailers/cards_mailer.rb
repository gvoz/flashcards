# Cards Mailer
class CardsMailer < ApplicationMailer
  default from: ENV["EMAIL"]

  def pending_cards_notification(user)
    @user = user
    @url = ENV["SITE"]
    mail(to: @user.email, subject: 'Уведомление об отложенных картах')
  end
end
