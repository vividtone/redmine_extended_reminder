module ExtendedReminderHelper
  def due_date_in_words(due_date)
    case due_date
    when Date.yesterday
      l(:label_yesterday)
    when Date.today
      l(:label_today)
    when Date.tomorrow
      l(:extended_reminder_tomorrow)
    else
      if due_date < Date.today
        l(:extended_reminder_days_ago, :days => distance_of_time_in_words_to_now(due_date))
      else
        l(:extended_reminder_days_after, :days => distance_of_time_in_words_to_now(due_date))
      end
    end
  end
end
