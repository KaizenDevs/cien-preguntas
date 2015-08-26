class Content < ActiveRecord::Base
  validates_presence_of :title, :content, :content_order
  enum content_order: [:izquierda, :derecha]
end
