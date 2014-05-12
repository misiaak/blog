class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  field :body, type: String
  field :abusive, type: Boolean, default: false

  belongs_to :post
  belongs_to  :user
  has_many :votes

def mark_as_not_abusive
    update_attribute :abusive, false
  end

  def mark_as_abusive
    update_attribute :abusive, true
  end

  def self.get_all(current_user, post_id)
    post = Post.find(post_id)
    comments = post.comments

    if comments.size >= 1
      comments_selected = []

      comments.each do |comment|
        if current_user.owner? post
          comments_selected.push(comment)
        else
          if comment.abusive == false
            comments_selected.push(comment)
          end
        end
      end

      return comments_selected
    end

    return comments
  end
  

  

end
