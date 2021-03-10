class Tweet < ApplicationRecord
  validates :tweet, presence: true, length: {minimum: 1, maximum: 280}
  belongs_to :user
end
