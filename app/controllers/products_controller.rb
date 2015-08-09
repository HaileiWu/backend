class ProductsController < ApplicationController
	before_action :authenticate_admin!
	before_action :set_product, only: [:update, :edit]

  def index
  	@products = Product.all
  end

  def new
  	@product = Product.new
  end

  def create
  	@product = Product.new(set_product_params)
  	if @product.save
  		redirect_to products_path
  	end
  end

  def update
  	@product.update set_product_params
  	redirect_to products_path
  end

  def edit
  	
  end

  private
  	def set_product
  		@product = Product.find params[:id]
  	end

  	def set_product_params
  		params.require(:product).permit(:name, :version)
  	end

end
