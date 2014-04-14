module ApplicationHelper
  def full_title(page_title)
    base_title = 'Feed Parser'
    page_title.empty? ? base_title : "#{base_title} | #{page_title}"
  end

  def set_active
    arr = %w(active inactive)
    action_name == 'new' ? arr.reverse << 'invisible' : arr << 'inactive'
  end
end
