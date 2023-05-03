class Student < ApplicationRecord
  has_many :courses
  has_many :subjects, through: :courses
end
