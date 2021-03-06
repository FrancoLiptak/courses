# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'admin@admin.com', password: 123456)

Course.create year: Time.zone.today.year
Course.create year: (Time.zone.today.year - 1)

30.times do |i|
  course = Course.all.sample
  name = Faker::GameOfThrones.character
  split_name = name.split(/\W+/)
  email = name.delete(' ') + '@gmail.com'
  Student.create( name: split_name.first, 
                  last_name: split_name.last,
                  course: course, 
                  dni: rand(35000000..40000000),
                  email: email, 
                  student_number: "#{ rand(12000..15000) }/#{ rand(1..10) }"
                )
end

Course.all.each do |course|
  3.times do |i|
    EvaluationInstance.create(course: course,
                              title: "Instance #{i +1}", 
                              passing_score: rand(40...60), 
                              top_score: rand(61...100),  
                              date: Time.at(rand((Time.new(course.year, 1, 1))..(Time.new(course.year, 12, 31))))
                              )
  end
end
  
Course.all.each do |c|
  c.evaluation_instances.each do |e|
    c.students.shuffle.first(5).each do |s|
      e.scores.build(score: rand(40..60).to_i, student: s )
      e.save
    end
  end
end

