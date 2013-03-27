module ActionDispatch::Routing
  class Mapper
    def draw_talky_routes
      resources :categories, :except => [:index, :show]
      resources :forums, :except => :index do
        resources :topics, :shallow => true, :except => :index do
          resources :posts, :shallow => true, :except => [:index, :show]
        end
        root :to => 'categories#index', :via => :get
      end
    end
  end
end

