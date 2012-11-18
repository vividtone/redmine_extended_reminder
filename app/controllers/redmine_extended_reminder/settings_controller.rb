class RedmineExtendedReminder::SettingsController < ApplicationController
  before_filter :require_login

  def send_reminder
    user = User.current
    Mailer.reminders(user)
    flash[:notice] = l(:notice_email_sent, :value => user.mail)
    redirect_to :controller => '/my', :action => 'account'
  end
end