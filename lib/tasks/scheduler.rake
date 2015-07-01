desc "Heroku scheduler tasks"
task :deliver_daily_question => :environment do
  puts "Sending out email questions."
  mail_hash = Question.deliver_daily_question
  # Question.deliver_mail(mail_hash)
  puts "Emails sent!"
end