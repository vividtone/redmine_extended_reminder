class RedmineExtendedReminder::SettingsController < ApplicationController
  before_filter :require_login

  def update
    user = User.current
    user.pref[:extended_reminder_no_reminders] =
      (params[:extended_reminder_no_reminders] == '1')
    user.pref.save!
    flash[:notice] = l(:notice_successful_update)
    redirect_to :controller => '/my', :action => 'account'
  end

  def send_reminder
    user = User.current
    unless user.pref[:extended_reminder_no_reminders]
      Mailer.reminders(:users => [user.id])
      flash[:notice] = l(:notice_email_sent, :value => user.mail)
    else
      flash[:error] = l(:extended_reminder_no_reminders_is_set)
    end
    redirect_to :controller => '/my', :action => 'account'
  end
end