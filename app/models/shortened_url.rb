class ShortenedUrl < ApplicationRecord
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, :user_id, presence: true

  belongs_to :submitter,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User

  

  def self.random_code
    code = SecureRandom.urlsafe_base64[0..15]
    while ShortenedUrl.exists?(short_url: code)
      code = SecureRandom.urlsafe_base64[0..15]
    end
    code
  end

  def self.shorten_url(user, long_url)
    ShortenedUrl.create!(short_url: ShortenedUrl.random_code,
    long_url: long_url, user_id: user.id)
  end

end
