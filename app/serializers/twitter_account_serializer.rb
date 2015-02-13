class TwitterAccountSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :twitter_id
end
