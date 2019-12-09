class TasksController < ApplicationController

  def index
    render json: tasks_and_inbox_as_json
  end

  def update # update completed, add/remove tags, what else...?
    toggle_complete!
    add_tags!

    render json: tasks_and_inbox_as_json
  end

  def create
    Task.create(name: permitted_params[:name])
    render json: tasks_and_inbox_as_json
  end

  private

  def tasks_and_inbox_as_json
    { 
      tasks: Task.where(inbox: false).as_json,
      inbox: Task.where(inbox: true).as_json 
    }
  end

  def permitted_params
    params.permit(:id, :completed, :name, tags: :id)
  end

  def task
    @task ||= Task.find(permitted_params[:id])
  end

  def toggle_complete!
    return unless permitted_params[:completed]

    task.toggle!(:completed)
  end

  def add_tags!
    return unless tags

    tags.each { |tag| task.tags << Tag.find(tag[:id]) }
    task.toggle!(:inbox) if task.inbox
  end

  def tags
    permitted_params[:tags]
  end
end
