require_dependency 'mailer'

module RedmineExtendedReminder
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
      @count = issues.size
      reminder_without_patch(user, issues, days)
    end
  end
end

unless Mailer.included_modules.include?(RedmineExtendedReminder::MailerModelPatch)
  Mailer.send(:include, RedmineExtendedReminder::MailerModelPatch)
end