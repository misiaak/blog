class CommentsController < ApplicationController
  before_filter :authenticate_user!
  expose_decorated(:post)
  expose_decorated(:comment)

  def index
  end

  def new
  end

  def create
    comment = post.comments.build(comment_params)
    comment.user_id = current_user.id
    if comment.save
      redirect_to controller:'posts', action: 'index'
    else
      render :new
    end
  end

  def mark_as_not_abusive
    comment.mark_as_not_abusive
    redirect_to post
  end

  def vote_up
    if self.create_vote(1)
      flash[:notice] = "Thank you for voting!"
    else
      flash[:notice] = "You already voted for this comment"
    end

    redirect_to post
  end

  def vote_down
    if self.create_vote(-1)
      flash[:notice] = "Thank you for voting!";
    else
      flash[:notice] = "You already voted for this comment"
    end

    redirect_to post
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  protected

  def create_vote(value)
    vote = comment.votes.build(
      :user => current_user.id,
      :value => value
    )
    return vote.save
  end

end
