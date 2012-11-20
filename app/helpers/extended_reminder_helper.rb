module ExtendedReminderHelper
  def due_date_in_words(due_date)
    today = Date.today
    case due_date
    when Date.yesterday
      l(:label_yesterday)
    when today
      l(:label_today)
    when Date.tomorrow
      l(:extended_reminder_tomorrow)
    else
      days_in_word = distance_of_time_in_words(today, due_date)
      if due_date < today
        l(:extended_reminder_days_ago, :days => days_in_word)
      else
        l(:extended_reminder_days_after, :days => days_in_word)
      end
    end
  end
end
