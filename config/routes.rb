Rails.application.routes.draw do

  root "students#show_home"

  resources :course_histories
  resources :course_descriptions
  resources :documents
  resources :jobs
  resources :students
  post "course_descriptions/search" => "course_descriptions#search"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  delete "/course_histories" => "course_histories#search_and_destroy"
  get "re/:id" => "students#revised_edit"
  post "students/:id/upload_photo" => "students#upload_photo"
end
