class TweetsController < ApplicationController
  before_action :set_tweet1, only: [:show, :edit] 
  before_action :set_tweet2, only: [:update, :destroy] 
  before_action :move_to_index, except: [:index, :show, :search]

	def index
    @tweets = Tweet.includes(:user).order("created_at DESC").page(params[:page])
  end

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(tweet_params)
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end

  def edit
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
  end

  def search
    @tweets = Tweet.search(params[:keyword])
  end

  private
  def tweet_params
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
  end

  def set_tweet1
    @tweet = Tweet.find(params[:id])
  end

  def set_tweet2
    tweet = Tweet.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
