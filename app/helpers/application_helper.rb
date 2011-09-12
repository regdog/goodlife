module ApplicationHelper
	def active_li_css(comparison_name, *names)
	  # Make sure we can pass in an array or multiple strings
	  names.flatten!
	  for name in names
  	  if name == comparison_name
        return 'active'
      end
    end
    return ''
  end
end
