class UserProduct
  include Mongoid::Document
  include Mongoid::Timestamps


  field :duration, type: Integer
  field :deadline, type: DateTime

  belongs_to :user
  belongs_to :product
end
