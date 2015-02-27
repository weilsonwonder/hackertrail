Rails.application.routes.draw do
  root "home#index"

  post "register" => "home#register"
  get "login" => "session#new"
  post "login" => "session#create"
  delete "logout" => "session#destroy"

  get "dashboard/home"
end
