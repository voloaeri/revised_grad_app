json.extract! course_description, :id, :number, :name, :section, :teacher, :semester, :category, :hours, :created_at, :updated_at
json.url course_description_url(course_description, format: :json)