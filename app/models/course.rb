class Course < ApplicationRecord
  enum status: { draft: 0, published: 1 }

  validates :title, :video_url, presence: true
end
