class CitiesController < ApplicationController
  def index
    @cities = City.all
  end

  def show
    @city = City.find_by(name: params[:id])
    @users = User.where(city_id: @city.id)
  end

  def new
    @city = City.new
  end

  def edit
    @city = City.find_by(name: params[:id])
  end

  def create
    @city = City.new(post_params)
    if @city.save
      puts "******* city saved"
      redirect_to city_path(@city.id)
    else
      puts "******* mauvaise city"
      puts "La city n'as pu être créee pour la ou les raisons suivantes:"
      @city.errors.full_messages.each do |message|
        puts "ERROR:  <>>>>  #{message}"
      end
      render new_city_path
    end
  end

  def update
    @city = City.find_by(name: params[:id])
    if @city.update(post_params)
      puts "******* city update"
      redirect_to city_path(@city.id)
    else
      puts "******* mauvaise city"
      puts "La city n'as pu être update pour la ou les raisons suivantes:"
      @city.errors.full_messages.each do |message|
        puts "ERROR:  <>>>>  #{message}"
      end
      render edit_city_path
    end
  end

  def destroy
    @city = City.find_by(name: params[:id]).destroy
    redirect_to cities_path
  end

  private

  def post_params
    params.require(:city).permit(:name, :zip_code)
  end
end
