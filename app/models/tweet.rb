class Tweet < ApplicationRecord
  validates :tweet, presence: true, length: {minimum: 1, maximum: 280}, allow_blank: false
  belongs_to :user
end
