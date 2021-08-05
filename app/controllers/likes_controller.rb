class LikesController < ApplicationController
  before_action :authenticate_user, only: [:create, :destroy]
  
  ########################################
  def create
    @like = Like.new(user_id: current_user.id, gossip_id: params[:gossip_id])
    if @like.save 
      puts "******* like saved"
      redirect_back(fallback_location: home_path)
      else
        puts "******* mauvais like"
        puts "Le like n'as pu être crée pour la ou les raisons suivantes:"
        @like.errors.full_messages.each do |message|
        puts "ERROR:  <>>>>  #{message}"
        end
        redirect_back(fallback_location: home_path)
      end
  end

  ########################################
  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_back(fallback_location: home_path)
  end

  
  ########################################

  private

  ########################################
    def authenticate_user
      unless current_user
        #flash[:danger] = "Please log in."
        redirect_to new_session_path
      end
    end
  
  ########################################
    
  
end
