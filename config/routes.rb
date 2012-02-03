Refinery::Core::Engine.routes.draw do
  namespace :inquiries, :path => '' do
    get '/contact', :to => 'inquiries#new', :as => 'new_inquiry'

    resources :contact,
                :only => :create,
                :as => :inquiries,
                :controller => 'inquiries' do
      get :thank_you, :on => :collection
    end

    namespace :admin, :path => 'refinery' do
      resources :inquiries, :only => [:index, :show, :destroy] do
        get :spam, :on => :collection
        get :toggle_spam, :on => :member
      end

      resources :settings, :only => [:edit, :update]
    end
  end
end
