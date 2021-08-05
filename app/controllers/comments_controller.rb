class CommentsController < ApplicationController
include CommentsHelper
before_action :authenticate_user, only: [:create, :edit, :update, :destroy]
before_action :is_same_user, only: [:edit, :update, :destroy]
#########################################  
  def create
    @gossip = Gossip.find(params[:comment][:gossip_id])
    @comment = Comment.new(content: params[:comment][:content], user_id: current_user.id, gossip_id: @gossip.id)
    
    if @comment.save 
      puts "******* comment saved"
      redirect_to gossip_path(@gossip.id)
    else
      puts "******* mauvais comment"
      puts "Le comment n'as pu être crée pour la ou les raisons suivantes:"
      @comment.errors.full_messages.each do |message|
        puts "ERROR:  <>>>>  #{message}"
      end
      render gossip_path(@gossip.id)
    end
  end
#########################################
  def edit
    @comment = current_comment
    @gossip = @comment.gossip
  end

#########################################
  def update
    @comment = current_comment
    if @comment.update(content: params[:comment][:content])
      puts "******* comment update"
      redirect_to gossip_path(@comment.gossip_id)
    else
      puts "******* mauvais comment"
      puts "Le comment n'as pu être update pour la ou les raisons suivantes:"
      @comment.errors.full_messages.each do |message|
        puts "ERROR:  <>>>>  #{message}"
      end
      render edit_comment_path(@comment.id)
    end
  end

#########################################
  def destroy
      @comment = current_comment
      @gossip = Gossip.find(@comment.gossip_id)
      @comment.destroy
      redirect_to gossip_path(@gossip.id)
  end

#########################################

  private

########################################
  def authenticate_user
    unless current_user
      #flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end

########################################
  def is_same_user
    if current_comment.user != current_user
      puts "Wrong user"
      redirect_to gossip_path(current_comment.gossip_id)
    end
  end
########################################

end
