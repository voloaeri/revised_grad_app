json.extract! faculty, :id, :firstName, :lastName, :sectionNumber, :PID, :isAdmin, :created_at, :updated_at
json.url faculty_url(faculty, format: :json)