Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :projects, except: [:new, :edit] do
    put '/statuses/order', action: :update_order, controller: 'statuses'
    patch '/statuses/order', action: :update_order, controller: 'statuses'

    resources :statuses, except: [:new, :edit] do
    end

    resources :tasks, except: [:new, :edit] do
      put '/order', action: :update_order
      patch '/order', action: :update_order
    end
  end
end
