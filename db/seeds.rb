# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


thorp = Student.create(firstName: "Holden",
                       lastName: "Thorp",
                       age: 49)

Job.create( title: "Resident Advisor",
            student: thorp)