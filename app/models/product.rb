class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :version

  has_many :user_products

  def self.test
  	product = Product.new
  	product.name = 'webchat'
  	product.version = '1.2'
    product.created_at = Time.now
    product.updated_at = Time.now
  	product.save
  end
end
