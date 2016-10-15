json.extract! course_history, :id, :student_id, :course_description_id, :grade, :created_at, :updated_at
json.url course_history_url(course_history, format: :json)