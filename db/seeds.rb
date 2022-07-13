# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Notification.all.each do |notification|
  notification.destroy
end

Expense.all.each do |expense|
  expense.destroy
end

Task.all.each do |task|
  task.destroy
end

Event.all.each do |event|
  event.destroy
end

User.all.each do |user|
  user.destroy
end
users =[
        ["Rohit Shaw","rohit1coding@gmail.com","rohit"],
        ["Bikash Shaw","bika6290@gmail.com","bikash"],
        ["Test 1","test1@gmail.com","testing"],
        ["Test 2","test2@gmail.com","testing"],
        ["Test 3","test3@gmail.com","testing"],
        ["Test 4","test4@gmail.com","testing"],
        ["Test 5","test5@gmail.com","testing"]
        
      ]
users.each do |user|
  User.create(name: user[0],email: user[1], password: user[2])
end

User.all.each do |user|
  user.events.create(name: "Picknik")
  user.events.create(name: "Trip")
  user.events.create(name: "Hiking")
  user.events.create(name: "Party")
  user.events.create(name: "Marriage")
  user.events.create(name: "Reception")
  user.events.create(name: "Birthday")
end

Event.all.each do |event|
  event.tasks.create(name: "Music")
  event.tasks.create(name: "Food")
  event.tasks.create(name: "Lights")
  event.tasks.create(name: "Camera")
  event.tasks.create(name: "Travel")
  event.tasks.create(name: "Snax")
end

Event.all.each do |event|
  event.expenses.create(name: "Travel", amount: 5000)
  event.expenses.create(name: "Food", amount: 10000)
  event.expenses.create(name: "Cold Drink", amount: 1400)
end

Event.all.each do |event|
  event.tasks.first.update(completed: true)
  event.tasks.last.update(completed: true)
end