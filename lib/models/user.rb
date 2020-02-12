class User < ActiveRecord::Base
  has_many :tickets
  has_many :ski_resorts, through: :tickets
end
