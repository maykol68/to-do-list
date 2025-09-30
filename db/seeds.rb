# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Task.create(title: "Tarea 1", description: "Descripción de tarea 1", completed: false)
Task.create(title: "Tarea 2", description: "Descripción de tarea 2", completed: false)
Task.create(title: "Tarea 3", description: "Descripción de tarea 3", completed: false)
Task.create(title: "Tarea 4", description: "Descripción de tarea 4", completed: false)
Task.create(title: "Tarea 5", description: "Descripción de tarea 5", completed: false)
Task.create(title: "Tarea 6", description: "Descripción de tarea 6", completed: false)
Task.create(title: "Tarea 7", description: "Descripción de tarea 7", completed: false)
Task.create(title: "Tarea 8", description: "Descripción de tarea 8", completed: false)
Task.create(title: "Tarea 9", description: "Descripción de tarea 9", completed: false)
Task.create(title: "Tarea 10", description: "Descripción de tarea 10", completed: false)


puts "Seeds creados: #{Task.count} tareas"
