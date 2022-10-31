require 'redmine'
require_dependency File.expand_path('../lib/redmine_extended_reminder/hooks', __FILE__)

zeitwerk_enabled = Rails.version > '6.0' && Rails.autoloaders.zeitwerk_enabled?
Rails.configuration.__send__(zeitwerk_enabled ? :after_initialize : :to_prepare) do
  require_dependency File.expand_path('../lib/redmine_extended_reminder/mailer_model_patch', __FILE__)
end

Redmine::Plugin.register :redmine_extended_reminder do
  requires_redmine :version_or_higher => '3.0'
  name 'Redmine Extended Reminder plugin'
  author 'MAEDA, Go'
  description 'Improves email reminders'
  version '0.0.3'
  url 'https://github.com/vividtone/redmine_extended_reminder'
  author_url 'https://www.facebook.com/MAEDA.Go'

  settings(
    :default => {'days' => '0', 'disable_on_non_woking_days' => 0},
    :partial => 'redmine_extended_reminder/plugin_settings')
end
