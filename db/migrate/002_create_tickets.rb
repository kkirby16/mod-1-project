class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.integer :ski_resort_id #user sample for resort and user id which will give you random ones.
      t.integer :user_id
      t.float :price
      t.string :category #this is like if the ticket is a half day, full day, night skiing, etc type
      t.timestamps
    end
  end
end
