class PostsController < ApplicationController

  # POST /post
  def create
    @post = Post.create_with_user! post_params, user_params
    json_response @post, :ok
  end

  # POST /post/:id/rate
  def rate
    @post = Post.find params[:id]
    @post.rate! params[:value]

    json_response average_rate: @post.average_rate
  end

  # GET /post/top?limit=10
  def top
    @posts = Post.top params.fetch(:limit, 10)
    json_response @posts, :ok, only: %i(average_rate subject body)
  end

  # GET /post/ips_by_logins?logins[]=user1&logins[]=user2
  def ips_by_logins
    data = Aggregator.ips_by_logins(params[:logins])
    json_response data
  end

  private

  def strong_params
    params.permit :login, :ip_address, :subject, :body
  end

  def post_params
    strong_params.except :login
  end

  def user_params
    strong_params.slice :login
  end
end
