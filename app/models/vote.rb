class Vote
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  belongs_to :user
  belongs_to :comment

  field :value, type: Integer, default: 0
  validates_uniqueness_of :comment, :scope => :user

  def mark_comment_if_is_negative_as_abusive
    negative = self.class.where(:value => -1, :comment => comment.id).count.to_int
    if negative.modulo(3).zero?
      comment.mark_as_abusive
    end
  end
end
