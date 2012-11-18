require_dependency 'mailer'

module RedmineExtendedReminder
  include ActionView::Helpers::DateHelper

  module MailerModelPatch
    def self.included(base)
      base.send(:include, InstanceMethods)

      base.class_eval do
        helper :extended_reminder

        # replace instance methods
        alias_method_chain :reminder, :patch
      end
    end
  end

  module InstanceMethods
    def reminder_with_patch(user, issues, days)
      @issues_by_date = issues.sort_by(&:due_date).group_by(&:due_date)
      @days = days
      @count = issues.size
      @issues_url = url_for(:controller => 'issues', :action => 'index',
                                  :set_filter => 1, :assigned_to_id => user.id,
                                  :sort => 'due_date:asc')
      mail :to => user.mail,
        :subject => l(:mail_subject_reminder, :count => @count, :days => days)
    end
  end
end

unless Mailer.included_modules.include?(RedmineExtendedReminder::MailerModelPatch)
  Mailer.send(:include, RedmineExtendedReminder::MailerModelPatch)
end