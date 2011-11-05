Rails.application.routes.draw do

  scope(:module => 'refinery') do
    get '/contact', :to => 'inquiries#new', :as => 'new_inquiry'
    resources :contact,
              :only => :create,
              :as => :inquiries,
              :controller => 'inquiries' do
      collection do
        get :thank_you
      end
    end

    scope(:module => 'admin', :path => 'refinery', :as => 'refinery_admin') do
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

  scope(:module => 'admin', :path => 'refinery', :as => 'admin') do
    resources :inquiry_settings, :only => [:edit, :update]
  end
end
