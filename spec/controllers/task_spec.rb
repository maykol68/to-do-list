require 'rails_helper'

RSpec.describe "Tasks API", type: :request do
  describe "GET /tasks" do
    it "devuelve todas las tareas" do
      Task.create!(title: "Tarea 1", description: "Descripción 1")
      Task.create!(title: "Tarea 2", description: "Descripción 2")

      get "/tasks"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "GET /tasks/:id" do
    it "devuelve una tarea específica" do
      task = Task.create!(title: "Tarea única", description: "Algo")

      get "/tasks/#{task.id}"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["title"]).to eq("Tarea única")
    end
  end

  describe "POST /tasks" do
    it "crea una nueva tarea con datos válidos" do
      valid_params = { task: { title: "Nueva tarea", description: "Descripción" } }

      expect {
        post "/tasks", params: valid_params
      }.to change(Task, :count).by(1)

      expect(response).to have_http_status(:created)
    end

    it "no crea una tarea con datos inválidos" do
      invalid_params = { task: { title: "" } }

      expect {
        post "/tasks", params: invalid_params
      }.not_to change(Task, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
