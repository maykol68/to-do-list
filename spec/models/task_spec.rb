require 'rails_helper'

RSpec.describe Task, type: :model do
  context "validaciones" do
    it "es válido con título, descripción y completed" do
      task = Task.new(title: "Prueba", description: "Descripción", completed: false)
      expect(task).to be_valid
    end

    it "no es válido sin título" do
      task = Task.new(description: "Descripción", completed: true)
      expect(task).not_to be_valid
    end

    it "no es válido sin descripción" do
      task = Task.new(title: "Prueba", completed: true)
      expect(task).not_to be_valid
    end


    it "no es valido description muy larga" do 
      long_a = "a" *100 
      task = Task.new(title: "Prueba", description: long_a, completed: true)
      expect(task).not_to be_valid
    end

    it "es válido con completed en true o false" do
      task_true = Task.new(title: "Tarea true", description: "Ok", completed: true)
      task_false = Task.new(title: "Tarea false", description: "Ok", completed: false)

      expect(task_true).to be_valid
      expect(task_false).to be_valid
    end

    it "no es válido si completed es nil" do
      task = Task.new(title: "Tarea nil", description: "Ok", completed: nil)
      expect(task).not_to be_valid
    end
  end
end
