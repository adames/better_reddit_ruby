Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/posts/next_page', to: 'posts#next_page'

  get '/posts/store', to: 'posts#store'

  get '/posts/get_comment', to: 'posts#get_comment'
  resources :posts, only: [:post, :create, :index]


end
