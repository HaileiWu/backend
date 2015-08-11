# encoding: utf-8
class UsersController < ApplicationController

	protect_from_forgery with: :null_session, on: :create

	def index
		@users = User.all
	end

	def create
		# 用户名、密码、软件编号、设备号
		username = params['username']
		password = params['password']
		product_id = params['product_id']
		device = params['device']

		if username.nil? or password.nil? or product_id.nil? or device.nil?
			render json: {'code'=> 500, 'msg'=> '参数有空值'} and return
		end

		# 校验用户名、密码是否存在
		user = User.find_by username: username, device: device
		if user.nil?
			user = User.new username: username, password: password, device: device
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
		user_products = UserProduct.where user_id: user.id
		result = {'user_id' => user.id.to_s, 'products' => []}
		user_products.each do |user_product| 
			product = user_product.product
			product.id = product.id.to_s
			result['products'] << product
		end

		render json: result
	end
end
