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
    post "participateEvent"
    get "myTemplates"
    get "createTemplate"
    post "createTemplate"
    get "editTemplate"
    post "editTemplate"
  end

  # catch all to root
  get "*path" => redirect("/")
end
