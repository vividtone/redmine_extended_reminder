# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
namespace :redmine_extended_reminder do
  match 'settings/send_reminder' => 'settings#send_reminder'
end