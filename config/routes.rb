Rails.application.routes.draw do
  resources :taggings
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'taggings#index'
  get 'stats', to: 'taggings#stats'
  get 'stats/*entity_type/:entity_id', to: 'taggings#stats2'
  get 'taggings/*entity_type/:entity_id', to: 'taggings#show2'
  delete 'taggings/*entity_type/:entity_id', to: 'taggings#destroy2'
  put 'taggings/*entity_type/:entity_id', to: 'taggings#update2'
end
