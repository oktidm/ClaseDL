class CommentsController < ApplicationController
load_and_authorize_resource

	def create
		load_post
		build_comment

		if @comment.save
			redirect_to @post, notice: "Success"
		else 
			redirect_to @post, alert: "Wrong"
		end
	end

	private  

	def build_comment
		@comment = @post.comments.build(comment_params)
	end

	def comment_params
			params.require(:comment).permit(:content, :photo, :photo_cache)
		end

	def load_post
		@post = Post.find(params['post_id'])

		
	end

end