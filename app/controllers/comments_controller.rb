class CommentsController < ApplicationController
  before_filter :authenticate_user!

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
      flash[:notice] = "Your vote was saved !";
    else
      flash[:notice] = "Can't vote twice for the same comment!"
    end

    redirect_to post
  end

  def vote_down
    if self.create_vote(-1)
      flash[:notice] = "Your vote was saved !";
    else
      flash[:notice] = "Can't vote twice for the same comment!"
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
