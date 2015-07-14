module PagesHelper

  def average_answers_per_user
    users = User.where(role: 0).count
    answers = Answer.all.count
    answers/users
  end
end
