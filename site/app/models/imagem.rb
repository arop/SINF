class Imagem < ActiveRecord::Base
	mount_uploader :image, ImageUploader
end
