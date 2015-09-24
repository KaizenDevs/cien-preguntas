ActiveRecord::Base.connection.reset_pk_sequence!('questions')

100.times do |x|
  Question.create(question: Faker::Hacker.say_something_smart)
end


Content.create(title: '¿Qué hace a Cien Preguntas diferente?', content: 'Make it Real es un programa muy estructurado, apoyado de mentores y una comunidad de estudiantes que trabajan de la mano, pero con la flexibilidad horaria y la dedicación que más te convenga.

  Hemos diseñado cuidadosamente el programa para que aprendas las habilidades que se requieren para convertirte en Desarrollador Web y puedas construir y desplegar aplicaciones complejas y robustas.', content_order: 0)
Content.create(title: '¿Cómo sé si este programa es para mi?', content: 'Si sientes que el programa no es para ti y te retiras en los primeros 15 días, recibirás un reembolso completo. Si cancelas después, recibirás un reembolso parcial según tu avance en la plataforma. Cero riesgo', content_order: 1)
Content.create(title: '¿Me van a ayudar a encontrar empleo?', content: 'Es posible que publiquemos algunas ofertas para los alumnos más avanzados pero no hay ninguna garantía. Es cierto que la demanda de programadores sigue creciendo, así que entre más duro trabajes por crear tu portafolio, más probable es que consiguas un empleo.', content_order: 0)
Content.create(title: '¿Cuáles son los requerimientos?', content: 'Lo único que necesitas es un computador (con cualquier sistema operativo) y una buena conexión a Internet para ver los videos. Una advertencia: la mayoría de recursos están en Inglés. Es preferible si al menos lo entiendes escrito. Pero si no, no te preocupes, puedes usar un traductor si es necesario y buscar otros recursos por tu cuenta.', content_order: 1)

# 30.times do |x|
# 	User.create(email: Faker::Internet.email,password: "12345678",name: Faker::Name.first_name, lastname: Faker::Name.last_name, role: 0)
# end

answer_times = 5

User.create(
  email: 'muygrafico@gmail.com',
  password: '12345678',
  name: 'Germán',
  lastname: 'Hernández',
  max_streak: answer_times,
  last_sign_in_at: Date.today,
  role: 1,
  avatar: File.new("app/assets/images/profile/profile-test.jpg")
  )

User.create(
  email: 'alejoescobac@gmail.com',
  password: '12345678',
  name: 'Alejandro',
  lastname: 'Escobar',
  max_streak: answer_times,
  last_sign_in_at: Date.today - answer_times,
  role: 0,
  avatar: Faker::Avatar.image
  )

Answer.create!(
  answer: Faker::Lorem.paragraphs,
  question_id: 1,
  user_id: 1,
  public_answer: true,
  created_at: Date.today
  )

(answer_times - 2).times do
  User.create(
    email: Faker::Internet.email,
    password: '12345678',
    name: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    max_streak: answer_times,
    avatar: Faker::Avatar.image,
    last_sign_in_at: Date.today - answer_times,
    role: 0
    )
end

answer_times.times do |x|
  x = x + 1
  Answer.create!(
    answer: Faker::Hacker.say_something_smart,
    question_id: 1,
    user_id: x,
    public_answer: rand(2) == 1 ? true : false,
    created_at: Date.today - (answer_times - x)
    )
end

answer_times.times do |x|
  x = x + 2
  Answer.create!(
    answer: "respuestas número #{x} del seed",
    question_id: x,
    user_id: 1,
    public_answer: rand(2) == 1 ? true : false,
    created_at: Date.today - (answer_times - x)
    )
end


