desc "Send email for user with pending cards"
task :send_cards_notification => :environment do
  User.cards_notification
end
