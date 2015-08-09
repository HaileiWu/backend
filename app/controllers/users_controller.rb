class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def create
		# 用户名、密码、软件编号、设备号
		username = params['username']
		password = params['password']
		product_id = params['product_id']
		device = params['device']

		if username.nil? or password.nil? or version.nil? or device.nil?
			render json: {'code'=> 500, 'msg'=> '参数有空值'} and return
		end

		# 校验用户名、密码是否存在
		user = User.find_by 'username': username, 'device': device
		if user.nil?
			user = User.new 'username': username, 'password': password, 'device': device
		end

		if user.save 
			user_product = UserProduct.find_by user_id: user.id, product_id: product_id
			if user_product.nil?
				user_product = UserProduct.new user_id: user.id, product_id: product_id
				user_product.save!
			else
				render json: {'code'=> 500, 'msg'=> '用户产品信息已存在'} and return
			end
		end

		# 获取返回值
		user_products = UserProduct.find_by user_id: user.id
		result = {user_id: user.id, products: []}
		user_products.each {|user_product| result['products'] >> user_product}

		render json: result
	end
end
