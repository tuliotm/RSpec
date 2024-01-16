json.extract! course, :id, :title, :video_url, :status, :created_at, :updated_at
json.url course_url(course, format: :json)
