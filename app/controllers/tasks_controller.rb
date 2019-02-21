class TasksController < ApplicationController

  def index
    tasks = Task.where(inbox: false).order(:id)
    inbox = Task.where(inbox: true).order(:id)
    render json: {tasks: tasks.as_json, inbox: inbox.as_json}
  end

  def update # update completed, add/remove tags, what else...?
    task = Task.find(params[:id])
    tags = params[:tags]

    task.completed = !task.completed if params[:completed]
    if tags
      tags.each do |tag|
        task.tags << Tag.find(tag[:id])
      end
    end
    task.inbox = false
    task.save

    tasks = Task.where(inbox: false).order(:id)
    inbox = Task.where(inbox: true).order(:id)

    render json: {tasks: tasks.as_json, inbox: inbox.as_json}
  end

  def create
    task = Task.new
    task.name = params[:name]
    task.save
    tasks = Task.where(inbox: false).order(:id)
    inbox = Task.where(inbox: true).order(:id)
    render json: {tasks: tasks.as_json, inbox: inbox.as_json}
  end
end
