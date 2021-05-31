Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :people do
        collection do
          get :frequency_count_by_emails
          get :matched_records
        end
      end
    end
  end
end
