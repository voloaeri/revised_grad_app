# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# File.readlines((Rails.public_path + "defaults/faculty_list.txt")) do |line|
#   puts line
# end

File.foreach((Rails.public_path + "defaults/faculty_list.txt")).with_index do |line, line_num|
  #puts "#{line_num}: #{line.strip}"
  line = line.strip.split(" ")
  # puts line
  if(line.length == 3)
    Faculty.create(firstName: line[0], lastName: line[1], sectionNumber: line[2])
  elsif(line.length == 4)
    Faculty.create(firstName: line[0], lastName: line[2], sectionNumber: line[3])
  end
end

f= Faculty.create( :firstName => "Transfer", :lastName => "Credit", :sectionNumber => "0")

a= CourseDescription.create(number: 1, name: "Transfer", category: "N/A", hours: "1", department: "TRANSFER")
b= CourseDescription.create(number: 2, name: "Transfer", category: "N/A", hours: "2", department: "TRANSFER")
c= CourseDescription.create(number: 3, name: "Transfer", category: "N/A", hours: "3", department: "TRANSFER")
d= CourseDescription.create(number: 4, name: "Transfer", category: "N/A", hours: "4", department: "TRANSFER")


year= 2006
14.times do |x|



  Semester.create(course_description_id: a.id, faculty_id: f.id, year: year, semester: "N/A" )
  Semester.create(course_description_id: b.id, faculty_id: f.id, year: year, semester: "N/A" )
  Semester.create(course_description_id: c.id, faculty_id: f.id, year: year, semester: "N/A" )
  Semester.create(course_description_id: d.id, faculty_id: f.id, year: year, semester: "N/A" )
  year= year+1
end