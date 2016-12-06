Rails.application.routes.draw do

  resources :faculties
  root "students#show_home"

  resources :course_histories
  resources :course_descriptions
  resources :documents
  resources :jobs
  resources :students
  post "course_descriptions/search" => "course_descriptions#search"
  post "course_descriptions/transfer" => "course_descriptions#transfer"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  delete "/course_histories" => "course_histories#search_and_destroy"
  post "students/:id/upload_photo" => "students#upload_photo"
  get 'course_descriptions/typeahead/:query' => 'course_descriptions#typeahead'
  get 'faculties/typeahead/:query' => 'faculties#typeahead'
  get 'search' => 'search#searchStudents'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'login' => 'sessions#destroy'
  get '*path' => 'sessions#not_found'

end
