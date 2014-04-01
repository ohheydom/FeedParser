FeedParser::Application.routes.draw do
  resources :feeds
  root 'feeds#index'
  post 'update_feed_order', to: 'feeds#update_feed_order', as: :update_feed_order
end
