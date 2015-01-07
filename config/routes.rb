Rails.application.routes.draw do
  mount Base => '/'
  root 'home#index'
end
