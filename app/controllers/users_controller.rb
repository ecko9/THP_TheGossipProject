class UsersController < ApplicationController
  
  def index
    # Méthode qui récupère tous les potins et les envoie à la view index (index.html.erb) pour affichage
  end

  def show
    @user = User.find(params[:id])
    # Méthode qui récupère le potin concerné et l'envoie à la view show (show.html.erb) pour affichage
  end

  def new
    @user = User.new
    # Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
  end

  def create
    if params[:user][:password] == params[:user][:password_confirm]
      @user = User.new(user_params)
      if @user.save
        log_in(@user)
        if params[:user][:stay_connect] == 1
          remember_him(@user)
        end
        puts "******* user saved and connected"
        redirect_to user_path(@user.id)
      else
        puts "******* mauvais user"
        puts "L'user n'as pu être créé(e) pour la ou les raisons suivantes:"
        @user.errors.full_messages.each do |message|
        puts "ERROR:  <>>>>  #{message}"
        end
        render new_user_path
      end
    end
  end

  def edit
    # Méthode qui récupère le potin concerné et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition
  end

  def update
    # Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params
    # Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher le potin modifié)
  end

  def destroy
    # Méthode qui récupère le potin concerné et le détruit en base
    # Une fois la suppression faite, on redirige généralement vers la méthode index (pour afficher la liste à jour)
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :age, :email, :city_id, :password, :description)
  end

end
