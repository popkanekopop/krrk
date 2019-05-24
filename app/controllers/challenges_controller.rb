class ChallengesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy


  def new
    @challenge = Challenge.new
  end

  def create
    @challenge = current_user.challenges.new(challenge_params)
    if @challenge.save
      flash[:success] = "challenge created!"
      redirect_to challenge_path(id: @challenge.id)
    else
      redirect_to root_url
    end
  end

  def index
    @challenges = Challenge.all
  end

  def show
    @challenge = Challenge.find_by(id: params[:id])
    @posts = @challenge.posts
  end

  def destroy
    @challenge.destroy
    flash[:success] = "Challenge deleted"
    redirect_to root_url
  end

  def new_post
    @challenge = Challenge.find_by(id: params[:id])
    @post = Post.new
  end

  private def challenge_params
    params.require(:challenge).permit(:title, :body, :picture)
  end

  def correct_user
    @challenge = current_user.challenges.find_by(id: params[:id])
    redirect_to root_url if @challenge.nil?
  end
end
