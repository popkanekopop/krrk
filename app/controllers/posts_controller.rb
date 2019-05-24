class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @challenge = Challenge.find_by(id: params[:post][:challenge_id])
    @post = @challenge.posts.new(post_params)
    if @post.save
      flash[:success] = "post created!"
      redirect_to post_path(id: @post.id)
    else
      redirect_to root_url
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def destroy
    @post.destroy
    flash[:success] = "Challenge deleted"
    redirect_to root_url
  end

  private def post_params
    params.require(:post).permit(:title, :body, :picture, :challenge_id)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
