module Blog
  class PostsController < ApplicationController
    def index
      @blog = ::Blog::Blog.find(params[:blog_id])
      @posts = policy_scope(Post)
      authorize @posts

      render :index, layout: 'blog'
    end
    
    def show
      @blog = ::Blog::Blog.find(params[:blog_id])
      @post = ::Blog::Post.find(params[:id])
      authorize @post
      render :show, layout: 'blog'
    end

    def new
      @blog = ::Blog::Blog.find(params[:blog_id])
      @post = @blog.posts.build
      authorize @post
      render :new, layout: 'blog'
    end

    def create
      @blog = ::Blog::Blog.find(params[:blog_id])
      @post = ::Blog::Post.new
      @post.update_attributes(post_params)
      @post.blog_id = @blog.id
      authorize @post

      respond_to do |format|
        if @post.save
          format.html { redirect_to blog.blog_posts_path(@blog), notice: 'Post was successfully created.' }
          # format.json { render json: page, status: :created, location: page }
        else
          format.html { render action: "new" }
          # format.json { render json: page.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit
      @blog = ::Blog::Blog.find(params[:blog_id])
      @post = Post.find(params[:id])
      authorize @post
      render :edit, layout: 'blog'
    end

    def update
      @blog = ::Blog::Blog.find(params[:blog_id])
      @post = Post.find(params[:id])
      authorize @post

      if @post.update_attributes(permitted_attributes(@post))
        redirect_to blog.blog_post_path(@blog, @post), notice: 'Post was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @post = Page.find(params[:id])
      authorize @post

      @post.delete
      redirect_to pages.pages_path, notice: 'Page was successfully deleted.'
    end

    def by_year_and_month
      @blog = ::Blog::Blog.find(params[:blog_id])
      @posts =  PostPolicy::Scope.new(current_user, ::Blog::Post).by_year_and_month(params[:year], params[:month])

      authorize @posts

      render :index, layout: 'blog'
    end

    def by_tag
      @blog = ::Blog::Blog.find(params[:blog_id])
      @posts =  PostPolicy::Scope.new(current_user, ::Blog::Post).by_tag(params[:tag])

      authorize @posts

      render :index, layout: 'blog'      
    end

    private

    def post_params
      params.require(:post).permit(policy(@post).permitted_attributes)
    end
  end
end
