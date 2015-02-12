class TwitterFollowerRelationship < ActiveRecord::Base
  belongs_to :followee, class_name: "TwitterAccount"
  belongs_to :follower, class_name: "TwitterAccount"

  validates :followee_id, presence: true
  validates :follower_id, presence: true
end
