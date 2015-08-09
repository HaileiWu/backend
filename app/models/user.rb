class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :username, type: String
  field :password, type: String
  field :device, type: String
  # field :products, type: Array

  has_many :user_products

  def self.test
  	user = User.new
  	user.username = 'wuhailei'
  	user.password = '123456'
  	user.save
  end 

end
