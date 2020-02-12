require "faker"

10.times do
  User.create(name: Faker::Name.name)
end

puts "successfully seeded users!"

20.times do
  SkiResort.create(name: Faker::Games::ElderScrolls.city)
end

puts "successfully seeded Ski Resorts!"

categories = ["Half Day", "Full Day", "Night Skiing"]

#prices = {"Half Day": 40, "Full Day": 70, "Night Skiing": 20} #maybe add this in later as a stretch goal if I want to associate categories to prices later.

10.times do #use a hash to set categories equal to their prices. #make it work first and have it so I can see what is happening first.
  Ticket.create(user_id: User.all.sample.id, ski_resort_id: SkiResort.all.sample.id, price: Faker::Number.within(range: 30..60), category: categories.sample)
end
