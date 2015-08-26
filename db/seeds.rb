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

answer_times.times do |x|
  x = x + 1
  Answer.create(
    answer: "respuestas número #{x} del seed",
    question_id: x, user_id: 1,
    public_answer: rand(2) == 1 ? true : false,
    created_at: Date.today - (answer_times - x)
  )
end

User.create(
  email: 'muygrafico@gmail.com',
  password: '12345678',
  name: 'Germán Hernández',
  max_streak: answer_times
)

