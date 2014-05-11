class Vote
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  belongs_to :user
  belongs_to :comment
end
