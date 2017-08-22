Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts, only: [:post, :show, :index]


  get '/posts/next_page', to: 'posts#next_page'

end
