class CommentsController < ApplicationController
  
  def create
  	@comment_hash = params[:comment]
  	if (params[:comment].has_key?(:parent_id) && !params[:comment][:parent_id].blank?)
    	@parent = Comment.find(params[:comment][:parent_id])
	end
  	@obj = @comment_hash[:commentable_type].constantize.find(@comment_hash[:commentable_id])
  	 # Not implemented: check to see whether the user has permission to create a comment on this object
  	@comment = Comment.build_from(@obj, current_user.id, @comment_hash[:body])

  	if @comment.save
        # render :partial => "comments/comment", :locals => { :comment => @comment }, :layout => false, :status => :created
        if @parent
        	@comment.move_to_child_of(@parent)
      	end
        respond_to do |format|
        	format.js
        end
    else
        render :js => "alert('error saving comment');"
    end
  end

  def child_comments
  	@id_post = params[:p_id]
  	@post = Post.find(params[:post_id])
  	@new_comment = Comment.build_from(@post, current_user, '')

  	respond_to do |format|
  		format.html
        format.js
    end
  end

end
