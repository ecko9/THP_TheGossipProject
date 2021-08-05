class GossipController < ApplicationController
  include GossipHelper
  before_action :authenticate_user, only: [:new, :create, :edit, :update, :destroy, :show]
  before_action :is_same_user, only: [:edit, :update, :destroy]
########################################
  def index
    @gossips = Gossip.all
  end

########################################
  def show
    @gossip = current_gossip
    @like = Like.find_by(gossip_id: @gossip.id, user_id: current_user.id)
    @user = User.find(@gossip.user_id)
    @comments = Comment.where(gossip_id: @gossip.id)
    @comment = Comment.new
  end

########################################
  def new
      @gossip = Gossip.new
  end

########################################
  def create
      @gossip = Gossip.new(post_params)
      @gossip.user = current_user
      if @gossip.save 
        puts "******* gossip saved"
        redirect_to gossip_path(@gossip.id)
      else
          puts "******* mauvais gossip"
          puts "Le gosspip n'as pu être crée pour la ou les raisons suivantes:"
          @gossip.errors.full_messages.each do |message|
          puts "ERROR:  <>>>>  #{message}"
          end
        render new_gossip_path
      end
  end

########################################
  def edit
      @gossip = current_gossip
  end

########################################
  def update
      @gossip = current_gossip
      if @gossip.update(post_params)
        puts "******* gossip update"
        redirect_to gossip_path(@gossip.id)
      else
        puts "******* mauvais gossip"
        puts "Le gossip n'as pu être update pour la ou les raisons suivantes:"
        @gossip.errors.full_messages.each do |message|
          puts "ERROR:  <>>>>  #{message}"
        end
        render edit_gossip_path
      end
  end

########################################
  def destroy
    @gossip = current_gossip.destroy
    redirect_to gossip_index_path
  end

########################################
########################################

  private

########################################  
  def post_params
    params.require(:gossip).permit(:title, :content)
  end

######################################## 
  def authenticate_user
    unless current_user
      #flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end

########################################
  def is_same_user
    if current_gossip.user != current_user
      puts "Wrong user"
      redirect_to gossip_path(params[:id])
    end
  end
######################################## 

end
