class Score < ApplicationRecord
  belongs_to :evaluation_instance
  belongs_to :student

  validates_presence_of :student_id, :evaluation_instance_id

  validates :score, :uniqueness => {:scope => [:evaluation_instance_id, :student_id]}
  validates :score, presence: true, numericality: { only_integer: true }
  validate :range?, if: Proc.new{ |s| !(s.score.nil?)  }

  scope :has_score_for, ->(student, evaluation_instance) { where(student: student, evaluation_instance: evaluation_instance) }

  def range?
    if !((score > 0) && (score <= evaluation_instance.top_score))
      errors.add(:score, "the score must be greater than 0 and less than the maximum score")
      false 
    else 
      true
    end
  end

  def approved?
    score.nil? ? false : score >= evaluation_instance.passing_score
  end
end
