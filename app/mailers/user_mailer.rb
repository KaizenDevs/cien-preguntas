class UserMailer < BaseMandrillMailer
  def daily_question(user_id)
    user = User.find(user_id)
    subject = "¡Bienvenido a Vuelteros!"
    merge_vars = {
      "NAME" => user.name,
      "NEW_URL" => new_service_url
    }
    body = mandrill_template("cienpreguntas_questions", merge_vars)

    send_mail(user.email, subject, body)
  end
end