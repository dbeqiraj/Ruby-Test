Rails.application.routes.draw do
  get '/'	=> 'home#index', :as => "home"
  post '/upload' => 'home#upload', :as => 'upload_file'
  get '/results/' => 'home#results', :as => 'show_results'
end
