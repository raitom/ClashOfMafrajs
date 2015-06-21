Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users

  get 'mafraj/index'
  get 'mafraj/ameliorer/:batiment', to: 'mafraj#ameliorer'
  get 'mafraj/archiver/:ressource', to: 'mafraj#archiver'

  get 'zamel/index'
  post 'zamel/construire'

  get 'attaquer/index'
  post 'attaquer/preparation'
  post 'attaquer/attaquer'

  get 'highscore/index'
end
