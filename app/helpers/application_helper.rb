module ApplicationHelper
  def frequency_label(frequency)
    case frequency
      when 1
        return "<span class='label label-default'>#{Frequency::VALUES.key(frequency)}</span>".html_safe
      when 2
        return "<span class='label label-success'>#{Frequency::VALUES.key(frequency)}</span>".html_safe
      when 3
        return "<span class='label label-warning'>#{Frequency::VALUES.key(frequency)}</span>".html_safe
      when 4
        return "<span class='label label-important'>#{Frequency::VALUES.key(frequency)}</span>".html_safe
      when 5
        return "<span class='label label-info'>#{Frequency::VALUES.key(frequency)}</span>".html_safe
      when 6
        return "<span class='label label-inverse'>#{Frequency::VALUES.key(frequency)}</span>".html_safe
      else
        return "<span class='label label-warning'>error</span>".html_safe
    end
  end

end
