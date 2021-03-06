class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_save :sanitize_inputs
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followee_id", dependent: :destroy

  has_many :following, through: :active_relationships, source: :followee, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower, dependent: :destroy

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def follow(user)
    active_relationships.create(followee_id: user.id)
  end

  def unfollow(followee_user)
    active_relationships.find_by(followee_id: followee_user.id).destroy
  end

  def following?(user)
    following.include?(user)
  end

  def sanitize_inputs
    self.email = email.downcase
    self.username = username.downcase
  end
end
