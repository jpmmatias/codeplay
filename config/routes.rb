# get localhost:3000/api/courses

Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  devise_for :students

  namespace :admin do
    resources :courses do
      resources :lessons, only: %i[show new create]
    end
  end

  resources :courses, only: [:show] do
    resources :lessons, only: %i[show]
    post 'enroll', on: :member
    get 'my_courses', on: :collection
  end

  namespace :api do
    namespace :v1 do
      resources :courses, only: %i[index show create], param: :code
      resources :enrollments, only: %i[index]
    end
  end
end
