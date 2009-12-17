ActionController::Routing::Routes.draw do |map|
  map.root :controller => :sessions, :action => :new
  map.resource :session, :only => [:create, :destroy, :new]
  map.resources :emails, :only => [:index, :show]
  map.resources :calendars, :only => [:index, :show], :requirements => { :id => /[a-zA-Z0-9\-\.\%]+/ }
  map.open_id_complete 'session', :controller => "sessions", :action => "create", :requirements => { :method => :get }
  map.authenticated_content '/authenticated', :controller => :authenticated, :action => :index
end
