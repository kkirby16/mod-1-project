class SkiResort < ActiveRecord::Base #these models files are just giving you a bunch of methods that you'll use through runtime of your code.
  has_many :tickets
  has_many :users, through: :tickets
end
