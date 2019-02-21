Rails.application.routes.draw do
  get "/tasks" => "tasks#index"
  post "/tasks" => "tasks#create"
  patch "/tasks/:id" => "tasks#update"

  get "/tags" => "tags#index"
end
