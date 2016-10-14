json.extract! document, :id, :type, :location, :student_id, :created_at, :updated_at
json.url document_url(document, format: :json)