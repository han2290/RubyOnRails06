Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   
    #home_controller
    root 'home#index' #get '/' => 'home#index'
    get '/lunch' => 'home#menu'
    get '/lotto_sample' => 'home#lotto'
    
    #user_controller
    get '/users' => 'user#index'
    get '/users/new' => 'user#new'
    get '/user/:id' =>'user#show' #RESTful
    post '/user/create' => 'user#create'
    
    #Lotto
    get '/lotto' => 'lotto#index'
    post '/lotto/new' => 'lotto#new'
    
  
end
