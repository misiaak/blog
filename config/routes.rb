Easyblog::Application.routes.draw do
  root :to => "home#index"
  devise_for :users
  resources :users
  resources :posts do
    member do
      post :mark_archived
    end
    resource :comments do
      member do
        post ':id/mark_as_not_abusive', :action => 'mark_as_not_abusive', :as => 'mark_as_not_abusive'
        post ':id/voteup', :action => 'vote_up',   :as => 'voteup'
        post ':id/votedown', :action => 'vote_down', :as => 'votedown'
      end
    end
  end
end
