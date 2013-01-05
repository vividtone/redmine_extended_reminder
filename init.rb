require 'redmine'
require_dependency 'redmine_extended_reminder/hooks'

Rails.configuration.to_prepare do
  require_dependency 'redmine_extended_reminder/mailer_model_patch'
end

Redmine::Plugin.register :redmine_extended_reminder do
  requires_redmine :version_or_higher => '2.0'
  name 'Redmine Extended Reminder plugin'
  author 'MAEDA, Go'
  description 'Improves reminders.'
  version '0.0.1'
  url 'https://github.com/vividtone/redmine_extended_reminder'
  author_url 'https://www.facebook.com/MAEDA.Go'

  settings(
    :default => {'days' => '0', 'disable_on_non_woking_days' => 0},
    :partial => 'redmine_extended_reminder/plugin_settings')  
end
