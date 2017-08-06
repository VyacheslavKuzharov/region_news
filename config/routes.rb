Rails.application.routes.draw do
  # mount SwaggerUiEngine::Engine, at: '/api_docs'
  get '/apidoc' => redirect('/swagger2/dist/index.html?url=/apidocs/api-docs.json')

  namespace :api do
    namespace :v1 do
      resources :news
    end
  end
end
