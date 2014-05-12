class PostsController < ApplicationController
  before_filter :authenticate_user!

  expose_decorated(:posts) { Post.get_all }
  expose_decorated(:comments) { Comment.get_all(current_user, params[:id]) }
  expose_decorated(:post, attributes: :post_params)
  expose(:tag_cloud) { Post.tags_with_weight }

  def index
  end

  def new
  end

  def edit
  end

  def update
    if post.save
      render action: :index
    else
      render :new
    end
  end

  def destroy
    post.destroy if current_user.owner? post
    render action: :index
  end

  def show
  end

  def mark_archived
    post.archive!
    render action: :index
  end

  def create
    post.user_id = current_user.id
    if post.save
      redirect_to action: :index
    else
      render :new
    end
  end

  private

  def post_params
    return if %w{mark_archived}.include? action_name
    params.require(:post).permit(:body, :title, :tags)
  end
end
