require 'json'

namespace :db do
  desc "Reads lib/assets/bootstrap.json and insert initial data into db"
  task :bootstrap => :environment do
    file = File.open('lib/assets/bootstrap.json', 'r')
    dinosaurs = JSON.parse(file.read)

    dinosaurs.each do |dinosaur|
      dinosaur.symbolize_keys!

      Dinosaur.create(
        name: dinosaur[:name],
        period: dinosaur[:period],
        continent: dinosaur[:continent],
        diet: dinosaur[:diet],
        weight: dinosaur[:weight],
        walking: dinosaur[:walking],
        description: dinosaur[:description],
      )
    end
  end

  task :initialize => [:drop, :create, :migrate, :bootstrap]
end
