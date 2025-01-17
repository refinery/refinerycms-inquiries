Refinery::Core::Engine.routes.draw do
  # Frontend routes
  namespace :inquiries, :path => '' do
    localizable do
      get Refinery::Inquiries.page_path_new, :to => 'inquiries#new', :as => 'new_inquiry'

      resources :contact, :path => Refinery::Inquiries.post_path, :only => [:create],
                :as => :inquiries, :controller => 'inquiries'

      resources :contact, :path => '', :only => [], :as => :inquiries, :controller => 'inquiries' do
        get :thank_you, :path => Refinery::Inquiries.page_path_thank_you, :on => :collection
      end
    end
  end

  # Admin routes
  namespace :inquiries, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :inquiries, :only => [:index, :show, :destroy] do
        get :spam, :on => :collection
        get :toggle_spam, :on => :member
      end

      scope :path => 'inquiries' do
        resources :settings, :only => [:edit, :update]
      end
    end
  end
end