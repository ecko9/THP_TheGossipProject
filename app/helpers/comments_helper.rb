module CommentsHelper
  def current_comment
    Comment.find(params[:id])
  end
end
