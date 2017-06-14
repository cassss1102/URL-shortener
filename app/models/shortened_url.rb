# == Schema Information
#
# Table name: shortened_urls
#
#  id         :integer          not null, primary key
#  short_url  :string           not null
#  long_url   :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, :user_id, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    # foreign_key: :user_id,
    foreign_key: :shortened_url_id,
    class_name: :Visit

  has_many :visitors,
    -> { distinct },
    through: :visits, # [visit1, visit2, visit3]
    source: :visitor # [user1, user2, user1]


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

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
    # self.visits.select(:user_id).distinct.count
  end

  def num_recent_uniques
    self.visits.where(["created_at >= ?", 10.minutes.ago]).distinct.count
  end

end
