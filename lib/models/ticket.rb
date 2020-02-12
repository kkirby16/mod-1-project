class Ticket < ActiveRecord::Base #this method is correct I'm pretty sure.
  belongs_to :user #or would this be has_one user?
  belongs_to :ski_resort
end
