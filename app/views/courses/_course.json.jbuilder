json.extract! course, :id, :student_id, :subject_id, :created_at, :updated_at
json.url course_url(course, format: :json)
