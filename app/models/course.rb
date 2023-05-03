class Course < ApplicationRecord
  belongs_to :student
  belongs_to :subject

  after_create do |c|
    c.compute_student_number_of_units
    c.compute_student_total_assessment
    c.compute_subject_number_of_students
  end

  after_update do |c|
    if c.saved_change_to_subject&.first&.number_of_units != c.saved_change_to_subject&.last&.number_of_units
      old_units, new_units = c.saved_change_to_subject
      c.student.number_of_units -= old_units
      c.student.number_of_units += new_units
      c.student.total_assessment -= (old_units * c.subject.per_unit_rate)
      c.student.total_assessment += (new_units * c.subject.per_unit_rate)
      c.student.save

      c.subject.teacher.monthly_salary -= (old_units * c.subject.teacher.per_unit_rate)
      c.subject.teacher.monthly_salary += (new_units * c.subject.teacher.per_unit_rate)
      c.subject.teacher.save
    end
  end

  def compute_student_number_of_units
    self.student.number_of_units += self.subject.number_of_units
    self.student.save
  end

  def compute_student_total_assessment
    self.student.total_assessment += (self.subject.number_of_units * self.subject.per_unit_rate)
    self.student.save
  end

  def compute_subject_number_of_students
    self.subject.number_of_students += 1
    self.subject.save
  end
end
