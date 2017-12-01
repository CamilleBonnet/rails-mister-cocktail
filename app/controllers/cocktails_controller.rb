class CocktailsController < ApplicationController
  before_action :set_cocktail, only: [:show, :destroy]

  def index
    @cocktails = Cocktail.all
    @cocktail =  Cocktail.new
  end

  def show
    @dose = Dose.new
    @ingredients = Ingredient.all - @cocktail.ingredients
  end

  # def new
  #   @cocktail =  Cocktail.new
  # end

  def create
    @cocktail = Cocktail.new(params_cocktail)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      @cocktails = Cocktail.all
      render 'cocktails/index'
    end
  end

  def destroy
    @cocktail.destroy
    redirect_to cocktails_path
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def params_cocktail
    params.require(:cocktail).permit(:name)
  end
end
