class UserProductsController < ApplicationController

	protect_from_forgery with: :null_session, on: :create

	def index
		@user_products = UserProduct.all
	end

	def create
		# 用户id、产品id、时间间隔
		user_id = params['user_id']
		product_id = params['product_id']
		duration = params['duration']

		# if not duration.is_a? Integer
		# 	render json: {code: 500, msg: '时间间隔不是整数'} and return
		# else
			duration = duration.to_i / 24 
		# end

		user_product = UserProduct.find_by user_id: user_id, product_id: product_id

		if not user_product.nil?
			if not user_product.duration.nil?
				render json: {code: 500, msg: '用户产品信息已存在'} and return
			end
			user_product.duration = duration
			user_product.deadline = DateTime.now + duration.days
			user_product.save!
			render json: {code: 200, msg: "天数#{duration}"} and return
		end

		render json: {code: 500, msg: '用户产品信息不存在'}

	end

end
