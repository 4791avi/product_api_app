class Product < ApplicationRecord
# Serializations
	serialize :category, Array
	serialize :tags, Array
	serialize :metadata, JSON
#Associations
	has_one_attached :image
#Validation
	validates :price, presence: true, numericality: { only_integer: true }
	validates :sku_id, presence: true
	validates :name, presence: true, format: { with: /\A[a-zA-Z ]+\z/ }
end
