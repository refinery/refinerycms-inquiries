Refinery::Application.routes.draw do
  get '/contact', :to => 'inquiries#new', :as => 'new_inquiry'
  resources :contact,
            :only => :create,
            :as => :inquiries,
            :controller => 'inquiries' do
    collection do
      get :thank_you
    end
  end

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :inquiries, :only => [:index, :show, :destroy] do
      collection do
        get :spam
      end
      member do
        get :toggle_spam
      end
    end
    resources :inquiry_settings, :only => [:edit, :update]
  end
end
