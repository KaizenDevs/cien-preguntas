class UserMailer < BaseMandrillMailer
  def daily_question(user_id, question_id)
    user = User.find(user_id)
    question = Question.find(question_id)
    subject = "Nueva Pregunta de 100 Preguntas"
    merge_vars = {
      "NAME" => user.name,
      "QUESTION_NUMBER" => question.id,
      "QUESTION" => question.question,
      "USER_URL" => "#{pages_profile_url(user_id: user.id)}?token=" + "#{user.auth_token}",
      "ANSWER_URL" => "#{new_question_answer_url(question.id)}?token=" + "#{user.auth_token}",
      "ANSWER_NUMBER" => user.answers.count
    }
    body = mandrill_template("cienpreguntas_questions", merge_vars)

    send_mail(user.email, subject, body)
  end

  def congratulations_email(user_id)
    user = User.find(user_id)
    subject = "Felicitaciones de 100 Preguntas"
    merge_vars = {
      "NAME" => user.name,
    }
    body = mandrill_template("cienpreguntas_congratulations", merge_vars)

    send_mail(user.email, subject, body)
  end
end
