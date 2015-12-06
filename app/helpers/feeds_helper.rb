module FeedsHelper
  def bold_if_new(post)
    last_viewed_date = cookies[:last_viewed]
    if last_viewed_date
      post.published.localtime > Time.parse(last_viewed_date) ? 'title-bold' : 'title-normal'
    else
      'title-normal'
    end
  end

  def format_time(post)
    post.published.localtime.strftime('%B %d, %Y at %I:%M %P')
  end

  def set_time_cookie
    cookies.permanent[:last_viewed] = Time.now
  end

  def remove_non_digits(param)
    param.map! { |num| num[/\d+-\d+/].split('-').map(&:to_i) }
  end
end
