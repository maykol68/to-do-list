require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "GET /tasks" do
    it "devuelve status 200 y renderiza index" do
      Task.create!(title: "Tarea 1", description: "Test 1", completed: false)
      Task.create!(title: "Tarea 2", description: "Test 2", completed: true)

      get "/tasks"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Tarea 1") 
      expect(response.body).to include("Tarea 2")
    end
  end
  
  describe "POST /tasks" do
    it "crea una nueva tarea con parámetros válidos" do
      expect {
        post "/tasks", params: { task: { title: "Nueva tarea", description: "Algo", completed: false } }
      }.to change(Task, :count).by(1)

      expect(response).to redirect_to("/tasks")
      follow_redirect!
      expect(response.body).to include("tasks has been created")
    end

    it "no crea tarea con parámetros inválidos" do
      expect {
        post "/tasks", params: { task: { title: "" } }
      }.not_to change(Task, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
