Rails.application.routes.draw do
  root "home#index"

  post "register" => "home#register"
  post "login" => "session#create"
  post "logout" => "session#destroy"

  namespace "dashboard" do
    get "home"
    get "createEvent"
    post "createEvent"
    get "editEvent"
    post "editEvent"
    get "viewEvent"
    get "allEvents"
  end

  # catch all to root
  get "*path" => redirect("/")
end
