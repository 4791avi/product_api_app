class Product < ApplicationRecord
	serialize :category, Array
	serialize :tags, Array
	serialize :metadata, JSON

	has_one_attached :image	
end
