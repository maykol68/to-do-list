require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "GET /tasks" do
    it "devuelve status 200 y renderiza index con las tareas" do
      Task.create!(title: "Tarea 1", description: "Test 1", completed: false)
      Task.create!(title: "Tarea 2", description: "Test 2", completed: true)

      get tasks_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Tarea 1")
      expect(response.body).to include("Tarea 2")
    end
  end

  describe "GET /tasks/:id" do
    it "muestra la tarea específica" do
      task = Task.create!(title: "Tarea show", description: "Detalle", completed: false)

      get task_path(task)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Tarea show")
    end
  end

  describe "POST /tasks" do
    context "con parámetros válidos" do
      it "crea una nueva tarea y redirige al index" do
        expect {
          post tasks_path, params: { task: { title: "Nueva tarea", description: "Algo", completed: false } }
        }.to change(Task, :count).by(1)

        expect(response).to redirect_to(tasks_path)
        follow_redirect!
        expect(response.body).to include("tasks has been created")
      end
    end

    context "con parámetros inválidos" do
      it "no crea tarea y renderiza new" do
        expect {
          post tasks_path, params: { task: { title: "" } }
        }.not_to change(Task, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /tasks/:id" do
    let!(:task) { Task.create!(title: "Vieja tarea", description: "Desc", completed: false) }

    context "con parámetros válidos" do
      it "actualiza la tarea y redirige a show" do
        patch task_path(task), params: { task: { title: "Título actualizado" } }
        task.reload
        expect(task.title).to eq("Título actualizado")
        expect(response).to redirect_to(task_path(task))
        follow_redirect!
        expect(response.body).to include("Task actualizada correctamente")
      end
    end

    context "con parámetros inválidos" do
      it "no actualiza y renderiza edit" do
        patch task_path(task), params: { task: { title: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Edit").or include("error")
      end
    end
  end

  describe "DELETE /tasks/:id" do
    let!(:task) { Task.create!(title: "Borrar", description: "Se va", completed: false) }

    it "elimina la tarea y redirige al index" do
      expect {
        delete task_path(task)
      }.to change(Task, :count).by(-1)

      expect(response).to redirect_to(tasks_path)
      follow_redirect!
      expect(response.body).to include("Task eliminada correctamente")
    end
  end
end
