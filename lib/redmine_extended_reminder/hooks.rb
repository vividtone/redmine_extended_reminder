module RedmineExtendedReminder
  class Hooks < Redmine::Hook::ViewListener
    def view_layouts_base_sidebar(context = {})
      controller = context[:controller]
      if controller.controller_name == 'my' && controller.action_name == 'account'
        controller.send(:render_to_string, {
          :partial => "hooks/redmine_extended_reminder/setting",
          :locals => {:context => context}
        })
      end
    end
  end
end