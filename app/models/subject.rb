class Subject < ApplicationRecord
  belongs_to :teacher
  has_many :courses
  has_many :students, through: :courses

  after_create do |subj|
    subj.compute_teacher_monthly_salary
  end

  after_update do |subj|
    if subj.saved_change_to_number_of_units?
      old_units, new_units = subj.saved_change_to_number_of_units
      subj.teacher.monthly_salary -= (old_units * subj.teacher.per_unit_rate)
      subj.teacher.monthly_salary += (new_units * subj.teacher.per_unit_rate)
      subj.teacher.save

      subj.students.each do |student|
        student.number_of_units -= old_units
        student.number_of_units += new_units
        student.total_assessment -= (old_units * subj.per_unit_rate)
        student.total_assessment += (new_units * subj.per_unit_rate)
        student.save
      end
    end

    if subj.teacher_id_changed? ||
       (subj.teacher.per_unit_rate_changed? &&
        subj.teacher.per_unit_rate != subj.teacher.per_unit_rate_was)
      subj.compute_teacher_monthly_salary
    end
end

  def compute_teacher_monthly_salary
    self.teacher.monthly_salary = self.number_of_units * self.teacher.per_unit_rate
    self.teacher.save
  end
end
