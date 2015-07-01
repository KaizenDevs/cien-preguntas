class UserMailer < BaseMandrillMailer
  def daily_question(user_id, question_id)
    user = User.find(user_id)
    question = Question.find(question_id)
    subject = "Nueva Pregunta de 100 Preguntas"
    merge_vars = {
      "NAME" => user.name,
      "QUESTION_NUMBER" => question.id,
      "QUESTION" => question.question
    }
    body = mandrill_template("cienpreguntas_questions", merge_vars)

    send_mail(user.email, subject, body)
  end
end