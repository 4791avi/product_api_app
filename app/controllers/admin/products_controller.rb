class Admin::ProductsController < Admin::ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :set_product, only: [:show,:edit,:update]
	def index
		@products = Product.all
	end

	def show
	end
	
	def edit
	end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to admin_products_path, notice: 'Product was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :sku_id, :price)
  end

	def set_product
    begin
      @product = Product.find(params[:id])
    rescue
      redirect_to admin_products_path, alert: "Product not found."
    end
  end
end

