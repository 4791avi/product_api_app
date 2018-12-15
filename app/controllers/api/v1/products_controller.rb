require 'open-uri'
class Api::V1::ProductsController < Api::V1::ApplicationController
	skip_before_action :verify_authenticity_token
  def create
		product = Product.new(name: params[:parameters]["name"],sku_id: params[:parameters]["sku_id"],categories: params[:parameters]["categories"],tags: params[:parameters]["tags"],price: params[:parameters]["price"],expire_date: params[:parameters]["expire_date"],metadata: params[:parameters])
		puts  params[:parameters]["images"]
		puts image_url = params[:parameters]["images"]
		puts image_url = image_url[0]["img_path"]
		puts image_url.class
		downloaded_image = open(image_url)
		product.image.attach(io: downloaded_image  , filename: "mona.jpg")
		# abort
		# puts "---------------"
		# puts image_url
		# download_image = open(image_url)
		# abort download_image
		# product.image.attach(download_image)
	if product.save
		render json: {status: 'SUCCESS', message: 'Save product',date: product},status: :ok
	else
		render json: {status: 'ERROR', message: 'Product not saved',date: product.errors},status: :unprocessable_entity
	end  	
  end
end