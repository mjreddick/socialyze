class TwitterAccount < ActiveRecord::Base
  belongs_to :user
  has_many :tweets
  has_many :tweet_words
  has_many :follower_relationships, class_name: "TwitterFollowerRelationship", foreign_key: "followee_id"
  has_many :followers, through: :follower_relationships
  has_many :followee_relationships, class_name: "TwitterFollowerRelationship", foreign_key: "follower_id"
  has_many :followees, through: :followee_relationships

  validates :twitter_uid, presence: true, uniqueness: true
end
