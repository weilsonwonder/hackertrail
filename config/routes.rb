Rails.application.routes.draw do
  root "home#index"

  post "register" => "home#register"
  post "login" => "session#create"
  post "logout" => "session#destroy"

  get "dashboard/home"
end
