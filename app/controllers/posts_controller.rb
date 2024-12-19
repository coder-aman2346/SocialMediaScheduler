class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post, only: %i[edit update destroy]
  
    def index
      @posts = current_user.posts.order(scheduled_at: :desc)
    end
  
    def new
      @post = current_user.posts.build
    end
  
    def create
      @post = current_user.posts.build(post_params)
      if @post.save
        schedule_post(@post)
        redirect_to posts_path, notice: 'Post successfully scheduled.'
      else
        render :new
      end
    end
  
    def edit; end
  
    def update
      if @post.update(post_params)
        redirect_to posts_path, notice: 'Post successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @post.destroy
      redirect_to posts_path, notice: 'Post successfully deleted.'
    end
  
    private
  
    def set_post
      @post = current_user.posts.find(params[:id])
    end
  
    def post_params
      params.require(:post).permit(:content, :scheduled_at, :published)
    end
  
    def schedule_post(post)
      PostSchedulerJob.set(wait_until: post.scheduled_at).perform_later(post.id)
    end
  end
  