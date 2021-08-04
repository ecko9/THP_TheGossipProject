class GossipController < ApplicationController
########################################
  def index
    @gossips = Gossip.all
    # Méthode qui récupère tous les potins et les envoie à la view index (index.html.erb) pour affichage
  end
########################################
  def show
    @gossip = Gossip.find(params[:id])
    @user = User.find(@gossip.user_id)
    @comments = Comment.where(gossip_id: @gossip.id)
    @comment = Comment.new
    # Méthode qui récupère le potin concerné et l'envoie à la view show (show.html.erb) pour affichage
  end
########################################
  def new
    @gossip = Gossip.new
    # Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
  end
########################################
  def create
    @user = User.find_by(first_name: params[:gossip][:gossip_author])
    @gossip = Gossip.new(title: params[:gossip][:title], content: params[:gossip][:content], user_id: 5)
    if @gossip.save # essaie de sauvegarder en base @gossip
      puts "******* gossip saved"
      redirect_to gossip_path(@gossip.id)
      # si ça marche, il redirige vers la page d'index du site
    else
      puts "******* mauvais gossip"
      puts "Le gosspip n'as pu être crée pour la ou les raisons suivantes:"
      @gossip.errors.full_messages.each do |message|
        puts "ERROR:  <>>>>  #{message}"
      end
      render new_gossip_path
      # sinon, il render la view new (qui est celle sur laquelle on est déjà)
    end
    # Méthode qui créé un potin à partir du contenu du formulaire de new.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params (ton meilleur pote)
    # Une fois la création faite, on redirige généralement vers la méthode show (pour afficher le potin créé)
  end
########################################
  def edit
    @gossip = Gossip.find(params[:id])
    # Méthode qui récupère le potin concerné et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition
  end
########################################
  def update
    @gossip = Gossip.find(params[:id])
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
    # Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params
    # Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher le potin modifié)
  end
########################################
  def destroy
    @gossip = Gossip.find(params[:id]).destroy
    redirect_to gossip_index_path
    # Méthode qui récupère le potin concerné et le détruit en base
    # Une fois la suppression faite, on redirige généralement vers la méthode index (pour afficher la liste à jour)
  end
########################################
########################################
  private

########################################  
  def post_params
    params.require(:gossip).permit(:title, :content)
  end
end
