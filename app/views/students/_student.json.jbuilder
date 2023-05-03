json.extract! student, :id, :name, :year_level, :number_of_units, :total_assessment, :created_at, :updated_at
json.url student_url(student, format: :json)
