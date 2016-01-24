class CommentsController < ApplicationController

	http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy

	def new
	@comment = Comment.new
	end

	def create
	@article = Article.find(params[:article_id])
	@comment = @article.comments.create(comment_params)
	redirect_to article_path(@article)
	end

	def destroy
	@article = Article.find(params[:article_id])
	@comment = @article.comments.find(params[:id])
	@comment.destroy
	redirect_to article_path(@article)
	end

	def show
	@comment = Comment.find(params[:id])
	end


	def edit
	@article = Article.find(params[:article_id])
	@comment = @article.comments.find(params[:id])
	end

	def update
	@comment = Comment.find(params[:id])
	@article = @comment.article
	if @comment.update_attributes(params[:comment].permit(:vaihe, :image))
			redirect_to @article
		else
			render 'edit'
		end
	end

	private
		def comment_params
		  params.require(:comment).permit(:vaihe, :image)
		end
	end