require "faker"

User.create(name: "Micky")
User.create(name: "Eugene")
User.create(name: "Stephen")
User.create(name: "Joy")
User.create(name: "Tom")
User.create(name: "Christina")
User.create(name: "Peter")
User.create(name: "Richard")
User.create(name: "Ben")
User.create(name: "Mike")

puts "successfully seeded users!"

20.times do
  SkiResort.create(name: Faker::Games::ElderScrolls.unique.city)
end

puts "successfully seeded Ski Resorts!"

categories = ["Half Day", "Full Day", "Night Skiing"]

#prices = {"Half Day": 40, "Full Day": 70, "Night Skiing": 20} #maybe add this in later as a stretch goal if I want to associate categories to prices later.

10.times do #use a hash to set categories equal to their prices. #make it work first and have it so I can see what is happening first.
  Ticket.create(user_id: User.all.sample.id, ski_resort_id: SkiResort.all.sample.id)
end
