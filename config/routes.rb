Rails.application.routes.draw do
  post 'api/events' => 'api_events/events#create'
end
