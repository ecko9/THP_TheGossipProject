class CommentsController < ApplicationController
  def create
    p params
    @user = User.find_by(first_name: params[:comment][:comment_author])
    @gossip = Gossip.find(params[:comment][:gossip_id])
    @comment = Comment.new(content: params[:comment][:content], user_id: 5, gossip_id: @gossip.id)
    
    if @comment.save # essaie de sauvegarder en base @gossip
      puts "******* comment saved"
      redirect_to gossip_path(@gossip.id)
      # si ça marche, il redirige vers la page d'index du site
    else
      puts "******* mauvais comment"
      puts "Le comment n'as pu être crée pour la ou les raisons suivantes:"
      @comment.errors.full_messages.each do |message|
        puts "ERROR:  <>>>>  #{message}"
    end
      render gossip_path(@gossip.id)
      # sinon, il render la view new (qui est celle sur laquelle on est déjà)
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
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

  def destroy
    p params
    @comment = Comment.find(params[:id])
    @gossip = Gossip.find(@comment.gossip_id)
    @comment.destroy
    redirect_to gossip_path(@gossip.id)
  end
end
