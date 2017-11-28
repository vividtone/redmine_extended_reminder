# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
namespace :redmine_extended_reminder do
  match 'settings/update' => 'settings#update', :via => [:post]
  match 'settings/send_reminder' => 'settings#send_reminder', :via => [:get, :post]
end
