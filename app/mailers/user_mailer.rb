class UserMailer < BaseMandrillMailer
  def daily_question(user_id)
    user = User.find(user_id)
    subject = "Pregunta #{Question.first.id}"
    merge_vars = {
      "NAME" => user.name,
    }
    body = mandrill_template("cienpreguntas_questions", merge_vars)

    send_mail(user.email, subject, body)
  end
end