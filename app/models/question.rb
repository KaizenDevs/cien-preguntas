# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  question   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ActiveRecord::Base
  has_many :answers
  has_many :users, through: :answers

  def self.deliver_daily_question
    mail_hash = {}
    User.all.each do |user|
      if user.last_sent_question != -1
        if user.answers.count == Question.all.count
          user.update(last_sent_question: -1)
          UserMailer.congratulations_email(user.id).deliver_now
          puts "Congratulations!!!!"
        else
          puts "I enter here!"
          if user.last_sent_question == nil
            mail_hash[user.id] = Question.first.id
            user.update(last_sent_question: Question.first.id)
          elsif Question.where("id > ?", user.last_sent_question).first == nil
            if user.questions.include?(Question.first)
              question_true = true
              included_question = Question.where("id > ?", user.Question.first).first
              while question_true == true
                unless user.questions.include?(included_question)
                  mail_hash[user.id] = included_question.id
                  user.update(last_sent_question: included_question.id)
                  question_true = false
                end
                included_question = Question.where("id > ?", included_question).first
              end
            else
              mail_hash[user.id] = Question.first.id
              user.update(last_sent_question: Question.first.id)
            end
          else
            Question.where("id > ?", user.last_sent_question).first # To get next question to send
            question_true = true
            included_question = Question.where("id > ?", Question.find(user.last_sent_question)).first
            while question_true == true
              unless user.questions.include?(included_question)
                mail_hash[user.id] = included_question.id
                user.update(last_sent_question: included_question.id)
                question_true = false
              end
              included_question = Question.where("id > ?", included_question).first
            end
          end
        end
      end
    end
    puts mail_hash
    mail_hash
  end

  def self.deliver_mail(mail_hash)
    mail_hash.each do |user_id, question_id|
      puts "delivering question_id: #{question_id} to user_id: #{user_id}"
      UserMailer.daily_question(user_id, question_id).deliver_now
    end
  end

  def self.import(file)
    if file != nil
      CSV.foreach(file.path, headers: true) do |row|
        Question.create! row.to_hash
      end
    end
  end

end
