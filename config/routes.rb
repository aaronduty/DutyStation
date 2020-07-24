Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :projects, except: [:new, :edit] do
    resources :statuses, except: [:new, :edit] do
      resources :tasks, except: [:new, :edit]
    end
  end
end
