# == Schema Information
#
# Table name: answers
#
#  id            :integer          not null, primary key
#  answer        :string
#  question_id   :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  public_answer :boolean
#

class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  validates_presence_of :answer
end
