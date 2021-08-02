Rails.application.routes.draw do
  root 'home#homepage'

  get 'welcome/:welcome_user', to: 'welcome#welcome_user'

  get 'team/members', to: 'team#members'
  get 'team/contact', to: 'team#contact'

  get 'gossip/:show_gossip', to: 'gossip#show_gossip'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end