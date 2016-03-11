class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @comments = @commentable.comments.reorder(:created_at).includes(:user, :images)
    @comments.map{|c| c.inline = true}
  end

  def create
    @comment = Comment.new comment_params
    if @comment.save
      # @comment.commentable.create_activity :comment, owner: current_user, recipient: @comment
    end
  end

  def destroy
    @comment = Comment.find(params[:id]).destroy
  end

  private

  def render_inline?
    params[:inline] == 'true'
  end

  def comment_params
    params.require(:comment).permit(
      :commentable_id,
      :commentable_type,
      :content,
      images_files: []).merge(user_id: current_user.id)
  end
end
