Rails.application.routes.draw do
  scope(:module => 'refinery') do
    get '/contact', :to => 'inquiries#new', :as => 'new_inquiry'
    resources :contact,
              :only => :create,
              :as => :inquiries,
              :controller => 'inquiries' do
      get :thank_you, :on => :collection
    end

    scope(:path => 'refinery', :as => 'refinery_admin', :module => 'admin') do
      resources :inquiries, :only => [:index, :show, :destroy] do
        get :spam, :on => :collection
        get :toggle_spam, :on => :member
      end
      resources :inquiry_settings, :only => [:edit, :update]
    end
  end
end
