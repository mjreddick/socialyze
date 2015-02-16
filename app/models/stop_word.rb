class StopWord < ActiveRecord::Base

  validates :word, uniqueness: true
end
