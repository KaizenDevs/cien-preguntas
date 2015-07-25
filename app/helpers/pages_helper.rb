module PagesHelper

  def average_answers_per_user
    users = User.where(role: 0).count
    answers = Answer.all.count
    answers/users
  end

  def self.day_streak(user)
    return [] if user.answers.count == 0
    start = user.answers.order("created_at").first.created_at
    streak_array = []
    (Time.zone.today).downto(start.to_date).map do |date|
      if Answer.where(created_at: date.beginning_of_day..date.end_of_day).count == 0 && date != Time.zone.today
        break
      end
      streak_array.push({
        day: date.strftime(),
        answer: Answer.where(created_at: date.beginning_of_day..date.end_of_day)
      })
    end
    streak_array.shift if streak_array.first[:answer].count == 0
    streak_array.reverse
  end

  def day_streak(user)
    PagesHelper.day_streak(user)
  end
end
