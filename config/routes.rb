require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  resources :podcast_links, only: :index, :defaults => { :format => :json }
end
