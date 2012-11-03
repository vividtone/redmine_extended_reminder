require_dependency 'mailer'

module RedmineExtendedReminder
  module MailerModelPatch
    def self.included(base)
      base.extend(ClassMethods)
      base.class_eval do
        class << self
          alias_method_chain :reminders, :patch
        end        
      end
    end
  end

  module ClassMethods
    def reminders_with_patch(options={})
      days = options[:days] || 7
      project = options[:project] ? Project.find(options[:project]) : nil
      tracker = options[:tracker] ? Tracker.find(options[:tracker]) : nil
      user_ids = options[:users]

      scope = Issue.open.where("#{Issue.table_name}.assigned_to_id IS NOT NULL" +
        " AND #{Project.table_name}.status = #{Project::STATUS_ACTIVE}" +
        " AND #{Issue.table_name}.due_date <= ?", days.day.from_now.to_date
      )
      scope = scope.where(:assigned_to_id => user_ids) if user_ids.present?
      scope = scope.where(:project_id => project.id) if project
      scope = scope.where(:tracker_id => tracker.id) if tracker

      issues_by_assignee = scope.includes(:status, :assigned_to, :project, :tracker).order('due_date').all.group_by(&:assigned_to)
      issues_by_assignee.keys.each do |assignee|
        if assignee.is_a?(Group)
          assignee.users.each do |user|
            issues_by_assignee[user] ||= []
            issues_by_assignee[user] += issues_by_assignee[assignee]
          end
        end
      end

      issues_by_assignee.each do |assignee, issues|
        reminder(assignee, issues, days).deliver if assignee.is_a?(User) && assignee.active?
      end
    end
  end
end

unless Mailer.included_modules.include?(RedmineExtendedReminder::MailerModelPatch)
  Mailer.send(:include, RedmineExtendedReminder::MailerModelPatch)
end