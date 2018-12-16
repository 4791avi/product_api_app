require 'open-uri'
class Api::V1::ProductsController < Api::V1::ApplicationController
	skip_before_action :verify_authenticity_token
  def create
	sku_id = params[:parameters]["sku_id"]
	@product = Product.find_by(sku_id: sku_id)
	if @product
		update_product = @product.update(name: params[:parameters]["name"],categories: params[:parameters]["categories"],tags: params[:parameters]["tags"],price: params[:parameters]["price"],expire_date: params[:parameters]["expire_date"],metadata: params[:parameters])
		puts  params[:parameters]["images"]
		puts image_url = params[:parameters]["images"]
		puts image_url = image_url[0]["img_path"]
		downloaded_image = open(image_url)
		@product.image.purge
		update_product.image.attach(io: downloaded_image  , filename: "product_image.jpg")
		if update_product
			render json: {status: 'SUCCESS', message: 'Product Updated',data: @product},status: :ok
		else
			render json: {status: 'ERROR', message: 'Product not saved',data: @product.errors},status: :unprocessable_entity
		end 
	else			
		product = Product.new(name: params[:parameters]["name"],sku_id: params[:parameters]["sku_id"],categories: params[:parameters]["categories"],tags: params[:parameters]["tags"],price: params[:parameters]["price"],expire_date: params[:parameters]["expire_date"],metadata: params[:parameters])
		puts  params[:parameters]["images"]
		puts image_url = params[:parameters]["images"]
		puts image_url = image_url[0]["img_path"]
		downloaded_image = open(image_url)
		product.image.attach(io: downloaded_image  , filename: "mona.jpg")
		if product.save
			render json: {status: 'SUCCESS', message: 'Product saved',data: product},status: :ok
		else
			render json: {status: 'ERROR', message: 'Product not saved',data: product.errors},status: :unprocessable_entity
		end 
	end 	
  end
end