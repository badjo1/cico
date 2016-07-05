# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create!(first_name:  "Bart",
              last_name: "Bloemers",
              email: "bart@badjo.nl",
              password:              "_Badjo01",
              password_confirmation: "_Badjo01",
              activated: true,
              activated_at: Time.zone.now)

venue = Venue.create!(name: "Shiatsu Centrum Amsterdam")


VenueUser.create!(venue: venue, user: user, role: 'admin', visit_on: Time.zone.now)
