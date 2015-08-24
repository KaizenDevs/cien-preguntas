desc "Heroku scheduler tasks"
task :deliver_daily_question => :environment do
  puts "Sending out email questions."
  User.change_token
  Question.deliver_mail(Question.deliver_daily_question)
  puts "Emails sent!"
end