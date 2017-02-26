class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all.order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: "El articulo fue publicado con éxito"
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    #@post = Post.find(params[:id])
    @post = current_user.posts.find(params[:id])
  end

  def update
    #@post = Post.find(params[:id])
    @post = current_user.posts.find(params[:id])

    if @post.update(params[:post].permit(:title, :body))
      redirect_to posts_path, notice: "El articulo fue editado con éxito"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path, notice: "El articulo fue eliminado con éxito"
  end

  private
    def post_params
      params.require(:post).permit(:title, :body, :user_id)
    end
end
