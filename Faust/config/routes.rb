Rails.application.routes.draw do
  root 'products#list'
  get 'products/:id' => 'products#detail'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
